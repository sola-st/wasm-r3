import { unreachable } from "./util.cjs"
import { Trace } from "./tracer.cjs"
import fs, { WriteStream } from "fs"
import readline from 'readline'
import { WasmEvent } from "../trace.cjs"


export type ImpExp = { import: boolean, name: string }
export type Call = { type: "Call", name: string, params: number[] }
export type TableCall = { type: 'TableCall', tableName: string, funcidx: number, params: number[] }
export type Store = { type: "Store", addr: number, data: number[] } & ImpExp
export type MemGrow = { type: "MemGrow", amount: number } & ImpExp
export type TableSet = { type: "TableSet", idx: number, funcImport: boolean, funcName: string } & ImpExp
export type TableGrow = { type: "TableGrow", idx: number, amount: number } & ImpExp
export type GlobalSet = { type: "GlobalSet", value: number, bigInt: boolean } & ImpExp
export type Event = Call | TableCall | Store | MemGrow | TableSet | TableGrow | GlobalSet
export type Import = { module: string, name: string }
export type Result = { results: number[], reps: number }
export type Context = Event[]
export type Function = Import & { bodys: Context[], results: Result[] }
export type Memory = Import & WebAssembly.MemoryDescriptor
export type Table = Import & WebAssembly.TableDescriptor
export type Global = Import & WebAssembly.GlobalDescriptor & { initial: number }
export type Replay = {
    funcImports: { [key: string]: Function }
    memImports: { [key: string]: Memory }
    tableImports: { [key: string]: Table }
    globalImports: { [key: string]: Global }
    calls: { name: string, params: number[] }[]
    initialization: Event[]
    modules: string[]
}

/**
 * Replay Generator backend
 */
export type ReplayToWriteStream = (stream: WriteStream, code: Replay) => Promise<void>

/**
 * Replay optimiser
 */
export type ReplayOptimise = (code: Replay) => Replay

type State = { importCallStack: CallStack, lastFunc?: Function, lastFuncReturn: boolean, globalScope: boolean, importCallStackFunction: Function[] }
type CallStack = Context[]
export default class Generator {
    private code: Replay = {
        funcImports: {},
        memImports: {},
        tableImports: {},
        globalImports: {},
        calls: [],
        initialization: [],
        modules: [],
    }
    private state: State

    constructor() {
        this.state = { importCallStack: [this.code.initialization], globalScope: true, lastFuncReturn: false, importCallStackFunction: [] }
    }

    generateReplay(trace: Trace) {
        if (trace.getLength() === 0) {
            throw new Error('No trace has been provided. Are you sure the app that you are using instantiates WebAssembly.')
        }
        trace.forEach((event) => this.consumeEvent(event))
        return this.code
    }

    generateReplayFromStream(traceStream: fs.ReadStream): Promise<Replay> {
        return new Promise((resolve, reject) => {
            const rl = readline.createInterface({
                input: traceStream,
                crlfDelay: Infinity
            });
            const trace = new Trace()
            rl.on('line', (line) => {
                trace.push(line)
                this.consumeEvent(trace.parseEventToObj(trace.resolve(trace.getTop())))
            });

            rl.on('close', () => {
                resolve(this.code)
            });
        })
    }

    private consumeEvent(event: WasmEvent) {
        switch (event.type) {
            case "ExportCall":
                this.pushEvent({ type: 'Call', name: event.name, params: event.params })
                break
            case 'TableCall':
                this.pushEvent({ type: 'TableCall', tableName: event.tableName, funcidx: event.funcidx, params: event.params })
            case 'ExportReturn':
                this.state.globalScope = true
                break
            case "ImportCall":
                this.state.globalScope = false
                this.code.funcImports[event.idx].bodys.push([])
                this.state.importCallStack.push(this.code.funcImports[event.idx].bodys[this.code.funcImports[event.idx].bodys.length - 1])
                this.state.importCallStackFunction.push(this.code.funcImports[event.idx])
                this.state.lastFunc = this.code.funcImports[event.idx]
                this.state.lastFuncReturn = false
                break
            case "ImportReturn":
                let r = this.state.importCallStackFunction[this.state.importCallStackFunction.length - 1].results
                if (r.length > 0) {
                    if (r.slice(-1)[0].results[0] === event.results[0]) {
                        this.state.lastFuncReturn = true
                        r.slice(-1)[0].reps += 1
                        this.state.importCallStack.pop()
                        this.state.lastFunc = this.state.importCallStackFunction.pop()
                        break
                    }
                }
                this.state.lastFuncReturn = true
                r.push({ results: event.results, reps: 1 })
                this.state.importCallStack.pop()
                this.state.lastFunc = this.state.importCallStackFunction.pop()
                break
            case "Load":
                this.pushEvent({
                    type: 'Store',
                    import: this.code.memImports[event.idx] !== undefined,
                    name: event.name,
                    addr: event.offset,
                    data: event.data,
                })
                break
            case 'MemGrow':
                this.pushEvent({
                    type: event.type,
                    import: this.code.memImports[event.idx] !== undefined,
                    name: event.name,
                    amount: event.amount
                })
                break
            case "TableGet":
                this.pushEvent({
                    type: 'TableSet',
                    import: this.code.tableImports[event.tableidx] !== undefined,
                    name: event.name,
                    idx: event.idx,
                    funcImport: this.code.funcImports[event.funcidx] !== undefined,
                    funcName: event.funcName
                })
                break
            case "TableGrow":
                this.pushEvent({
                    type: event.type,
                    import: this.code.tableImports[event.idx] !== undefined,
                    name: event.name,
                    idx: event.idx,
                    amount: event.amount
                })
                break
            case 'ImportMemory':
                this.addModule(event)
                this.code.memImports[event.idx] = {
                    module: event.module,
                    name: event.name,
                    initial: event.initial,
                    maximum: event.maximum
                }
                break
            case 'GlobalGet':
                this.pushEvent({
                    type: 'GlobalSet',
                    import: this.code.globalImports[event.idx] !== undefined,
                    name: event.name,
                    value: event.value,
                    bigInt: event.valtype === 'i64'
                })
                break
            case 'ImportTable':
                this.addModule(event)
                this.code.tableImports[event.idx] = {
                    module: event.module,
                    name: event.name,
                    element: event.element,
                    initial: event.initial,
                    maximum: event.maximum,
                }
                break
            case 'ImportGlobal':
                this.addModule(event)
                this.code.globalImports[event.idx] = {
                    module: event.module,
                    name: event.name,
                    value: event.value,
                    initial: event.initial,
                    mutable: event.mutable
                }
                break
            case 'ImportFunc':
                this.addModule(event)
                this.code.funcImports[event.idx] = {
                    module: event.module,
                    name: event.name,
                    bodys: [],
                    results: []
                }
                break
            case 'FuncEntry':
            case 'FuncReturn':
            case 'LoadExt':
            case 'TableGetExt':
                break
            default:
                unreachable(event)
        }
    }

    private pushEvent(event: Event) {
        if (event.type === 'Call' || event.type === 'TableCall') {
            const currentContext = this.state.importCallStack[this.state.importCallStack.length - 1]
            currentContext.push(event)
            return
        }
        let currentContext = this.state.lastFunc?.bodys.slice(-1)[0]
        if (this.state.globalScope === true) {
            currentContext = this.code.initialization
        }
        if (currentContext.slice(-1)[0]?.type === "Call" || currentContext.slice(-1)[0]?.type === 'TableCall') {
            if (this.state.lastFuncReturn === false) {
                currentContext.splice(currentContext.length - 1, 0, event)
            } else {
                this.state.lastFunc?.bodys.slice(-1)[0].push(event)
            }
            return
        }
        currentContext.push(event)
    }

    private addModule(event: Import) {
        if (!this.code.modules.includes(event.module)) {
            this.code.modules.push(event.module)
        }
    }
}
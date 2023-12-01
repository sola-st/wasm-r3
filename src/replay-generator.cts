import { unreachable } from "./util.cjs"
import { Trace } from "./tracer.cjs"
import fs, { WriteStream } from "fs"
import readline from 'readline'
import { WasmEvent } from "../trace.cjs"

type ImpExp = { import: boolean, name: string }
type Call = { type: "Call", name: string, params: number[] }
type Store = { type: "Store", addr: number, data: number[] } & ImpExp
type MemGrow = { type: "MemGrow", amount: number } & ImpExp
type TableSet = { type: "TableSet", idx: number, funcImport: boolean, funcName: string } & ImpExp
type TableGrow = { type: "TableGrow", idx: number, amount: number } & ImpExp
type GlobalSet = { type: "GlobalSet", value: number, bigInt: boolean } & ImpExp
type Event = Call | Store | MemGrow | TableSet | TableGrow | GlobalSet
type Import = { module: string, name: string }
type Result = { results: number[], reps: number }
type Function = Import & { bodys: Event[][], results: Result[] }
type Memory = Import & WebAssembly.MemoryDescriptor
type Table = Import & WebAssembly.TableDescriptor
type Global = Import & WebAssembly.GlobalDescriptor & { initial: number }
type State = { importCallStack: Function[], lastFunc?: Function, lastFuncReturn: boolean, globalScope: boolean }

export default class Generator {
    private code: Code
    private state: State

    constructor() {
        this.code = new Code()
        this.state = { importCallStack: [], globalScope: true, lastFuncReturn: false }
    }

    generateReplay(trace: Trace) {
        if (trace.into().length === 0) {
            throw new Error('No trace has been provided. Are you sure the app that you are using instantiates WebAssembly.')
        }
        trace.into().forEach((event) => this.consumeEvent(event))
        return this.code
    }

    generateReplayFromStream(traceStream: fs.ReadStream): Promise<Code> {
        return new Promise((resolve, reject) => {
            const rl = readline.createInterface({
                input: traceStream,
                crlfDelay: Infinity
            });
            const trace = new Trace()
            rl.on('line', (line) => {
                trace.push(Trace.parseEvent(line))
                this.consumeEvent(Trace.parseEventToObj(trace.resolve(trace.getTop())))
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
            case 'ExportReturn':
                this.state.globalScope = true
                break
            case "ImportCall":
                this.state.globalScope = false
                this.code.funcImports[event.idx].bodys.push([])
                this.state.importCallStack.push(this.code.funcImports[event.idx])
                this.state.lastFunc = this.code.funcImports[event.idx]
                this.state.lastFuncReturn = false
                break
            case "ImportReturn":
                let r = this.state.lastFunc.results
                if (r.length > 0) {
                    if (r.slice(-1)[0].results[0] === event.results[0]) {
                        r.slice(-1)[0].reps += 1
                        break
                    }
                }
                this.state.lastFuncReturn = true
                r.push({ results: event.results, reps: 1 })
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
            case 'Call':
            case 'StoreExt':
                break
            default:
                unreachable(event)
        }
    }

    private pushEvent(event: Event) {
        let currentContext = this.state.lastFunc?.bodys.slice(-1)[0]
        if (this.state.globalScope === true) {
            currentContext = this.code.initialization
        }
        if (currentContext.slice(-1)[0]?.type === "Call" && event.type !== 'Call' && this.state.lastFuncReturn === false) {
            currentContext.splice(currentContext.length - 1, 0, event)
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

class Code {
    funcImports: { [key: string]: Function }
    memImports: { [key: string]: Memory }
    tableImports: { [key: string]: Table }
    globalImports: { [key: string]: Global }
    calls: { name: string, params: number[] }[]
    initialization: Event[]
    modules: string[]

    constructor() {
        this.funcImports = {}
        this.memImports = {}
        this.tableImports = {}
        this.globalImports = {}
        this.calls = []
        this.initialization = []
        this.modules = []
    }

    async toWriteStream(stream: WriteStream) {
        stream.write(`import fs from 'fs'\n`)
        stream.write(`import path from 'path'\n`)
        stream.write(`let instance\n`)
        // stream.write(`function getImports(wasmBinary) {\n`)
        stream.write('let imports = {}\n')

        // Init modules
        for (let module of this.modules) {
            stream.write(`${writeModule(module)}\n`)
        }
        // Init memories
        for (let memidx in this.memImports) {
            let mem = this.memImports[memidx]
            stream.write(`const ${mem.name} = new WebAssembly.Memory({ initial: ${mem.initial}, maximum: ${mem.maximum} })\n`)
            stream.write(`${writeImport(mem.module, mem.name)}${mem.name}\n`)
        }
        // Init globals
        for (let globalIdx in this.globalImports) {
            let global = this.globalImports[globalIdx]
            // There is a special case here: 
            // you can also import the values NaN and Infinity as globals in WebAssembly
            // Thats why whe need this if else
            if (Number.isNaN(global.initial)) {
                if (global.name.toLocaleLowerCase() === 'infinity') {
                    stream.write(`${writeImport(global.module, global.name)}Infinity\n`)
                } else if (global.name.toLocaleLowerCase() === 'nan') {
                    stream.write(`${writeImport(global.module, global.name)}NaN\n`)
                } else {
                    throw new Error(`Could not generate javascript code for the global initialisation, the initial value is NaN. The website you where recording did some weired stuff that I was not considering during the implementation of Wasm-R3. Tried to genereate global ${global}`)
                }
            } else {
                stream.write(`const ${global.name} = new WebAssembly.Global({ value: '${global.value}', mutable: ${global.mutable}}, ${global.initial})\n`)
                stream.write(`${writeImport(global.module, global.name)}${global.name}\n`)
            }
        }
        // Init tables
        for (let tableidx in this.tableImports) {
            let table = this.tableImports[tableidx]
            stream.write(`const ${table.name} = new WebAssembly.Table({ initial: ${table.initial}, maximum: ${table.maximum}, element: '${table.element}'})\n`)
            stream.write(`${writeImport(table.module, table.name)}${table.name}\n`)
        }
        // Imported functions
        for (let funcidx in this.funcImports) {
            stream.write(`let ${writeFuncGlobal(funcidx)} = -1\n`)
            let func = this.funcImports[funcidx]
            stream.write(`${writeImport(func.module, func.name)}() => {\n`)
            stream.write(`${writeFuncGlobal(funcidx)}++\n`)
            if (func.bodys.length !== 0) {
                stream.write(`switch (${writeFuncGlobal(funcidx)}) {\n`)
                for (let i = 0; i < func.bodys.length; i++) {
                    await this.writeBody(stream, func.bodys[i], i)
                }
                stream.write('}\n')
            }
            await this.writeResults(stream, func.results, writeFuncGlobal(funcidx))
            stream.write('}\n')
        }
        // stream.write(`return imports\n`)
        // stream.write('}\n')
        stream.write(`export function replay(wasm) {`)
        stream.write(`instance = wasm.instance\n`)
        for (let exp of this.calls) {
            stream.write(`instance.exports.${exp.name}(${writeParamsString(exp.params)}) \n`)
        }
        // Init entity states
        for (let event of this.initialization) {
            switch (event.type) {
                case 'Store':
                    await this.write(stream, this.storeEvent(event))
                    break
                case 'MemGrow':
                    await this.write(stream, this.memGrowEvent(event))
                    break
                case 'TableSet':
                    await this.write(stream, this.tableSetEvent(event))
                    break
                case 'TableGrow':
                    await this.write(stream, this.tableGrowEvent(event))
                    break
                case 'Call':
                    await this.write(stream, this.callEvent(event))
                    break
                case 'GlobalSet':
                    await this.write(stream, this.globalSet(event))
                    break
                default: unreachable(event)
            }
        }
        stream.write(`}\n`)
        stream.write(`export function instantiate(wasmBinary) {\n`)
        stream.write(`return WebAssembly.instantiate(wasmBinary, imports)\n`)
        stream.write(`}\n`)
        stream.write(`if (process.argv[2] === 'run') {\n`)
        stream.write(`const p = path.join(path.dirname(import.meta.url).replace(/^file:/, ''), 'index.wasm')\n`)
        stream.write(`const wasmBinary = fs.readFileSync(p)\n`)
        stream.write(`instantiate(wasmBinary).then((wasm) => replay(wasm))\n`)
        stream.write(`}\n`)
        stream.close()
    }

    private async writeBody(stream: WriteStream, b: Event[], i: number) {
        if (b.length !== 0) {
            await this.write(stream, `case ${i}:\n`)
            for (let event of b) {
                switch (event.type) {
                    case 'Call':
                        await this.write(stream, `instance.exports.${event.name}(${writeParamsString(event.params)})\n`)
                        break
                    case 'Store':
                        await this.write(stream, this.storeEvent(event))
                        break
                    case 'MemGrow':
                        await this.write(stream, this.memGrowEvent(event))
                        break
                    case 'TableSet':
                        await this.write(stream, this.tableSetEvent(event))
                        break
                    case 'TableGrow':
                        await this.write(stream, this.tableGrowEvent(event))
                        break
                    case 'GlobalSet':
                        await this.write(stream, this.globalSet(event))
                        break
                    default: unreachable(event)
                }
            }
            stream.write(`break\n`)
        }
    }

    private async writeResults(stream: WriteStream, results: Result[], funcGlobal: string) {
        let current = 0
        for (let r of results) {
            const newC = current + r.reps
            stream.write(`if ((${funcGlobal} >= ${current}) && ${funcGlobal} < ${newC}) {\n`)
            stream.write(`return ${r.results[0]} }\n`)
            current = newC
        }
    }

    private async write(stream: WriteStream, s: string) {
        if (stream.write(s) === false) {
            await new Promise((resolve) => stream.once('drain', resolve))
        }
    }

    private storeEvent(event: Store) {
        let jsString = ''
        event.data.forEach((byte, j) => {
            event = event as Store
            if (event.import) {
                jsString += `new Uint8Array(${event.name}.buffer)[${event.addr + j}] = ${byte}\n`
            } else {
                jsString += `new Uint8Array(instance.exports.${event.name}.buffer)[${event.addr + j}] = ${byte}\n`
            }
        })
        return jsString
    }

    private callEvent(event: Call) {
        return `instance.exports.${event.name}(${writeParamsString(event.params)}) \n`
    }

    private memGrowEvent(event: MemGrow) {
        let jsString = ''
        if (event.import) {
            jsString += `${event.name}.grow(${event.amount})\n`
        } else {
            jsString += `instance.exports.${event.name}.grow(${event.amount})\n`
        }
        return jsString
    }

    private tableSetEvent(event: TableSet) {
        let jsString = ''
        if (event.import) {
            jsString += `${event.name}.set(${event.idx}, `
        } else {
            jsString += `instance.exports.${event.name}.set(${event.idx}, `
        }
        if (event.funcImport) {
            jsString += `${event.funcName}`
        } else {
            jsString += `instance.exports.${event.funcName}`
        }
        jsString += `)\n`
        return jsString
    }

    private tableGrowEvent(event: TableGrow) {
        let jsString = ''
        if (event.import) {
            jsString += `${event.name}.grow(${event.amount})\n`
        } else {
            jsString += `instance.exports.${event.name}.grow(${event.amount})\n`
        }
        return jsString
    }

    private globalSet(event: GlobalSet) {
        let jsString = ''
        if (event.import) {
            jsString += `${event.name}.value = ${event.value}\n`
        } else {
            jsString += `instance.exports.${event.name}.value = ${event.bigInt ? `BigInt(${event.value})` : event.value}\n`
        }
        return jsString
    }
}

function writeFuncGlobal(funcidx: string) {
    return `global_${funcidx}`
}

function writeModule(module: string) {
    return `imports['${module}'] = {}`
}

function writeImport(module: string, name: string) {
    return `imports['${module}']['${name}'] = `
}

function writeParamsString(params: number[]) {
    let paramsString = ''
    for (let p of params) {
        paramsString += p + ','
    }
    paramsString = paramsString.slice(0, -1)
    return paramsString
}
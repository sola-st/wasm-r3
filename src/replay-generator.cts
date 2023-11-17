import { unreachable } from "./util.cjs"
import { Trace } from "../trace.d.cjs"

type ImpExp = { import: boolean, name: string }
type Call = { type: "Call", name: string, params: number[] }
type Store = { type: "Store", addr: number, data: number[] } & ImpExp
type MemGrow = { type: "MemGrow", amount: number } & ImpExp
type TableSet = { type: "TableSet", idx: number, funcImport: boolean, funcName: string } & ImpExp
type TableGrow = { type: "TableGrow", idx: number, amount: number } & ImpExp
type GlobalSet = { type: "GlobalSet", value: number, bigInt: boolean } & ImpExp
type Event = Call | Store | MemGrow | TableSet | TableGrow | GlobalSet
type Import = { module: string, name: string }
type Function = Import & { body: { results: number[], events: Event[] }[] }
type Memory = Import & { pages: number }
type Table = Import & WebAssembly.TableDescriptor
type Global = Import & { valtype: string, value: number }
type State = { callStack: Function[], lastFunc?: Function }

export default class Generator {
    private code: Code
    private state: State

    constructor() {
        this.code = new Code()
        this.state = { callStack: [] }
    }

    generateReplay(trace: Trace) {
        trace.forEach((event) => {
            switch (event.type) {
                case "ExportCall":
                    if (this.state.callStack.length === 0) {
                        this.code.calls.push({ name: event.name, params: event.params })
                        break
                    }
                    this.pushEvent({ type: 'Call', name: event.name, params: event.params })
                    break
                case "ImportCall":
                    this.code.funcImports[event.idx].body.push({ results: [], events: [] })
                    this.state.callStack.push(this.code.funcImports[event.idx])
                    break
                case "ImportReturn":
                    this.state.lastFunc = this.state.callStack.pop()
                    this.state.lastFunc.body.slice(-1)[0].results = event.results
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
                        pages: event.pages
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
                        valtype: event.valtype,
                        value: event.value,
                    }
                    break
                case 'ImportFunc':
                    this.addModule(event)
                    this.code.funcImports[event.idx] = {
                        module: event.module,
                        name: event.name,
                        body: []
                    }
                    break
                default:
                    unreachable(event)
            }
        })
        return this.code
    }

    private pushEvent(event: Event) {
        const stackTop = this.state.callStack.slice(-1)[0]?.body.slice(-1)[0]
        if (stackTop === undefined) {
            if (this.state.lastFunc === undefined) {
                this.code.initialization.push(event)
                return
            }
            this.state.lastFunc.body.slice(-1)[0].events.push(event)
            return
        }
        if (stackTop.events?.slice(-1)[0]?.type === "Call") {
            stackTop.events.splice(stackTop.events.length - 1, 0, event)
            return
        }
        stackTop.events.push(event)
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

    public toString() {
        let jsString = `import fs from 'fs'\n`
        jsString += `import path from 'path'\n`
        jsString += `export default async function replay(wasmBinary) {\n`
        jsString += `let instance\n`
        jsString += 'let imports = {}\n'

        // Init modules
        for (let module of this.modules) {
            jsString += `${writeModule(module)}\n`
        }
        // Init memories
        for (let memidx in this.memImports) {
            let mem = this.memImports[memidx]
            jsString += `const ${mem.name} = new WebAssembly.Memory({ initial: ${mem.pages}, maximum: ${mem.pages/*This is wrong. You need to trace the actual maximum here*/} })\n`
            jsString += `${writeImport(mem.module, mem.name)}${mem.name}\n`
        }
        // Init globals
        for (let globalIdx in this.globalImports) {
            let global = this.globalImports[globalIdx]
            jsString += `const ${global.name} = new WebAssembly.Global({ value: '${global.valtype}', mutable: true}, ${global.value})\n`
            jsString += `${global.name}.value = ${global.value}\n`
            jsString += `${writeImport(global.module, global.name)}${global.name}\n`
        }
        // Init tables
        for (let tableidx in this.tableImports) {
            let table = this.tableImports[tableidx]
            jsString += `const ${table.name} = new WebAssembly.Table({ initial: ${table.initial}, element: '${table.element}'})\n`
            jsString += `${writeImport(table.module, table.name)}${table.name}\n`
        }
        // Init entity states
        for (let event of this.initialization) {
            switch (event.type) {
                case 'Store':
                    jsString += this.storeEvent(event)
                    break
                case 'MemGrow':
                    jsString += this.memGrowEvent(event)
                    break
                case 'TableSet':
                    jsString += this.tableSetEvent(event)
                    break
                case 'TableGrow':
                    jsString += this.tableGrowEvent(event)
                    break
            }
        }
        // Imported functions
        for (let funcidx in this.funcImports) {
            jsString += `let ${writeFuncGlobal(funcidx)} = -1\n`
            let func = this.funcImports[funcidx]
            jsString += `${writeImport(func.module, func.name)}() => {\n`
            jsString += `${writeFuncGlobal(funcidx)}++\n`
            jsString += `switch (${writeFuncGlobal(funcidx)}) {\n`
            func.body.forEach((b, i) => {
                jsString += `case ${i}:\n`
                for (let event of b.events) {
                    switch (event.type) {
                        case 'Call':
                            jsString += `instance.exports.${event.name}(${writeParamsString(event.params)})\n`
                            break
                        case 'Store':
                            jsString += this.storeEvent(event)
                            break
                        case 'MemGrow':
                            jsString += this.memGrowEvent(event)
                            break
                        case 'TableSet':
                            jsString += this.tableSetEvent(event)
                            break
                        case 'TableGrow':
                            jsString += this.tableGrowEvent(event)
                            break
                        case 'GlobalSet':
                            jsString += this.globalSet(event)
                            break
                        default: unreachable(event)
                    }
                }
                jsString += `return ${b.results[0]} \n`
            })
            jsString += '}\n'
            jsString += '}\n'
        }
        jsString += `let wasm = await WebAssembly.instantiate(wasmBinary, imports) \n`
        jsString += `instance = wasm.instance\n`
        for (let exp of this.calls) {
            jsString += `await instance.exports.${exp.name}(${writeParamsString(exp.params)}) \n`
        }
        jsString += `}\n`
        jsString += `if (process.argv[2] === 'run') {\n`
        jsString += `const p = path.join(path.dirname(import.meta.url).replace(/^file:/, ''), 'index.wasm')\n`
        jsString += `const wasmBinary = fs.readFileSync(p)\n`
        jsString += `replay(wasmBinary)\n`
        jsString += `}\n`
        return jsString
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
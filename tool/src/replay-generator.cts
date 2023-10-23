import { unreachable } from "./util.cjs"
import { Trace } from "./trace.cjs"

type Call = { type: "Call", name: string }
type Store = { type: "Store", memPath: { import: boolean, name: string }, addr: number, data: Uint8Array }
type MemGrow = { type: "MemGrow", memPath: { import: boolean, name: string }, amount: number }
type TableSet = { type: "TableSet", idx: number, addr: number, value: number }
type TableGrow = { type: "TableGrow", idx: number, amount: number }
type GlobalSet = { type: "GlobalSet", globalPath: { import: boolean, name: string }, value: number, bigInt: boolean }
type Event = Call | Store | MemGrow | TableSet | TableGrow | GlobalSet
type ImportObject = { module: string, name: string }
type Function = ImportObject & { body: { results: number[], events: Event[] }[] }
type Memory = ImportObject & { pages: number }
type Table = ImportObject & {}
type Global = ImportObject & { valtype: string, value: number }
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
                    // TODO: support for export calls with arguments
                    if (this.state.callStack.length === 0) {
                        this.code.calls.push({ name: event.names[0], params: event.params })
                        break
                    }
                    this.pushEvent({ type: 'Call', name: event.names[0] })
                    break
                case "ImportCall":
                    // if (this.code.funcImports[event.idx] === undefined) {
                    //     throw 'There shoudl be already the imported function'
                    // } else {
                    this.code.funcImports[event.idx].body.push({ results: [], events: [] })
                    // }
                    this.state.callStack.push(this.code.funcImports[event.idx])
                    break
                case "ImportReturn":
                    this.state.lastFunc = this.state.callStack.pop()!
                    this.state.lastFunc.body.slice(-1)[0].results = event.results
                    break
                case "Load":
                    let memPath
                    let memImports = this.code.memImports[event.idx]
                    if (memImports !== undefined) {
                        memPath = { import: true, name: event.name }
                    } else {
                        memPath = { import: false, name: event.name }
                    }
                    this.pushEvent({
                        type: 'Store',
                        memPath,
                        addr: event.offset,
                        data: event.data,
                    })
                    break
                case 'MemGrow':
                    let memPath2
                    let memImports2 = this.code.memImports[event.idx]
                    if (memImports2 !== undefined) {
                        memPath2 = { import: true, name: event.name }
                    } else {
                        memPath2 = { import: false, name: event.name }
                    }
                    this.pushEvent({
                        type: event.type,
                        memPath: memPath2,
                        amount: event.amount
                    })
                    break
                case "TableGet":
                    throw "TableGet not supported yet"
                    break
                case "TableGrow":
                    throw "TableGet not supported yet"
                    break
                case 'ImportMemory':
                    this.code.memImports[event.idx] = {
                        module: event.module,
                        name: event.name,
                        pages: event.pages
                    }
                    break
                case 'GlobalGet':
                    let globalPath
                    let globalImports = this.code.globalImports[event.idx]
                    if (globalImports !== undefined) {
                        globalPath = { import: true, name: event.name }
                    } else {
                        globalPath = { import: false, name: event.name }
                    }
                    this.pushEvent({
                        type: 'GlobalSet',
                        globalPath,
                        value: event.value,
                        bigInt: event.valtype === 'i64'
                    })
                    break
                case 'ImportTable':
                    throw 'ImportTable not supported yet'
                    break
                case 'ImportGlobal':
                    this.code.globalImports[event.idx] = {
                        module: event.module,
                        name: event.name,
                        valtype: event.valtype,
                        value: event.value,
                    }
                    break
                case 'ImportFunc':
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
}

class Code {
    funcImports: { [key: string]: Function }
    memImports: { [key: string]: Memory }
    tableImports: { [key: string]: Table }
    globalImports: { [key: string]: Global }
    calls: { name: string, params: number[] }[]
    initialization: Event[]

    constructor() {
        this.funcImports = {}
        this.memImports = {}
        this.tableImports = {}
        this.globalImports = {}
        this.calls = []
        this.initialization = []
    }

    public toString() {
        let jsString = `import fs from 'fs'\n`
        jsString += `import path from 'path'\n`
        jsString += `const p = path.join(path.dirname(import.meta.url).replace(/^file:/, ''), 'index.wasm')\n`
        jsString += `const wasmBinary = fs.readFileSync(p)\n`
        jsString += `let instance\n`
        jsString += 'let imports = {}\n'
        let instanciatedModules: string[] = []
        for (let memidx in this.memImports) {
            let mem = this.memImports[memidx]
            if (!instanciatedModules.includes(mem.module)) {
                jsString += `imports.${mem.module} = {}\n`
                instanciatedModules.push(mem.module)
            }
            jsString += `const ${mem.name} = new WebAssembly.Memory({ initial: ${mem.pages} })\n`
            jsString += `imports.${mem.module}.${mem.name} = ${mem.name}\n`
        }
        for (let globalIdx in this.globalImports) {
            let global = this.globalImports[globalIdx]
            if (!instanciatedModules.includes(global.module)) {
                jsString += `imports.${global.module} = {}\n`
                instanciatedModules.push(global.module)
            }
            jsString += `const ${global.name} = new WebAssembly.Global({ value: '${global.valtype}', mutable: true}, ${global.value})\n`
            jsString += `imports.${global.module}.${global.name} = ${global.name}\n`
        }
        // TODO: initialize tables
        for (let event of this.initialization) {
            switch (event.type) {
                case 'Store':
                    event.data.forEach((byte, j) => {
                        event = event as Store
                        if (event.memPath.import) {
                            jsString += `new Uint8Array(${event.memPath.name}.buffer)[${event.addr + j}] = ${byte}\n`
                        } else {
                            jsString += `new Uint8Array(instance.exports.${event.memPath.name}.buffer)[${event.addr + j}] = ${byte}\n`
                        }
                    })
                    break
                case 'MemGrow':
                    if (event.memPath.import) {
                        jsString += `${event.memPath.name}.grow(${event.amount}) \n`
                    } else {
                        jsString += `instance.exports.memory.grow(${event.amount}) \n`
                    }
                    break
                case 'TableSet':
                    break
                case 'TableGrow':
                    break
                case 'GlobalSet':
            }
        }
        for (let funcidx in this.funcImports) {
            jsString += `let ${global(funcidx)} = -1\n`
            let func = this.funcImports[funcidx]
            if (!instanciatedModules.includes(func.module)) {
                jsString += `imports.${func.module} = {}\n`
                instanciatedModules.push(func.module)
            }
            jsString += `imports.${func.module}.${func.name} = `
            jsString += `() => {\n`
            jsString += `${global(funcidx)}++\n`
            jsString += `switch (${global(funcidx)}) {\n`
            func.body.forEach((b, i) => {
                jsString += `case ${i}:\n`
                for (let event of b.events) {
                    switch (event.type) {
                        case 'Call':
                            jsString += `instance.exports.${event.name}()\n`
                            break
                        case 'Store':
                            event.data.forEach((byte, j) => {
                                event = event as Store
                                if (event.memPath.import) {
                                    jsString += `new Uint8Array(${event.memPath.name}.buffer)[${event.addr + j}] = ${byte}\n`
                                } else {
                                    jsString += `new Uint8Array(instance.exports.${event.memPath.name}.buffer)[${event.addr + j}] = ${byte}\n`
                                }
                            })
                            break
                        case 'MemGrow':
                            if (event.memPath.import) {
                                jsString += `${event.memPath.name}.grow(${event.amount})\n`
                            } else {
                                jsString += `instance.exports.memory.grow(${event.amount})\n`
                            }
                            break
                        case 'TableSet':
                            break
                        case 'TableGrow':
                            break
                        case 'GlobalSet':
                            if (event.globalPath.import) {
                                jsString += `${event.globalPath.name}.value = ${event.value}\n`
                            } else {
                                jsString += `instance.exports.${event.globalPath.name}.value = ${event.bigInt ? `BigInt(${event.value})` : event.value}\n`
                            }
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
            let paramsString = ''
            for (let p of exp.params) {
                paramsString += p + ','
            }
            paramsString = paramsString.slice(0, -1)
            jsString += `await instance.exports.${exp.name}(${paramsString}) \n`
        }
        return jsString
    }
}

function global(funcidx: string) {
    return `global_${funcidx} `
}
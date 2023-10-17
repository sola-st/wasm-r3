import { unreachable } from "./util"

type Call = { type: "Call", name: string }
type Store = { type: "Store", memPath: { import: boolean, name: string }, addr: number, data: Uint8Array }
type MemGrow = { type: "MemGrow", memPath: { import: boolean, name: string }, amount: number }
type TableSet = { type: "TableSet", idx: number, addr: number, value: number }
type TableGrow = { type: "TableGrow", idx: number, amount: number }
type GlobalSet = { type: "GlobalSet", idx: number, value: number }
type Event = Call | Store | MemGrow | TableSet | TableGrow | GlobalSet
type ImportObject = { module: string, name: string }
type Function = ImportObject & { body: { results: number[], events: Event[] }[] }
type Memory = ImportObject & {}
type Table = ImportObject & {}
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
                        this.code.calls.push(event.names[0])
                        break
                    }
                    this.pushEvent({ type: 'Call', name: event.names[0] })
                    break
                case "ImportCall":
                    if (this.code.funcImports[event.funcidx] === undefined) {
                        this.code.funcImports[event.funcidx] = {
                            module: event.module,
                            name: event.name,
                            body: [{ results: [], events: [] }],
                        }
                    } else {
                        this.code.funcImports[event.funcidx].body.push({ results: [], events: [] })
                    }
                    this.state.callStack.push(this.code.funcImports[event.funcidx])
                    break
                case "ImportReturn":
                    this.state.lastFunc = this.state.callStack.pop()!
                    this.state.lastFunc.body.slice(-1)[0].results = event.results
                    break
                case "Load":
                    let memPath
                    let memImports = this.code.memImports[event.name]
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
                    let memImports2 = this.code.memImports[event.name]
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
                    this.code.memImports[event.name] = {
                        module: event.module,
                        name: event.name,
                    }
                    break
                case 'GlobalGet':
                    throw 'Global Get not supported yet'
                    break
                case 'ImportTable':
                    throw 'ImportTable not supported yet'
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
    calls: string[]
    initialization: Event[]
    constructor() {
        this.funcImports = {}
        this.memImports = {}
        this.tableImports = {}
        this.calls = []
        this.initialization = []
    }

    public stringify() {
        let jsString = `import fs from 'fs'\n`
        jsString += `import path from 'path'\n`
        jsString += `const wasmBinary = fs.readFileSync(path.join(import.meta.dir, 'index.wasm'))\n`
        jsString += `let instance\n`
        jsString += 'let imports = {}\n'
        let instanciatedModules: string[] = []
        for (let memidx in this.memImports) {
            let mem = this.memImports[memidx]
            if (!instanciatedModules.includes(mem.module)) {
                jsString += `imports.${mem.module} = {}\n`
                instanciatedModules.push(mem.module)
            }
            jsString += `const ${mem.name} = new WebAssembly.Memory({ initial: ${1} })\n`
            jsString += `imports.${mem.module}.${mem.name} = ${mem.name}\n`
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
                    break
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
            jsString += `await instance.exports.${exp} () \n`
        }
        return jsString
    }
}

function global(funcidx: string) {
    return `global_${funcidx} `
}
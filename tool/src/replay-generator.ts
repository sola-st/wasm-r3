type Call = { type: "Call", name: string }
type Store = { type: "Store", addr: number, data: Uint8Array }
type MemGrow = { type: "MemGrow", idx: number, amount: number }
type TableSet = { type: "TableSet", idx: number, addr: number, value: number }
type TableGrow = { type: "TableGrow", idx: number, amount: number }
type GlobalSet = { type: "GlobalSet", idx: number, value: number }
type Event = Call | Store | MemGrow | TableSet | TableGrow | GlobalSet
type Function = { module: string, name: string, body: { results: number[], events: Event[] }[] }
type Code = { imports: { [key: string]: Function }, calls: string[] }
type State = { callStack: Function[], lastFunc?: Function }

export default function generate(trace: Trace) {
    let code: Code = { imports: {}, calls: [] }
    let state: State = { callStack: [] }
    trace.forEach((event) => {
        switch (event.type) {
            case "ExportCall":
                // TODO: support for export calls with arguments
                if (state.callStack.length === 0) {
                    code.calls.push(event.names[0])
                    break
                }
                pushEvent({ type: 'Call', name: event.names[0] }, state)
                break
            case "ImportCall":
                if (code.imports[event.funcidx] === undefined) {
                    code.imports[event.funcidx] = {
                        module: event.module,
                        name: event.name,
                        body: [{ results: [], events: [] }],
                    }
                } else {
                    code.imports[event.funcidx].body.push({ results: [], events: [] })
                }
                state.callStack.push(code.imports[event.funcidx])
                break
            case "ImportReturn":
                state.lastFunc = state.callStack.pop()!
                state.lastFunc.body.slice(-1)[0].results = event.results
                break
            case "Load":
                pushEvent({
                    type: 'Store',
                    addr: event.offset,
                    data: event.data,
                }, state)
                break
            case 'MemGrow':
                pushEvent({
                    type: event.type,
                    idx: event.memidx,
                    amount: event.amount
                }, state)
                break
            case "TableGet":
                throw "TableGet not supported yet"
                break
            case "TableGrow":
                throw "TableGet not supported yet"
                break
            default:
                throw "Not a valid trace event"
        }
    })
    return stringify(code)
}

function pushEvent(event: Event, state: State) {
    const stackTop = state.callStack.slice(-1)[0]?.body.slice(-1)[0]
    if (stackTop === undefined) {
        state.lastFunc!.body.slice(-1)[0].events.push(event)
        return
    }
    if (stackTop.events?.slice(-1)[0]?.type === "Call") {
        stackTop.events.splice(stackTop.events.length - 1, 0, event)
        return
    }
    stackTop.events.push(event)
}

function stringify(code: Code) {
    let jsString = `import fs from 'fs'\n`
    jsString += `import path from 'path'\n`
    jsString += `const wasmBinary = fs.readFileSync(path.join(import.meta.dir, 'index.wasm'))\n`
    jsString += `let instance\n`
    jsString += 'let imports = {}\n'
    let instanciatedModules: string[] = []
    for (let funcidx in code.imports) {
        jsString += `let ${global(funcidx)} = -1\n`
        let func = code.imports[funcidx]
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
                            jsString += `new Uint8Array(instance.exports.memory.buffer)[${(event as Store).addr + j}] = ${byte}\n`
                        })
                        break
                    case 'MemGrow':
                        jsString += `instance.exports.memory.grow(${event.amount}) \n`
                        break
                    case 'TableSet':
                        break
                    case 'TableGrow':
                        break
                    case 'GlobalSet':
                        break
                }
            }
            jsString += `return ${b.results[0]} \n`
        })
        jsString += '}\n'
        jsString += '}\n'
    }
    jsString += `let wasm = await WebAssembly.instantiate(wasmBinary, imports) \n`
    jsString += `instance = wasm.instance\n`
    for (let exp of code.calls) {
        jsString += `await instance.exports.${exp} () \n`
    }
    return jsString
}

function global(funcidx: string) {
    return `global_${funcidx} `
}
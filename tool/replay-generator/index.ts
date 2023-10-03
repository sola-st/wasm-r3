const fs = require('fs')
const path = require('path')

type Code = {
    imports: {
        [key: string]: {
            module: string,
            name: string,
            body: {
                results: number[],
                stores: { addr: number, data: Uint8Array }[],
                // tables
                // globals
            }[]
        }
    }
    exports: string[]
}

export function generate(trace: Trace) {
    let code: Code = { imports: {}, exports: [] }
    let importCallStack: ImportCall[] = []
    let lastReturnedImportedFunction: number
    trace.forEach((event, i) => {
        switch (event.type) {
            case "ExportCall":
                // TODO: support for export calls with arguments
                code.exports.push(event.names[0])
                break
            case "ImportCall":
                importCallStack.push(event)
                let funcidx = event.funcidx
                if (code.imports[funcidx] === undefined) {
                    code.imports[funcidx] = {
                        module: event.module,
                        name: event.name,
                        body: [],
                    }
                }
                break
            case "ImportReturn":
                let call = importCallStack.pop()
                if (call === undefined) {
                    throw 'This cannot be you cannot return from an imported function without it being called'
                }
                lastReturnedImportedFunction = call.funcidx
                code.imports[call.funcidx].body.push({ results: event.results, stores: [] })
                break
            case "Load":
                code.imports[lastReturnedImportedFunction].body.slice(-1)[0].stores.push({
                    addr: event.offset,
                    data: event.data,
                })
                break
            case "TableGet":
                throw "TableGet not supported yet"
                break
            default:
                throw "Not a valid trace event"
        }
    })
    return stringify(code)
}

function stringify(code: Code) {
    let jsString = `const fs = await import('fs')\n`
    jsString += `const path = await import('path')\n`
    jsString += `let instance\n`
    jsString += 'let imports = {}\n'
    let instanciatedModules: string[] = []
    for (let funcidx in code.imports) {
        jsString += `${global(funcidx)} = 0\n`
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
            for (let store of b.stores) {
                store.data.forEach((byte, j) => {
                    jsString += `new Uint8Array(instance.exports.memory.buffer)[${store.addr + j}] = ${byte}\n`
                })
            }
            jsString += `return ${b.results[0]}\n`
            jsString += `break\n`
        })
        jsString += '}\n'
        jsString += '}\n'
    }
    jsString += `let wasmBinary = fs.readFileSync(path.join(__dirname, 'index.wasm'))\n`
    jsString += `let wasm = await WebAssembly.instantiate(wasmBinary, imports)\n`
    jsString += `instance = wasm.instance\n`
    for (let exp of code.exports) {
        jsString += `await instance.exports.${exp}()\n`
    }
    return jsString
}

export function parse(traceString: string) {
    let trace: Trace = []
    let events = traceString.trim().split('\n')
    for (let event of events) {
        let components = event.split(';')
        switch (components[0]) {
            case "ExportCall":
                trace.push({
                    type: components[0],
                    names: components[1]?.split(','),
                    params: splitList(components[2])
                })
                break
            case "ImportCall":
                trace.push({
                    type: components[0],
                    funcidx: parseInt(components[1]),
                    module: components[2],
                    name: components[3],
                })
                break
            case "ImportReturn":
                trace.push({
                    type: components[0],
                    funcidx: parseInt(components[1]),
                    results: splitList(components[2]),
                    // TODO: MemGrow and TableGrow
                    memGrow: [],
                    tableGrow: [],
                })
                break
            case "Load":
                trace.push({
                    type: components[0],
                    memidx: parseInt(components[1]),
                    offset: parseInt(components[2]),
                    data: new Uint8Array(splitList(components[3])),
                })
                break
            case "TableGet":
                trace.push({
                    type: components[0],
                    tableidx: parseInt(components[1]),
                    idx: parseInt(components[2]),
                    ref: components[3] as "funcref" | "externref"
                })
                throw "TableGet not supported yet"
                break
            default:
                throw "Not a valid trace event"
        }
    }
    return trace
}

function global(funcidx: string) {
    return `global_${funcidx}`
}

function splitList(c?: string) {
    let list = c?.split(',').map(parseNumber)
    if (list === undefined || (list.length === 1 && Number.isNaN(list[0]))) {
        return []
    }
    return list
}

function parseNumber(n: string) {
    if (n.includes('.')) {
        return parseFloat(n)
    }
    return parseInt(n)
}
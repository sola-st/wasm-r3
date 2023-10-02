const fs = require('fs')
const path = require('path')

type Code = {
    imports: {
        [key: string]: {
            module: string,
            name: string,
            mappings: {
                [params: string]: number[]
            }
            stores: { addr: number, data: Uint8Array }[]
        }
    }
    exports: string[]
}

export function generate(trace: Trace) {
    let code: Code = { imports: {}, exports: [] }
    let importCallStack: ImportCall[] = []
    let callHistory: ImportCall[] = []
    trace.forEach((event, i) => {
        switch (event.type) {
            case "ExportCall":
                // TODO: support for export calls with arguments
                code.exports.push(event.names[0])
                break
            case "ImportCall":
                importCallStack.push(event)
                let funcidx = 'func_' + event.funcidx
                if (code.imports[funcidx] === undefined) {
                    code.imports[funcidx] = {
                        module: event.module,
                        name: event.name,
                        mappings: {},
                        stores: []
                    }
                }
                let params = stringifyParams(event.params)
                if (params === '') {
                    break
                }
                if (code.imports[funcidx].mappings[params] === undefined) {
                    code.imports[funcidx].mappings[params] = []
                }
                break
            case "ImportReturn":
                let call = importCallStack.pop()
                if (call === undefined) {
                    throw 'This cannot be you cannot return from an imported function without it being called'
                }
                callHistory.push(call)
                code.imports['func_' + call.funcidx].mappings[stringifyParams(call.params)] = event.results
                break
            case "Load":
                // This means that the load was different then expected,
                // there was a store in the host code
                // find the last returned function
                for (let j = i; j >= 0; j--) {
                    if (trace[j].type === "ImportReturn") {
                        let funcidx = (trace[j] as ImportReturn).funcidx
                        if (funcidx === callHistory[callHistory.length - 1].funcidx) {
                            code.imports['func_' + funcidx].stores.push({
                                addr: event.offset,
                                data: event.data,
                            })
                        }
                    }
                }
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
        let func = code.imports[funcidx]
        if (!instanciatedModules.includes(func.module)) {
            jsString += `imports.${func.module} = {}\n`
            instanciatedModules.push(func.module)
        }
        jsString += `imports.${func.module}.${func.name} = `
        let paramString = Object.keys(func.mappings)[0]
        let args = parseParams(paramString)
        let argString = ''
        for (let i = 0; i < args.length; i++) {
            argString += `a${i}, `
        }
        argString = argString.slice(0, argString.length - 2)
        jsString += `(${argString}) => {\n`
        for (let store of code.imports[funcidx].stores) {
            for (let i = 0; i < store.data.length; i++) {
                jsString += `new Uint8Array(instance.exports.memory)[${store.addr + i}] = ${store.data[i]}\n`
            }
        }
        for (let paramString in func.mappings) {
            if (func.mappings[paramString] === undefined || paramString === '') {
                continue
            }
            let params = parseParams(paramString)
            jsString += 'if ('
            params.map((p, i) => {
                jsString += `a${i} === ${p}`
                if (i < params.length - 1) {
                    jsString += ' && '
                }
            })
            jsString += ') {\n'
            let returnString = ''
            for (let value of func.mappings[paramString]) {
                returnString += value.toString() + ', '
            }
            returnString = returnString.slice(0, returnString.length - 2)
            jsString += `return ${returnString}\n`
            jsString += '}\n'
        }
        jsString += '}\n'
    }
    jsString += `let wasmBinary = fs.readFileSync(path.join(import.meta.dir, 'index.wasm'))\n`
    jsString += `let wasm = await WebAssembly.instantiate(wasmBinary, imports)\n`
    jsString += `instance = wasm.instance\n`
    for (let exp of code.exports) {
        jsString += `await instance.exports.${exp}()\n`
    }
    return jsString
}

function stringifyParams(params: number[]) {
    let paramString = ''
    for (let param of params) {
        paramString += param.toString() + '_'
    }
    paramString = paramString.replaceAll('.', 'd')
    paramString = paramString.replaceAll('-', 'n')
    paramString = paramString.slice(0, paramString.length - 1)
    return paramString
}

function parseParams(params: string) {
    if (params === '') {
        return []
    }
    return params.replaceAll('d', '.').replaceAll('n', '-').split('_')
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
                    params: components[2]?.split(',').map(parseNumber) || []
                })
                break
            case "ImportCall":
                trace.push({
                    type: components[0],
                    funcidx: parseInt(components[1]),
                    module: components[2],
                    name: components[3],
                    params: components[4]?.split(',').map(parseNumber) || []
                })
                break
            case "ImportReturn":
                trace.push({
                    type: components[0],
                    funcidx: parseInt(components[1]),
                    results: components[2]?.split(',').map(parseNumber) || [],
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
                    data: new Uint8Array(components[3]?.split(',').map(parseNumber)),
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

function parseNumber(n: string) {
    if (n.includes('.')) {
        return parseFloat(n)
    }
    return parseInt(n)
}
const fs = require('fs')
const path = require('path')

type Code = {
    imports: { [key: string]: { [key: string]: { [key: string]: number[] } } }
    exports: string[]
}

export function generate(trace: Trace) {
    let code: Code = { imports: {}, exports: [] }
    let importCallStack: ImportCall[] = []
    for (let event of trace) {
        switch (event.type) {
            case "ExportCall":
                // TODO: support for export calls with arguments
                code.exports.push(event.names[0])
                break
            case "ImportCall":
                importCallStack.push(event)
                if (code.imports[event.module] === undefined) {
                    code.imports[event.module] = {}
                }
                if (code.imports[event.module][event.name] === undefined) {
                    code.imports[event.module][event.name] = {}
                }
                let params = stringifyParams(event.params)
                if (code.imports[event.module][event.name][params] === undefined) {
                    code.imports[event.module][event.name][params] = []
                }
                break
            case "ImportReturn":
                let call = importCallStack.pop()
                if (call === undefined) {
                    throw 'This cannot be you cannot return from an imported function without it being called'
                }
                code.imports[call.module][call.name][stringifyParams(call.params)] = event.results
                break
            case "Load":
                throw 'Load not supported yet'
                break
            case "TableGet":
                throw "TableGet not supported yet"
                break
            default:
                throw "Not a valid trace event"
        }
    }
    return stringify(code)
}

function stringify(code: Code) {
    let jsString = 'const imports = {\n'
    for (let module in code.imports) {
        jsString += module + ': {\n'
        for (let name in code.imports[module]) {
            let key = Object.keys(code.imports[module][name])[0]
            let args = parseParams(key)
            let argString = ''
            for (let i = 0; i < args.length; i++) {
                argString += `a${i}, `
            }
            argString = argString.slice(0, argString.length - 2)
            jsString += name + `: (${argString}) => {\n`
            for (let args in code.imports[module][name]) {
                if (code.imports[module][name][args] === undefined) {
                    continue
                }
                let params = parseParams(args)
                jsString += 'if ('
                params.map((p, i) => {
                    jsString += `a${i} === ${p}`
                    if (i < params.length - 1) {
                        jsString += ' && '
                    }
                })
                jsString += ') {\n'
                let returnString = ''
                for (let value of code.imports[module][name][args]) {
                    returnString += value.toString() + ', '
                }
                returnString = returnString.slice(0, returnString.length - 2)
                jsString += `return ${returnString}\n`
                jsString += '}\n'
            }
            jsString += '},\n'
        }
        jsString += '},\n'
    }
    jsString += '}\n'
    const wasmPath = './index.wasm'
    jsString += `const wasmBinary = fs.readFileSync('${wasmPath}')\n`
    jsString += `const { instance } = await WebAssembly.instantiate(wasmBinary, imports)\n`
    for (let exp of code.exports) {
        jsString += `instance.exports.${exp}()\n`
    }
    return jsString
}

function stringifyParams(params: number[]) {
    let paramString = ''
    for (let param of params) {
        paramString += param.toString() + '_'
    }
    paramString.replaceAll('.', 'd')
    paramString = paramString.slice(0, paramString.length - 1)
    return paramString
}

function parseParams(params: string) {
    return params.replaceAll('d', '.').split('_')
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
                    params: components[2]?.split(',').map(parseNumber)
                })
                break
            case "ImportCall":
                trace.push({
                    type: components[0],
                    module: components[1],
                    name: components[2],
                    params: components[3]?.split(',').map(parseNumber)
                })
                break
            case "ImportReturn":
                trace.push({
                    type: components[0],
                    results: components[1]?.split(',').map(parseNumber),
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
                throw 'Load not supported yet'
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
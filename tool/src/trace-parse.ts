export default function parse(traceString: string) {
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
            case "MemGrow":
                trace.push({
                    type: components[0],
                    memidx: parseInt(components[1]),
                    amount: parseInt(components[2])
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
            case "TableGrow":
                trace.push({
                    type: components[0],
                    tableidx: parseInt(components[1]),
                    amount: parseInt(components[2])
                })
                throw "TableGet not supported yet"
                break
            default:
                throw "Not a valid trace event"
        }
    }
    return trace
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
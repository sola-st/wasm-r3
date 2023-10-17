export default function stringifyTrace(trace: Trace) {
    function str(list: Iterable<any>) {
        let s = ""
        for (let l of list) {
            s += l + ","
        }
        return s.slice(0, -1)
    }
    let traceString = ""
    for (let t of trace) {
        switch (t.type) {
            case "Load":
                traceString += "Load;" + t.name + ";" + t.offset + ";" + str(t.data)
                break
            case 'MemGrow':
                traceString += 'MemGrow;' + t.name + ';' + t.amount
                break
            case "TableGet":
                traceString += "TableGet;" + t.tableidx + ";" + t.idx + ";" + t.ref
                break
            case 'TableGrow':
                traceString += 'TableGrow;' + t.tableidx + ';' + t.amount
                break
            case 'GlobalGet':
                traceString += 'GlobalGet;' + t.globalidx + ';' + t.value
                break
            case "ExportCall":
                traceString += "ExportCall;" + str(t.names)
                break
            case "ImportCall":
                traceString += "ImportCall;" + t.funcidx + ';' + t.module + ";" + t.name
                break
            case "ImportReturn":
                traceString += "ImportReturn;" + t.funcidx + ';' + str(t.results)
                break
            case 'ImportMemory':
                traceString += 'ImportMemory;' + t.module + ';' + t.name
                break
            default:
                throw `Invalid Trace event type: ${t.type}`
        }
        traceString += "\n"
    }
    return traceString
}
import { unreachable } from "./util"

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
                traceString += "Load" + ';' + t.idx + ';' + t.name + ";" + t.offset + ";" + str(t.data)
                break
            case 'MemGrow':
                traceString += 'MemGrow' + ';' + t.idx + ';' + t.name + ';' + t.amount
                break
            case "TableGet":
                traceString += "TableGet" + ';' + t.tableidx + ';' + t.name + ";" + t.idx
                break
            case 'TableGrow':
                traceString += 'TableGrow' + ';' + t.idx + ';' + t.name + ';' + t.amount
                break
            case 'GlobalGet':
                traceString += 'GlobalGet' + ';' + t.idx + ';' + t.name + ';' + t.value + ';' + t.valtype
                break
            case "ExportCall":
                traceString += "ExportCall" + ';' + str(t.names) + ';' + str(t.params)
                break
            case "ImportCall":
                traceString += "ImportCall" + ';' + t.idx + ';' + t.name
                break
            case "ImportReturn":
                traceString += "ImportReturn" + ';' + t.idx + ';' + t.name + ';' + str(t.results)
                break
            case 'ImportMemory':
                traceString += 'ImportMemory' + ';' + t.idx + ';' + t.module + ';' + t.name + ';' + t.pages
                break
            case 'ImportGlobal':
                traceString += 'ImportGlobal' + ';' + t.idx + ';' + t.module + ';' + t.name + ';' + t.valtype + ';' + t.value
                break
            case 'ImportFunc':
                traceString += 'ImportFunc' + ';' + t.idx + ';' + t.module + ';' + t.name
                break
            case 'ImportTable':
                traceString + 'ImportTable' + ';' + t.idx + ';' + t.module + ';' + t.type + ';' + t.reftype
                break
            default:
                unreachable(t)
        }
        traceString += "\n"
    }
    return traceString
}
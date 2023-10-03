export default function stringifyTrace(trace) {
    function str(list) {
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
                traceString += "Load;" + t.memidx + ";" + t.offset + ";" + str(t.data)
                break
            case "TableGet":
                traceString += "TableGet;" + t.tableidx + ";" + t.idx + ";" + t.ref
                break
            case "ExportCall":
                traceString += "ExportCall;" + str(t.names)
                break
            case "ImportCall":
                traceString += "ImportCall;" + t.funcidx + ';' + t.module + ";" + t.name
                break
            case "ImportReturn":
                traceString += "ImportReturn;" + t.funcidx + ';' + str(t.results) + ";" + str(t.memGrow) + ";" + str(t.tableGrow)
                break
            default:
                throw "Invalid Trace event type"
        }
        traceString += "\n"
    }
    return traceString
}
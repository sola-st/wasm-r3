let trace = []
let shadowMemory = []
// TODO: let shadowTables = []

let init = true
Wasabi.analysis = {

    begin(location, type) {
        if (init) {
            shadowMemory = _.cloneDeep(Wasabi.module.exports.memory.buffer)
            // TODO: shadowTables init
            init = false
        }
        if (type === "function") {
            trace.push({ type: "ExportCall", names: Wasabi.module.info.functions[location.func].export })
        }
    },

    store(location, op, memarg, value) {
        // TODO: actual support for store with different datatypes. Uint8Array servers only as a dummy here
        let shadowArray = new Uint8Array(shadowMemory)
        if (shadowArray[memarg.addr] === value) {
            return
        }
        shadowArray[memarg.addr] = value
    },

    // TODO: bulk memory instructions

    memory_grow(location, byPages, previousSizePages) {
        shadowMemory.grow(byPages)
    },

    load(location, op, memarg, value) {
        // TODO: actual support for load with different datatypes. Uint8Array serves only as a dummy here
        let shadowArray = new Uint8Array(shadowMemory)
        if (shadowArray[memarg.addr] === new Uint8Array(Wasabi.module.exports.memory.buffer)[memarg.addr]) {
            return
        }
        shadowArray[memarg.addr] = value
        trace.push({ type: "Load", memidx: 1, offset: memarg.addr, data: value })
    },

    // TODO: table_set
    // TODO: table_grow
    // TODO: table_get


    call_pre(location, targetFunc, args, indirectTableIdx) {
        trace.push({ type: "ImportCall", funcidx: targetFunc, params: args })
    },

    call_post(location, values) {
        let importReturn = {
            type: "ImportReturn",
            results: values,
            memGrow: [],
            tableGrow: [],
        }
        if (Wasabi.module.exports.memory.buffer.byteLength > shadowMemory.byteLength) {
            // TODO: grow memory
        }
        // TODO: check if table needs to be grown and grow it
        trace.push(importReturn)
    },
}

function stringifyTrace(trace) {
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
                traceString += "Load;" + t.memidx + ";" + t.offset + ";" + t.data
                break
            case "TableGet":
                traceString += "TableGet;" + t.tableidx + ";" + t.idx + ";" + t.ref
                break
            case "ExportCall":
                traceString += "ExportCall;" + str(t.names)
                break
            case "ImportCall":
                traceString += "ImportCall;" + t.module + ";" + t.name + ";" + str(t.params)
                break
            case "ImportReturn":
                traceString += "ImportReturn;" + str(t.results) + ";" + str(t.memGrow) + ";" + str(t.tableGrow)
                break
            default:
                throw "Invalid Trace event type"
        }
        traceString += "\n"
    }
    return traceString
}
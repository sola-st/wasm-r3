let trace = []
let shadowMemory = []
let actualMemory
// TODO: let shadowTables = []

let init = true
Wasabi.analysis = {

    begin(location, type) {
        if (init) {
            actualMemory = Wasabi.module.exports.memory.buffer
            shadowMemory = _.cloneDeep(actualMemory)
            // TODO: shadowTables init
            init = false
        }
        if (type === "function") {
            console.log(Wasabi)
            trace.push({ type: "ExportCall", names: Wasabi.module.info.functions[location.func].export, params: [] })
        }
    },

    store(location, op, memarg, value) {
        let addr = memarg.addr
        let data
        switch (op) {
            case 'i32.store':
                data = get_actual_mem(addr, 4)
                set_shadow_memory(data, addr, 4)
                break;
            case 'i32.store8':
                data = get_actual_mem(addr, 4)
                set_shadow_memory(data, addr, 1)
                break;
            case 'i32.store16':
                data = get_actual_mem(addr, 4)
                set_shadow_memory(data, addr, 2)
                break;
            case 'i64.store':
                data = get_actual_mem(addr, 8)
                set_shadow_memory(data, addr, 8)
                break;
            case 'i64.store8':
                data = get_actual_mem(addr, 8)
                set_shadow_memory(data, addr, 1)
                break;
            case 'i64.store16':
                data = get_actual_mem(addr, 8)
                set_shadow_memory(data, addr, 2)
                break;
            case 'i64.store32':
                data = get_actual_mem(addr, 8)
                set_shadow_memory(data, addr, 4)
                break;
            case 'f32.store':
                data = get_actual_mem(addr, 4)
                set_shadow_memory(data, addr, 4)
                break;
            case 'f64.store':
                data = get_actual_mem(addr, 8)
                set_shadow_memory(data, addr, 8)
                break;
            default:
                throw `instruction ${op} not supported`
            // TODO: support for remaining store instructions
        }
    },

    // TODO: bulk memory instructions

    memory_grow(location, byPages, previousSizePages) {
        shadowMemory.grow(byPages)
    },

    load(location, op, memarg, value) {
        let addr = memarg.addr
        let shadow
        let data
        switch (op) {
            case 'i32.load':
                if (mem_content_equals(addr, 4)) {
                    return
                }
                data = get_actual_mem(addr, 4)
                set_shadow_memory(data, addr, 4)
                break
            case 'i32.load8_s':
                if (mem_content_equals(addr, 1)) {
                    return
                }
                data = get_actual_mem(addr, 1)
                set_shadow_memory(data, addr, 1)
                break
            case 'i32.load8_u':
                if (mem_content_equals(addr, 1)) {
                    return
                }
                data = get_actual_mem(addr, 1)
                set_shadow_memory(data, addr, 1)
                break
            case 'i32.load16_s':
                if (mem_content_equals(addr, 2)) {
                    return
                }
                data = get_actual_mem(addr, 2)
                set_shadow_memory(data, addr, 2)
                break
            case 'i32.load16_u':
                if (mem_content_equals(2)) {
                    return
                }
                data = get_actual_mem(addr, 2)
                set_shadow_memory(data, addr, 2)
                break
            case 'i64.load':
                if (mem_content_equals(addr, 8)) {
                    return
                }
                data = get_actual_mem(addr, 8)
                set_shadow_memory(data, addr, 8)
                break
            case 'i64.load8_s':
                if (mem_content_equals(addr, 1)) {
                    return
                }
                data = get_actual_mem(addr, 1)
                set_shadow_memory(data, addr, 1)
                break
            case 'i64.load8_u':
                if (mem_content_equals(addr, 1)) {
                    return
                }
                data = get_actual_mem(addr, 1)
                set_shadow_memory(data, addr, 1)
                break
            case 'i64.load16_s':
                if (mem_content_equals(addr, 2)) {
                    return
                }
                data = get_actual_mem(addr, 2)
                set_shadow_memory(data, addr, 2)
                break
            case 'i64.load16_u':
                if (mem_content_equals(addr, 2)) {
                    return
                }
                data = get_actual_mem(addr, 2)
                set_shadow_memory(data, addr, 2)
                break
            case 'i64.load32_s':
                if (mem_content_equals(addr, 4)) {
                    return
                }
                data = get_actual_mem(addr, 4)
                set_shadow_memory(data, addr, 4)
                break
            case 'i64.load32_u':
                if (mem_content_equals(addr, 4)) {
                    return
                }
                data = get_actual_mem(addr, 4)
                set_shadow_memory(data, addr, 4)
                break
            case 'f32.load':
                if (mem_content_equals(addr, 4)) {
                    return
                }
                data = get_actual_mem(addr, 4)
                set_shadow_memory(data, addr, 4)
                break
            case 'f64.load':
                if (mem_content_equals(addr, 8)) {
                    return
                }
                data = get_actual_mem(addr, 8)
                set_shadow_memory(data, addr, 8)
                break
            default:
                throw `instruction ${op} not supported`
            // TODO: Support all loads
        }

        trace.push({ type: "Load", memidx: 1, offset: addr, data })
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
                traceString += "Load;" + t.memidx + ";" + t.offset + ";" + str(t.data)
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

function set_shadow_memory(data, address, numBytes) {
    for (let i = 0; i < numBytes; i++) {
        let shadowArray = new Uint8Array(shadowMemory)
        shadowArray[address + i] = data[i]
    }
}

function mem_content_equals(addr, numBytes) {
    for (let i = 0; i < numBytes; i++) {
        if (new Uint8Array(shadowMemory)[addr + i] !== new Uint8Array(actualMemory)[addr + i]) {
            return false
        }
    }
    return true
}

/**
 * Get the contents of the actual memory
 * @param {*} addr offset
 * @param {*} numBits how many Bits to read
 * @returns Memory is organized in little endian, so is the return value
 */
function get_actual_mem(addr, numBytes) {
    let uint1Array = new Uint8Array(numBytes)
    for (let i = 0; i < numBytes; i++) {
        uint1Array[i] = new Uint8Array(actualMemory)[addr + i]
    }
    return uint1Array
}
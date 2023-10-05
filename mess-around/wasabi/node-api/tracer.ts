export default function (runtimePath: string) {
    const _ = require('lodash')
    const Wasabi = require(runtimePath) as Wasabi

    const MEM_PAGE_SIZE = 65536

    let trace: any = []
    let shadowMemory: any = []
    let actualMemory: any
    // TODO: let shadowTables = []

    let init = true
    Wasabi.analysis = {

        begin(location, type) {
            if (init) {
                // Algorithm for later
                assignMemory()
                shadowMemory = _.cloneDeep(actualMemory)
                // TODO: shadowTables init
                init = false
            }
            if (type === "function") {
                trace.push({ type: "ExportCall", names: Wasabi.module.info.functions[location.func].export, params: [] })
                checkMemGrow()
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
            growShadowMem(byPages)
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
                    if (mem_content_equals(addr, 2)) {
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

        global(location, op, globalIndex, value) {
            trace.push({ type: 'GlobalGet', globalidx: globalIndex, value })
        },


        call_pre(location, targetFunc, args, indirectTableIdx) {
            let module = Wasabi.module.info.functions[targetFunc].import[0]
            let name = Wasabi.module.info.functions[targetFunc].import[1]
            trace.push({ type: "ImportCall", funcidx: targetFunc, module, name })
        },

        call_post(location, values) {
            let funcidx
            for (let i = trace.length - 1; i >= 0; i--) {
                if (trace[i].type === 'ImportCall') {
                    funcidx = trace[i].funcidx
                }
            }
            if (funcidx === undefined) {
                throw 'this cannot be, there must be a call before a return event'
            }
            let importReturn = {
                type: "ImportReturn",
                funcidx,
                results: values,
                memGrow: [],
                tableGrow: [],
            }
            trace.push(importReturn)
            checkMemGrow()
            // TODO: check if table needs to be grown and grow it
        },
    }

    function set_shadow_memory(data: any, address: any, numBytes: any) {
        for (let i = 0; i < numBytes; i++) {
            let shadowArray = new Uint8Array(shadowMemory)
            shadowArray[address + i] = data[i]
        }
    }

    function mem_content_equals(addr: any, numBytes: any) {
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
    function get_actual_mem(addr: any, numBytes: any) {
        let uint1Array = new Uint8Array(numBytes)
        for (let i = 0; i < numBytes; i++) {
            uint1Array[i] = new Uint8Array(actualMemory)[addr + i]
        }
        return uint1Array
    }

    function assignMemory() {
        // if (Wasabi.module.info.memories !== undefined) {
        //     for (let mem of Wasabi.module.info.memories) {
        //         if (mem.export.length >= 1) {
        //             actualMemory = mem.memory.buffer
        //         }
        //     }
        // }
        if (Wasabi.module.exports.memory !== undefined) {
            actualMemory = Wasabi.module.exports.memory.buffer
        }
    }

    function growShadowMem(byPages: any) {
        const newShadow = new ArrayBuffer(shadowMemory.byteLength + byPages * MEM_PAGE_SIZE)
        new Uint8Array(shadowMemory).forEach((b, i) => {
            new Uint8Array(newShadow)[i] = b
        })
        shadowMemory = newShadow
    }

    function checkMemGrow() {
        let memoryWasGrown = actualMemory && actualMemory.byteLength === 0
        if (memoryWasGrown) {
            assignMemory()
            let memGrow: any = {}
            let amount = actualMemory.byteLength / MEM_PAGE_SIZE - shadowMemory.byteLength / MEM_PAGE_SIZE
            memGrow[0] = amount
            growShadowMem(amount)
            trace.push({ type: 'MemGrow', memidx: 0, amount })
        }
    }

    function stringifyTrace(trace: any) {
        function str(list: any) {
            let s = ""
            for (let l of list) {
                s += l + ","
            }
            return s.slice(0, -1)
        }
        function objectify(o: any) {
            let s = ''
            for (let i in o) {
                s += i + ':' + o[i] + ','
            }
            return s.slice(0, -1)
        }
        let traceString = ""
        for (let t of trace) {
            switch (t.type) {
                case "Load":
                    traceString += "Load;" + t.memidx + ";" + t.offset + ";" + str(t.data)
                    break
                case 'MemGrow':
                    traceString += 'MemGrow;' + t.memidx + ';' + t.amount
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
                    traceString += "ImportReturn;" + t.funcidx + ';' + str(t.results) + ";" + objectify(t.memGrow) + ";" + objectify(t.tableGrow)
                    break
                default:
                    throw "Invalid Trace event type"
            }
            traceString += "\n"
        }
        return traceString
    }

    return trace
}
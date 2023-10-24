import _ from 'lodash'
import { Wasabi } from '../wasabi.cjs'
import { Trace, ImportCall, ImportReturn } from '../trace.d.cjs'

export default function (runtimePath: string) {
    let Wasabi: Wasabi = require(runtimePath)

    const MEM_PAGE_SIZE = 65536

    let trace: Trace = []

    // shadow stuff
    let shadowMemories: ArrayBuffer[] = []
    let shadowGlobals: number[] = []
    let shadowTables: WebAssembly.Table[] = []

    // helpers
    let init = true
    let calledFunction: number | null = null

    Wasabi.analysis = {

        begin_function(location, args) {
            if (init) {
                Wasabi.module.memories.forEach((mem, i) => {
                    let isImported = Wasabi.module.info.memories[i].import !== null
                    if (isImported) {
                        shadowMemories.push(new ArrayBuffer(mem.buffer.byteLength))
                    } else {
                        shadowMemories.push(_.cloneDeep(mem.buffer))
                    }
                })
                Wasabi.module.info.memories.forEach((m, idx) => {
                    if (m.import !== null) {
                        trace.push({ type: 'ImportMemory', module: m.import[0], name: m.import[1], pages: Wasabi.module.memories[idx].buffer.byteLength / MEM_PAGE_SIZE, idx })
                    }
                })
                // shadowTables = _.cloneDeep(Wasabi.module.tables)
                Wasabi.module.tables.forEach((t, i) => {
                    shadowTables.push(new WebAssembly.Table({ initial: Wasabi.module.tables[i].length, element: 'anyfunc' }))
                    for (let y = 0; y < Wasabi.module.tables[i].length; y++) {
                        shadowTables[i].set(y, t.get(y))
                    }
                })
                Wasabi.module.info.tables.forEach((t, idx) => {
                    if (t.import !== null) {
                        trace.push({ type: 'ImportTable', module: t.import![0], name: t.import![1], element: 'anyfunc', idx, initial: Wasabi.module.tables[idx].length })
                    }
                })
                shadowGlobals = _.cloneDeep(Wasabi.module.globals.map(g => g.value))
                Wasabi.module.info.globals.forEach((g, idx) => {
                    if (g.import !== null) {
                        trace.push({ type: 'ImportGlobal', module: g.import[0], name: g.import[1], valtype: g.valType, value: Wasabi.module.globals[idx].value, idx })
                    }
                })
                Wasabi.module.info.functions.forEach((f, idx) => {
                    if (f.import !== null) {
                        trace.push({ type: 'ImportFunc', module: f.import![0], name: f.import[1], idx })
                    }
                })

                init = false
            }
            if (calledFunction === null) {
                trace.push({ type: "ExportCall", names: Wasabi.module.info.functions[location.func].export, params: args })
                checkMemGrow()
                checkTableGrow()
            } else {
                calledFunction = null
            }
        },

        store(location, op, target, memarg, value) {
            let addr = target.addr + memarg.offset
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
                    throw new Error(`instruction ${op} not supported`)
                // TODO: support for remaining store instructions
            }
        },

        // TODO: bulk memory instructions

        memory_grow(location, memIdx, byPages, previousSizePages) {
            growShadowMem(byPages)
        },

        load(location, op, target, memarg, value) {
            let addr = target.addr
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
                    throw new Error(`instruction ${op} not supported`)
                // TODO: Support all loads
            }
            trace.push({ type: "Load", name: getMemName(), offset: addr, data, idx: 0 })
        },

        global(location, op, globalIndex, value) {
            if (op === 'global.set') {
                shadowGlobals[globalIndex] = value
                return
            }
            if (shadowGlobals[globalIndex] !== value) {
                let valtype = Wasabi.module.info.globals[globalIndex].valType
                trace.push({ type: 'GlobalGet', name: getGlobalName(globalIndex), value, valtype, idx: globalIndex })
            }
        },


        call_pre(location, op, targetFunc, args, tableTarget) {
            if (tableTarget !== undefined) {
                let indirectTableIdx = tableTarget.elemIdx
                if (!_.isEqual(shadowTables[0].get(indirectTableIdx), Wasabi.module.tables[0].get(indirectTableIdx))) {
                    trace.push({ type: 'TableGet', tableidx: 0, name: getTableName(), idx: indirectTableIdx, funcidx: targetFunc, funcName: getFuncName(targetFunc) })
                    shadowTables[0].set(0, Wasabi.module.tables[0].get(indirectTableIdx))
                    let name
                    if (Wasabi.module.info.functions[targetFunc].import === null) {
                        calledFunction = targetFunc
                        return
                    } else {
                        name = Wasabi.module.info.functions[targetFunc].import[1]
                    }
                    trace.push({ type: "ImportCall", name, idx: targetFunc })
                }
            }
            if (Wasabi.module.info.functions[targetFunc].import === null) {
                calledFunction = targetFunc;
                return
            }
            // let module = Wasabi.module.info.functions[targetFunc].import[0]
            let name = Wasabi.module.info.functions[targetFunc].import[1]
            trace.push({ type: "ImportCall", name, idx: targetFunc })
        },

        call_post(location, values) {
            let name
            let idx
            let returnCounter = 0
            for (let i = trace.length - 1; i >= 0; i--) {
                if (trace[i].type === 'ImportReturn') {
                    returnCounter++
                }
                if (trace[i].type === 'ImportCall') {
                    if (returnCounter > 0) {
                        returnCounter--
                        continue
                    }
                    name = (trace[i] as ImportCall).name
                    idx = (trace[i] as ImportCall).idx
                    break
                }
            }
            if (name === undefined || idx === undefined) {
                return
            }
            let importReturn: ImportReturn = {
                type: "ImportReturn",
                name,
                results: values,
                idx
            }
            trace.push(importReturn)
            checkMemGrow()
            checkTableGrow()
        },

        table_set(location, target, value) {
            shadowTables[0].set(target.elemIdx, value)
        },

        table_get(location, target, value) {
            let index = target.elemIdx
            if (!_.isEqual(shadowTables[0].get(index), Wasabi.module.tables[0].get(index))) {
                trace.push({ type: 'TableGet', tableidx: 0, name: getTableName(), idx: index, funcidx: parseInt(Wasabi.module.tables[0].get(index).name), funcName: getFuncName(parseInt(Wasabi.module.tables[0].get(index).name) - Object.keys(Wasabi.module.lowlevelHooks).length) })
                shadowTables[0].set(0, value)
            }
        }
    }

    function set_shadow_memory(data: Uint8Array, address: number, numBytes: number) {
        for (let i = 0; i < numBytes; i++) {
            let shadowArray = new Uint8Array(shadowMemories[0])
            shadowArray[address + i] = data[i]
        }
    }

    function mem_content_equals(addr: number, numBytes: number) {
        for (let i = 0; i < numBytes; i++) {
            if (new Uint8Array(shadowMemories[0])[addr + i] !== new Uint8Array(Wasabi.module.memories[0].buffer)[addr + i]) {
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
    function get_actual_mem(addr: number, numBytes: number): Uint8Array {
        let uint1Array = new Uint8Array(numBytes)
        for (let i = 0; i < numBytes; i++) {
            uint1Array[i] = new Uint8Array(Wasabi.module.memories[0].buffer)[addr + i]
        }
        return uint1Array
    }

    function growShadowMem(byPages: number) {
        const newShadow = new ArrayBuffer(shadowMemories[0].byteLength + byPages * MEM_PAGE_SIZE)
        new Uint8Array(shadowMemories[0]).forEach((b, i) => {
            new Uint8Array(newShadow)[i] = b
        })
        shadowMemories[0] = newShadow
    }

    function growShadowTable(amount: number) {
        const newShadow = new WebAssembly.Table({ initial: Wasabi.module.tables[0].length + amount, element: 'anyfunc' })
        for (let i = 0; i < Wasabi.module.tables[0].length; i++) {
            newShadow.set(i, Wasabi.module.tables[0].get(i))
        }
        shadowTables[0] = newShadow
    }

    function checkMemGrow() {
        if (Wasabi.module.memories[0]?.buffer !== undefined && Wasabi.module.memories[0].buffer.byteLength !== shadowMemories[0].byteLength) {
            let memGrow: any = {}
            let amount = Wasabi.module.memories[0].buffer.byteLength / MEM_PAGE_SIZE - shadowMemories[0].byteLength / MEM_PAGE_SIZE
            memGrow[0] = amount
            growShadowMem(amount)
            trace.push({ type: 'MemGrow', name: getMemName(), amount, idx: 0 })
        }
    }

    function checkTableGrow() {
        if (Wasabi.module.tables[0] !== undefined && Wasabi.module.tables[0].length !== shadowTables[0].length) {
            let tableGrow: any = {}
            let amount = Wasabi.module.tables[0].length - shadowTables[0].length
            tableGrow[0] = amount
            growShadowTable(amount)
            trace.push({ type: 'TableGrow', name: getTableName(), amount, idx: 0 })
        }
    }

    function getMemName() {
        if (Wasabi.module.info.memories[0].import !== null) {
            return Wasabi.module.info.memories[0].import[1]
        } else {
            return Wasabi.module.info.memories[0].export[0]
        }
    }

    function getTableName() {
        if (Wasabi.module.info.tables[0].import !== null) {
            return Wasabi.module.info.tables[0].import[1]
        } else {
            return Wasabi.module.info.tables[0].export[0]
        }
    }

    function getGlobalName(idx: number) {
        if (Wasabi.module.info.globals[idx].import !== null) {
            return Wasabi.module.info.globals[idx].import[1]
        } else {
            return Wasabi.module.info.globals[idx].export[0]
        }
    }

    function getFuncName(idx: number) {
        if (Wasabi.module.info.functions[idx].import !== null) {
            return Wasabi.module.info.functions[idx].import[1]
        } else {
            return Wasabi.module.info.functions[idx].export[0]
        }
    }

    return trace
}
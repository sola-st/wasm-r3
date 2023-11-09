//@ts-nocheck
import { StoreOp, LoadOp, ImpExp} from '../wasabi.cjs'
import _ from 'lodash'
export default function tracer(runtimePath: string) {
let Wasabi = require(runtimePath)

const MEM_PAGE_SIZE = 65536

let trace: Trace = []

// shadow stuff
let shadowMemories: ArrayBuffer[] = []
let shadowGlobals: number[] = []
let shadowTables: WebAssembly.Table[] = []

// helpers
let first_entry = true
let currentWasmFunc: number | null = null
let extCallStack: { name: string, idx: number }[] = []

Wasabi.analysis = {
    start(location) { },
    nop(location) { },
    unreachable(location) { },
    if_(location, condition) { },
    br(location, target) { },
    br_if(location, conditionalTarget, condition) { },
    br_table(location, table, defaultTarget, tableIdx) { },
    begin(location, type) { },
    end(location, type, beginLocation, ifLocation) { },
    drop(location, value) { },
    select(location, cond, first, second) { },
    return_(location, values) { },
    const_(location, op, value) { },
    unary(location, op, input, result) { },
    binary(location, op, first, second, result) { },
    memory_size(location, memoryIdx, currentSizePages) { },
    local(location, op, localIndex, value) { },
    global(location, op, globalIndex, value) { },
    memory_fill(location, index, value, length) { },
    memory_copy(location, destination, source, length) { },
    memory_init(location, destination, source, length) { },
    table_size(location, currentSizeEntries) { },
    table_copy(location, destination, source, length) { },
    table_init(location, destination, source, length) { },
    table_grow(location, n, val, previusElement) { },
    table_fill(location, index, value, length) { },

    begin_function(location, args) {
        if (first_entry) {
            init()
            first_entry = false
        }
        if (currentWasmFunc === null) {
            trace.push({ type: "ExportCall", name: Wasabi.module.info.functions[location.func].export, params: args })
            checkMemGrow()
            checkTableGrow()
        } else {
            currentWasmFunc = null
        }
    },

    store(location, op, target, memarg, value) {
        if (shadowMemories.length === 0) {
            return
        }
        let addr = target.addr + memarg.offset
        let byteLength = getByteLength(op)
        let data = get_actual_mem(target.memIdx, addr, byteLength)
        set_shadow_memory(target.memIdx, addr, data)
    },

    memory_grow(location, memIdx, byPages, previousSizePages) {
        if (shadowMemories.length === 0) {
            return
        }
        growShadowMem(memIdx, byPages)
    },

    load(location, op, target, memarg, value) {
        if (shadowMemories.length === 0) {
            return
        }
        let addr = target.addr
        let numType = getByteLength(op)
        if (mem_content_equals(target.memIdx, addr, numType)) {
            return
        }
        let data = get_actual_mem(target.memIdx, addr, numType)
        set_shadow_memory(target.memIdx, addr, data)
        trace.push({ type: "Load", name: getName(Wasabi.module.info.memories[target.memIdx]), offset: addr, data, idx: 0 })
    },

    global(location, op, idx, value) {
        if (op === 'global.set') {
            shadowGlobals[idx] = value
            return
        }
        if (op === 'global.get') {
            let globalInfo = Wasabi.module.info.globals[idx]
            if (shadowGlobals[idx] !== value) {
                // console.log(location)
                // console.log(idx + ' ' + op + 'value', value)
                let valtype = globalInfo.valType
                trace.push({ type: 'GlobalGet', name: getName(globalInfo), value, valtype, idx })
            }
        }
    },

    call_pre(location, op, funcidx, args, tableTarget) {
        let funcImport = Wasabi.module.info.functions[funcidx].import
        if (op === 'call_indirect') {
            tableGetEvent(tableTarget.tableIdx, tableTarget.elemIdx)
        }
        if (funcImport === null) {
            currentWasmFunc = funcidx;
            return
        }
        let name = funcImport[1]
        extCallStack.push({ name, idx: funcidx })
        // console.log('CallPre: ' + name)
        trace.push({ type: "ImportCall", name, idx: funcidx })
    },

    call_post(location, results) {
        let func = extCallStack.pop()
        if (func === undefined) {
            return
        }
        // console.log('CallPost: ' + func.name)
        trace.push({ type: 'ImportReturn', name: func.name, results, idx: func.idx })
        checkMemGrow()
        checkTableGrow()
    },

    table_set(location, target, value) {
        shadowTables[target.tableIdx].set(target.elemIdx, value)
    },

    table_get(location, target, value) {
        tableGetEvent(target.tableIdx, target.elemIdx)
    }
}

function init() {
    // Init Memories
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
    // Init Tables
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
    // Init Globals
    shadowGlobals = _.cloneDeep(Wasabi.module.globals.map(g => g.value))
    Wasabi.module.info.globals.forEach((g, idx) => {
        if (g.import !== null) {
            trace.push({ type: 'ImportGlobal', module: g.import[0], name: g.import[1], valtype: g.valType, value: Wasabi.module.globals[idx].value, idx })
        }
    })
    // Init Functions
    Wasabi.module.info.functions.forEach((f, idx) => {
        if (f.import !== null) {
            trace.push({ type: 'ImportFunc', module: f.import![0], name: f.import[1], idx })
        }
    })
}

function set_shadow_memory(memIdx: number, addr: number, data: Uint8Array) {
    for (let i = 0; i < data.length; i++) {
        let shadowArray = new Uint8Array(shadowMemories[memIdx])
        shadowArray[addr + i] = data[i]
    }
}

function mem_content_equals(memIdx: number, addr: number, numBytes: number) {
    for (let i = 0; i < numBytes; i++) {
        if (new Uint8Array(shadowMemories[memIdx])[addr + i] !== new Uint8Array(Wasabi.module.memories[0].buffer)[addr + i]) {
            return false
        }
    }
    return true
}

function get_actual_mem(memIdx: number, addr: number, numBytes: number): number[] {
    let data = []
    for (let i = 0; i < numBytes; i++) {
        data.push(new Uint8Array(Wasabi.module.memories[memIdx].buffer)[addr + i])
    }
    return data
}

function tableGetEvent(tableidx: number, idx: number) {
    let table = Wasabi.module.tables[tableidx]
    let shadowTable = shadowTables[tableidx]
    if (!_.isEqual(shadowTable.get(idx), table.get(idx))) {
        let name = getName(Wasabi.module.info.tables[tableidx])
        let funcidx = parseInt(table.get(idx).name)
        let funcName = getName(Wasabi.module.info.functions[parseInt(table.get(idx).name) - Object.keys(Wasabi.module.lowlevelHooks).length])
        trace.push({ type: 'TableGet', tableidx, name, idx, funcidx, funcName })
        shadowTables[0].set(0, table.get(idx))
    }
}

function growShadowMem(memIdx, byPages: number) {
    const newShadow = new ArrayBuffer(shadowMemories[memIdx].byteLength + byPages * MEM_PAGE_SIZE)
    new Uint8Array(shadowMemories[memIdx]).forEach((b, i) => {
        new Uint8Array(newShadow)[i] = b
    })
    shadowMemories[0] = newShadow
}

function growShadowTable(tableIdx, amount: number) {
    const newShadow = new WebAssembly.Table({ initial: Wasabi.module.tables[0].length, element: 'anyfunc' })
    for (let i = 0; i < Wasabi.module.tables[tableIdx].length; i++) {
        newShadow.set(i, Wasabi.module.tables[tableIdx].get(i))
    }
    shadowTables[0] = newShadow
}

function checkMemGrow() {
    Wasabi.module.memories.forEach((mem, idx) => {
        if (mem.buffer.byteLength !== shadowMemories[idx].byteLength) {
            let memGrow: any = {}
            let amount = mem.buffer.byteLength / MEM_PAGE_SIZE - shadowMemories[idx].byteLength / MEM_PAGE_SIZE
            memGrow[idx] = amount
            growShadowMem(idx, amount)
            trace.push({ type: 'MemGrow', name: getName(Wasabi.module.info.memories[idx]), amount, idx })
        }
    })
}

function checkTableGrow() {
    Wasabi.module.tables.forEach((t, idx) => {
        if (t.length !== shadowTables[idx].length) {
            let tableGrow: any = {}
            let amount = Wasabi.module.tables[idx].length - shadowTables[idx].length
            tableGrow[idx] = amount
            growShadowTable(idx, amount)
            trace.push({ type: 'TableGrow', name: getName(Wasabi.module.info.tables[0]), amount, idx })
        }
    })
}

function getName(entity: ImpExp) {
    if (entity.import !== null) {
        return entity.import[1]
    } else {
        return entity.export[0]
    }
}

function getByteLength(instr: StoreOp | LoadOp) {
    return parseInt(instr.substring(1, 3)) / 8
}
return trace
}
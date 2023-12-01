import { StoreOp, LoadOp, ImpExp, Wasabi } from '../wasabi.cjs'
import { Trace as TraceType, ConsiseTrace, ValType, ConsiseWasmEvent, WasmEvent, Ref } from '../trace.d.cjs'
import { AnalysisI } from './analyser.cjs'

export class Trace {
    private trace: string[]
    private cache: string[] = []

    constructor() {
        this.trace = []
    }

    push(event: ConsiseWasmEvent | Ref) {
        const eventString = this.stringifyEvent(event)
        if (event[0] === 'IC' || event[0] === 'IR') {
            const cashIndex = this.cache.findIndex(v => v === eventString)
            // const cashIndex = this.cache.findIndex(v => this.eventEquals(v, event))
            if (cashIndex !== -1) {
                this.trace.push(cashIndex.toString())
                // this.trace.push([cashIndex])
                return
            } else {
                this.cache.push(eventString)
            }
        }
        this.trace.push(eventString)
    }

    private eventEquals(e1: ConsiseWasmEvent, e2: ConsiseWasmEvent) {
        !e1.some((f1, i) => {
            const f2 = e2[i]
            if (Array.isArray(f1) && Array.isArray(f2) && f1.length === f2.length) {
                f1.some((f1, j) => f1 !== e2[i][j])
            } else if (f1 === f2) {
                return false
            }
            return true
        })
    }

    into() {
        let trace: TraceType = []
        for (let eventString of this.trace) {
            let e = Trace.parseEvent(eventString)
            if (typeof e[0] === 'number') {
                e = Trace.parseEvent(this.cache[e[0]])
            }
            switch (e[0]) {
                case 'L':
                    trace.push({ type: 'Load', idx: e[1], name: e[2], offset: e[3], data: e[4] })
                    break
                case 'LE':
                    trace.push({ type: 'LoadExt', idx: e[1], name: e[2], offset: e[3], data: e[4] })
                    break
                case 'MG':
                    trace.push({ type: 'MemGrow', idx: e[1], name: e[2], amount: e[3] })
                    break
                case 'T':
                    trace.push({ type: 'TableGet', tableidx: e[1], name: e[2], idx: e[3], funcidx: e[4], funcName: e[5] })
                    break
                case 'TE':
                    trace.push({ type: 'TableGetExt', tableidx: e[1], name: e[2], idx: e[3], funcidx: e[4], funcName: e[5] })
                    break
                case 'TG':
                    trace.push({ type: 'TableGrow', idx: e[1], name: e[2], amount: e[3] })
                    break
                case 'G':
                    trace.push({ type: 'GlobalGet', idx: e[1], name: e[2], value: e[3], valtype: e[4] })
                    break
                case 'EC':
                    trace.push({ type: 'ExportCall', name: e[1], params: e[2] })
                    break
                case 'ER':
                    trace.push({ type: 'ExportReturn' })
                    break
                case 'IC':
                    trace.push({ type: 'ImportCall', idx: e[1], name: e[2] })
                    break
                case 'IR':
                    trace.push({ type: 'ImportReturn', idx: e[1], name: e[2], results: e[3] })
                    break
                case 'IM':
                    trace.push({ type: 'ImportMemory', idx: e[1], module: e[2], name: e[3], initial: e[4], maximum: e[5] })
                    break
                case 'IT':
                    trace.push({ type: 'ImportTable', idx: e[1], module: e[2], name: e[3], initial: e[4], maximum: e[5], element: e[6] })
                    break
                case 'IG':
                    trace.push({ type: 'ImportGlobal', idx: e[1], module: e[2], name: e[3], value: e[4], mutable: e[5] === 1, initial: e[6] })
                    break
                case 'IF':
                    trace.push({ type: 'ImportFunc', idx: e[1], module: e[2], name: e[3] })
                    break
                case 'FE':
                    trace.push({ type: 'FuncEntry', idx: e[1], args: e[2] })
                    break
                case 'FR':
                    trace.push({ type: 'FuncReturn', idx: e[1], values: e[2] })
                    break
                default:
                    throw new Error(`Unknown event type ${e[0]}`)
            }
        }
        return trace
    }

    private stringifyEvent(event: ConsiseWasmEvent | Ref) {
        let eventString = ''
        event.forEach((value, i) => {
            if (Array.isArray(value)) {
                value.forEach((item, i) => {
                    eventString += item
                    //@ts-ignore
                    if (i < value.length - 1) {
                        eventString += `,`
                    }
                })
            } else {
                if (value !== undefined && value !== null) {
                    eventString += value
                }
            }
            if (i < event.length - 1) {
                eventString += ';'
            }
        })
        return eventString
    }

    static parseEvent(event: string): ConsiseWasmEvent | Ref {
        if (Number.isFinite(Number(event))) {
            return [parseInt(event)]
        }
        function splitList(c?: string) {
            let list = c?.split(',').map(parseNumber)
            if (list === undefined || (list.length === 1 && Number.isNaN(list[0]))) {
                return []
            }
            return list
        }

        function parseNumber(n: string) {
            if (n.includes('.') || n.includes('e-') || n.includes('NaN') || n.includes('Infinity')) {
                return parseFloat(n)
            }
            return parseInt(n)
        }
        let components = event.split(';')
        switch (components[0]) {
            case 'IM':
                return [
                    components[0],
                    parseInt(components[1]),
                    components[2],
                    components[3],
                    parseInt(components[4]),
                    components[5] === '' ? undefined : parseInt(components[5])
                ]
            case "EC":
                return [
                    components[0],
                    components[1],
                    splitList(components[2])
                ]
            case 'ER':
                return [
                    components[0]
                ]
            case "IC":
                return [
                    components[0],
                    parseInt(components[1]),
                    components[2]
                ]
            case 'C':
                return [
                    components[0],
                    parseInt(components[1])
                ]
            case "IR":
                return [
                    components[0],
                    parseInt(components[1]),
                    components[2],
                    splitList(components[3]),
                ]
            case "L":
            case 'LE':
                return [
                    components[0],
                    parseInt(components[1]),
                    components[2],
                    parseInt(components[3]),
                    splitList(components[4]),
                ]
            case "MG":
                return [
                    components[0],
                    parseInt(components[1]),
                    components[2],
                    parseInt(components[3])
                ]
            case "T":
            case 'TE':
                return [
                    components[0],
                    parseInt(components[1]),
                    components[2],
                    parseInt(components[3]),
                    parseInt(components[4]),
                    components[5],
                ]
            case "TG":
                return [
                    components[0],
                    parseInt(components[1]),
                    components[2],
                    parseInt(components[3])
                ]
            case 'G':
                return [
                    components[0],
                    parseInt(components[1]),
                    components[2],
                    parseInt(components[3]),
                    components[4] as ValType,
                ]
            case 'IG':
                return [
                    components[0],
                    parseInt(components[1]),
                    components[2],
                    components[3],
                    components[4] as ValType,
                    parseInt(components[5]) as 0 | 1,
                    parseInt(components[6]),
                ]
            case 'IF':
                return [
                    components[0],
                    parseInt(components[1]),
                    components[2],
                    components[3],
                ]
            case 'IT':
                return [
                    components[0],
                    parseInt(components[1]),
                    components[2],
                    components[3],
                    parseInt(components[4]),
                    components[5] === '' ? undefined : parseInt(components[5]),
                    components[6] as 'anyfunc'
                ]
            case 'FE':
            case 'FR':
                return [
                    components[0],
                    parseInt(components[1]),
                    splitList(components[2]),
                ]
            case 'S':
                return [
                    components[0],
                    parseInt(components[1]),
                    splitList(components[2]),
                ]
            default:
                throw new Error(`${components[0]}: Not a valid trace event. The whole event: ${event}.`)
        }
    }

    static parseEventToObj(event: string): WasmEvent {
        if (Number.isFinite(Number(event))) {
            throw new Error('you cannot parse an unresolved event to an object')
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
        let components = event.split(';')
        switch (components[0]) {
            case 'IM':
                return {
                    type: 'ImportMemory',
                    idx: parseInt(components[1]),
                    module: components[2],
                    name: components[3],
                    initial: parseInt(components[4]),
                    maximum: components[5] === '' ? undefined : parseInt(components[5])
                }
            case "EC":
                return {
                    type: 'ExportCall',
                    name: components[1],
                    params: splitList(components[2])
                }
            case 'ER':
                return {
                    type: 'ExportReturn'
                }
            case "IC":
                return {
                    type: 'ImportCall',
                    idx: parseInt(components[1]),
                    name: components[2]
                }
            case 'C':
                return {
                    type: 'Call',
                    idx: parseInt(components[1])
                }
            case "IR":
                return {
                    type: 'ImportReturn',
                    idx: parseInt(components[1]),
                    name: components[2],
                    results: splitList(components[3]),
                }
            case "L":
                return {
                    type: 'Load',
                    idx: parseInt(components[1]),
                    name: components[2],
                    offset: parseInt(components[3]),
                    data: splitList(components[4]),
                }
            case "LE":
                return {
                    type: 'LoadExt',
                    idx: parseInt(components[1]),
                    name: components[2],
                    offset: parseInt(components[3]),
                    data: splitList(components[4]),
                }
            case "MG":
                return {
                    type: 'MemGrow',
                    idx: parseInt(components[1]),
                    name: components[2],
                    amount: parseInt(components[3])
                }
            case "T":
                return {
                    type: 'TableGet',
                    tableidx: parseInt(components[1]),
                    name: components[2],
                    idx: parseInt(components[3]),
                    funcidx: parseInt(components[4]),
                    funcName: components[5],
                }
            case "TE":
                return {
                    type: 'TableGetExt',
                    tableidx: parseInt(components[1]),
                    name: components[2],
                    idx: parseInt(components[3]),
                    funcidx: parseInt(components[4]),
                    funcName: components[5],
                }
            case "TG":
                return {
                    type: 'TableGrow',
                    idx: parseInt(components[1]),
                    name: components[2],
                    amount: parseInt(components[3])
                }
            case 'G':
                return {
                    type: 'GlobalGet',
                    idx: parseInt(components[1]),
                    name: components[2],
                    value: parseInt(components[3]),
                    valtype: components[4] as ValType,
                }
            case 'IG':
                return {
                    type: 'ImportGlobal',
                    idx: parseInt(components[1]),
                    module: components[2],
                    name: components[3],
                    initial: parseInt(components[6]),
                    value: components[4] as ValType,
                    mutable: parseInt(components[5]) === 1
                }
            case 'IF':
                return {
                    type: 'ImportFunc',
                    idx: parseInt(components[1]),
                    module: components[2],
                    name: components[3],
                }
            case 'IT':
                return {
                    type: 'ImportTable',
                    idx: parseInt(components[1]),
                    module: components[2],
                    name: components[3],
                    initial: parseInt(components[4]),
                    maximum: components[5] === '' ? undefined : parseInt(components[5]),
                    element: components[6] as 'anyfunc'
                }
            case 'FE':
                return {
                    type: 'FuncEntry',
                    idx: parseInt(components[1]),
                    args: splitList(components[2])
                }
            case 'FR':
                return {
                    type: 'FuncReturn',
                    idx: parseInt(components[1]),
                    values: splitList(components[2])
                }
            case 'S':
                return {
                    type: 'StoreExt',
                    offset: parseInt(components[1]),
                    data: splitList(components[2])
                }
            default:
                throw new Error(`${components[0]}: Not a valid trace event. The whole event: ${event}.`)
        }
    }

    toString() {
        return this.trace.join(`\n`)
    }

    static fromString(traceString: string) {
        let self = new Trace()
        self.trace = []
        let events = traceString.trim().split('\n')
        for (let event of events) {
            self.push(Trace.parseEvent(event))
        }
        return self
    }

    getTop() {
        return this.trace[this.trace.length - 1]
    }

    resolve(event: string) {
        if (Number.isFinite(Number(event))) {
            return this.cache[parseInt(event)]
        }
        return event
    }

    getLength() {
        return this.trace.length
    }
}

type Options = { extended: boolean }
export default class Analysis implements AnalysisI<Trace> {

    private trace: Trace = new Trace()
    private Wasabi: Wasabi
    private options: Options

    // shadow stuff
    private shadowMemories: ArrayBuffer[] = []
    private shadowGlobals: number[] = []
    private shadowTables: WebAssembly.Table[] = []

    // helpers
    private callStack: ('int' | { name: string, idx: number })[] = [{ name: 'main', 'idx': -1 }]

    private MEM_PAGE_SIZE = 65536


    getResult(): Trace {
        return this.trace
    }

    getResultChunk(size: number) {
        return this.trace
        // return this.trace.getChunk(0, size)
    }

    constructor(Wasabi: Wasabi, options = { extended: false }) {
        this.Wasabi = Wasabi
        this.options = options

        Wasabi.analysis = {
            start(location) { },
            nop(location) { },
            unreachable(location) { },
            if_(location, condition) { },
            br(location, target) { },
            br_if(location, conditionalTarget, condition) { },
            br_table(location, table, defaultTarget, tableIdx) { },
            begin(location, type) { },
            drop(location, value) { },
            select(location, cond, first, second) { },
            const_(location, op, value) { },
            unary(location, op, input, result) { },
            binary(location, op, first, second, result) { },
            memory_size(location, memoryIdx, currentSizePages) { },
            local(location, op, localIndex, value) { },
            memory_fill(location, index, value, length) { },
            memory_copy(location, destination, source, length) { },
            memory_init(location, destination, source, length) { },
            table_size(location, currentSizeEntries) { },
            table_copy(location, destination, source, length) { },
            table_init(location, destination, source, length) { },
            table_grow(location, n, val, previusElement) { },
            table_fill(location, index, value, length) { },

            begin_function: (location, args) => {
                if (options.extended) {
                    this.trace.push(['FE', location.func, args])
                }
                if (this.callStack[this.callStack.length - 1] !== 'int') {
                    const exportName = this.Wasabi.module.info.functions[location.func].export[0]
                    // there is some fucked up shit going on. I dont know what It is but somehow there can be unexported functions called
                    // even tho we tho we should be inside of the host
                    // I dont know what the fuck is going on here, but I just ignore those for now and hope for the best
                    if (exportName !== undefined) {
                        this.trace.push(["EC", exportName, args])
                        this.checkMemGrow()
                        this.checkTableGrow()
                    }
                }
                this.callStack.push('int')
            },

            store: (location, op, target, memarg, value) => {
                const addr = target.addr + memarg.offset
                if (this.shadowMemories.length === 0) {
                    return
                }
                let byteLength = this.getByteLength(op)
                for (let i = 0; i < byteLength; i++) {
                    const value = new Uint8Array(this.Wasabi.module.memories[0].buffer)[addr + i]
                    new Uint8Array(this.shadowMemories[0])[addr + i] = value
                    // if (this.options.extended === true) {
                    //     this.trace.push(['S', addr + i, [value]])
                    // }
                }
            },

            memory_grow: (location, memIdx, byPages, previousSizePages) => {
                if (this.shadowMemories.length === 0) {
                    return
                }
                this.growShadowMem(memIdx, byPages)
            },

            load: (location, op, target, memarg, value) => {
                if (this.shadowMemories.length === 0) {
                    return
                }
                const addr = target.addr + memarg.offset
                const memName = this.getName(Wasabi.module.info.memories[target.memIdx])
                let byteLength = this.getByteLength(op)
                const res = this.mem_content_equals(target.memIdx, addr, byteLength)
                if (this.options.extended === true) {
                    let data = []
                    for (let i = 0; i < byteLength; i++) {
                        data.push(new Uint8Array(this.Wasabi.module.memories[0].buffer)[addr + i])
                    }
                    this.trace.push(['LE', 0, memName, addr, data])
                }
                res.forEach((r, i) => {
                    if (r !== true) {
                        new Uint8Array(this.shadowMemories[0])[addr + i] = new Uint8Array(this.Wasabi.module.memories[0].buffer)[addr + i]
                        new Uint8Array(this.Wasabi.module.memories[0].buffer)[addr + i] = r as number
                        this.trace.push(['L', 0, memName, addr + i, [r as number]])
                    }
                })
            },

            global: (location, op, idx, value) => {
                if (op === 'global.set') {
                    this.shadowGlobals[idx] = value
                    return
                }
                if (op === 'global.get') {
                    let globalInfo = Wasabi.module.info.globals[idx]
                    // can be NaN in case of the NaN being imported to the WebAssembly Module. Google it!
                    if (this.shadowGlobals[idx] !== value && !Number.isNaN(this.shadowGlobals[idx]) && !Number.isNaN(value)) {
                        let valtype = globalInfo.valType
                        this.trace.push(['G', idx, this.getName(globalInfo), value, valtype])
                    }
                }
            },

            call_pre: (location, op, funcidx, args, tableTarget) => {
                if (op === 'call_indirect') {
                    this.tableGetEvent(tableTarget.tableIdx, tableTarget.elemIdx)
                }
                let funcImport = Wasabi.module.info.functions[funcidx].import
                if (funcImport !== null) {
                    let name = funcImport[1]
                    this.callStack.push({ name, idx: funcidx })
                    this.trace.push(["IC", funcidx, name])
                }
                // if (options.extended) {
                //     this.trace.push(['C', funcidx])
                // }
            },

            call_post: (location, results) => {
                const func = this.callStack[this.callStack.length - 1]
                if (func === 'int') {
                    return
                }
                this.callStack.pop()
                this.trace.push(['IR', func.idx, func.name, results])
                this.checkMemGrow()
                this.checkTableGrow()
            },

            return_: (location, values) => {
                this.callStack.pop()
                if (this.options.extended === true) {
                    this.trace.push(['FR', location.func, values])
                }
                if (this.callStack.length === 1) {
                    this.trace.push(['ER'])
                }
            },

            table_set: (location, target, value) => {
                this.shadowTables[target.tableIdx].set(target.elemIdx, value)
            },

            table_get: (location, target, value) => {
                this.tableGetEvent(target.tableIdx, target.elemIdx)
            }
        }
    }

    private set_shadow_memory(memIdx: number, addr: number, data: number[]) {
        for (let i = 0; i < data.length; i++) {
            let shadowArray = new Uint8Array(this.shadowMemories[memIdx])
            shadowArray[addr + i] = data[i]
        }
    }

    private mem_content_equals(memIdx: number, addr: number, numBytes: number): (number | boolean)[] {
        let result = []
        for (let i = 0; i < numBytes; i++) {
            const data = new Uint8Array(this.Wasabi.module.memories[0].buffer)[addr + i]
            if (new Uint8Array(this.shadowMemories[memIdx])[addr + i] !== data) {
                result.push(data)
            } else {
                result.push(true)
            }
        }
        return result
    }

    private tableGetEvent(tableidx: number, idx: number) {
        let table = this.Wasabi.module.tables[tableidx]
        let shadowTable = this.shadowTables[tableidx]
        let resolvedFuncIdx = parseInt(table.get(idx).name)
        if (resolvedFuncIdx >= this.Wasabi.module.info.originalFunctionImportsCount) {
            resolvedFuncIdx = resolvedFuncIdx - Object.keys(this.Wasabi.module.lowlevelHooks).length
        }
        if (shadowTable.get(idx) !== table.get(idx)) {
            let name = this.getName(this.Wasabi.module.info.tables[tableidx])
            let funcidx = parseInt(table.get(idx).name)
            let funcName = this.getName(this.Wasabi.module.info.functions[resolvedFuncIdx])
            this.trace.push(['T', tableidx, name, idx, funcidx, funcName])
            this.shadowTables[0].set(0, table.get(idx))
        }
        if (this.options.extended === true) {
            let name = this.getName(this.Wasabi.module.info.tables[tableidx])
            let funcidx = parseInt(table.get(idx).name)
            let funcName = this.getName(this.Wasabi.module.info.functions[resolvedFuncIdx])
            this.trace.push(['TE', tableidx, name, idx, funcidx, funcName])
        }
    }

    private growShadowMem(memIdx, byPages: number) {
        const newShadow = new ArrayBuffer(this.shadowMemories[memIdx].byteLength + byPages * this.MEM_PAGE_SIZE)
        new Uint8Array(this.shadowMemories[memIdx]).forEach((b, i) => {
            new Uint8Array(newShadow)[i] = b
        })
        this.shadowMemories[0] = newShadow
    }

    private growShadowTable(tableIdx, amount: number) {
        const newShadow = new WebAssembly.Table({ initial: this.Wasabi.module.tables[0].length, element: 'anyfunc' })
        for (let i = 0; i < this.Wasabi.module.tables[tableIdx].length; i++) {
            newShadow.set(i, this.Wasabi.module.tables[tableIdx].get(i))
        }
        this.shadowTables[0] = newShadow
    }

    private checkMemGrow() {
        this.Wasabi.module.memories.forEach((mem, idx) => {
            if (mem.buffer.byteLength !== this.shadowMemories[idx].byteLength) {
                let memGrow: any = {}
                let amount = mem.buffer.byteLength / this.MEM_PAGE_SIZE - this.shadowMemories[idx].byteLength / this.MEM_PAGE_SIZE
                memGrow[idx] = amount
                this.growShadowMem(idx, amount)
                this.trace.push(['MG', idx, this.getName(this.Wasabi.module.info.memories[idx]), amount])
            }
        })
    }

    private checkTableGrow() {
        this.Wasabi.module.tables.forEach((t, idx) => {
            if (t.length !== this.shadowTables[idx].length) {
                let tableGrow: any = {}
                let amount = this.Wasabi.module.tables[idx].length - this.shadowTables[idx].length
                tableGrow[idx] = amount
                this.growShadowTable(idx, amount)
                this.trace.push(['TG', idx, this.getName(this.Wasabi.module.info.tables[0]), amount])
            }
        })
    }

    private getName(entity: ImpExp) {
        if (entity.import !== null) {
            return entity.import[1]
        } else {
            return entity.export[0]
        }
    }


    /**
     * @example 'i32.load' => 4
     * 'i32.load16' => 2
     * 'i64.store' => 8
     * 'i64.store8_u' => 1
     */
    private getByteLength(instr: StoreOp | LoadOp) {
        let typeIndex = 9
        if (instr.charAt(4) === 'l') {
            typeIndex = 8
        }
        if (instr.charAt(typeIndex) === '8') {
            return parseInt(instr.charAt(typeIndex)) / 8
        } else if (instr.charAt(typeIndex) === '1' || instr.charAt(typeIndex) === '3') {
            return parseInt(instr.substring(typeIndex, typeIndex + 2)) / 8
        }
        return parseInt(instr.substring(1, 3)) / 8
    }

    private cloneArrayBuffer(original: ArrayBuffer) {
        const cloned = new ArrayBuffer(original.byteLength);
        const sourceArray = new Uint8Array(original);
        const clonedArray = new Uint8Array(cloned);

        // Copy the data from the original ArrayBuffer to the cloned ArrayBuffer
        for (let i = 0; i < original.byteLength; i++) {
            clonedArray[i] = sourceArray[i];
        }

        return cloned;
    }

    init() {
        // Init Memories
        this.Wasabi.module.info.memories.forEach((m, idx) => {
            if (m.import !== null) {
                this.trace.push(['IM', idx, m.import[0], m.import[1], m.initial, m.maximum])
            }
        })
        this.Wasabi.module.memories.forEach((mem, i) => {
            let isImported = this.Wasabi.module.info.memories[i].import !== null
            if (isImported) {
                this.shadowMemories.push(new ArrayBuffer(mem.buffer.byteLength))
            } else {
                this.shadowMemories.push(this.cloneArrayBuffer(mem.buffer))
            }
        })
        // Init Tables
        this.Wasabi.module.tables.forEach((t, i) => {
            this.shadowTables.push(new WebAssembly.Table({ initial: this.Wasabi.module.tables[i].length, element: 'anyfunc' })) // want to replace anyfunc through t.refType but it holds the wrong string ('funcref')
            for (let y = 0; y < this.Wasabi.module.tables[i].length; y++) {
                this.shadowTables[i].set(y, t.get(y))
            }
        })
        this.Wasabi.module.info.tables.forEach((t, idx) => {
            if (t.import !== null) {
                this.trace.push(['IT', idx, t.import![0], t.import![1], t.initial, t.maximum, 'anyfunc']) // want to replace anyfunc through t.refType but it holds the wrong string ('funcref')
            }
        })
        // Init Globals
        this.shadowGlobals = this.Wasabi.module.globals.map(g => g.value)
        this.Wasabi.module.info.globals.forEach((g, idx) => {
            if (g.import !== null) {
                this.trace.push(['IG', idx, g.import[0], g.import[1], g.valType, g.mutability === 'Mut' ? 1 : 0, this.Wasabi.module.globals[idx].value])
            }
        })
        // Init Functions
        this.Wasabi.module.info.functions.forEach((f, idx) => {
            if (f.import !== null) {
                this.trace.push(['IF', idx, f.import![0], f.import[1]])
            }
        })
    }

    private debugLoad(op: LoadOp, addr: number, byteLength: number) {
        console.log('*********** LOAD ***********')
        console.log('Trace length', this.trace.getLength(), 'last event', this.trace.getTop(), op)
        console.log('addr', addr, 'byteLength', byteLength, 'data')
        console.log('shadowMem', new Uint8Array(this.shadowMemories[0]).slice(addr, addr + byteLength).join(','))
        this.debugMemory(addr, addr + byteLength)
    }

    private debugStore(op: StoreOp, addr: number, byteLength: number) {
        console.log('*********** STORE ***********')
        console.log('Trace length', this.trace.getLength(), 'last event', this.trace.getTop(), op)
        console.log('addr', addr, 'byteLength', byteLength, 'data')
        this.debugMemory(addr, addr + byteLength)
    }

    private debugMemory(startAddr: number, endAddr: number) {
        console.log(`actualMem from ${startAddr}:`, new Uint8Array(this.Wasabi.module.memories[0].buffer).slice(startAddr, endAddr).join(','))
        console.log(`shadowMem from ${startAddr}:`, new Uint8Array(this.shadowMemories[0]).slice(startAddr, endAddr).join(','))
    }
}

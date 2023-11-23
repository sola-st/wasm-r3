import { StoreOp, LoadOp, ImpExp, Wasabi } from '../wasabi.cjs'
import { Trace as TraceType, ConsiseTrace, ValType, ConsiseWasmEvent, WasmEvent, Ref } from '../trace.d.cjs'
import { AnalysisI } from './analyser.cjs'

export class Trace {
    private trace: string[]// ConsiseTrace
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
                    trace.push({ type: 'Load', idx: e[1], name: e[2], offset: e[3], data: e[4]})
                    break
                case 'MG':
                    trace.push({type: 'MemGrow', idx: e[1], name: e[2], amount: e[3]})
                    break
                case 'T':
                    trace.push({type: 'TableGet', tableidx: e[1], name: e[2], idx: e[3], funcidx: e[4], funcName: e[5] })
                    break
                case 'TG':
                    trace.push({type: 'TableGrow', idx: e[1], name: e[2], amount: e[3]})
                    break
                case 'G':
                    trace.push({type: 'GlobalGet', idx: e[1], name: e[2], value: e[3], valtype: e[4]})
                    break
                case 'EC':
                    trace.push({type: 'ExportCall', name: e[1], params: e[2]})
                    break
                case 'IC':
                    trace.push({type: 'ImportCall', idx: e[1], name: e[2]})
                    break
                case 'IR':
                    trace.push({type: 'ImportReturn', idx: e[1], name: e[2], results: e[3]})
                    break
                case 'IM':
                    trace.push({type: 'ImportMemory', idx: e[1], module: e[2], name: e[3], pages: e[4], maxPages: e[5]})
                    break
                case 'IT':
                    trace.push({type: 'ImportTable', idx: e[1], module: e[2], name: e[3], initial: e[4], element: e[5]})
                    break
                case 'IG':
                    trace.push({type: 'ImportGlobal', idx: e[1], module: e[2], name: e[3], valtype: e[4], value: e[5]})
                    break
                case 'IF':
                    trace.push({type: 'ImportFunc', idx: e[1], module: e[2], name: e[3]})
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
                    if(i < value.length - 1) {
                        eventString += `,`
                    } 
                })
            } else {
                eventString += value
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
            if (n.includes('.')) {
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
                        parseInt(components[5])
                    ]
                case "EC":
                    return [
                        components[0],
                        components[1],
                        splitList(components[2])
                    ]
                case "IC":
                    return [
                        components[0],
                        parseInt(components[1]),
                        components[2]
                    ]
                case "IR":
                    return [
                        components[0],
                        parseInt(components[1]),
                        components[2],
                        splitList(components[3]),
                    ]
                case "L":
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
                        parseInt(components[5]),
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
                        components[5] as 'anyfunc'
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
                        pages: parseInt(components[4]),
                        maxPages: parseInt(components[5])
                    }
                case "EC":
                    return {
                        type: 'ExportCall',
                        name: components[1],
                        params: splitList(components[2])
                    }
                case "IC":
                    return {
                        type: 'ImportCall',
                        idx: parseInt(components[1]),
                        name: components[2]
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
                case "MG":
                    return {
                        type: 'MemGrow',
                        idx: parseInt(components[1]),
                        name: components[2],
                        amount:parseInt(components[3])
                    }
                case "T":
                    return {
                        type: 'TableGet',
                        tableidx: parseInt(components[1]),
                        name: components[2],
                        idx: parseInt(components[3]),
                        funcidx:parseInt(components[4]),
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
                        valtype: components[4] as ValType,
                        value: parseInt(components[5]),
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
                        element: components[5] as 'anyfunc'
                    }
                default:
                    throw new Error(`${components[0]}: Not a valid trace event. The whole event: ${event}.`)
            }
    }

    toString() {
        return this.trace.join(`\n`)
    }

    // toString() {
    //     return this.trace.map(e => this.parseEvent(e).map(f => {
    //         if (Array.isArray(f)) {
    //             return f.join(',')
    //         }
    //         return f
    //     }).join(';')).join(`\n`)
    // }

    // toString() {
    //     function stringifyEvent(...fields: (string | number)[]) {
    //         let eventString = ''
    //         for (let field of fields) {
    //             eventString += field + ';'
    //         }
    //         return eventString.slice(0, -1)
    //     }

    //     function str(list: Iterable<any>) {
    //         let s = ""
    //         for (let l of list) {
    //             s += l + ","
    //         }
    //         return s.slice(0, -1)
    //     }
    //     let traceString = ""
    //     for (let e of this.trace) {
    //         switch (e.type) {
    //             case "Load":
    //                 traceString += stringifyEvent(e.type, e.idx, e.name, e.offset, str(e.data))
    //                 break
    //             case 'MemGrow':
    //             case 'TableGrow':
    //                 traceString += stringifyEvent(e.type, e.idx, e.name, e.amount)
    //                 break
    //             case "TableGet":
    //                 traceString += stringifyEvent(e.type, e.tableidx, e.name, e.idx, e.funcidx, e.funcName)
    //                 break
    //             case 'GlobalGet':
    //                 traceString += stringifyEvent(e.type, e.idx, e.name, e.value, e.valtype)
    //                 break
    //             case "ExportCall":
    //                 traceString += stringifyEvent(e.type, e.name, str(e.params))
    //                 break
    //             case "ImportCall":
    //                 traceString += stringifyEvent(e.type, e.idx, e.name)
    //                 break
    //             case "ImportReturn":
    //                 traceString += stringifyEvent(e.type, e.idx, e.name, str(e.results))
    //                 break
    //             case 'ImportMemory':
    //                 traceString += stringifyEvent(e.type, e.idx, e.module, e.name, e.pages, e.maxPages)
    //                 break
    //             case 'ImportGlobal':
    //                 traceString += stringifyEvent(e.type, e.idx, e.module, e.name, e.valtype, e.value)
    //                 break
    //             case 'ImportFunc':
    //                 traceString += stringifyEvent(e.type, e.idx, e.module, e.name)
    //                 break
    //             case 'ImportTable':
    //                 traceString += stringifyEvent(e.type, e.idx, e.module, e.name, e.initial, e.element)
    //                 break
    //             default:
    //                 throw new Error(`Event of type ${(e as Event).type} not supported. Trace: ${JSON.stringify(this.trace)}`,)
    //         }
    //         traceString += "\n"
    //     }
    //     return traceString
    // }
    
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
}

export default class Analysis implements AnalysisI<Trace> {

    private trace: Trace = new Trace()
    private Wasabi: Wasabi

    // shadow stuff
    private shadowMemories: ArrayBuffer[] = []
    private shadowGlobals: number[] = []
    private shadowTables: WebAssembly.Table[] = []

    // helpers
    private first_entry = true
    private currentWasmFunc: number | null = null
    private extCallStack: { name: string, idx: number }[] = []

    private MEM_PAGE_SIZE = 65536


    getResult(): Trace {
        return this.trace
    }

    getResultChunk(size: number) {
        return this.trace
        // return this.trace.getChunk(0, size)
    }

    constructor(Wasabi: Wasabi) {
        this.Wasabi = Wasabi

        // console.log('---------------------------------------------')
        // console.log('                   Wasm-R3                   ')
        // console.log('---------------------------------------------')
        // console.log('Recording...')

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
            memory_fill(location, index, value, length) { },
            memory_copy(location, destination, source, length) { },
            memory_init(location, destination, source, length) { },
            table_size(location, currentSizeEntries) { },
            table_copy(location, destination, source, length) { },
            table_init(location, destination, source, length) { },
            table_grow(location, n, val, previusElement) { },
            table_fill(location, index, value, length) { },

            begin_function: (location, args) => {
                if (this.first_entry) {
                    this.init()
                    this.first_entry = false
                }
                if (this.currentWasmFunc === null) {
                    this.trace.push(["EC", this.Wasabi.module.info.functions[location.func].export, args ])
                    this.checkMemGrow()
                    this.checkTableGrow()
                } else {
                    this.currentWasmFunc = null
                }
            },

            store: (location, op, target, memarg, value) => {
                const addr = target.addr + memarg.offset
                if (this.shadowMemories.length === 0) {
                    return
                }
                let byteLength = this.getByteLength(op)
                byteLength = parseInt(op.substring(1, 3)) / 8
                let data = this.get_actual_mem(target.memIdx, addr, byteLength)
                this.set_shadow_memory(target.memIdx, addr, data)
            },

            memory_grow: (location, memIdx, byPages, previousSizePages) => {
                if (this.shadowMemories.length === 0) {
                    return
                }
                this.growShadowMem(memIdx, byPages)
            },

            load: (location, op, target, memarg, value) => {
                const addr = target.addr + memarg.offset
                if (this.shadowMemories.length === 0) {
                    return
                }
                let numType = this.getByteLength(op)
                if (this.mem_content_equals(target.memIdx, addr, numType)) {
                    return
                }
                let data = this.get_actual_mem(target.memIdx, addr, numType)
                this.set_shadow_memory(target.memIdx, addr, data)
                this.trace.push(["L", 0, this.getName(Wasabi.module.info.memories[target.memIdx]), addr, data ])
            },

            global: (location, op, idx, value) => {
                if (op === 'global.set') {
                    this.shadowGlobals[idx] = value
                    return
                }
                if (op === 'global.get') {
                    let globalInfo = Wasabi.module.info.globals[idx]
                    if (this.shadowGlobals[idx] !== value) {
                        let valtype = globalInfo.valType
                        this.trace.push(['G', idx, this.getName(globalInfo), value, valtype ])
                    }
                }
            },

            call_pre: (location, op, funcidx, args, tableTarget) => {
                let funcImport = Wasabi.module.info.functions[funcidx].import
                if (op === 'call_indirect') {
                    this.tableGetEvent(tableTarget.tableIdx, tableTarget.elemIdx)
                }
                if (funcImport === null) {
                    this.currentWasmFunc = funcidx;
                    return
                }
                let name = funcImport[1]
                this.extCallStack.push({ name, idx: funcidx })
                this.trace.push(["IC", funcidx, name ])
            },

            call_post: (location, results) => {
                let func = this.extCallStack.pop()
                if (func === undefined) {
                    return
                }
                this.trace.push(['IR', func.idx, func.name, results ])
                this.checkMemGrow()
                this.checkTableGrow()
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

    private mem_content_equals(memIdx: number, addr: number, numBytes: number) {
        for (let i = 0; i < numBytes; i++) {
            if (new Uint8Array(this.shadowMemories[memIdx])[addr + i] !== new Uint8Array(this.Wasabi.module.memories[0].buffer)[addr + i]) {
                return false
            }
        }
        return true
    }

    private get_actual_mem(memIdx: number, addr: number, numBytes: number): number[] {
        let data = []
        for (let i = 0; i < numBytes; i++) {
            data.push(new Uint8Array(this.Wasabi.module.memories[memIdx].buffer)[addr + i])
        }
        return data
    }

    private tableGetEvent(tableidx: number, idx: number) {
        let table = this.Wasabi.module.tables[tableidx]
        let shadowTable = this.shadowTables[tableidx]
        if (shadowTable.get(idx) !== table.get(idx)) {
            let name = this.getName(this.Wasabi.module.info.tables[tableidx])
            let funcidx = parseInt(table.get(idx).name)
            let funcName = this.getName(this.Wasabi.module.info.functions[parseInt(table.get(idx).name) - Object.keys(this.Wasabi.module.lowlevelHooks).length])
            this.trace.push(['T', tableidx, name, idx, funcidx, funcName ])
            this.shadowTables[0].set(0, table.get(idx))
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

    private getByteLength(instr: StoreOp | LoadOp) {
        let typeIndex = 9
        // if (instr.charAt(4) === 's') {
        //     if (instr.charAt(typeIndex) === '8') {
        //         return parseInt(instr.charAt(typeIndex)) / 8
        //     } else if (instr.charAt(typeIndex) === '1' || instr.charAt(typeIndex) === '3') {
        //         return parseInt(instr.substring(typeIndex, 9)) / 8
        //     }
        // }
        if (instr.charAt(4) === 'l') {
            typeIndex = 8
            if (instr.charAt(typeIndex) === '8') {
                return parseInt(instr.charAt(typeIndex)) / 8
            } else if (instr.charAt(typeIndex) === '1' || instr.charAt(typeIndex) === '3') {
                return parseInt(instr.substring(typeIndex, 9)) / 8
            }
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

    private init() {
        // Init Memories
        this.Wasabi.module.memories.forEach((mem, i) => {
            let isImported = this.Wasabi.module.info.memories[i].import !== null
            if (isImported) {
                this.shadowMemories.push(new ArrayBuffer(mem.buffer.byteLength))
            } else {
                this.shadowMemories.push(this.cloneArrayBuffer(mem.buffer))
            }
        })
        this.Wasabi.module.info.memories.forEach((m, idx) => {
            if (m.import !== null) {
                const memory = this.Wasabi.module.memories[idx]
                const pages = memory.buffer.byteLength / this.MEM_PAGE_SIZE
                const maxPages = memory.buffer.byteLength / (64 * 1024)
                this.trace.push(['IM', idx, m.import[0], m.import[1], pages, maxPages ])
            }
        })
        // Init Tables
        this.Wasabi.module.tables.forEach((t, i) => {
            this.shadowTables.push(new WebAssembly.Table({ initial: this.Wasabi.module.tables[i].length, element: 'anyfunc' }))
            for (let y = 0; y < this.Wasabi.module.tables[i].length; y++) {
                this.shadowTables[i].set(y, t.get(y))
            }
        })
        this.Wasabi.module.info.tables.forEach((t, idx) => {
            if (t.import !== null) {
                this.trace.push(['IT', idx, t.import![0], t.import![1], this.Wasabi.module.tables[idx].length , 'anyfunc'])
            }
        })
        // Init Globals
        this.shadowGlobals = this.Wasabi.module.globals.map(g => g.value)
        this.Wasabi.module.info.globals.forEach((g, idx) => {
            if (g.import !== null) {
                this.trace.push([ 'IG', idx, g.import[0], g.import[1], g.valType, this.Wasabi.module.globals[idx].value])
            }
        })
        // Init Functions
        this.Wasabi.module.info.functions.forEach((f, idx) => {
            if (f.import !== null) {
                this.trace.push(['IF', idx, f.import![0], f.import[1]])
            }
        })
    }
}
// export class Trace {
//     private trace: string[] //TraceType
//     private cache: string[] = []

//     constructor() {
//         this.trace = []
//     }

//     push(event: WasmEvent) {
//         let eventString = this.stringifyEvent(event)
//         if (event.type === 'IC' || event.type === 'IR') {
//             const cashIndex = this.cache.findIndex(v => v === eventString)
//             if (cashIndex !== -1) {
//                 eventString = cashIndex.toString()
//             } else {
//                 this.cache.push(eventString)
//             }
//         }
//         this.trace.push(eventString)
//     }

//     into() {
//         return this.trace
//     }

//     private stringifyEvent(event: WasmEvent) {
//         let eventString = ''
//         for (let field in event) {
//             const value = event[field]
//             if (Array.isArray(value)) {
//                 for (let item of value) {
//                     eventString += item += `,`
//                 }
//             } else {
//                 eventString += value
//             }
//             eventString += ';'
//         }
//         return eventString
//     }

//     toString() {
//         return this.trace.join(`\n`)
//     }

//     // toString() {
//     //     function stringifyEvent(...fields: (string | number)[]) {
//     //         let eventString = ''
//     //         for (let field of fields) {
//     //             eventString += field + ';'
//     //         }
//     //         return eventString.slice(0, -1)
//     //     }

//     //     function str(list: Iterable<any>) {
//     //         let s = ""
//     //         for (let l of list) {
//     //             s += l + ","
//     //         }
//     //         return s.slice(0, -1)
//     //     }
//     //     let traceString = ""
//     //     for (let e of this.trace) {
//     //         switch (e.type) {
//     //             case "Load":
//     //                 traceString += stringifyEvent(e.type, e.idx, e.name, e.offset, str(e.data))
//     //                 break
//     //             case 'MemGrow':
//     //             case 'TableGrow':
//     //                 traceString += stringifyEvent(e.type, e.idx, e.name, e.amount)
//     //                 break
//     //             case "TableGet":
//     //                 traceString += stringifyEvent(e.type, e.tableidx, e.name, e.idx, e.funcidx, e.funcName)
//     //                 break
//     //             case 'GlobalGet':
//     //                 traceString += stringifyEvent(e.type, e.idx, e.name, e.value, e.valtype)
//     //                 break
//     //             case "ExportCall":
//     //                 traceString += stringifyEvent(e.type, e.name, str(e.params))
//     //                 break
//     //             case "ImportCall":
//     //                 traceString += stringifyEvent(e.type, e.idx, e.name)
//     //                 break
//     //             case "ImportReturn":
//     //                 traceString += stringifyEvent(e.type, e.idx, e.name, str(e.results))
//     //                 break
//     //             case 'ImportMemory':
//     //                 traceString += stringifyEvent(e.type, e.idx, e.module, e.name, e.pages, e.maxPages)
//     //                 break
//     //             case 'ImportGlobal':
//     //                 traceString += stringifyEvent(e.type, e.idx, e.module, e.name, e.valtype, e.value)
//     //                 break
//     //             case 'ImportFunc':
//     //                 traceString += stringifyEvent(e.type, e.idx, e.module, e.name)
//     //                 break
//     //             case 'ImportTable':
//     //                 traceString += stringifyEvent(e.type, e.idx, e.module, e.name, e.initial, e.element)
//     //                 break
//     //             default:
//     //                 throw new Error(`Event of type ${(e as Event).type} not supported. Trace: ${JSON.stringify(this.trace)}`,)
//     //         }
//     //         traceString += "\n"
//     //     }
//     //     return traceString
//     // }
    
//     static fromString(traceString: string) {
//         let self = new Trace()
//         function splitList(c?: string) {
//             let list = c?.split(',').map(parseNumber)
//             if (list === undefined || (list.length === 1 && Number.isNaN(list[0]))) {
//                 return []
//             }
//             return list
//         }

//         function parseNumber(n: string) {
//             if (n.includes('.')) {
//                 return parseFloat(n)
//             }
//             return parseInt(n)
//         }
//         self.trace = []
//         let events = traceString.trim().split('\n')
//         for (let event of events) {
//             let components = event.split(';')
//             switch (components[0]) {
//                 case 'IM':
//                     self.trace.push(self.stringifyEvent({
//                         type: components[0],
//                         idx: parseInt(components[1]),
//                         module: components[2],
//                         name: components[3],
//                         pages: parseInt(components[4]),
//                         maxPages: parseInt(components[5])
//                     }))
//                     break
//                 case "EC":
//                     self.trace.push(self.stringifyEvent({
//                         type: components[0],
//                         name: components[1],
//                         params: splitList(components[2])
//                     }))
//                     break
//                 case "IC":
//                     self.trace.push(self.stringifyEvent({
//                         type: components[0],
//                         idx: parseInt(components[1]),
//                         name: components[2]
//                     }))
//                     break
//                 case "IR":
//                     self.trace.push(self.stringifyEvent({
//                         type: components[0],
//                         idx: parseInt(components[1]),
//                         name: components[2],
//                         results: splitList(components[3]),
//                     }))
//                     break
//                 case "L":
//                     self.trace.push(self.stringifyEvent({
//                         type: components[0],
//                         idx: parseInt(components[1]),
//                         name: components[2],
//                         offset: parseInt(components[3]),
//                         data: splitList(components[4]),
//                     }))
//                     break
//                 case "MG":
//                     self.trace.push(self.stringifyEvent({
//                         type: components[0],
//                         idx: parseInt(components[1]),
//                         name: components[2],
//                         amount: parseInt(components[3])
//                     }))
//                     break
//                 case "T":
//                     self.trace.push(self.stringifyEvent({
//                         type: components[0],
//                         tableidx: parseInt(components[1]),
//                         name: components[2],
//                         idx: parseInt(components[3]),
//                         funcidx: parseInt(components[4]),
//                         funcName: components[5],
//                     }))
//                     break
//                 case "TG":
//                     self.trace.push(self.stringifyEvent({
//                         type: components[0],
//                         idx: parseInt(components[1]),
//                         name: components[2],
//                         amount: parseInt(components[3])
//                     }))
//                     break
//                 case 'G':
//                     self.trace.push(self.stringifyEvent({
//                         type: components[0],
//                         idx: parseInt(components[1]),
//                         name: components[2],
//                         value: parseInt(components[3]),
//                         valtype: components[4] as ValType,
//                     }))
//                     break
//                 case 'IG':
//                     self.trace.push(self.stringifyEvent({
//                         type: components[0],
//                         idx: parseInt(components[1]),
//                         module: components[2],
//                         name: components[3],
//                         valtype: components[4] as ValType,
//                         value: parseInt(components[5]),
//                     }))
//                     break
//                 case 'IF':
//                     self.trace.push(self.stringifyEvent({
//                         type: components[0],
//                         idx: parseInt(components[1]),
//                         module: components[2],
//                         name: components[3],
//                     }))
//                     break
//                 case 'IT':
//                     self.trace.push(self.stringifyEvent({
//                         type: components[0],
//                         idx: parseInt(components[1]),
//                         module: components[2],
//                         name: components[3],
//                         initial: parseInt(components[4]),
//                         element: components[5] as 'anyfunc'
//                     }))
//                     break
//                 default:
//                     throw new Error(`${components[0]}: Not a valid trace event. The whole event: ${event}. Trace: ${JSON.stringify(self.trace)}`)
//             }
//         }
//         return self
//     }
// }

// export default class Analysis implements AnalysisI<Trace> {

//     private trace: Trace = new Trace()
//     private Wasabi: Wasabi

//     // shadow stuff
//     private shadowMemories: ArrayBuffer[] = []
//     private shadowGlobals: number[] = []
//     private shadowTables: WebAssembly.Table[] = []

//     // helpers
//     private first_entry = true
//     private currentWasmFunc: number | null = null
//     private extCallStack: { name: string, idx: number }[] = []

//     private MEM_PAGE_SIZE = 65536


//     getResult(): Trace {
//         return this.trace
//     }

//     getResultChunk(size: number) {
//         return this.trace
//         // return this.trace.getChunk(0, size)
//     }

//     constructor(Wasabi: Wasabi) {
//         this.Wasabi = Wasabi

//         // console.log('---------------------------------------------')
//         // console.log('                   Wasm-R3                   ')
//         // console.log('---------------------------------------------')
//         // console.log('Recording...')

//         Wasabi.analysis = {
//             start(location) { },
//             nop(location) { },
//             unreachable(location) { },
//             if_(location, condition) { },
//             br(location, target) { },
//             br_if(location, conditionalTarget, condition) { },
//             br_table(location, table, defaultTarget, tableIdx) { },
//             begin(location, type) { },
//             end(location, type, beginLocation, ifLocation) { },
//             drop(location, value) { },
//             select(location, cond, first, second) { },
//             return_(location, values) { },
//             const_(location, op, value) { },
//             unary(location, op, input, result) { },
//             binary(location, op, first, second, result) { },
//             memory_size(location, memoryIdx, currentSizePages) { },
//             local(location, op, localIndex, value) { },
//             memory_fill(location, index, value, length) { },
//             memory_copy(location, destination, source, length) { },
//             memory_init(location, destination, source, length) { },
//             table_size(location, currentSizeEntries) { },
//             table_copy(location, destination, source, length) { },
//             table_init(location, destination, source, length) { },
//             table_grow(location, n, val, previusElement) { },
//             table_fill(location, index, value, length) { },

//             begin_function: (location, args) => {
//                 if (this.first_entry) {
//                     this.init()
//                     this.first_entry = false
//                 }
//                 if (this.currentWasmFunc === null) {
//                     this.trace.push({ type: "EC", name: this.Wasabi.module.info.functions[location.func].export, params: args })
//                     this.checkMemGrow()
//                     this.checkTableGrow()
//                 } else {
//                     this.currentWasmFunc = null
//                 }
//             },

//             store: (location, op, target, memarg, value) => {
//                 const addr = target.addr + memarg.offset
//                 if (this.shadowMemories.length === 0) {
//                     return
//                 }
//                 let byteLength = this.getByteLength(op)
//                 byteLength = parseInt(op.substring(1, 3)) / 8
//                 let data = this.get_actual_mem(target.memIdx, addr, byteLength)
//                 this.set_shadow_memory(target.memIdx, addr, data)
//             },

//             memory_grow: (location, memIdx, byPages, previousSizePages) => {
//                 if (this.shadowMemories.length === 0) {
//                     return
//                 }
//                 this.growShadowMem(memIdx, byPages)
//             },

//             load: (location, op, target, memarg, value) => {
//                 const addr = target.addr + memarg.offset
//                 if (this.shadowMemories.length === 0) {
//                     return
//                 }
//                 let numType = this.getByteLength(op)
//                 if (this.mem_content_equals(target.memIdx, addr, numType)) {
//                     return
//                 }
//                 let data = this.get_actual_mem(target.memIdx, addr, numType)
//                 this.set_shadow_memory(target.memIdx, addr, data)
//                 this.trace.push({ type: "L", name: this.getName(Wasabi.module.info.memories[target.memIdx]), offset: addr, data, idx: 0 })
//                 // if ((addr === 1434178 || addr === 1434179 || addr === 4317476 || addr === 1434198)) {
//                 //     console.log('-----------------------------')
//                 //     console.log('op', op)
//                 //     console.log('byteLength', numType)
//                 //     console.log('location', location)
//                 //     console.log('target', target)
//                 //     console.log('memarg', memarg)
//                 //     console.log('addr', addr)
//                 //     console.log('value', value)
//                 //     console.log('trace length', trace.length)
//                 //     console.log('trace', trace)
//                 // }
//             },

//             global: (location, op, idx, value) => {
//                 if (op === 'global.set') {
//                     this.shadowGlobals[idx] = value
//                     return
//                 }
//                 if (op === 'global.get') {
//                     let globalInfo = Wasabi.module.info.globals[idx]
//                     if (this.shadowGlobals[idx] !== value) {
//                         let valtype = globalInfo.valType
//                         this.trace.push({ type: 'G', name: this.getName(globalInfo), value, valtype, idx })
//                     }
//                 }
//             },

//             call_pre: (location, op, funcidx, args, tableTarget) => {
//                 let funcImport = Wasabi.module.info.functions[funcidx].import
//                 if (op === 'call_indirect') {
//                     this.tableGetEvent(tableTarget.tableIdx, tableTarget.elemIdx)
//                 }
//                 if (funcImport === null) {
//                     this.currentWasmFunc = funcidx;
//                     return
//                 }
//                 let name = funcImport[1]
//                 this.extCallStack.push({ name, idx: funcidx })
//                 this.trace.push({ type: "IC", name, idx: funcidx })
//             },

//             call_post: (location, results) => {
//                 let func = this.extCallStack.pop()
//                 if (func === undefined) {
//                     return
//                 }
//                 this.trace.push({ type: 'IR', name: func.name, results, idx: func.idx })
//                 this.checkMemGrow()
//                 this.checkTableGrow()
//             },

//             table_set: (location, target, value) => {
//                 this.shadowTables[target.tableIdx].set(target.elemIdx, value)
//             },

//             table_get: (location, target, value) => {
//                 this.tableGetEvent(target.tableIdx, target.elemIdx)
//             }
//         }
//     }

//     private set_shadow_memory(memIdx: number, addr: number, data: number[]) {
//         for (let i = 0; i < data.length; i++) {
//             let shadowArray = new Uint8Array(this.shadowMemories[memIdx])
//             shadowArray[addr + i] = data[i]
//         }
//     }

//     private mem_content_equals(memIdx: number, addr: number, numBytes: number) {
//         for (let i = 0; i < numBytes; i++) {
//             if (new Uint8Array(this.shadowMemories[memIdx])[addr + i] !== new Uint8Array(this.Wasabi.module.memories[0].buffer)[addr + i]) {
//                 return false
//             }
//         }
//         return true
//     }

//     private get_actual_mem(memIdx: number, addr: number, numBytes: number): number[] {
//         let data = []
//         for (let i = 0; i < numBytes; i++) {
//             data.push(new Uint8Array(this.Wasabi.module.memories[memIdx].buffer)[addr + i])
//         }
//         return data
//     }

//     private tableGetEvent(tableidx: number, idx: number) {
//         let table = this.Wasabi.module.tables[tableidx]
//         let shadowTable = this.shadowTables[tableidx]
//         if (shadowTable.get(idx) !== table.get(idx)) {
//             let name = this.getName(this.Wasabi.module.info.tables[tableidx])
//             let funcidx = parseInt(table.get(idx).name)
//             let funcName = this.getName(this.Wasabi.module.info.functions[parseInt(table.get(idx).name) - Object.keys(this.Wasabi.module.lowlevelHooks).length])
//             this.trace.push({ type: 'T', tableidx, name, idx, funcidx, funcName })
//             this.shadowTables[0].set(0, table.get(idx))
//         }
//     }

//     private growShadowMem(memIdx, byPages: number) {
//         const newShadow = new ArrayBuffer(this.shadowMemories[memIdx].byteLength + byPages * this.MEM_PAGE_SIZE)
//         new Uint8Array(this.shadowMemories[memIdx]).forEach((b, i) => {
//             new Uint8Array(newShadow)[i] = b
//         })
//         this.shadowMemories[0] = newShadow
//     }

//     private growShadowTable(tableIdx, amount: number) {
//         const newShadow = new WebAssembly.Table({ initial: this.Wasabi.module.tables[0].length, element: 'anyfunc' })
//         for (let i = 0; i < this.Wasabi.module.tables[tableIdx].length; i++) {
//             newShadow.set(i, this.Wasabi.module.tables[tableIdx].get(i))
//         }
//         this.shadowTables[0] = newShadow
//     }

//     private checkMemGrow() {
//         this.Wasabi.module.memories.forEach((mem, idx) => {
//             if (mem.buffer.byteLength !== this.shadowMemories[idx].byteLength) {
//                 let memGrow: any = {}
//                 let amount = mem.buffer.byteLength / this.MEM_PAGE_SIZE - this.shadowMemories[idx].byteLength / this.MEM_PAGE_SIZE
//                 memGrow[idx] = amount
//                 this.growShadowMem(idx, amount)
//                 this.trace.push({ type: 'MG', name: this.getName(this.Wasabi.module.info.memories[idx]), amount, idx })
//             }
//         })
//     }

//     private checkTableGrow() {
//         this.Wasabi.module.tables.forEach((t, idx) => {
//             if (t.length !== this.shadowTables[idx].length) {
//                 let tableGrow: any = {}
//                 let amount = this.Wasabi.module.tables[idx].length - this.shadowTables[idx].length
//                 tableGrow[idx] = amount
//                 this.growShadowTable(idx, amount)
//                 this.trace.push({ type: 'TG', name: this.getName(this.Wasabi.module.info.tables[0]), amount, idx })
//             }
//         })
//     }

//     private getName(entity: ImpExp) {
//         if (entity.import !== null) {
//             return entity.import[1]
//         } else {
//             return entity.export[0]
//         }
//     }

//     private getByteLength(instr: StoreOp | LoadOp) {
//         let typeIndex = 9
//         // if (instr.charAt(4) === 's') {
//         //     if (instr.charAt(typeIndex) === '8') {
//         //         return parseInt(instr.charAt(typeIndex)) / 8
//         //     } else if (instr.charAt(typeIndex) === '1' || instr.charAt(typeIndex) === '3') {
//         //         return parseInt(instr.substring(typeIndex, 9)) / 8
//         //     }
//         // }
//         if (instr.charAt(4) === 'l') {
//             typeIndex = 8
//             if (instr.charAt(typeIndex) === '8') {
//                 return parseInt(instr.charAt(typeIndex)) / 8
//             } else if (instr.charAt(typeIndex) === '1' || instr.charAt(typeIndex) === '3') {
//                 return parseInt(instr.substring(typeIndex, 9)) / 8
//             }
//         }
//         return parseInt(instr.substring(1, 3)) / 8
//     }

//     private cloneArrayBuffer(original: ArrayBuffer) {
//         const cloned = new ArrayBuffer(original.byteLength);
//         const sourceArray = new Uint8Array(original);
//         const clonedArray = new Uint8Array(cloned);

//         // Copy the data from the original ArrayBuffer to the cloned ArrayBuffer
//         for (let i = 0; i < original.byteLength; i++) {
//             clonedArray[i] = sourceArray[i];
//         }

//         return cloned;
//     }

//     private init() {
//         // Init Memories
//         this.Wasabi.module.memories.forEach((mem, i) => {
//             let isImported = this.Wasabi.module.info.memories[i].import !== null
//             if (isImported) {
//                 this.shadowMemories.push(new ArrayBuffer(mem.buffer.byteLength))
//             } else {
//                 this.shadowMemories.push(this.cloneArrayBuffer(mem.buffer))
//             }
//         })
//         this.Wasabi.module.info.memories.forEach((m, idx) => {
//             if (m.import !== null) {
//                 const memory = this.Wasabi.module.memories[idx]
//                 const pages = memory.buffer.byteLength / this.MEM_PAGE_SIZE
//                 const maxPages = memory.buffer.byteLength / (64 * 1024)
//                 this.trace.push({ type: 'IM', module: m.import[0], name: m.import[1], pages, idx, maxPages })
//             }
//         })
//         // Init Tables
//         this.Wasabi.module.tables.forEach((t, i) => {
//             this.shadowTables.push(new WebAssembly.Table({ initial: this.Wasabi.module.tables[i].length, element: 'anyfunc' }))
//             for (let y = 0; y < this.Wasabi.module.tables[i].length; y++) {
//                 this.shadowTables[i].set(y, t.get(y))
//             }
//         })
//         this.Wasabi.module.info.tables.forEach((t, idx) => {
//             if (t.import !== null) {
//                 this.trace.push({ type: 'IT', module: t.import![0], name: t.import![1], element: 'anyfunc', idx, initial: this.Wasabi.module.tables[idx].length })
//             }
//         })
//         // Init Globals
//         this.shadowGlobals = this.Wasabi.module.globals.map(g => g.value)
//         this.Wasabi.module.info.globals.forEach((g, idx) => {
//             if (g.import !== null) {
//                 this.trace.push({ type: 'IG', module: g.import[0], name: g.import[1], valtype: g.valType, value: this.Wasabi.module.globals[idx].value, idx })
//             }
//         })
//         // Init Functions
//         this.Wasabi.module.info.functions.forEach((f, idx) => {
//             if (f.import !== null) {
//                 this.trace.push({ type: 'IF', module: f.import![0], name: f.import[1], idx })
//             }
//         })
//     }
// }
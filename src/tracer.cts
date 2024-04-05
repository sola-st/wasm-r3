import { StoreOp, LoadOp, ImpExp, Wasabi } from '../wasabi.cjs'
import { Trace as TraceType, ValType, WasmEvent } from '../trace.d.cjs'
import { AnalysisI } from './analyser.cjs'
import { timeStamp } from 'console';
// import fs from 'fs'

function parseNumber(str): number {
    str = str.trim(); // Remove leading/trailing whitespace

    if (str === '' || str === '+' || str === '-') {
        // Handle empty or only sign character
        return NaN;
    }

    if (str === 'Infinity' || str === '+Infinity') {
        return Infinity;
    }

    if (str === '-Infinity') {
        return -Infinity;
    }

    if (!isNaN(str)) {
        if (str.includes('.') || str.toLowerCase().includes('e')) {
            // Handle floats and scientific notation
            return parseFloat(str);
        }

        let num = BigInt(str);
        if (num >= Number.MIN_SAFE_INTEGER && num <= Number.MAX_SAFE_INTEGER) {
            // Convert to Number if within safe range
            return Number(num);
        }

        //@ts-ignore
        return num; // Return as BigInt
    }

    return NaN; // Not a number
}

export class Trace {
    private trace: string[]
    private cache: string[] = []
    private flag = true

    constructor() {
        this.trace = []
    }

    push(event: string) {
        // if (event.startsWith('IC') || event.startsWith('IR')) {
        //     const cashIndex = this.cache.findIndex(v => v === event)
        //     if (cashIndex !== -1) {
        //         this.trace.push(cashIndex.toString())
        //         return
        //     } else {
        //         this.cache.push(event)
        //     }
        // }
        this.trace.push(event)
        // if (this.trace.length > 15000 && this.flag === true) {
        //     fs.writeFileSync('/Users/jakob/Desktop/wasm-r3/ffmpeg/bin_0/replay-trace.r3', this.toString())
        //     this.flag = false
        // }
    }

    forEach(callbackFn: (value: WasmEvent, index: number) => void) {
        this.trace.forEach((e, i) => {
            const event = this.parseEventToObj(e)
            callbackFn(event, i)
        })
    }

    parseEventToObj(event: string): WasmEvent {
        const cacheIdx = Number(event)
        if (Number.isFinite(cacheIdx)) {
            event = this.cache[cacheIdx]
        }
        function splitList(c?: string) {
            let list = c?.split(',').map(parseNumber)
            if (list === undefined || (list.length === 1 && Number.isNaN(list[0]))) {
                return []
            }
            return list
        }

        let components = event.split(';')
        switch (components[0]) {
            case "EC":
                return {
                    type: 'ExportCall',
                    funcidx: parseInt(components[1]),
                    name: components[2],
                    params: splitList(components[3])
                }
            case 'TC':
                return {
                    type: 'TableCall',
                    funcidx: parseInt(components[1]),
                    tableName: components[2],
                    tableidx: parseInt(components[3]),
                    params: splitList(components[4])
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
                    value: parseNumber(components[3]),
                    valtype: components[4] as ValType,
                }
            case 'IG':
                return {
                    type: 'ImportGlobal',
                    idx: parseInt(components[1]),
                    module: components[2],
                    name: components[3],
                    initial: parseNumber(components[6]),
                    value: components[4] as ValType,
                    mutable: parseInt(components[5]) === 1
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
            self.push(event)
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
    private stats = {
        loads: 0,
        relevantLoads: 0,
        tableGets: 0,
        relevantTableGets: 0,
        globalGets: 0,
        relevantGlobalGets: 0,
        functionEntries: 0,
        relevantFunctionEntries: 0,
        functionExits: 0,
        relevantFunctionExits: 0,
        calls: 0,
        relevantCalls: 0,
        callReturns: 0,
        relevantCallReturns: 0,
    };

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

    getStats() {
        return this.stats;
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
                this.stats.functionEntries++;
                if (options.extended) {
                  this.trace.push(`FE;${location.func};${args.join(",")}`);
                }
                if (this.callStack[this.callStack.length - 1] !== "int") {
                  const exportName =
                    this.Wasabi.module.info.functions[location.func].export[0];
                  const CALLED_WITH_TABLE_GET = exportName === undefined;
                  if (CALLED_WITH_TABLE_GET) {
                    if (
                      !this.Wasabi.module.tables.some((table, i) => {
                        for (
                          let tableIndex = 0;
                          tableIndex < table.length;
                          tableIndex++
                        ) {
                          if (table.get(tableIndex) !== null) {
                            const funcidx = this.resolveFuncIdx(table, tableIndex);
                            if (funcidx === location.func) {
                            this.stats.relevantFunctionEntries++;
                              this.trace.push(
                                `TC;${location.func};${this.getName(
                                  this.Wasabi.module.info.tables[i]
                                )};${tableIndex};${args.join(",")}`
                              );
                              return true;
                            }
                          }
                        }
                        return false;
                      })
                    ) {
                      console.log(location);
                      throw new Error(
                        "The function you where calling from outside the wasm module is neither exported nor in a table..."
                      );
                    }
                  } else {
                    this.stats.relevantFunctionEntries++;
                    this.trace.push(
                      `EC;${location.func};${exportName};${args.join(",")}`
                    );
                    this.checkMemGrow();
                    this.checkTableGrow();
                  }
                }
                this.callStack.push("int");
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
                }
            },

            memory_grow: (location, memIdx, byPages, previousSizePages) => {
                if (this.shadowMemories.length === 0) {
                    return
                }
                this.growShadowMem(memIdx, byPages)
            },

            load: (location, op, target, memarg, value) => {
                this.stats.loads++;
                if (this.shadowMemories.length === 0) {
                    return
                }
                const addr = target.addr + memarg.offset
                const memName = this.getName(Wasabi.module.info.memories[target.memIdx])
                let byteLength = this.getByteLength(op)
                if (this.options.extended === true) {
                    let data = []
                    for (let i = 0; i < byteLength; i++) {
                        data.push(new Uint8Array(this.Wasabi.module.memories[0].buffer)[addr + i])
                    }
                    this.trace.push(`LE;${0};${memName};${addr};${data.join(',')}`)
                }
                if (!this.mem_content_equals(target.memIdx, addr, byteLength)) {
                    for (let i = 0; i < byteLength; i++) {
                        let r = new Uint8Array(this.Wasabi.module.memories[0].buffer)[addr + i]
                        new Uint8Array(this.shadowMemories[0])[addr + i] = new Uint8Array(this.Wasabi.module.memories[0].buffer)[addr + i]
                        new Uint8Array(this.Wasabi.module.memories[0].buffer)[addr + i] = r as number
                        this.stats.relevantLoads++;
                        this.trace.push(`L;${0};${memName};${addr + i};${[r as number]}`)
                    }
                }
            },

            global: (location, op, idx, value) => {
                this.stats.globalGets++
                if (op === 'global.set') {
                    this.shadowGlobals[idx] = value
                    return
                }
                if (op === 'global.get') {
                    let globalInfo = Wasabi.module.info.globals[idx]
                    // can be NaN in case of the NaN being imported to the WebAssembly Module. Google it!
                    if (this.shadowGlobals[idx] !== value && !Number.isNaN(this.shadowGlobals[idx]) && !Number.isNaN(value)) {
                        let valtype = globalInfo.valType
                        this.stats.relevantGlobalGets++
                        this.trace.push(`G;${idx};${this.getName(globalInfo)};${value};${valtype}`)
                        this.shadowGlobals[idx] = value
                    }
                }
            },

            call_pre: (location, op, funcidx, args, tableTarget) => {
                this.stats.calls++;
                if (op === 'call_indirect') {
                    this.tableGetEvent(tableTarget.tableIdx, tableTarget.elemIdx)
                }
                let funcImport = Wasabi.module.info.functions[funcidx].import
                if (funcImport !== null) {
                    let name = funcImport[1]
                    this.callStack.push({ name, idx: funcidx })
                    this.stats.relevantCalls++;
                    this.trace.push(`IC;${funcidx};${name}`)
                }
            },

            call_post: (location, results) => {
                this.stats.callReturns++;
                const func = this.callStack[this.callStack.length - 1]
                if (func === 'int') {
                    return
                }
                this.callStack.pop()
                this.stats.relevantCallReturns++;
                this.trace.push(`IR;${func.idx};${func.name};${results.join(',')}`)
                this.checkMemGrow()
                this.checkTableGrow()
            },

            return_: (location, values) => {
                this.stats.functionExits++;
                this.callStack.pop()
                if (this.options.extended === true) {
                    this.trace.push(`FR;${location.func};${values.join(',')}`)
                }
                if (this.callStack.length === 1) {
                    this.stats.relevantFunctionExits++;
                    this.trace.push(`ER`)
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

    private mem_content_equals(memIdx: number, addr: number, numBytes: number): boolean {
        let result = []
        for (let i = 0; i < numBytes; i++) {
            const data = new Uint8Array(this.Wasabi.module.memories[0].buffer)[addr + i]
            if (new Uint8Array(this.shadowMemories[memIdx])[addr + i] !== data)
                return false
        }
        return true
    }

    private tableGetEvent(tableidx: number, idx: number) {
        this.stats.tableGets++;
        let table = this.Wasabi.module.tables[tableidx]
        let shadowTable = this.shadowTables[tableidx]
        let resolvedFuncIdx = this.resolveFuncIdx(table, idx)
        if (shadowTable.get(idx) !== table.get(idx)) {
            let name = this.getName(this.Wasabi.module.info.tables[tableidx])
            let funcidx = this.resolveFuncIdx(table, idx)
            let funcName = this.getName(this.Wasabi.module.info.functions[resolvedFuncIdx])
            this.stats.relevantTableGets++;
            this.trace.push(`T;${tableidx};${name};${idx};${funcidx};${funcName}`)
            this.shadowTables[0].set(0, table.get(idx))
        }
        if (this.options.extended === true) {
            let name = this.getName(this.Wasabi.module.info.tables[tableidx])
            let funcidx = this.resolveFuncIdx(table, idx)
            let funcName = this.getName(this.Wasabi.module.info.functions[resolvedFuncIdx])
            this.trace.push(`TE;${tableidx};${name};${idx};${funcidx};${funcName}`)
        }
    }

    private resolveFuncIdx(table: WebAssembly.Table, idx: number) {
        let resolvedFuncIdx = parseInt(table.get(idx).name)
        if (resolvedFuncIdx >= this.Wasabi.module.info.originalFunctionImportsCount) {
            resolvedFuncIdx = resolvedFuncIdx - Object.keys(this.Wasabi.module.lowlevelHooks).length
        }
        return resolvedFuncIdx
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
                this.trace.push(`MG;${idx};${this.getName(this.Wasabi.module.info.memories[idx])};${amount}`)
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
                this.trace.push(`TG;${idx};${this.getName(this.Wasabi.module.info.tables[0])};${amount}`)
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
            if (this.Wasabi.module.info.tables[i].refType !== 'funcref') {
                throw new Error('I didnt implement other tabletypes then funcrefs yet')
            }
            this.shadowTables.push(new WebAssembly.Table({ initial: this.Wasabi.module.tables[i].length, element: 'anyfunc' })) // want to replace anyfunc through t.refType but it holds the wrong string ('funcref')
            for (let y = 0; y < this.Wasabi.module.tables[i].length; y++) {
                this.shadowTables[i].set(y, t.get(y))
            }
        })
        // Init Globals
        this.shadowGlobals = this.Wasabi.module.globals.map(g => g.value)
        this.Wasabi.module.info.globals.forEach((g, idx) => {
            if (g.import !== null) {
                this.trace.push(`IG;${idx};${g.import[0]};${g.import[1]};${g.valType};${g.mutability === 'Mut' ? 1 : 0};${this.Wasabi.module.globals[idx].value}`)
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
        console.log(`actualMem from ${startAddr}: `, new Uint8Array(this.Wasabi.module.memories[0].buffer).slice(startAddr, endAddr).join(','))
        console.log(`shadowMem from ${startAddr}: `, new Uint8Array(this.shadowMemories[0]).slice(startAddr, endAddr).join(','))
    }
}

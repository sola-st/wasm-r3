import { StoreOp, LoadOp, ImpExp, Wasabi } from '../wasabi.cjs'
import { Trace as TraceType, ValType, WasmEvent } from '../trace.cjs'
import { AnalysisI } from './analyser.cjs'

type ExtTrace = Event[]
type Event = FunctionEntry | FunctionCall | FunctionReturn | Load | Store | MemGrow | TableGet | TableSet | GlobalGet | GlobalSet
type FunctionEntry = { type: 'E', funcIdx: number, args: number[] }
type FunctionCall = { type: 'C', funcIdx: number, args: number[] }
type FunctionReturn = { type: 'R', funcIdx: number, results: number[] }
type Load = { type: 'L', memIdx: number, addr: number, op: string, value: number }
type Store = { type: 'S', memIdx: number, addr: number, op: string, value: number }
type MemGrow = { type: 'MG', memIdx: number, byPages: number }
type TableGet = { type: 'TG', tableIdx: number, idx: number, funcIdx: number }
type TableSet = { type: 'TS', tableIdx: number, idx: number, funcIdx: number }
type GlobalGet = { type: 'GG', globalIdx: number, value: number }
type GlobalSet = { type: 'GS', globalIdx: number, value: number }

export class Trace {
    private trace: ExtTrace
    constructor() {
        this.clear()
    }

    push(event: Event) {
        this.trace.push(event)
    }

    into() {
        return this.trace
    }

    clear() {
        this.trace = []
    }

    toString() {
        let traceString = ''
        for (let event of this.trace) {
            for (let field in event) {
                const value = event[field]
                if (Array.isArray(value)) {
                    for (let item of value) {
                        traceString += item += `,`
                    }
                } else {
                    traceString += value
                }
                traceString += ';'
            }
            traceString += `\n`
        }
        return traceString
    }

    fromString(traceString: string) {
        this.trace = JSON.parse(traceString)
    }
}

export default class Analysis implements AnalysisI<Trace> {

    private trace: Trace = new Trace()

    getResult(): Trace {
        return this.trace
    }

    clear() {
        this.trace.clear()
    }

    constructor(Wasabi: Wasabi) {
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
                this.trace.push({ type: 'C', funcIdx: location.func, args })
            },

            store: (location, op, target, memarg, value) => {
                this.trace.push({ type: 'S', memIdx: target.memIdx, addr: target.addr + memarg.offset, op, value })
            },

            memory_grow: (location, memIdx, byPages, previousSizePages) => {
                this.trace.push({ type: 'MG', memIdx, byPages })
            },

            load: (location, op, target, memarg, value) => {
                this.trace.push({ type: 'L', memIdx: target.memIdx, addr: target.addr + memarg.offset, op, value })
            },

            global: (location, op, idx, value) => {
                if (op === 'global.set') {
                    this.trace.push({ type: 'GS', globalIdx: idx, value })
                } else {
                    this.trace.push({ type: 'GG', globalIdx: idx, value })
                }
            },

            call_pre: (location, op, funcIdx, args, tableTarget) => {
                this.trace.push({ type: 'C', funcIdx, args })
                if (op === 'call_indirect') {
                    this.trace.push({ type: 'TG', tableIdx: tableTarget.tableIdx, idx: tableTarget.elemIdx, funcIdx })
                }
            },

            call_post: (location, results) => {
                this.trace.push({ type: 'R', funcIdx: 0, results })
            },

            table_set: (location, target, value) => {
                this.trace.push({ type: 'TS', tableIdx: target.tableIdx, idx: target.elemIdx, funcIdx: value })
            },

            table_get: (location, target, value) => {
                this.trace.push({ type: 'TG', tableIdx: target.tableIdx, idx: target.elemIdx, funcIdx: value })
            }
        }
    }
}
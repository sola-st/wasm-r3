import { Wasabi } from '../wasabi.cjs'

type FromInit = { funcidx: 'h', host: true }
type FromHost = { funcidx: number, host: true }
type FromWasm = { funcidx: number, host: false }
type FromNode = FromInit | FromHost | FromWasm
export type ToFromHost = { funcidx: number, host: false, memSizes: number[], tableSizes: number[] }
export type ToFromWasm = { funcidx: number, host: boolean }
type Edge = {
    params: number[],
} & (
        | { from: FromInit, to: ToFromHost }
        | { from: FromHost, to: ToFromHost }
        | { from: FromWasm, to: ToFromWasm }
    )
export type CallGraph = Edge[]

export default function setupAnalysis(Wasabi: Wasabi) {

    // console.log('---------------------------------------------')
    // console.log('                   Wasm-R3                   ')
    // console.log('---------------------------------------------')
    // console.log('Constructing call graph...')

    let from: FromNode = { funcidx: 'h', host: true }
    let inHost: boolean | null = null
    let callGraph: CallGraph = []
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
        call_post(location, values) { },
        return_(location, values) { },
        const_(location, op, value) { },
        unary(location, op, input, result) { },
        binary(location, op, first, second, result) { },
        load(location, op, memarg, value) { },
        store(location, op, memarg, value) { },
        memory_size(location, memoryIdx, currentSizePages) { },
        memory_grow(location, memoryIdx, byPages, previousSizePages) { },
        local(location, op, localIndex, value) { },
        global(location, op, globalIndex, value) { },
        memory_fill(location, index, value, length) { },
        memory_copy(location, destination, source, length) { },
        memory_init(location, destination, source, length) { },
        table_size(location, currentSizeEntries) { },
        table_copy(location, destination, source, length) { },
        table_init(location, destination, source, length) { },
        table_get(location, index, value) { },
        table_set(location, index, value) { },
        table_grow(location, n, val, previusElement) { },
        table_fill(location, index, value, length) { },
        call_pre(locatation, op, targetFunc, args, tableTarget) {
            inHost = Wasabi.module.info.functions.filter(f => f.import !== null).length <= locatation.func
            if (inHost) {
                let from: FromWasm = {
                    funcidx: locatation.func,
                    host: false as false,
                }
                let to = {
                    funcidx: targetFunc,
                    params: args,
                    host: true,
                }
                callGraph.push({ from, params: args, to })
            }
            from = {
                funcidx: targetFunc,
                host: true,
            }
        },
        begin_function(location, args) {
            if (from.funcidx === 'h') {
                let from: FromInit = {
                    funcidx: 'h' as 'h',
                    host: true as true
                }
                let to: ToFromHost = {
                    funcidx: location.func,
                    host: false as false,
                    memSizes: Wasabi.module.memories.map(m => m.buffer.byteLength),
                    tableSizes: Wasabi.module.tables.map(t => t.length),
                }
                callGraph.push({ from, params: args, to })
                return
            }
            if (from.host) {
                let to: ToFromHost = {
                    funcidx: location.func,
                    host: false,
                    memSizes: Wasabi.module.memories.map(m => m.buffer.byteLength),
                    tableSizes: Wasabi.module.tables.map(t => t.length)
                }
                callGraph.push({ from, params: args, to })
                return
            }
            let to: ToFromWasm = {
                funcidx: location.func,
                host: false,
            }
            //@ts-ignore
            callGraph.push({ from, params: args, to })
        }
    }
    return callGraph
}
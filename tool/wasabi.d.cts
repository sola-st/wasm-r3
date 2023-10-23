type Location = { func: number, instr: number }
type ValType = 'i32' | 'i64' | 'f32' | 'f64' | 'anyfunc' | 'funcref' | 'externref'
type MemArg = { addr: number, align: number, offset: number }
type GlobalOp = 'global.set' | 'global.get'

export declare type Wasabi = {
    HOOK_NAMES: [
        "start",
        "if_",
        "br",
        "br_if",
        "br_table",
        "begin",
        "end",
        "nop",
        "unreachable",
        "drop",
        "select",
        "call_pre",
        "call_post",
        "return_",
        "const_",
        "unary",
        "binary",
        "load",
        "store",
        "memory_size",
        "memory_grow",
        "local",
        "global",
        "memory_fill",
        "memory_copy",
        "memory_init",
        "table_size",
        "table_copy",
        "table_init",
    ],
    module: {
        info: {
            functions: {
                type: string,
                import: string[],
                export: string[],
                locals: string,
                instrCount: number
            }[],
            memories: {
                import: string[] | null,
                export: string[]
            }[],
            tables: {
                import: string[] | null,
                export: string,
                ref_type: any
            }[],
            globals: {
                import: string[] | null,
                export: string[],
                valType: ValType,
            }[],
            start: any,
            tableExportName: string,
            brTables: any[],
            originalFunctionImportsCount: number
        },
        lowlevelHooks: any,
        exports: {
            [name: string]: any
        },
        tables: WebAssembly.Table[],
        memories: WebAssembly.Memory[],
        globals: WebAssembly.Global[],
    },
    resolveTableIdx: Function,
    analysis: {
        start?: (location: Location, ...args: any) => void,
        if_?: (location: Location, ...args: any) => void,
        br?: (location: Location, ...args: any) => void,
        br_if?: (location: Location, ...args: any) => void,
        br_table?: (location: Location, ...args: any) => void,
        begin?: (location: Location, ...args: any) => void,
        begin_function?: (location: Location, args: number[]) => void,
        end?: (location: Location, ...args: any) => void,
        nop?: (location: Location, ...args: any) => void,
        unreachable?: (location: Location, ...args: any) => void,
        drop?: (location: Location, ...args: any) => void,
        select?: (location: Location, ...args: any) => void,
        call_pre?: (location: Location, targetFunc: number, args: number[], indirectTableIdx: number | undefined) => void,
        call_post?: (location: Location, values: number[]) => void,
        return_?: (location: Location, ...args: any) => void,
        const_?: (location: Location, ...args: any) => void,
        unary?: (location: Location, ...args: any) => void,
        binary?: (location: Location, ...args: any) => void,
        load?: (location: Location, op: string, memarg: MemArg, ...args: any) => void,
        store?: (location: Location, op: string, memarg: MemArg, ...args: any) => void,
        memory_size?: (location: Location, ...args: any) => void,
        memory_grow?: (location: Location, ...args: any) => void,
        local?: (location: Location, ...args: any) => void,
        global?: (location: Location, op: GlobalOp, ...args: any) => void,
        memory_fill?: (location: Location, index: number, value: number, length: number) => void,
        memory_copy?: (location: Location, destination: number, source: number, length: number) => void,
        memory_init?: (location: Location, destination: number, source: number, length: number) => void,
        table_size?: (location: Location, currentSizeEntries: number) => void,
        table_copy?: (location: Location, destination: number, source: number, length: number) => void,
        table_init?: (location: Location, destination: number, source: number, length: number) => void,
        table_get?: (location: Location, index: number, value: any) => void,
        table_set?: (location: Location, index: number, value: any) => void,
        table_grow?: (location: Location, n: any, val: number, previousElement: number) => void,
        table_fill?: (location: Location, index: number, value: any, length: number) => void,
    }
}
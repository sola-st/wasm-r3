export type Location = { func: number, instr: number }
export type ValType = keyof WebAssembly.ValueTypeMap
export type GlobalOp = 'global.set' | 'global.get'
export type LocalOp = 'local.get' | 'local.set' | 'local.tee'
export type StoreOp = 'i32.store' | 'i32.store8' | 'i32.store16' | 'i64.store' | 'i64.store8' | 'i64.store16' | 'i64.store32' | 'f32.store' | 'f64.store'
export type LoadOp = 'i32.load' | "i32.load8_s" | 'i32.load8_u' | 'i32.load16_s' | 'i32.load16_u' | 'i64.load' | 'i64.load8_s' | 'i64.load8_u' | 'i64.load16_s' | 'i64.load16_u' | 'i64.load32_s' | 'i64.load32_u' | 'f32.load' | 'f64.load'
export type MemTarget = { memIdx: number, addr: number }
export type MemArg = { align: number, offset: number }
export type TableTarget = { tableIdx: number, elemIdx: number }
export type BranchTarget = { label: number, location: Location }
export type BlockType = 'function' | 'block' | 'loop' | 'if' | 'else'
export type UnaryOp = string // todo
export type BinaryOp = string // todo
export type ImpExp = { import: string[] | null, export: string }
export type Mutability = 'Mut' | 'Const'
export type Limits = { initial: number, maximum: number | null }

export type Wasabi = {
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
            functions: (ImpExp & {
                type: string,
                locals: string,
                instrCount: number
            })[],
            memories: (ImpExp & Limits)[],
            tables: (ImpExp & Limits & { refType: any })[],
            globals: (ImpExp & { valType: ValType, mutability: Mutability })[],
            start: any,
            tableExportNames: string[],
            memoryExportNames: string[],
            globalExportNames: string[],
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
        start?: (location: Location) => void,
        if_?: (location: Location, condition: boolean) => void,
        br?: (location: Location, target: BranchTarget) => void,
        br_if?: (location: Location, conditionalTarget: BranchTarget, condition: boolean) => void,
        br_table?: (location: Location, table: any, defaultTarget: any, tableIdx: number) => void, // this needs to be extended for wasm 2.0 as well to support multiple tables
        begin?: (location: Location, type: BlockType) => void,
        begin_function?: (location: Location, args: number[]) => void,
        end?: (location: Location, type: BlockType, beginLocation: Location, ifLocation: Location) => void,
        nop?: (location: Location) => void,
        unreachable?: (location: Location) => void,
        drop?: (location: Location, value: any) => void,
        select?: (location: Location, condition: boolean, first: any, second: any) => void,
        call_pre?: (location: Location, op: 'call' | 'call_indirect', targetFunc: number, args: number[], tableTarget: TableTarget | undefined) => void, // is number correct here? Or can ther be other types
        call_post?: (location: Location, values: number[]) => void, // is number correct here? Or can there be other types
        return_?: (location: Location, values: number[]) => void, // is number correct here? Or can there be other types
        const_?: (location: Location, op: 'i32.const' | 'i64.const' | 'f32.const' | 'f64.const', value: number) => void,
        unary?: (location: Location, op: UnaryOp, input: any, result: any) => void,
        binary?: (location: Location, op: BinaryOp, first: any, second: any, result: any) => void,
        load?: (location: Location, op: LoadOp, target: MemTarget, memarg: MemArg, value: any) => void,
        store?: (location: Location, op: StoreOp, target: MemTarget, memarg: MemArg, result: any) => void,
        memory_size?: (location: Location, memoryIndex: number, currentSizePages: number) => void,
        memory_grow?: (location: Location, memoryIndex: number, byPages: number, previousSizePages: number) => void,
        local?: (location: Location, op: LocalOp, localidx: number, value: any) => void,
        global?: (location: Location, op: GlobalOp, globalIndex: number, value: any) => void,
        memory_fill?: (location: Location, target: MemTarget, value: number, length: number) => void,
        memory_copy?: (location: Location, destination: MemTarget, source: MemTarget, length: number) => void,
        memory_init?: (location: Location, destination: MemTarget, source: MemTarget, length: number) => void,
        table_size?: (location: Location, tableIndex: number, currentSizeEntries: number) => void,
        table_copy?: (location: Location, destination: TableTarget, source: TableTarget, length: number) => void,
        table_init?: (location: Location, destination: TableTarget, source: TableTarget, length: number) => void,
        table_get?: (location: Location, target: TableTarget, value: any) => void,
        table_set?: (location: Location, target: TableTarget, value: any) => void,
        table_grow?: (location: Location, tableindex: number, n: any, val: number, previousElement: number) => void,
        table_fill?: (location: Location, target: TableTarget, value: any, length: number) => void,
    }
}
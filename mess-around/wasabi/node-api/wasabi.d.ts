type Wasabi = {
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
        "global"
    ],
    module: {
        info: {
            functions: {
                type: string,
                import: any,
                export: string[],
                locals: string,
                instrCount: number
            }[],
            globals: string,
            start: any,
            tableExportName: string,
            brTables: any[],
            originalFunctionImportsCount: number
        },
        lowlevelHooks: any,
        exports: {
            [name: string]: any
        },
        table: any
    },
    analysis: {
        start?: (...args: any[]) => any,
        if_?: (...args: any[]) => any,
        br?: (...args: any[]) => any,
        br_if?: (...args: any[]) => any,
        br_table?: (...args: any[]) => any,
        begin?: (...args: any[]) => any,
        end?: (...args: any[]) => any,
        nop?: (...args: any[]) => any,
        unreachable?: (...args: any[]) => any,
        drop?: (...args: any[]) => any,
        select?: (...args: any[]) => any,
        call_pre?: (...args: any[]) => any,
        call_post?: (...args: any[]) => any,
        return_?: (...args: any[]) => any,
        const_?: (...args: any[]) => any,
        unary?: (...args: any[]) => any,
        binary?: (...args: any[]) => any,
        load?: (...args: any[]) => any,
        store?: (...args: any[]) => any,
        memory_size?: (...args: any[]) => any,
        memory_grow?: (...args: any[]) => any,
        local?: (...args: any[]) => any,
        global?: (...args: any[]) => any,
    }
}
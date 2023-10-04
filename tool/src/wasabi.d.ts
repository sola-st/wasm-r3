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
        start: () => void,
        if_: () => void,
        br: () => void,
        br_if: () => void,
        br_table: () => void,
        begin: () => void,
        end: () => void,
        nop: () => void,
        unreachable: () => void,
        drop: () => void,
        select: () => void,
        call_pre: () => void,
        call_post: () => void,
        return_: () => void,
        const_: () => void,
        unary: () => void,
        binary: () => void,
        load: () => void,
        store: () => void,
        memory_size: () => void,
        memory_grow: () => void,
        local: () => void,
        global: () => void,
    }
}
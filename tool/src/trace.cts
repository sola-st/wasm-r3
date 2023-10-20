/*
 * type definitions for trace implementation
 * according to the trace specification
 */

export type Trace = WasmEvent[]

export type WasmEvent = Load | MemGrow | TableGet | TableGrow | GlobalGet | ExportCall | ImportCall | ImportReturn | ImportMemory | ImportTable | ImportGlobal | ImportFunc

export type Load = { type: "Load", idx: number, name: string, offset: number, data: Uint8Array }

export type MemGrow = { type: 'MemGrow', idx: number,name: string, amount: number }

export type TableGet = { type: "TableGet", tableidx: number, name: string, idx: number }

export type TableGrow = { type: 'TableGrow', idx: number, name: string, amount: number }

export type GlobalGet = { type: 'GlobalGet', idx: number, name: string, value: number, valtype: ValType }

export type ExportCall = { type: "ExportCall", names: string[], params: number[] }

export type ImportCall = { type: "ImportCall", idx: number, name: string }

export type ImportReturn = { type: "ImportReturn", idx: number, name: string, results: number[] }

export type ImportMemory = { type: 'ImportMemory', idx: number, module: string, name: string, pages: number }

export type ImportTable = { type: 'ImportTable', idx: number, module: string, name: string, reftype: "funcref" | "externref", size: number }

export type ImportGlobal = { type: 'ImportGlobal', idx: number, module: string, name: string, valtype: ValType, value: number }

export type ImportFunc = { type: 'ImportFunc', idx: number, module: string, name: string }



export type ValType = 'i32' | 'i64' | 'f32' | 'f64' | 'anyfunc' | 'funcref' | 'externref'
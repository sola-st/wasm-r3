/*
 * type definitions for trace implementation
 * according to the trace specification
 */

// Normal Trace

export type Trace = WasmEvent[]

export type WasmEvent = Load | MemGrow | TableGet | TableGrow | GlobalGet | ExportCall | TableCall | ImportCall | ExportReturn | ImportReturn | ImportMemory | ImportTable | ImportGlobal | ImportFunc
    | FuncEntry | FuncReturn | LoadExtended | TableGetExtended

export type Load = { type: "Load", idx: number, name: string, offset: number, data: number[] }

export type LoadExtended = { type: "LoadExt", idx: number, name: string, offset: number, data: number[] }

export type MemGrow = { type: 'MemGrow', idx: number, name: string, amount: number }

export type TableGet = { type: "TableGet", tableidx: number, name: string, idx: number, funcidx: number, funcName: string }

export type TableGetExtended = { type: "TableGetExt", tableidx: number, name: string, idx: number, funcidx: number, funcName: string }

export type TableGrow = { type: 'TableGrow', idx: number, name: string, amount: number }

export type GlobalGet = { type: 'GlobalGet', idx: number, name: string, value: number, valtype: ValType }

export type ExportCall = { type: "ExportCall", funcidx: number, name: string, params: number[] }

export type TableCall = { type: "TableCall", funcidx: number, tableName: string, tableidx: number, params: number[] }

export type ExportReturn = { type: 'ExportReturn' }

export type ImportCall = { type: "ImportCall", idx: number, name: string }

export type ImportReturn = { type: "ImportReturn", idx: number, name: string, results: number[] }

export type ImportMemory = { type: 'ImportMemory', idx: number } & WebAssembly.MemoryDescriptor & Import

export type ImportTable = { type: 'ImportTable', idx: number } & WebAssembly.TableDescriptor & Import

export type ImportGlobal = { type: 'ImportGlobal', idx: number, initial: number } & WebAssembly.GlobalDescriptor & Import

export type ImportFunc = { type: 'ImportFunc', idx: number } & Import

export type FuncEntry = { type: 'FuncEntry', idx: number, args: number[] }

export type FuncReturn = { type: 'FuncReturn', idx: number, values: number[] }



export type ValType = keyof WebAssembly.ValueTypeMap
export type RefType = 'funcref' | 'externref'
export type Import = { module: string, name: string }
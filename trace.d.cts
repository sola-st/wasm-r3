/*
 * type definitions for trace implementation
 * according to the trace specification
 */

export type ConsiseTrace = (ConsiseWasmEvent | Ref)[]

export type ConsiseWasmEvent = ConsiseLoad | ConsiseMemGrow | ConsiseTableGet | ConsiseTableGrow | ConsiseGlobalGet | ConsiseExportCall | ConsiseImportCall | ConsiseImportReturn | ConsiseImportMemory | ConsiseImportTable | ConsiseImportGlobal | ConsiseImportFunc

// export type Load = { type: "L", idx: number, name: string, offset: number, data: number[] }
// export type Load = [type, idx, name, offset, data]
export type ConsiseLoad = ['L', number, string, number, number[]]

// export type MemGrow = { type: 'MG', idx: number, name: string, amount: number }
// export type MemGrow = [type, idx, name, amount]
export type ConsiseMemGrow = ['MG', number, string, number]

// export type TableGet = { type: "T", tableidx: number, name: string, idx: number, funcidx: number, funcName: string }
// export type TableGet = [type, tableidx, name, idx, funcidx, funcname]
export type ConsiseTableGet = ['T', number, string, number, number, string]

// export type TableGrow = { type: 'TG', idx: number, name: string, amount: number }
// export type TableGrow = [type, idx, name, amount]
export type ConsiseTableGrow = ['TG', number, string, number]

// export type GlobalGet = { type: 'G', idx: number, name: string, value: number, valtype: ValType }
// export type GlobalGet = [type, idx, name, value, valtype]
export type ConsiseGlobalGet = ['G', number, string, number, ValType]

// export type ExportCall = { type: "EC", name: string, params: number[] }
// export type ExportCall = [type, name, params]
export type ConsiseExportCall = ['EC', string, number[]]

// export type ImportCall = { type: "IC", idx: number, name: string }
// export type ImportCall = [type, idx, name]
export type ConsiseImportCall = ['IC', number, string]

// export type ImportReturn = { type: "IR", idx: number, name: string, results: number[] }
// export type ImportReturn = [type, idx, name, results]
export type ConsiseImportReturn = ['IR', number, string, number[]]

// export type ImportMemory = { type: 'IM', idx: number, initial: number, maximum: number } & Import
// export type ImportMemory = [type, idx, module, name, initial, maxiumum]
export type ConsiseImportMemory = ['IM', number, string, string, number | undefined, number]

// export type ImportTable = { type: 'IT', idx: number } & WebAssembly.TableDescriptor & Import
// export type ImportTable = [type, idx, module, name, initial, maximum, element]
export type ConsiseImportTable = ['IT', number, string, string, number, number | undefined, WebAssembly.TableKind]

// export type ImportGlobal = { type: 'IG', idx: number, valtype: ValType, value: number } & Import
// export type ImportGlobal = [type, idx, module, name, value, mutable, initial]
export type ConsiseImportGlobal = ['IG', number, string, string, ValType, 0 | 1, number]

// export type ImportFunc = { type: 'IF', idx: number } & Import
// export type ImportGlobal = [type, idx, module, name]
export type ConsiseImportFunc = ['IF', number, string, string]

export type Ref = [number]

// Normal Trace

export type Trace = WasmEvent[]

export type WasmEvent = Load | MemGrow | TableGet | TableGrow | GlobalGet | ExportCall | ImportCall | ImportReturn | ImportMemory | ImportTable | ImportGlobal | ImportFunc

export type Load = { type: "Load", idx: number, name: string, offset: number, data: number[] }

export type MemGrow = { type: 'MemGrow', idx: number, name: string, amount: number }

export type TableGet = { type: "TableGet", tableidx: number, name: string, idx: number, funcidx: number, funcName: string }

export type TableGrow = { type: 'TableGrow', idx: number, name: string, amount: number }

export type GlobalGet = { type: 'GlobalGet', idx: number, name: string, value: number, valtype: ValType }

export type ExportCall = { type: "ExportCall", name: string, params: number[] }

export type ImportCall = { type: "ImportCall", idx: number, name: string }

export type ImportReturn = { type: "ImportReturn", idx: number, name: string, results: number[] }

export type ImportMemory = { type: 'ImportMemory', idx: number } & WebAssembly.MemoryDescriptor & Import

export type ImportTable = { type: 'ImportTable', idx: number } & WebAssembly.TableDescriptor & Import

export type ImportGlobal = { type: 'ImportGlobal', idx: number, initial: number } & WebAssembly.GlobalDescriptor & Import

export type ImportFunc = { type: 'ImportFunc', idx: number } & Import



export type ValType = keyof WebAssembly.ValueTypeMap
// export type ValType = 'i32' | 'i64' | 'f32' | 'f64' | 'anyfunc' | 'funcref' | 'externref'
export type RefType = 'funcref' | 'externref'
export type Import = { module: string, name: string }
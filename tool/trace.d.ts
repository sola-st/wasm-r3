/*
 * type definitions for trace implementation
 * according to the trace specification
 */

type Trace = WasmEvent[]

type WasmEvent = Load | MemGrow | TableGet | TableGrow | GlobalGet | ExportCall | ImportCall | ImportReturn | ImportMemory | ImportTable | ImportGlobal | ImportFunc

type Load = { type: "Load", idx: number, name: string, offset: number, data: Uint8Array }

type MemGrow = { type: 'MemGrow', idx: number,name: string, amount: number }

type TableGet = { type: "TableGet", tableidx: number, name: string, idx: number }

type TableGrow = { type: 'TableGrow', idx: number, name: string, amount: number }

type GlobalGet = { type: 'GlobalGet', idx: number, name: string, value: number, valtype: ValType }

type ExportCall = { type: "ExportCall", names: string[], params: number[] }

type ImportCall = { type: "ImportCall", idx: number, name: string }

type ImportReturn = { type: "ImportReturn", idx: number, name: string, results: number[] }

type ImportMemory = { type: 'ImportMemory', idx: number, module: string, name: string, pages: number }

type ImportTable = { type: 'ImportTable', idx: number, module: string, name: string, reftype: "funcref" | "externref" }

type ImportGlobal = { type: 'ImportGlobal', idx: number, module: string, name: string, valtype: ValType, value: number }

type ImportFunc = { type: 'ImportFunc', idx: number, module: string, name: string }



type ValType = 'i32' | 'i64' | 'f32' | 'f64' | 'anyfunc' | 'funcref' | 'externref'
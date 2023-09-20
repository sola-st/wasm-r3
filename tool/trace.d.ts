/*
 * type definitions for trace implementation
 * according to the trace specification
 */

type Trace = WasmEvent[]

type WasmEvent = Load | TableGet | ExportCall | ImportCall | ImportReturn

type Load = { type: "Load", memidx: number, offset: number, data: Uint8Array }

type TableGet = { type: "TableGet", tableidx: number, idx: number, ref: "funcref" | "externref" }

type ExportCall = { type: "ExportCall", name: string[] }

type ImportCall = { type: "ImportCall", module: string, name: string, params: number[] }

type ImportReturn = { type: "ImportReturn", results: number[], memGrow: number[], tableGrow: number[] }
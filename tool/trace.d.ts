/*
 * type definitions for trace implementation
 * according to the trace specification
 */

type Trace = WasmEvent[]

type WasmEvent = Load | TableGet | ExportCall | ImportCall | ImportReturn

type Load = { type: "Load", memidx: number, offset: number, data: Uint8Array }

type TableGet = { type: "TableGet", tableidx: number, idx: number, ref: "funcref" | "externref" }

type ExportCall = { type: "ExportCall", names: string[], params: number[] }

type ImportCall = { type: "ImportCall", funcidx: number, module: string, name: string }

type ImportReturn = { type: "ImportReturn", funcidx: number, results: number[], memGrow: number[], tableGrow: number[] }
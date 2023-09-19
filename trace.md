## Introduction

This document describes the trace specification of the wasm-r3 toolchain.

This specification inherits a few definitions from the original [WebAssembly spec](https://webassembly.github.io/spec/core/intro/index.html). Specifically it inherits the types `sN` and `fN` and the concrete type `u32`, as well as `byte` and `reftype`

## Trace
A WebAssembly program can be recorded as a *Trace*, which is a sequence of Events. The specification is defined in a Typescript like syntax. `Vec<T>` is essentially `T[]` that is restricted to a maximum length of `2^32 - 1`.

```typescript
type Trace = Event[]
```

```typescript
type Event = Load | Store | TableGet | TableSet | ExportCall | ImportCall | ImportReturn
```

```typescript
type Load = { offset: u32, data: byte[] }
```

```typescript
type  TableGet = { tableidx: u32, idx: u32, ref: reftype }
```

```typescript
type  ExportCall = u32
```

```typescript
type  ImportCall = { funcidx: u32, params: Vec<(iN | fN)> }
```

```typescript
type  ImportReturn = Vec<number>
```

## Text
The text format of wasm-r3 traces is a utf-8 encoded representation of the abstract structure.

The recommended extension for files containing wasm-r3 traces in textual format is "`.r3`"
and the recommended MediaType is "`application/r3`".

The Grammar is defined as follows:
- Terminal symbols are strings surrounded by a `"`
- The `+` operator concatinates two Terminal symbols
- Nonterminal symbols can be resolved to strings. These consist out of Terminals, the `+` symbol and utility functions like `str(x)`
- This function `str(x)` will take an input of type `iN|fN|u32` and convert it to a string. Example `str(42)` will result in `"42"`
- `str(x)` is an overloaded macro. If it takes an input of type `(iN|fN|u32)[]` or `Vec<(iN|fN|u32)>` it may resolve into the following Nonterminal: `str(x[0]) + "," + ... + str(x[x.length - 1])`

Production rules are written as follows: `TraceType => Nonterminal`. Left denotes a type which appears in the [trace](Trace) specification and on the right denotes a Nonterminal to which the corresponding type resolves to. In the Nonterminal part we write `self` to refer to the concrete instantiation of the respective type on the right. Fields of these types can directly be accessed by their identifier.

```
iN|fN|u32 => str(self) + ","
```

```
ImportReturn => "ImportReturn " + str(self)
```

```
ImportCall => "ImportCall " + str(funcidx) + ";" + str(params)
```

```
ExportCall => "ExportCall " + str(self)
```

```
TableSet => "TableSet " + str(tableidx) + ";" str(idx) + ";" + str(ref)
```

```
TableGet => "TableGet " + str(tableidx) + ";" str(idx) + ";" + str(ref)
```

```
Store => "Store " + str(offset) + ";" + data
```

```
Load => "Load " + str(offset) + ";" + data
```

```
Event => self + "\n"
```

## Optaining Trace
The following presents general rules of thumb presented as an algorithm in pseudocode on how one might obtain the trace from a WebAssembly module.

The Tracer program wants to maintain three global data structures: the trace itself, a shadow memory and a list of shadow tables. On the instantion of the WebAssembly module those datastructures should be initialized with the internal memory and tables state.
```typescript
let trace: Event[] = []
let shadowMemory: byte[]
let shadowTables: Vec<[Vec<u32>, reftype]>
```
When certain events happen during the execution of our target programm we will perform certain actions and may or may not append a new `Event` to our `Trace`. Below is a listing of those events
```typescript
function onInstanciate(memoryState, tablesState) {
    shadowMemory = memoryState
    shadowTables = tablesState
}
```

```typescript
function onStore(offset, data) {
    shadowMemory[offset:(offset + data.length)] == data && return
    shadowMemory.write(offset, data)
}
```

```typescript
function onMemoryGrow(delta) {
    shadowMemory.append(pages(delta))
}
```

```typescript
function onLoad(offset, data) {
    shadowMemory[offset:(offset + data.length)] == data && return
    shadowMemory.length <= offset + data.length && shadowMemory.grow_accordingly(offset, data)
    shadowMemory.write(offset, data)
    trace.push({ offset, data }: Load)
}
```

```typescript
function onTableSet(tableidx, idx, ref) {
    table[tableidx][idx] == ref && return
    table[tableidx][idx] = ref
}
```

```typescript
function onTableSet(tableidx, idx, ref) {
    table[tableidx][idx] == ref && return
    table[tableidx].length <= idx && table[tableidx].grow_accordingly(idx)
    table[tableidx][idx] = ref
    trace.push({ tableidx, idx, ref }: TableSet)]
}
```

```typescript
function onEnterExportedFunction(funcidx) {
    trace.push(funcidx: ExportCall)
}
```

```typescript
function onCallImportedFunction(funcidx, params) {
    trace.push({ funcidx, params }: ImportCall)
}
```

```typescript
function onReturnImportedFunction(results) {
    trace.push(results: ImportReturn)
}
```

The function `trace.dump()` could dum the trace in textual representation to a `.r3` file.
## Introduction

This document describes the trace specification of the wasm-r3 toolchain.

This specification inherits definitions from the original [WebAssembly specification](https://webassembly.github.io/spec/core/intro/index.html). Specifically it inherits the structure types `sN` and `fN` and the concrete type `u32`, as well as `byte` and `reftype`

TODO: Define behaviour for table and memory grow.

## Trace
A WebAssembly program can be recorded as a *Trace*, which is a sequence of Events. The specification is defined in a Typescript like syntax. `Vec<T>` is essentially `T[]` that is restricted to a maximum length of `2^32 - 1`.

```typescript
type Trace = Event[]
```

```typescript
type Event = Load | TableGet | ExportCall | ImportCall | ImportReturn
```

```typescript
type Load = { memidx: u32, offset: u32, data: byte[] }
```

As of version 2.0 of the [WebAssembly standard](https://webassembly.github.io/spec/core/intro/index.html) there is only one memory supported per module. So `memidx` will implicitly always have the value `1`. This restriction may be lifted in future versions.

```typescript
type  TableGet = { tableidx: u32, idx: u32, ref: reftype }
```

```typescript
type  ExportCall = { names: string[], params: Vec<(iN | fN)> }
```

```typescript
type  ImportCall = { funcidx: u32, module: string, name: string }
```

```typescript
type  ImportReturn = { funcidx: u32, results: Vec<(iN | fN)>, memGrow: Vec<u32>, tableGrow: Vec<u32> }
``` 
**Note** This trace design contains more information then what is minimal necessarry for the actual implementation of a generator like for example `funcidx` in the events `ImportCall` and `ImportReturn`. This design choise simplifies and speeds up the replay generation. It increases the trace size slightly.

## Text
The text format of wasm-r3 traces is a utf-8 encoded representation of the abstract [Trace](Trace).

The recommended extension for files containing wasm-r3 traces in textual format is "`.txt`"
and the recommended MediaType is "`text/plain`".

The Grammar is defined as follows:
- Terminal symbols are strings surrounded by a `"`
- The `+` operator concatinates two Terminal symbols
- Nonterminal symbols can be resolved to strings. These consist out of Terminals, the `+` symbol and utility functions like `str(x)`
- This function `str(x)` will take an input of type `iN|fN|u32` and convert it to a string. Example `str(42)` will result in `"42"`
- `str(x)` is an overloaded macro. If it takes an input of type `(iN|fN|u32)[]` or `Vec<(iN|fN|u32)>` it may resolve into the following Nonterminal: `str(x[0]) + "," + ... + str(x[x.length - 1])`
- `byte[]` will just stay as raw data
- `x` of type `string[]` gets resolved to `x[0] + "," + ... + x[x.length - 1]`

Production rules are written as follows: `TraceType => Nonterminal`. Left denotes a type which appears in the [Trace](Trace) specification and right denotes a Nonterminal to which the corresponding type resolves to. In the Nonterminal part we write `self` to refer to the concrete instantiation of the respective type on the right. Fields of these types can directly be accessed by their identifier.

```
Event => self + "\n"
```

```
Load => "Load;" + str(memidx) + ";" + str(offset) + ";" + data
```

```
TableGet => "TableGet;" + str(tableidx) + ";" + str(idx) + ";" + str(ref)
```

```
ExportCall => "ExportCall;" + str(names) + ";" + str(params)
```

```
ImportCall => "ImportCall;" + str(funcidx) + ";" + module + ";" + name
```

```
ImportReturn => "ImportReturn;" + str(funcidx) + ";" + str(results) + ";" str(memGrow) + ";" + str(tableGrow)
```

```
iN|fN|u32 => str(self)
```

# Binary
The raw format of wasm-r3 traces is a linear encoding of the abstract [Trace](Trace).

The recommended extension for files containing wasm-r3 traces in textual format is "`.txt`"
and the recommended MediaType is "`application/r3`".

```
Event => self
```

```
Load => 0x00 memidx offset length(data) data
```

```
TableGet => 0x01 tableidx idx ref
```

```
ExportCall => 0x02 + length(names) names length(params) params
```

```
ImportCall => 0x03 length(module) module length(name) name length(params) paramas
```

```
ImportReturn => 0x04 + length(results) results length(memGrow) memGrow length(tableGrow) tableGrow
```

## Optaining Trace
The following presents a general approach on how one might obtain the trace from a WebAssembly module as a rough algorithm in typescript like pseudocode.

The Tracer program wants to maintain three global data structures: the trace itself, a shadow memory and a list of shadow tables. On the instantion of the WebAssembly module those datastructures should be initialized with the internal memory and tables state.

```typescript
let trace: Event[] = []
let shadowMemory: byte[] = []
let shadowTables: Vec<[Vec<u32>, reftype]> = []
```
Additionally we assume that a global variable `module` is available that contains state information about the instanciated WebAssembly module during runtime. When certain events happen during the execution of our target programm we will perform certain actions and may or may not append a new `Event` to the `trace`. Below is a listing of those events.

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
    shadowMemory.grow(delta)
}
```

```typescript
function onLoad(offset, data) {
    shadowMemory[offset:(offset + data.length)] == data && return
    shadowMemory.write(offset, data)
    trace.push({ memidx: 1, offset, data }: Load)
}
```

```typescript
function onTableSet(tableidx, idx, ref) {
    table[tableidx][idx] == ref && return
    table[tableidx][idx] = ref
}
```

```typescript
function onTableGrow(tableidx, delta) {
    table[tableidx].grow(delta)
}
```

```typescript
function onTableGet(tableidx, idx, ref) {
    table[tableidx][idx] == ref && return
    table[tableidx][idx] = ref
    trace.push({ tableidx, idx, ref }: TableSet)]
}
```

```typescript
function onEnterExportedFunction(exportNames) {
    trace.push(exportNames)
}
```

```typescript
function onCallImportedFunction(funcidx, params) {
    trace.push({ funcidx, params }: ImportCall)
}
```

```typescript
function onReturnImportedFunction(results) {
    let importReturn: ImportReturn = {
        results,
        memGrow: [],
        tableGrow: []
    }
    if wasm.memory.numPages != shadowMemory.numPages {
        let delta = wasm.memory.numPages - shadowMemory.numPages
        shadowMemory.grow(delta)
        importReturn.memGrow = [delta]
    }
    wasm.tables.map((table, tableidx) => {
        if table.length != shadowTables[tableidx].length {
            let delta = table.length - shadowTables[tableidx].length
            shadowTables[tableidx].grow(delta)
            importReturn.tableGrow.push(delta)
        }
    })
    trace.push(importReturn)
}
```
---
defaults:
    layout: full
theme: dracula
canvasWidth: 800
layout: cover
download: true
---

# Wasm-R3
Jakob Getz\
University of Stuttgart / KAIST

---

# Vision
Automated creation of WebAssembly benchmarks via **Record and Replay**
## Why
- Useful for performance mesurement, evaluation of static analyses, ...
- So far not many executable benchmarks out there
## How
Wasm-R3 Workflow:
```
Url    ---->    Wasm-R3    ---->    Browser    ---->    Packaged Benchmark
```

---
layout: two-cols
---

# WebAssembly

`index.wasm`:

```wasm
(module
    (import "env" "foo" (func $foo))
    (func (export "main")
        i32.const 69
        i32.const 420
        i32.store
        call $foo
        i32.const 69
        i32.load    ;; ??
    )
    (memory (export "mem") 1)
)
```

::right::

<br/>

`host.js`: 

```js
const binary = readFile('index.wasm')
const imports = {
    env: {
        foo: () => { /*...*/ }
    }
}

const wasm =
    await WebAssembly.instantiate(
        binary, imports
    )
wasm.instance.exports.foo()
```

---

# Record and Replay

- The execution of software is determined by Environment `E` and Application `A`
- `A` is deterministic but it uses interaces of `E`
    - `A` may **call** a function provided by `E` (eg. syscall)
    - `A` may get **called** by `E` (eg. interupt)
- `E` is a blackbox, its actions appear unpredictable to `A`
- In **Record and Replay** we
    - Record the behavior of `E` during program execution
    - Replay the behavior in a replay phase
- Our case: WebAssembly code is `A` and Javascript code is `E`
---
layout: two-cols
---

# Collecting Traces

```wasm
(module
    (import "env" "foo" (func $foo))
    (func (export "main")
        i32.const 69
        i32.const 420
        i32.store
        call $foo
        i32.const 69
        i32.load    ;; 12
    )
    (memory (export "mem") 1)
)
```

::right::

<br/>

## Trace

```
ExportCall;1;main;
ImportCall;0;foo;
ImportReturn;0;
Load;12
```
<br/>

## Replay Binary
```js
function foo() {
    wasm.instance.exports.mem[69] = 12
}
```

---

# Current State

- Instrument WebAssembly with Wasabi
- Collect traces and generate replay for 50+ (micro)tests
- Record and Replay of real website with Wasm-R3

<br/>

## CLI

<br/>

```
$ r3 record https://playgameoflife.com/ trace.r3
```

<br/>

```
$ r3 generate trace.r3 replay.js
```

---
layout: end
---

# That's All 

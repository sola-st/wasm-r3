---
defaults:
    layout: full
theme: dracula
canvasWidth: 800
layout: cover
download: true
---

# Wasm-R3 Concept
Jakob Getz\
University of Stuttgart / KAIST

---

# Wasm-R3
Wasm-R3 is a framework for creating WebAssembly benchmarks.
## Why
Useful for performance mesurement, evaluation of static analyses, ...
## How
Automatically generated from real world applications. Because it better represents a real world program

---

# What will we do
## Input
* Real World Website that uses WebAssembly
* User interactions with that Website
## Output
Benchmark

### Example
* Input: Website: `murloc.io`
* Output: Benchmark `murloc`

---

# Benchmark
A benchmark is a folder with the remplay file and all the original wasm files from the website:
```bash
+-- murloc
|   +-- replay.js
|   +-- wasm/
|   |   +-- bin1.wasm
|   |   +-- bin2.wasm

```
You will be able to run the Benchmark for example like this:
```bash
$ node murloc/replay.js
```

---

# Benchmark creation

1. Instrument Website
2. Interact with instrumented website   (Recording)
3. Collect trace information            (Recording)
4. Generate replay binary from trace
5. Package

---

# 1. Instrument Website
* Opening a website without Wasm-R3
```ts
website = { html, js, wasm }
server.send(website)
browser.receive(website)
```

* Opening a website with Wasm-R3
```ts
website = { html, js, wasm }
server.send(website)
instrumenter.receive(website)
instrumenter.instrument(&website) // this only affects .wasm files
instrumenter.send(website)
browser.receive(website)
```

---

# 2/3. Interact with Website and collet trace (Recording)
When a user interacts with a website certain events happen in the code of the website. For example a specific function `a` gets called or afunction `b` writes a value `c` to memory.\
We are interested in specific events that happen inside of the wasm code, e.g. when a wasm module calls an imported function.\
Because the website is instrumented now we can preserve information about those events in traces.

---

### Example
* Event: wasm function `a` calls imported function `b`
* Trace
```
EVT import_call #9475, caller a, callee b, memory_state, table_state
EVT import_return #9476, #9475, memory_state, table_state
```
Trace entry consists of
* Event type
* Unique identifier
* Additional information that is important for specifig event type

--- 

# 4. Generate replay binary

A replay binary is an application that takes the role of the user and not-wasm code and interacts with the wasm in exactly the same way as theuser and other non wasm components did during recording.\
From the trace we collected we create a file `replay.js`
* Replay binary should be as minimal as possible
    * as small as possible (optimise / reduce)
    * as fast as possible (maybe parts of the replay binary could be also in wasm?)

# 5. Package
Package wasm files and reblay binary into a benchmark folder\
<mdi-party-popper/> DONE

---

# How to generate replay binary

The replay  binary generator just needs as input the trace.\
How to generate the trace?
What wasm constructs to trace?

## I think about 

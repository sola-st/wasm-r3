# Wasm-R3

This document will include the current state and design decisions of the Wasm-R3 project, for everyone that is interested. Comments and discussion preferably via email: st176751@stud.uni-stuttgart.de

## Design choices

### 1: Support
When we have an application with multiple wasm binaries we will first consider only one binary at a time for wasm-r3. Later we might decide to also support multiple binary applications. Justification:
* start small and see how far you can get

### 2: Instrumentation
Instrumentation will be done with [Wasabi](https://github.com/danleh/wasabi). Justification:
- engine independent
- already supports most features we need
- good possibility to develop wasabi further and update it to support wasm 2.0
- since instrumentation is decoupled to the following wasm-r3 process one can easily replace the underlying technology

(Custom instrumentation could be done with e.g [wasmbin](https://github.com/GoogleChromeLabs/wasmbin). However we decide to use wasabi. Instrumentation performance is not critical here.)

### 3: Tracing
For tracing the memory and table state we will trace an entry for each relevant load/store and table.set/get
- Keep the trace at reasonable size

### 4: Replay binary
Format of replay binary will be webassembly which is glued with javascript to the target binary. Justification
- Least overhead introduced to the actuall target binary

### 5: Target binary
The target binary in the final benchmark shall be exactly the same as in the original program, i.e. it will be uninstrumented. Justification:
- The target binary behaves in the benchmark exactly the same as in the real world

## Roadmap
- [ ] Extend Wasabi with needed features for wasm 2.0
- [ ] Define trace standart
- [ ] Implement trace collection
- [ ] Record real world applications (eg. use collected [npm packages](https://github.com/sola-st/wasm-call-graphs/tree/main/real-world-programs) by Michelle)
- [ ] Implement replay generator 
- [ ] Package recorded real world applications into benchmarks
- [ ] Package wasm-r3 tool into public repository for public use
- [ ] Write and submit master thesis
- [ ] Write and publish workshop paper (optional)
- [ ] Support benchmark creation with multiple binaries (optional)
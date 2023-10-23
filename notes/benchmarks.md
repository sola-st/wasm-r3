# Benchmarks

- Which Benchmarks do exist for WebAssembly?
- What approaches are there for automatically generating Benchmarks (also for other languages)?

## Types of Benchmarks

- Microbenchmarks (small single purpose tests)
- Kernels (moderatly small core algorithms, that implement performance-critical work as part of a larger application)
- Applications (Represent comlete progams, [[they should include sideffects, like file IO :o]] I wanna do this!!)
- Domain specific applications

## What is a good benchmark

[The Art of Building a Good Benchmark](https://link.springer.com/chapter/10.1007/978-3-642-10424-4_3)
- Relevant
    - Meaningful and understandable metric
    - Stresses software features in a way that is similar to customer applications
    - Exercises hardware systems in a way that is similar to customer applications
    - Longevity – leading edge but not bleeding edge
    - Broad applicability
    - Does not misrepresent itself
    - Has a target audience that wants the information
- Repeatable
- Fair
- Verifiable
- Economical

Tradeofspace between Relevancy and the rest

## My Approach
- Executable Benchmarks
- What are executable webassembly programs?
    - If they run in the browser it is wasm with javascript hostcode
    - If they are standalone programs interpreted by some sort of vm, they have main function but do not require hostcode.
- I could compare my benchmark complexity to other Benchmarks (like in the dakapo paper)

## WasmBench
[An Empirical Study of Real-World WebAssembly Binaries](https://dl.acm.org/doi/abs/10.1145/3442381.3450138), [Benchmarks on github](https://github.com/sola-st/WasmBench)
- These are pure wasm binaries that are collected from github, package managers, the web and so on.
- They are **not** executable so they can only be analysed statically.

## Understanding the Performance of WebAssembly Applications
[Understanding the Performance of WebAssembly Applications](https://dl.acm.org/doi/abs/10.1145/3487552.3487827)
- Uses: Polybench and CHStone compiled to wasm

## Libsodium Webassembly Benchmark
[Github](https://github.com/jedisct1/webassembly-benchmarks)
[Benchmarks should be here in the 1.0.18-stable](https://download.libsodium.org/libsodium/releases/)
- type is probably kernel

## PSDF Kit
[PSDF](https://pspdfkit.com/blog/2018/a-real-world-webassembly-benchmark/)
- That one is pretty cool. It is this pdf online tool and they worked together with browser vendors

## Wasmboy Benchmarking tool
[Web](https://wasmboy.app/benchmark/)
- Compares wasm to javascript
- type is probably application, but the application itelf is only there for benchmarking lol

## New Kid on the Web
Source: [New Kid on the Web: A Study on the Prevalence of WebAssembly in the Wild](https://link.springer.com/chapter/10.1007/978-3-030-22038-9_2)
- Relatively old for webassembly

## SecBench
[SECBENCH.JS: An Executable Security Benchmark Suite for Server-Side JavaScript](https://publications.cispa.saarland/3909/)
- Executable Benchmark Suite of Vulnerabilities

## SPEC CPU
[Spec CPU](https://www.spec.org/cpu2017/)
- Can you compile stuff from them to wasm??
- Executable Benchmark Suite 
- Type is probably Kernel

## PolyBench
[PolyBench/C](https://web.cse.ohio-state.edu/~pouchet.2/software/polybench/)
- This is a c benchmark but you can compile it to wasm. They have done it here: [Understanding Performance of Wasm](https://dl.acm.org/doi/abs/10.1145/3487552.3487827)
- Type is probably Kernel

## CHStone
[CHStone: A benchmark program suite for practical C-based high-level synthesis](https://ieeexplore.ieee.org/document/4541637)
- This is a c benchmark but you can compile it to wasm. They have done it here: [Understanding Performance of Wasm](https://dl.acm.org/doi/abs/10.1145/3487552.3487827
- Type is probably Kernel

## Dacapo Suite
[Dacapo](https://www.dacapobench.org)
- These are benchmarks for java
- Difficult for me to understand what is going on because I dont know shit about java

## Webassembly Benchmarks
[Github](https://github.com/WebAssembly/benchmarks/tree/main)
- Crappy repo by Ben Titzer
- There is a nice classification of Benchmarks (Microbenchmark, Kernel, Application, Domain specific)

## Sightglass
[Github](https://github.com/bytecodealliance/sightglass)
Explicitly designed for Wasmtime and cranelift

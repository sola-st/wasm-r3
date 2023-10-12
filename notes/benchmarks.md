# Benchmarks

- Which Benchmarks do exist for WebAssembly?
- What approaches are there for automatically generating Benchmarks (also for other languages)?

## My Approach
- Executable Benchmarks
- What are executable webassembly programs?
    - If they run in the browser it is wasm with javascript hostcode
    - If they are standalone programs interpreted by some sort of vm, they have main function but do not require hostcode.

## WasmBench
Source: [An Empirical Study of Real-World WebAssembly Binaries](https://dl.acm.org/doi/abs/10.1145/3442381.3450138), [Benchmarks on github](https://github.com/sola-st/WasmBench)
- These are pure wasm binaries that are collected from github, package managers, the web and so on.
- They are **not** executable so they can only be analysed statically.

## New Kid on the Web
Source: [New Kid on the Web: A Study on the Prevalence of WebAssembly in the Wild](https://link.springer.com/chapter/10.1007/978-3-030-22038-9_2)
- Relatively old for webassembly

## SecBench
Source [SECBENCH.JS: An Executable Security Benchmark Suite for Server-Side JavaScript](https://publications.cispa.saarland/3909/)
- Executable Benchmark Suite of Vulnerabilities
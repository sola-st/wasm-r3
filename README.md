# Execution-Aware Program Reduction for WebAssembly via Record and Replay

This repository contains supplementary material for the paper "Execution-Aware Program Reduction for WebAssembly via Record and Replay".

# Repository structure

The Repository is structured as follows:

- `./rr-reduce`: This directory contains Python code used in the implementation.
  - `./rr-reduce/wasm-slice`: This file is a entry point for RR-Reduce
  - `./rr-reduce/wasm-hybrid`: This file is a entry point for Hybrid-Reduce
  - `./rr-reduce/heuristic_finder.py`: This file contains logic for identifying Heuristic Set.
- `./src`: This directory contains JavaScript code used in the implementation.
  - `./src/web.ts`: This file implements record phase and reduce phase of Wasm-R3.
- `./crates`: This directory contains rust code used in the implementation.
  - `./crates/replay_gen`: This directory contains replay phase of Wasm-R3.
  - `./crates/slice_dice`: This directory contains the split program phase of RR-Reduce.
- `./evaluation`: This directory contains evaluation set and evaluation scripts.
  - `./evaluation/benchmarks`: This directory contains 28 Wasm programs used for the evaluation of RR-Reduce, with the accompanying oracle script. We also include output of RR-Reduce (suffixed with .sliced.wasm), Hybrid-Reduce (suffixed with .hybrid.wasm), wasm-reduce (suffixed with .reduced.wasm), and wasm-shrink (suffixed with shrunken.wasm).
  - `./evaluation/engines`: This directory contains different versioins of three Wasm engines used for the evaluation.
  - `./evaluation/logs`: This directory contains experiment logs of the evaluation.
  - `./evaluation/oracle`: This directory contains oracle scripts used for the evaluation.
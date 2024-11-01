# RR-Reduce: Execution-Aware Program Reduction via Record-Replay

This repository contains supplementary material for the paper "RR-Reduce: Execution-Aware Program Reduction via Record-Replay".

# Repository structure

The Repository is structured as follows:

- `./benchmarks`: This directory contains 20 Wasm programs used for the evaluation of RR-Reduce, with the accompanying oracle script. We also include output of RR-Reduce (suffixed with .sliced.wasm), wasm-reduce (suffixed with .reduced.wasm), and wasm-shrink (suffixed with shrunken.wasm).
- `./crates`: This directory contains rust code used in the implementation of RR-Reduce.
  - `./crates/replay_gen`: This directory contains replay phase of Wasm-R3.
  - `./crates/slice_dice`: This directory contains the split program phase of RR-Reduce.
- `./evaluation`: This directory contains some implementations of RR-Reduce and evaluation scripts.
  - `./evaluation/wasm-slice`: This file is a entry point for RR-Reduce
  - `./evaluation/heuristic_finder.py`: This file contains logic for identifying Heuristic Set.
  - `./evaluation/engines`: This directory contains various engines under test.
  - `./evaluation/metrics.json`: This file contains the raw data output for experiments.
- `./src`: This directory contains record phase and reduce phase of Wasm-R3
- `./third_party`: This directory contains various third party softwares used by RR-Reduce.
  - `./third_party/binaryen`: This directory contains Binaryen, RR-Reduce uses `wasm-merge`, `wasm-reduce`, `wasm-as`, `wasm-dis` in particular.
  - `./third_party/wasm-tools`: This directory contains wasm-tools. RR-Reduce uses `wasm-tools objdump`, `wasm-tools shrink` in particular.
  - `./third_party/wizard-engine`: This directory contains the Wizard Research engine. RR-Reduce uses icount monitor of the Wizard engine in particular.

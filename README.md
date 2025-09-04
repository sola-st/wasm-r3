# Execution-Aware Program Reduction for WebAssembly via Record and Replay

This repository contains supplementary material for the paper "Execution-Aware Program Reduction for WebAssembly via Record and Replay" (ASE 2025).

# Getting Started

## Requirements

- Any OS that supports docker can run this artifact.
- To reproduce the effectiveness and efficiency number of the paper, you might  need a hardware matching the performance of the machine used for the original experiment (Intel Core i9-13900k CPU with 5600Mhz 192GB of DRAM)

## Installation

We provide three ways to install our artifact.

### Visual Studio Code Dev Container (Recommended)

- Install [Visual Studio Code](https://code.visualstudio.com/download) and its [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers).
- Open the repository in Visual Studio Code: `code .`.
- Build and open the project with Visual Studio Code Command: `Dev Containers: Rebuild and Reopen in Container`.

### Docker (Recommended)

- Pull the image: `docker pull doehyunbaek1/rr-reduce:final`
- Run the image: `docker run -it -u vscode --workdir /workspaces/wasm-r3   --entrypoint /usr/bin/bash   -e BINARYEN_ROOT=/workspaces/wasm-r3/third_party/binaryen   -e WASMR3_PATH=/workspaces/wasm-r3   -e PATH=/workspaces/wasm-r3/rr-reduce/:/workspaces/wasm-r3/crates/target/release:/workspaces/wasm-r3/evaluation/engines:/workspaces/wasm-r3/third_party/wasm-tools/target/release/:/workspaces/wasm-r3/third_party/binaryen/bin/:/workspaces/wasm-r3/third_party/wizard-engine/virgil/bin:/workspaces/wasm-r3/third_party/wizard-engine/bin:$PATH   doehyunbaek1/rr-reduce:final`

### Local Install

We officially support only X86-64 based Ubuntu 24.04 machines. Consult [.devcontainer](.devcontainer/) directory to find the relevant scripts.

## Kick-the-tire

We suppose that you have installed the artifact with one of the three methods described above.

# Detailed Description

## Reproducing the experiments of the paper.

We provide two scripts to reproduce the experiments of the paper.

[evaluation/eval_reduce.py](evaluation/eval_reduce.py) is the main script used for running all the experiments in the paper.

Its usage is as follows: `python eval_reduce [<tool>|all] [<test>|all]`

For \<tool\>, you can provide one of the four tools listed below:
- wasm-shrink
- wasm-reduce
- wasm-slice (Correspondds to RR-Reduce in the paper.)
- wasm-hybrid (Corresponds to Hybrid-Reduce in the paper.)

For \<test\>, you can provide one of the 28 programs listed below:
- wasmedge#3018   
- wamr#2789       
- wasmedge#3019   
- wamr#2862       
- wamr#2450       
- wasmedge#3076   
- mandelbrot      
- pathfinding     
- pacalc          
- wasmedge#3057   
- guiicons        
- rtexviewer      
- rfxgen          
- riconpacker     
- rguistyler      
- rguilayout      
- jqkungfu        
- bullet          
- funky-kart      
- sqlgui          
- hydro           
- figma-startpage 
- sandspiel       
- parquet         
- commanderkeen   
- jsc             
- boa             
- ffmpeg          

Output of the metric will be written in [evaluation/metrics.json](evaluation/metrics.json) file.
Output of the original metric is checked in [evaluation/expected_metrics.json](evaluation/expected_metrics.json).

Output of the individual reduction will be written inside directory [evaluation/benchmarks/\<test>\/]().
For example, here is what [evaluation/benchmarks/commanderkeen/](evaluation/benchmarks/commanderkeen/). would look like:

```bash
vscode ➜ /workspaces/wasm-r3 (ASE_2025) $ ls -l evaluation/benchmarks/commanderkeen/
total 29436
-rw-r--r--  1 vscode vscode   363027 Sep  4 21:49 commanderkeen.hybrid_stripped.wasm
-rw-r--r--  1 vscode vscode   363027 Sep  4 21:49 commanderkeen.hybrid_temp.wasm
-rw-r--r--  1 vscode vscode      951 Sep  4 23:36 commanderkeen.hybrid_test.wasm
-rw-r--r--  1 vscode vscode      951 Sep  4 23:36 commanderkeen.hybrid.wasm
-rw-r--r--  1 vscode vscode  1690562 Sep  7 05:08 commanderkeen.reduced_test.wasm
-rw-rw-r--  1 vscode vscode  1690577 Sep  7 05:08 commanderkeen.reduced.wasm
-rw-------  1 vscode vscode  1969892 Sep 11 07:30 commanderkeen.shrunken.wasm
-rw-r--r--  1 vscode vscode 14986192 Sep 11 07:30 commanderkeen.shrunken.wat
-rw-r--r--  1 vscode vscode   387482 Sep  4 14:10 commanderkeen.sliced.wasm
-rw-r--r--  1 vscode vscode  4331018 Sep  4 21:32 commanderkeen.stripped.wasm
-rw-r--r--  1 vscode vscode  4331018 Sep  4 21:32 commanderkeen.wasm
drwxr-xr-x  2 vscode vscode     4096 Sep 12 07:39 expected
drwxr-xr-x 16 vscode vscode     4096 Sep  4 14:10 out
```

- commanderkeen.wasm is the input to the reduction tools.
- commanderkeen.shrunken.wasm is the output of the `wasm-shrink` tool
- commanderkeen.reduced.wasm is the output of the `wasm-reduce` tool.
- commanderkeen.sliced.wasm is the output of the `wasm-slice` (RR-Reduce) tool.
- commanderkeen.hybrid.wasm is the output of the `wasm-hybrid` (Hybrid-Reduce) tool.
- commanderkeen.hybrid_stripped.wasm, commanderkeen.hybrid_temp.wasm, commanderkeen.hybrid_test.wasm, commanderkeen.reduced_test.wasm, commanderkeen.shrunken.wat, commanderkeen.stripped.wasm, are the intermediate files generated by the tools.
- Directory `out` contains intermediate files generated by `wasm-slice` and `wasm-hybrid`.
- Directory `expected` contains output of the original run for comparison.

NOTE: the size you get with `ls -l` is the size of the module, not the code. To get the code size you need to use tools like `wasm-tools objdump` or consult `metrics.json` which utilizes such tool.

For reference, we provide how long it took to reproduce the experiment with each tool.

NOTE: your result might differ depending on your hardware setup.

```bash
vscode ➜ /workspaces/wasm-r3 (ASE_2025) $ python evaluation/eval_reduce.py wasm-shrink all
2025-09-12 07:30:34,200 - INFO - Took 172802.76957297325s (48.0007693258259h)
```

```bash
vscode ➜ /workspaces/wasm-r3 (ASE_2025) $ python evaluation/eval_reduce.py wasm-reduce all
2025-09-08 01:53:27,849 - INFO - Took 161088.80288028717s (44.74688968896866h)
```

```bash
vscode ➜ /workspaces/wasm-r3 (ASE_2025) $ python evaluation/eval_reduce.py wasm-slice all
2025-09-04 19:09:01,172 - INFO - Took 18766.46604323387s (5.212907234231631h)
```

```bash
vscode ➜ /workspaces/wasm-r3 (ASE_2025) $ python evaluation/eval_reduce.py wasm-hybrid all
2025-09-05 21:53:01,421 - INFO - Took 87603.23522043228s (24.334232005675634h)
```

To reproduce the tables and figures used in the paper, you run [evaluation/latexify.py](evaluation/latexify.py).
```bash
vscode ➜ /workspaces/wasm-r3 (ASE_2025) $ python evaluation/latexify.py evaluation/metrics.json
```
The tables and figures will be written to [evaluation/table/](evaluation/table/) and [evaluation/figure/](evaluation/figure/).

## Repository structure

The Repository is structured as follows:

- `./rr-reduce`: This directory contains Python code used in the implementation.
  - `./rr-reduce/wasm-slice`: This file is a entry point for RR-Reduce
  - `./rr-reduce/wasm-hybrid`: This file is a entry point for Hybrid-Reduce
  - `./rr-reduce/heuristic_finder.py`: This file contains logic for identifying Heuristic Set.
- `./src`: This directory contains JavaScript code used in the implementation.
  - `./src/test.ts`: This file is a entry point to Wasm-R3.
  - `./src/test-slice-dice.ts`: This file calls other scripts that does split, record-replay, and combine.
  - `./src/web.ts`: This file implements record phase and reduce phase of Wasm-R3.
- `./crates`: This directory contains Rust code used in the implementation.
  - `./crates/replay_gen`: This directory contains replay phase of Wasm-R3.
  - `./crates/slice_dice`: This directory contains the split program phase of RR-Reduce.
- `./evaluation`: This directory contains evaluation set and evaluation scripts.
  - `./evaluation/benchmarks`: This directory contains 28 Wasm programs used for the evaluation of RR-Reduce. We also include output of RR-Reduce (suffixed with .sliced.wasm), Hybrid-Reduce (suffixed with .hybrid.wasm), wasm-reduce (suffixed with .reduced.wasm), and wasm-shrink (suffixed with shrunken.wasm).
  - `./evaluation/engines`: This directory contains different versioins of three Wasm engines used for the evaluation.
  - `./evaluation/oracle`: This directory contains oracle scripts used for the evaluation.

# Wasm-R3: Record-Reduce-Replay for Realistic and Standalone  WebAssembly Benchmarks

## Introduction

This repository contains supplementary material for the paper "Wasm-R3: Record-Reduce-Replay for Realistic and Standalone  WebAssembly Benchmarks" (OOPSLA'24).

## Hardware Dependencies

Wasm-R3 itself is usable on both arm machines and x86-64 machines.

However, due to our use of x86-64 specific software build and hardware counters, the machine with x86-64 cpu is required for the evaluation.

While the artifact should work with x86-64 mac machines, I was unable to build the image in the command where we build binaryen from source with my 2016 MacBook Pro 13-inch model.

Thus, we strongly advise to use Linux based x86-64 machine, which is the only setup confirmed by the authors.

We used docker version 27.0.3 to prepare this artifact.

## Getting Started Guide

There are two main components to this artifact. We explain them in order.

### Running Wasm-R3 yourself

We provide pre-built Docker image for artifact evaluation. You can run

```
docker pull doehyunbaek1/wasm-r3:latest
docker run --name wasm-r3 -dit --cap-add SYS_ADMIN doehyunbaek1/wasm-r3:latest
```

to pull the image and start the container.

Addition of Linux capability('--cap-add SYS_ADMIN') is required for running Linux perf tool to measure hardware counters.
If you intend to skip this measurement, you can omit this command-line argument.

Then, attach to the container.

```
docker exec -it wasm-r3 bash
```

### Utilizing Wasm-R3-Bench

We also provide a benchmark suite of 27 real-world web applications generated by Wasm-R3.

They are located at the `benchmarks/` directory of the container.

You can run any Wasm engines of your choice by running them at the shell, for example, with [wasmtime](https://github.com/bytecodealliance/wasmtime), you can just run

```
wasmtime benchmarks/funky-kart.wasm
```

at shell of your choice.

## Step by Step Instructions

### Container structure 

The container is organized as follows.

- `/home/wasm-r3/`
  - `benchmarks/`: Benchmark suite of 27 real-world web applications generated by Wasm-R3.
  - `evaluation-oopsla2024`: Main evaluation scripts. Described in detail below.
  - `tests/`: Contains various scripts used for testing Wasm-R3.
    - `online/`: Contains browser automation scripts used to run Wasm-R3 against real web applications.
  - `src/`: Source code for TypeScript part of Wasm-R3, which contains record and reduce phase.
  - `crates/`: Source code for Rust part of Wasm-R3, which contains replay phase.
  - `binaryen/`: Dependency of Wasm-R3, used for replay optimizations.
  - `wasabi/`: Dependency of Wasm-R3, used for bytecode instrumentation.

## Scripts inside evaluation-oopsla2024 directory

There are 7 evaluation scripts used for the evaluation of Wasm-R3.

Every scripts that starts with `eval` stores its metrics at `evaluation-oopsla2024/metrics.json` for later use.

- `eval-RQ1-1.py`: Runs Wasm-R3 against the real web application and generates replay benchmarks(section 5.2.1). Also logs some auxiliary stats related to trace reduction(section 5.4).
- `eval-RQ1-2.py`: Runs generated replay benchmarks on 6 target engines totalling 17 configurations(section 5.2.2).
- `eval-RQ2-1.py`: Measures record overhead by comparing cpu cycles of uninstrumented and instrumented chromium(section 5.3.1).
- `eval-RQ2-2.py`: Measures replay characteristics by comparing cpu cyles spent in original wasm code and replay function(section 5.3.2).
- `eval-RQ3.py`: Placeholder script. Acutal work is done as part of `eval-RQ1-1.py`
- `eval-RQ4.py`: Conducts an ablation study of four variants of Wasm-R3 with two replay optimizations enabled(section 5.5).
- `eval-all.sh`: Runs all of the scripts in order.

Note that when running these scripts separately, you need to run `eval-RQ1-1.py` before running any other scripts, as other scripts reuse replay benchmarks generated by `eval-RQ1-1.py`.

To run everything in one go, simply run

```
python3 evaluation-oopsla2024/eval-all.py
```

### Kick the tires

For quick evaluation of all the scripts, but targeting only single website, you can simply run

```
TEST_NAME=game-of-life python3 evaluation-oopsla2024/eval-all.py
```

In our setup, this took about 30 seconds, so we believe this is sufficiently short for the kick-the-tire phase.

### Things to note

We provide `tests/metrics.json`, which is a raw data we got at the time of submission for the convenience.
You can compare this with `evaluation-oopsla2024/metrics.json`, to see if the data you get matches ours.

### Detailed description of each evaluation scripts

`eval-RQ1-1.py`

This script runs Wasm-R3 against real world web applications on the website, generates a replay benchmark as a result, and check if it is accurate by comparing the trace.

You can see whether Wasm-R3 successfully generated accurate benchmarks at the commandline as below.

```
fractals                      ERROR
funky-kart                    SUCCESS
game-of-life                  SUCCESS
gotemplate                    ERROR
```

You can manually check the generated benchmark by checking `tests/online/{name}/benchmark/bin_0/replay.wasm`.

You can check the trace by the original exectuion at `tests/online/{name}/benchmark/bin_0/trace-ref.r3` and by the replay execution at `tests/online/{name}/benchmark/bin_0/trace-replay.r3`

This took about 30 minutes in our setup.

`eval-RQ1-2.py`

This script runs generated replay benchmarks on 17 different options of 6 Wasm engines.

You can see the execution time of generated replay benchmark per engine at the commandline as below.

```
multiplyDouble sm             4.10573
multiplyDouble sm-base        6.637122
multiplyDouble sm-opt         4.102249
multiplyDouble v8             4.742663
multiplyDouble v8-liftoff     6.639272
multiplyDouble v8-turbofan    5.107738
```

This took about 10 minutes in our setup.

`eval-RQ2-1.py`

This script measures cpu cycles spent in the uninstrumented and instrumented variation of Wasm-R3.

You can see the cpu cycles at the commandline as below.

```
boa            original       16175757607 cycles
boa            instrumented   432494441284 cycles
bullet         original       3903096092 cycles
bullet         instrumented   14417731264 cycles
```

You can check the stdout and stderr of chromium process manually at `evaluation-oopsla2024/output`

This took about 30 minutes in our setup.

NOTE: As perf is highly coupled with Linux kernel version, we highly recommend you use Linux machine with kernel 5.15.0-113-generic.

NOTE: In the original evaluation, we have repeated the experiment 10 times, but for the sake of time, we have set the REP_COUNT to 1 for this evaluation script.
If you want to reproduce the original evaluation, please set REP_COUNT environment variable to 1.

`eval-RQ2-2.py`

This script measures cycles spent in the original wasm functions and replay functions of replay benchmarks.

You can see the percentage of cpu cycles of replay functions at the commandline as below.
```
bullet                        5.220406249659279%
commanderkeen                 1.8601849870563851%
factorial                     1.601868353703344%
```

You can check the output of wizard engine, which is used for this measurement, at `evaluation-oopsla2024/data`.

This took about 3 minutes in our setup.

NOTE: In the original evaluation, we have repeated the experiment 10 times, but for the sake of time, we have set the REP_COUNT to 1 for this evaluation script.
If you want to reproduce the original evaluation, please set REP_COUNT environment variable to 1.

`eval-RQ4.py`

This script measures various dynamic stats of four variants of replay benchmarks, with and without optimizations.

You can see whether wizard was able to run on four variants as below.
```
game-of-life   noopt          SUCCESS
game-of-life   split          SUCCESS
game-of-life   merge          SUCCESS
game-of-life   benchmark      SUCCESS
```

This took about 30 seconds in our setup. 

NOTE: In the original evaluation, we have repeated the experiment 10 times, but for the sake of time, we have set the REP_COUNT to 1 for this evaluation script.
If you want to reproduce the original evaluation, please set REP_COUNT environment variable to 1.

`eval-all.sh`

This script runs all the above scripts in order.

# Reusability Guide

Among the directories in the container, `src` and `crates` should be considered a core part of the Wasm-R3, which should be reusable for various real-world web applications.

Wasm-R3-Bench, which is a benchmark suite of 27 real-world web applications generated by Wasm-R3, is located at `benchmarks` directory.
Even in the case that future changes to the websites break Wasm-R3's functionality on the website, Wasm-R3-Bench would not be effected; thus we also consider it as a reusable part of this artifact.

Browser automation scripts inside `tests/online` are meant to be a test code that exercises web applciations that are hosted in the web.
If the content of the web application changes, there might be some modifications required to the test script to adjust to the new application.
In the extreme circumstance that the web application is no longer hosted, the test scripts would not be reusable.
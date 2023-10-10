# Record and Replay

This document gives an overview of existing record and replay techniques.

# Categorising Approaches
- Low Level
- High Level
- Source Level Instrumentation
- Source Rewriting
- Userspace record/replay
- Virual Machine replay debugging
- Macro Like Replay tools (only record user input and not other inputs like network traffic)
- Parallel Replay
- Whole system replay

## My own technique: Wasm-r3
* Record applications to create Benchmarks.
* Independent of Environment. Works with every engine on every hardware
* Apply record and replay technique to programms with two Languages: Javascript and WebAssembly => Just replay WebAssembly
* Record will have high overhead due to instrumentation (Instrumentation necessarry for Environment Indepencence)
* Replay will have **NO** overhead. WebAssembly Binary remains untouched. Overall program will run faster since Hostcode will be reduced significantly
=> Reduce HostCode as much as possible so that most execution time in the replay comes from WebAssembly
* This technique can not only be used for benchmark creation but also for debugging purposes
* The host environment are the user interactions with a application as well as the platform (browser, virtual machine, hardware) the application runs on
* Host code is the javascript code that hosts the WebAssembly
* Our implementation will change the host code arbitrarily
* Other systems always need to record the interaction with the Host environment, we just need to record the interaction with the host code

### Research Contributions
* Replay a existing program with 0 overhead. (Only Wasm part)
* We show that record and replay is possible independent of the Host Environment


## Jalangi
Source: [Jalangi: a selective record-replay and dynamic analysis framework for JavaScript](https://dl.acm.org/doi/abs/10.1145/2491411.2491447)

* Purpose: A framework for writing heavy weight dynamic analysis

## RR
Source: [Engineering Record And Replay For Deployability](https://www.usenix.org/conference/atc17/technical-sessions/presentation/ocallahan), [RR Project](https://rr-project.org)

* Purpose: Debug applications to find bugs that only appear with a low chance.
* Does not use instrumentation
* Environment Dependent, Relies on hardware and OS features (Does not work on ARM CPUs)
* We show that record and replay of user-space pro- cesses on modern, stock hardware and software without pervasive code instrumentation is possible and practical.
* We introduce an in-process system-call interception technique and show it dramatically reduces over- head.
* We show that for low-parallelism workloads, RR recording and replay overhead is reasonably low, lower than other approaches with comparable de- ployability.
* We identify hardware and operating system design constraints required to support our approach.
* RR compresses all trace data, other than cloned files and blocks, with the zlib “deflate” method.
* This is lowlevel record and replay

## Dolos
Source: [Interactive Record/Replay for Web Application Debugging](https://dl.acm.org/doi/10.1145/2501988.2502050)

* Tool is called timelaps (For webapplications)
* Dolos is the Record/Replay infrastructure
* Dolos saves everything, User input and timing and network events. This is necessarry since all of this affects execution. We on the other hand only have to be concerned about the calls to and from Wasm.
* This is tightly coupled to WebKit. It does not use source code instrumentation.
* Record slowdown around very low (Max 1.65 for non interactive programs and no slow down for interactive programs)

## ReVirt
Source: [ReVirt: enabling intrusion analysis through virtual-machine logging and replay](https://dl.acm.org/doi/abs/10.1145/844128.844148)

* Full system replay
* Does not depend on operating system. It removes the dependencies on the target operating system by moving it to a VM and logging below the vm.
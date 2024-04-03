# Evaluation Set Failures

This describes the failures of executing Wasm-R3 on our evaluation set.

**Tags:**
- *Threads:*
This module uses the threads proposal for WebAssembly.
Wasabi currently does not support this feature.
- *Simd:*
This module uses the simd proposal for WebAssembly.
Wasabi curretly does not support this feature.
- *Out of memory:*
This web page generates large traces. The browser runs out of memory before the test script is finished.
This is due to the Wasabi based instrumentation not implementing trace streaming.
- *Proxying:*
For these websites there is an issue in the monkey patch script.
- *Poor performance:*
This web site performs heavy calculations.
Because of the performance overhead of Wasabi the website stays not interactable for an undefined amount of time.
- *Replay runs forever:*
When executing the generated replay, the execution does not seem to terminate.
- *No Wasm:*
This web site seems to not use wasm.
We should remove it from the evaluation set.

Dependencies
- Wasabi
    Wasabi doesn't support latest Proposals
    1. fractals
        - Threads
    2. lichess
        - Threads
    3. livesplit
        - Simd
- Binaryen
    4. waforth
        - When trying to generate the replay there is a wasm-merge issue
- Wasm
    6. roslyn
        - Poor performance
        - With modified test script: Maximum call stack size exceeded, 2: wasm trap: call stack exhausted

Flaky
  - tic-tac-toe. Produces benchmark 2/5. Not sure why.

Improvable 
7. image-convolute
    - Will be solved with an improved version of function split optimization.
8. timestretch
    - Proxying edge case. Should improve proxying logic.
10. vaporboy
    - No wasm --> use profiler to detect

Don't know.

6. rustpython
    - Poor performance
    The test might work for a very long delay.
2. gotemplate
    - Proxying
    After the instantation of the WebAssembly module, the websites code performs a check: result.instance instanceof WebAssembly.Instance.
    If not it throws. For some reason after the monkey patch this condition is true. I could not figure out exactly why.

. ~/.bashrc && timeout 120s npm test -- -t takahirox
. ~/.bashrc && timeout 120s npm test -- -t playnox
. ~/.bashrc && timeout 120s npm test -- -t hnset-bench
. ~/.bashrc && timeout 120s npm test -- -t wasmsh
. ~/.bashrc && timeout 120s npm test -- -t wheel



4. onnxjs
- Out of memory
- Poor performance

This website probably does work with a certain delay choosen for the test script.
The delay needs to be long enough that the page.evaluate can run and download traces and buffers.
The delay needs to be short enough that the process does not run out of memory.
I could not find the sweetspot

. ~/.bashrc && timeout 120s npm test -- -t rustpython
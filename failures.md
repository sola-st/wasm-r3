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


1. fractals
    - Threads

2. gotemplate
    - Proxying

    After the instantation of the WebAssembly module, the websites code performs a check: result.instance instanceof WebAssembly.Instance.
    If not it throws. For some reason after the monkey patch this condition is true. I could not figure out exactly why.

3. lichess
    - Threads

4. onnxjs
    - Out of memory
    - Poor performance

    This website probably does work with a certain delay choosen for the test script.
    The delay needs to be long enough that the page.evaluate can run and download traces and buffers.
    The delay needs to be short enough that the process does not run out of memory.
    I could not find the sweetspot

5. roslyn
    - Poor performance

    The test might work for a very long delay. I did it with 200_000 ms. This was not enough.
    From the browser console I can see that tere is a task: 'Initializing mono runtime' which does quite some heavy computation until the application loads.

6. rustpython
    - Poor performance

    The test might work for a very long delay.

7. image-convolute
    - Poor performance

    The test does not only have a poor performance during record, but also during replay generation and recording trace during replay.
    The test might work on my (Jakob) machine.
    I (Jakob) have a Intel Core I9 and 32GB of ram.
    It takes however very long to finish

8. tic-tac-toe
    - Poor performance
    - Replay runs forever

    The test might work for a very long delay.
    I (Jakob) was able to generate a replay with npm start, but executing the replay does not stop.

9. timestretch
    - Proxying

    The record browser just crashes shortly after record start.
    A error gets printed to the terminal that I do not understand.

10. vaporboy
    - No wasm

11. waforth
    When trying to generate the replay there is a wasm-merge issue

12. figma-startpage
    When trying to generate the replay there seems to be an issue with the generated module a.wasm.
    It is not valid.

13. livesplit
    - Simd

14. vim-wasm
    This website is just broken, with or without wasm attached.
    It uses a feature called SharedArrayBuffer which is not supported by google chrome at that time.
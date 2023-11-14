# Websites

This is a list of Websites we have tried wasm-r3 on.

- [Game of Life](https://playgameoflife.com/) (Seems to work)
- [Path finding](https://jacobdeichert.github.io/wasm-astar/) (Seems to work)
- [Calculator App](https://handytools.xd-deng.com/) (Seems to work)
- [Funky Karts](https://www.funkykarts.rocks/demo.html) (Replay fails with memory index out of bounds error)
    - Instrumentation takes 0:0.439, NaN
    - Trace download takes 1:56.243, 2:24.030
    - Trace conversion takes 0:0.080, 0:0.87
    - Wasm download takes 0:7.480, 0:7.266
    - Closing Browser takes 0:0.331, 0:0,325
    - Saving Benchmark takes NaN, 0:0.180\
    **Now New**:
    - Stringify: 0:0.536
    - Parse: 0:1.060
    - Download overall 0:4.475 => so this means more then half is for transfering the string from the browser to the local context. This might be due to trace size.
    It could help to compress the trace with zip or gzip to make the download faster
    - Trace processing 0:0.075
    - wasm download: 0:6.836 => This can potentially optimised the sme way as the trace download so far it is not optimised
    - browser close: 0:0.391
    - save Benchmark: NaN => It does not take too long though
- [Rust Python](https://rustpython.github.io/demo/) There is some compilation error
- [Generate Heatmap](https://aurium.gitlab.io/wasm-heatmap/) (Failed to load resource: net::ERR_BLOCKED_BY_RESPONSE.NotSameOrigin)
- [PSPDF Kit Demo](https://pspdfkit.com/demo/hello) (We didnt really test it yet. Wasm seems not to get instantiated) WebWorker issue
- [Capcut]() (email: jakob@getz.de, password: 123456)
const startTime = performance.now();

fetch("add.wasm")
    .then((response) => response.arrayBuffer())
    .then((bytes) => {
        console.log("Worker 2 bytes:", bytes);
        return WebAssembly.instantiate(bytes, {});
    })
    .then((result) => {
        const addResult = result.instance.exports.add(3, 4);
        console.log(`Worker 2: 3 + 4 = ${addResult}`);
        return addResult;
    })
    .then((addResult) => {
        const endTime = performance.now();
        const executionTime = endTime - startTime;
        self.postMessage({
            status: 'completed',
            result: `3 + 4 = ${addResult}`,
            executionTime: executionTime
        });
    })
    .catch((error) => {
        console.error("An error occurred in worker 2:", error);
        self.postMessage({
            status: 'error',
            error: error.message
        });
    });
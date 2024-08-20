const startTime = performance.now();

fetch("add.wasm")
    .then((response) => response.arrayBuffer())
    .then((bytes) => {
        console.log("Worker bytes:", bytes);
        return WebAssembly.instantiate(bytes, {});
    })
    .then((result) => {
        const addResult = result.instance.exports.add(1, 2);
        console.log(`1 + 2 = ${addResult}`);
        return addResult;
    })
    .then((addResult) => {
        const endTime = performance.now();
        const executionTime = endTime - startTime;
        self.postMessage({
            status: 'initialized',
            result: `1 + 2 = ${addResult}`,
            executionTime: executionTime
        });
    })
    .catch((error) => {
        console.error("An error occurred in worker:", error);
        self.postMessage({
            status: 'error',
            error: error.message
        });
    });
fetch("add.wasm")
    .then((response) => response.arrayBuffer())
    .then((bytes) => {
        console.log(bytes);
        return WebAssembly.instantiate(bytes, {});
    })
    .then((result) => {
        const addResult = result.instance.exports.add(1, 2);
        console.log(`1 + 2 = ${addResult}`);
        return addResult;
    })
    .then((addResult) => {
        self.postMessage({
            status: 'initialized',
            result: `1 + 2 = ${addResult}`
        });
    })
    .catch((error) => {
        console.error("An error occurred:", error);
        self.postMessage({
            status: 'error',
            error: error.message
        });
    });
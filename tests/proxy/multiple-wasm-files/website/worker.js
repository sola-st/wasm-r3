Promise.all([
    fetch("mul.wasm")
        .then((response) => response.arrayBuffer())
        .then((bytes) => WebAssembly.instantiate(bytes, {}))
        .then((result) => {
            console.log(`3 x 3 = ${result.instance.exports.mul(3, 3)}`);
            return result;
        }),
    fetch("div.wasm")
        .then((response) => response.arrayBuffer())
        .then((bytes) => WebAssembly.instantiate(bytes, {}))
        .then((result) => {
            console.log(`3 / 3 = ${result.instance.exports.div(3, 3)}`);
            return result;
        })
]).then(() => {
    self.postMessage('finished');
}).catch((error) => {
    console.error("An error occurred:", error);
    self.postMessage('error');
});
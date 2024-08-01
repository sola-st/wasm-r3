fetch("mul.wasm")
    .then((response) => response.arrayBuffer())
    .then((bytes) => WebAssembly.instantiate(bytes, {}))
    .then((result) => console.log(`3 x 3 = ${result.instance.exports.mul(3, 3)}`));
fetch("div.wasm")
    .then((response) => response.arrayBuffer())
    .then((bytes) => WebAssembly.instantiate(bytes, {}))
    .then((result) => console.log(`3 / 3 = ${result.instance.exports.div(3, 3)}`));
fetch("add.wasm")
    .then((response) => response.arrayBuffer())
    .then((bytes) => {
        console.log(bytes)
        return WebAssembly.instantiate(bytes, {})
    })
    .then((result) => console.log(`1 + 2 = ${result.instance.exports.add(1, 2)}`));
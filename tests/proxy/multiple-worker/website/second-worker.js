fetch("add.wasm")
    .then((response) => response.arrayBuffer())
    .then((bytes) => {
        console.log(bytes)
        return WebAssembly.instantiate(bytes, {})
    })
    .then((result) => console.log(`3 + 4 = ${result.instance.exports.add(3, 4)}`));
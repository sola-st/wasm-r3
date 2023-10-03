let instance
let imports = {
    env: {
        add: (a, b) => a + b
    }
}
let wasm = await WebAssembly.instantiate(wasmBinary, imports)
instance = wasm.instance
instance.exports.main(1, 2)
let instance
let imports = {
    env: {
        foo: () => instance.exports.baz()
    }
}
let wasm = await WebAssembly.instantiate(wasmBinary, imports)
instance = wasm.instance
instance.exports.main(1, 2)
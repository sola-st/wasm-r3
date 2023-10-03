let instance
let global = 0
let imports = {
    env: {
        foo: () => {
            global++
            return global
        }
    }
}
let wasm = await WebAssembly.instantiate(wasmBinary, imports)
instance = wasm.instance
instance.exports.main()
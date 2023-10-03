let instance
let imports = {}
let wasm = await WebAssembly.instantiate(wasmBinary, imports)
instance = wasm.instance
instance.exports.main()
instance.exports.foo()
instance.exports.bar()
instance.exports.foo()
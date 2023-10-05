const wasmBinary = require('fs').readFileSync('./index.wasm')
let instance: any
let imports = {}
let wasm = await WebAssembly.instantiate(wasmBinary, imports)
instance = wasm.instance
instance.exports.main()

export default 1
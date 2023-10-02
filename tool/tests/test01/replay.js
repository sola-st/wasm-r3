const fs = await import('fs')
const path = await import('path')
let instance
let imports = {}
imports.env = {}
imports.env.changeMem = () => {
new Uint8Array(instance.exports.memory)[1] = 1
new Uint8Array(instance.exports.memory)[2] = 0
new Uint8Array(instance.exports.memory)[3] = 0
new Uint8Array(instance.exports.memory)[4] = 0
}
let wasmBinary = fs.readFileSync(path.join(import.meta.dir, 'index.wasm'))
let wasm = await WebAssembly.instantiate(wasmBinary, imports)
instance = wasm.instance
await instance.exports.main()

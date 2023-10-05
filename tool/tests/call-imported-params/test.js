import fs from 'fs'
import path from 'path'
let wasmPath = path.join(import.meta.dir, 'index.wasm')
let wasmBinary = fs.readFileSync(wasmPath)
let instance
let imports = {
    env: {
        add: (a, b) => a + b
    }
}
let wasm = await WebAssembly.instantiate(wasmBinary, imports)
instance = wasm.instance
instance.exports.main(1, 2)
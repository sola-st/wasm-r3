import fs from 'fs'
import path from 'path'
let wasmPath = path.join(import.meta.dir, 'index.wasm')
let wasmBinary = fs.readFileSync(wasmPath)
let instance
let imports = {
    env: {
        foo: () => { }
    }
}
let wasm = await WebAssembly.instantiate(wasmBinary, imports)
instance = wasm.instance
instance.exports.main(1)
instance.exports.main(3)
instance.exports.main(4)

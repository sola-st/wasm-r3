import fs from 'fs'
import path from 'path'
let wasmBinary = fs.readFileSync(path.join(import.meta.dir, 'index.wasm'))
let instance
let imports = {
    env: {
        foo: () => { }
    }
}
let wasm = await WebAssembly.instantiate(wasmBinary, imports)
instance = wasm.instance
instance.exports.main()
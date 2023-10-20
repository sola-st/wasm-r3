import fs from 'fs'
import path from 'path'
let wasmBinary = fs.readFileSync(path.join(path.dirname(import.meta.url).replace(/^file:/, ''), 'index.wasm'))
let instance
let imports = {
    env: {
        foo: () => { }
    }
}
let wasm = await WebAssembly.instantiate(wasmBinary, imports)
instance = wasm.instance
instance.exports.main()
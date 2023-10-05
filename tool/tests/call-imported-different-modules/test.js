import fs from 'fs'
import path from 'path'
let wasmPath = path.join(import.meta.dir, 'index.wasm')
let wasmBinary = fs.readFileSync(wasmPath)
let instance
let imports = {
    env: {
        foo: () => { }
    },
    env2: {
        bar: () => { }
    }
}
let wasm = await WebAssembly.instantiate(wasmBinary, imports)
wasm.instance.exports.main()
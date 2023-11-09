import fs from 'fs'
import path from 'path'
const wasmPath = path.join(path.dirname(import.meta.url).replace(/^file:/, ''), 'index.wasm')
const wasmBinary = fs.readFileSync(wasmPath)
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
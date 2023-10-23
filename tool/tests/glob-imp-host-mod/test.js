import fs from 'fs'
import path from 'path'
const wasmPath = path.join(path.dirname(import.meta.url).replace(/^file:/, ''), 'index.wasm')
const wasmBinary = fs.readFileSync(wasmPath)

let instance
const global = new WebAssembly.Global({ value: "i32", mutable: true }, 0);
let imports = {
    env: {
        changeGlobal: () => {
            global.value = 5
        },
        global: global
    }
}
let wasm = await WebAssembly.instantiate(wasmBinary, imports)
instance = wasm.instance
instance.exports.main()
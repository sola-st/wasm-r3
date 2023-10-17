import fs from 'fs'
import path from 'path'
const wasmBinary = fs.readFileSync(path.join(import.meta.dir, 'index.wasm'))

let instance
const global = new WebAssembly.Global({ value: "i32", mutable: true}, 0);
let imports = {
    env: {
        changeGlobal: () => {
            global.value = 5
        },
        inspect: () => {
            console.log(global.value)
        },
        global: global
    }
}
let wasm = await WebAssembly.instantiate(wasmBinary, imports)
instance = wasm.instance
instance.exports.main()
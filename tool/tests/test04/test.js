import fs from 'fs'
import path from 'path'
const wasmBinary = fs.readFileSync(path.join(import.meta.dir, 'index.wasm'))

let imports = {
    env: {
        add: (a, b) => a + b,
        sub: (a, b) => a - b,
    },
    lib: {
        add: (a, b) => b + a
    }
}
let wasm = await WebAssembly.instantiate(wasmBinary, imports)
wasm.instance.exports.main()
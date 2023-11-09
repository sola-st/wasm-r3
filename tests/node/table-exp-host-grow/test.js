import fs from 'fs'
import path from 'path'
const wasmPath = path.join(path.dirname(import.meta.url).replace(/^file:/, ''), 'index.wasm')
const wasmBinary = fs.readFileSync(wasmPath)

let instance
let imports = {
    env: {
        changeTable: () => {
            instance.exports.table.grow(2)
            instance.exports.table.set(3, instance.exports.foo)
            return 3
        },
    }
}
let wasm = await WebAssembly.instantiate(wasmBinary, imports)
instance = wasm.instance
instance.exports.main()
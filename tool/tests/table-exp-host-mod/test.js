import fs from 'fs'
import path from 'path'
const wasmBinary = fs.readFileSync(path.join(import.meta.dir, 'index.wasm'))

let instance
let imports = {
    env: {
        changeTable: () => (
            instance.exports.table
        )
    }
}
let wasm = await WebAssembly.instantiate(wasmBinary, imports)
instance = wasm.instance
instance.exports.main()
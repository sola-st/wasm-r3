import fs from 'fs'
import path from 'path'
const wasmPath = path.join(path.dirname(import.meta.url).replace(/^file:/, ''), 'index.wasm')
const wasmBinary = fs.readFileSync(wasmPath)

let instance
let imports = {
    env: {
        changeTable: () => (
            instance.exports.table.set(0, instance.exports.foo)
        ),
        changeTable2: () => (
            instance.exports.table.set(0, instance.exports.bar)
        ),
        a: () => 1,
        b: () => 2,
    }
}
let wasm = await WebAssembly.instantiate(wasmBinary, imports)
instance = wasm.instance
instance.exports.main()
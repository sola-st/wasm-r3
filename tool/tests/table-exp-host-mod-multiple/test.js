import fs from 'fs'
import path from 'path'
const wasmPath = path.join(path.dirname(import.meta.url).replace(/^file:/, ''), 'index.wasm')
const wasmBinary = fs.readFileSync(wasmPath)

let instance
let imports = {
    env1: {
        changeTable1: () => (
            instance.exports.table1.set(0, instance.exports.d)
        )
    },
    env2: {
        changeTable2: () => (
            instance.exports.table2.set(0, instance.exports.a)
        )
    }
}
let wasm = await WebAssembly.instantiate(wasmBinary, imports)
instance = wasm.instance
instance.exports.main1()
instance.exports.main2()
import fs from 'fs'
import path from 'path'
const wasmPath = path.join(path.dirname(import.meta.url).replace(/^file:/, ''), 'index.wasm')
const wasmBinary = fs.readFileSync(wasmPath)

let instance
let imports = {
    env: {
        changeMemAfterReentry: () => {
            instance.exports.reentry()
            new Uint8Array(instance.exports.memory.buffer)[1] = 1
        },
        changeMemBeforeReentry: () => {
            new Uint8Array(instance.exports.memory.buffer)[1] = 1
            instance.exports.reentry()
        }
    }
}
let wasm = await WebAssembly.instantiate(wasmBinary, imports)
instance = wasm.instance
instance.exports.main()
import fs from 'fs'
import path from 'path'
const wasmBinary = fs.readFileSync(path.join(import.meta.dir, 'index.wasm'))

let instance
let memory = new WebAssembly.Memory({ initial: 1})
let imports = {
    env: {
        changeMem: () => (
            new Uint8Array(memory.buffer)[1] = 1
        ),
        memory
    }
}
let wasm = await WebAssembly.instantiate(wasmBinary, imports)
instance = wasm.instance
instance.exports.main()
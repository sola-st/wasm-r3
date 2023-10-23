import fs from 'fs'
import path from 'path'
const wasmPath = path.join(path.dirname(import.meta.url).replace(/^file:/, ''), 'index.wasm')
const wasmBinary = fs.readFileSync(wasmPath)

const mem = new WebAssembly.Memory({ initial: 1 })
let instance
let imports = {
    env: {
        changeMem: () => {
            mem.grow(3)
            let changeAddr = mem.buffer.byteLength - 4
            new Uint8Array(mem.buffer)[changeAddr] = 60000
            return changeAddr
        }
    },
    env2: {
        mem
    }
}
let wasm = await WebAssembly.instantiate(wasmBinary, imports)
instance = wasm.instance
instance.exports.main()
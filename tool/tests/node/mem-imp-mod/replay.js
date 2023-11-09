import fs from 'fs'
import path from 'path'
const p = path.join(path.dirname(import.meta.url).replace(/^file:/, ''), 'index.wasm')
const wasmBinary = fs.readFileSync(p)
let instance
let imports = {}
imports.env = {}
const memory = new WebAssembly.Memory({ initial: 1, maximum: 1 })
imports.env.memory = memory
new Uint8Array(memory.buffer)[1] = 1
new Uint8Array(memory.buffer)[2] = 0
new Uint8Array(memory.buffer)[3] = 0
new Uint8Array(memory.buffer)[4] = 0
let wasm = await WebAssembly.instantiate(wasmBinary, imports) 
instance = wasm.instance
await instance.exports.main() 

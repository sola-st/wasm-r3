import fs from 'fs'
import path from 'path'
const p = path.join(path.dirname(import.meta.url).replace(/^file:/, ''), 'index.wasm')
const wasmBinary = fs.readFileSync(p)
let instance
let imports = {}
imports.env = {}
const memory = new WebAssembly.Memory({ initial: 64, maximum: 64 })
imports.env.memory = memory
new Uint8Array(memory.buffer)[1048576] = 35
new Uint8Array(memory.buffer)[1048577] = 0
new Uint8Array(memory.buffer)[1048578] = 0
new Uint8Array(memory.buffer)[1048579] = 0
new Uint8Array(memory.buffer)[1048584] = 36
new Uint8Array(memory.buffer)[1048585] = 0
new Uint8Array(memory.buffer)[1048586] = 0
new Uint8Array(memory.buffer)[1048587] = 0
new Uint8Array(memory.buffer)[1048592] = 34
new Uint8Array(memory.buffer)[1048593] = 0
new Uint8Array(memory.buffer)[1048594] = 0
new Uint8Array(memory.buffer)[1048595] = 0
new Uint8Array(memory.buffer)[1048600] = 35
new Uint8Array(memory.buffer)[1048601] = 0
new Uint8Array(memory.buffer)[1048602] = 0
new Uint8Array(memory.buffer)[1048603] = 0
new Uint8Array(memory.buffer)[1048608] = 36
new Uint8Array(memory.buffer)[1048609] = 0
new Uint8Array(memory.buffer)[1048610] = 0
new Uint8Array(memory.buffer)[1048611] = 0
let wasm = await WebAssembly.instantiate(wasmBinary, imports) 
instance = wasm.instance
await instance.exports._gol(1048576,1258272,5) 
await instance.exports._gol(1048576,1258272,5) 

import fs from 'fs'
import path from 'path'
const p = path.join(path.dirname(import.meta.url).replace(/^file:/, ''), 'index.wasm')
const wasmBinary = fs.readFileSync(p)
let instance
let imports = {}
imports.env2 = {}
imports.env = {}
const mem = new WebAssembly.Memory({ initial: 1, maximum: 1 })
imports.env2.mem = mem
let global_0  = -1
imports.env.changeMem = () => {
global_0 ++
switch (global_0 ) {
case 0:
mem.grow(3)
new Uint8Array(mem.buffer)[262140] = 96
new Uint8Array(mem.buffer)[262141] = 0
new Uint8Array(mem.buffer)[262142] = 0
new Uint8Array(mem.buffer)[262143] = 0
return 262140 
}
}
let wasm = await WebAssembly.instantiate(wasmBinary, imports) 
instance = wasm.instance
await instance.exports.main() 

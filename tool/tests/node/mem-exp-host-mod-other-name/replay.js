import fs from 'fs'
import path from 'path'
const p = path.join(path.dirname(import.meta.url).replace(/^file:/, ''), 'index.wasm')
const wasmBinary = fs.readFileSync(p)
let instance
let imports = {}
imports.env = {}
let global_0  = -1
imports.env.changeMem = () => {
global_0 ++
switch (global_0 ) {
case 0:
new Uint8Array(instance.exports.yromem.buffer)[1] = 1
new Uint8Array(instance.exports.yromem.buffer)[2] = 0
new Uint8Array(instance.exports.yromem.buffer)[3] = 0
new Uint8Array(instance.exports.yromem.buffer)[4] = 0
return undefined 
}
}
let wasm = await WebAssembly.instantiate(wasmBinary, imports) 
instance = wasm.instance
await instance.exports.main() 

import fs from 'fs'
import path from 'path'
const p = path.join(path.dirname(import.meta.url).replace(/^file:/, ''), 'index.wasm')
const wasmBinary = fs.readFileSync(p)
let instance
let imports = {}
imports.env = {}
let global_0  = -1
imports.env.changeGlobal = () => {
global_0 ++
switch (global_0 ) {
case 0:
instance.exports.global1.value = 5
return undefined 
case 1:
instance.exports.global1.value = 5
return undefined 
}
}
let wasm = await WebAssembly.instantiate(wasmBinary, imports) 
instance = wasm.instance
await instance.exports.main() 

import fs from 'fs'
import path from 'path'
const p = path.join(path.dirname(import.meta.url).replace(/^file:/, ''), 'index.wasm')
const wasmBinary = fs.readFileSync(p)
let instance
let imports = {}
imports.env = {}
let global_0  = -1
imports.env.foo = () => {
global_0 ++
switch (global_0 ) {
case 0:
return undefined 
case 1:
return undefined 
case 2:
return undefined 
}
}
let wasm = await WebAssembly.instantiate(wasmBinary, imports) 
instance = wasm.instance
await instance.exports.main(1) 
await instance.exports.main(3) 
await instance.exports.main(4) 

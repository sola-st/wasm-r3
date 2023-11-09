import fs from 'fs'
import path from 'path'
const p = path.join(path.dirname(import.meta.url).replace(/^file:/, ''), 'index.wasm')
const wasmBinary = fs.readFileSync(p)
let instance
let imports = {}
imports.env = {}
let global_0  = -1
imports.env.add = () => {
global_0 ++
switch (global_0 ) {
case 0:
return 4 
case 1:
return 9 
case 2:
return 5 
case 3:
return 4 
case 4:
return 9 
case 5:
return 5 
case 6:
return 8 
case 7:
return 13 
case 8:
return 9 
}
}
let wasm = await WebAssembly.instantiate(wasmBinary, imports) 
instance = wasm.instance
await instance.exports.main(1,2) 
await instance.exports.main(3,2) 
await instance.exports.main(4,4) 

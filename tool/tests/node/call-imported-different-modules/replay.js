import fs from 'fs'
import path from 'path'
const p = path.join(path.dirname(import.meta.url).replace(/^file:/, ''), 'index.wasm')
const wasmBinary = fs.readFileSync(p)
let instance
let imports = {}
imports.env = {}
imports.env2 = {}
let global_0  = -1
imports.env.foo = () => {
global_0 ++
switch (global_0 ) {
case 0:
return undefined 
}
}
let global_1  = -1
imports.env2.bar = () => {
global_1 ++
switch (global_1 ) {
case 0:
return undefined 
}
}
let wasm = await WebAssembly.instantiate(wasmBinary, imports) 
instance = wasm.instance
await instance.exports.main() 

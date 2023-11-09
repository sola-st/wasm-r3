import fs from 'fs'
import path from 'path'
const p = path.join(path.dirname(import.meta.url).replace(/^file:/, ''), 'index.wasm')
const wasmBinary = fs.readFileSync(p)
let instance
let imports = {}
imports.env = {}
imports.lib = {}
let global_0  = -1
imports.env.add = () => {
global_0 ++
switch (global_0 ) {
case 0:
return 3 
case 1:
return 1 
}
}
let global_1  = -1
imports.env.sub = () => {
global_1 ++
switch (global_1 ) {
case 0:
return 2.5 
}
}
let global_2  = -1
imports.lib.add = () => {
global_2 ++
switch (global_2 ) {
case 0:
return 5 
}
}
let wasm = await WebAssembly.instantiate(wasmBinary, imports) 
instance = wasm.instance
await instance.exports.main() 

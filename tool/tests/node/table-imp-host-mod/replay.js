import fs from 'fs'
import path from 'path'
const p = path.join(path.dirname(import.meta.url).replace(/^file:/, ''), 'index.wasm')
const wasmBinary = fs.readFileSync(p)
let instance
let imports = {}
imports.env = {}
const table = new WebAssembly.Table({ initial: 2, element: 'anyfunc'})
imports.env.table = table
let global_0  = -1
imports.env.changeTable = () => {
global_0 ++
switch (global_0 ) {
case 0:
table.set(0, instance.exports.foo)
return undefined 
}
}
let global_1  = -1
imports.env.a = () => {
global_1 ++
switch (global_1 ) {
case 0:
return 1 
}
}
let global_2  = -1
imports.env.b = () => {
global_2 ++
switch (global_2 ) {
}
}
let wasm = await WebAssembly.instantiate(wasmBinary, imports) 
instance = wasm.instance
await instance.exports.main() 

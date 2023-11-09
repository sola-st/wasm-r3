import fs from 'fs'
import path from 'path'
const p = path.join(path.dirname(import.meta.url).replace(/^file:/, ''), 'index.wasm')
const wasmBinary = fs.readFileSync(p)
let instance
let imports = {}
imports.env1 = {}
imports.env2 = {}
let global_0  = -1
imports.env1.changeTable1 = () => {
global_0 ++
switch (global_0 ) {
case 0:
instance.exports.table1.set(0, instance.exports.d)
return undefined 
}
}
let global_1  = -1
imports.env2.changeTable2 = () => {
global_1 ++
switch (global_1 ) {
case 0:
instance.exports.table2.set(0, instance.exports.a)
return undefined 
}
}
let wasm = await WebAssembly.instantiate(wasmBinary, imports) 
instance = wasm.instance
await instance.exports.main1() 
await instance.exports.main2() 

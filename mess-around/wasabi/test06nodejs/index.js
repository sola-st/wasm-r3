import fs from 'fs'
import path from 'path'
const p = path.join(import.meta.dir, 'index.wasm')
const wasmBinary = fs.readFileSync(p)

let w = require('./index.wasabi.js')

w.analysis = {
    call_pre(location, targetFunc, args, indirectTableIdx) {
        console.log(`TAAARGETT: ${targetFunc}`)
        console.log(location, (indirectTableIdx === undefined ? "direct" : "indirect"), "call", "to func #", targetFunc, "args =", args);
    },
};

(async function () {
    let instance
    let imports = {}
    let wasm = await WebAssembly.instantiate(wasmBinary, imports)
    instance = wasm.instance
    instance.exports.main()
})()
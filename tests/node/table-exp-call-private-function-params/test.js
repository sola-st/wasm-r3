import fs from 'fs'

export default async function test(wasmBinary) {
    let instance
    let imports = {}
    let wasm = await WebAssembly.instantiate(wasmBinary, imports)
    instance = wasm.instance
    instance.exports.table.get(0)(15, 15.5)
}
// const wasmBinary = fs.readFileSync('/Users/jakob/Desktop/wasm-r3/tests/node/table-exp-call-private-function/index.wasm')
// test(wasmBinary)
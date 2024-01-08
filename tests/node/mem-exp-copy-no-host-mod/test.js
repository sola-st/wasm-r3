export default async function test(wasmBinary) {
    let instance
    let imports = {}
    let wasm = await WebAssembly.instantiate(wasmBinary, imports)
    instance = wasm.instance
    instance.exports.entry()
    throw Error('This is not yet implemented: Memory copy instruction. Also this testcase is not correct')
}
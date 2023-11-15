export default async function test(wasmBinary) {
    let instance
    let imports = {}
    let wasm = await WebAssembly.instantiate(wasmBinary, imports)
    instance = wasm.instance
    let universe = wasm.instance.exports.new()
    wasm.instance.exports.render()
}
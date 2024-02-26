export default async function test(wasmBinary) {
    let instance
    let imports = {}
    let wasm = await WebAssembly.instantiate(wasmBinary, imports)
    instance = wasm.instance
    instance.exports.entry()
    new Uint8Array(instance.exports.memory.buffer)[0] = 1
    instance.exports.foo()
    instance.exports.entry()
}
export default async function test(wasmBinary) {
    let instance; let imports = { env: {} }
    imports.env.changeMem = (k, v) => { new Uint8Array(instance.exports.memory.buffer)[k] = v }
    let wasm = await WebAssembly.instantiate(wasmBinary, imports)
    instance = wasm.instance
    instance.exports.entry()
    instance.exports.changeMemWasm()
}

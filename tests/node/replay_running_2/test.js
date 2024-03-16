export default async function test(wasmBinary) {
    let instance; let imports = { env: {} }
    imports.env.host2 = (k, v) => { instance.exports.wasm1(k, v); }
    imports.env.host1 = (k, v) => { instance.exports.wasm1(k, v); }
    let wasm = await WebAssembly.instantiate(wasmBinary, imports)
    instance = wasm.instance
    instance.exports.wasm0()
}

export default async function test(wasmBinary) {
    let instance; let imports = { env: {} }
    imports.env.host2 = (k, v) => {
        new Uint8Array(instance.exports.memory.buffer)[0] = 2;
    }
    imports.env.host1 = (k, v) => {
        new Uint8Array(instance.exports.memory.buffer)[0] = 1
        instance.exports.wasm0()
    }
    let wasm = await WebAssembly.instantiate(wasmBinary, imports)
    instance = wasm.instance
    instance.exports.entry()
}

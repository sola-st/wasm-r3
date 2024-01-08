export default async function test(wasmBinary) {
    let instance
    let imports = {
        env: {
            foo: () => { }
        }
    }
    let wasm = await WebAssembly.instantiate(wasmBinary, imports)
    instance = wasm.instance
    new Uint8Array(instance.exports.memory.buffer)[1] = 1
    instance.exports.entry()
    instance.exports.exp()
}
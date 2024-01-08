export default async function test(wasmBinary) {
    let instance
    let imports = {
        env: {
            foo: () => { }
        }
    }
    let wasm = await WebAssembly.instantiate(wasmBinary, imports)
    instance = wasm.instance
    instance.exports.entry(1)
    instance.exports.entry(3)
    instance.exports.entry(4)
}
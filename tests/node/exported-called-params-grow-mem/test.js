export default async function test(wasmBinary) {
    let instance
    let imports = {
        env: {
            foo: () => { }
        }
    }
    let wasm = await WebAssembly.instantiate(wasmBinary, imports)
    instance = wasm.instance
    instance.exports.main(1)
    instance.exports.main(3)
    instance.exports.main(4)
}
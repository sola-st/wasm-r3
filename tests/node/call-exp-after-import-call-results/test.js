export default async function test(wasmBinary) {
    let instance
    let imports = {
        env: {
            foo: () => {
                instance.exports.exp()
                instance.exports.exp()
                return 69
            },
            bar: () => 420
        }
    }
    let wasm = await WebAssembly.instantiate(wasmBinary, imports)
    instance = wasm.instance
    instance.exports.entry()
}
export default async function test(wasmBinary) {
    let instance
    let imports = {
        env: {
            foo: () => { },
            bar: () => { }
        }
    }
    let wasm = await WebAssembly.instantiate(wasmBinary, imports)
    instance = wasm.instance
    instance.exports.main(1)
}
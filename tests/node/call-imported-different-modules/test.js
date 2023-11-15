export default async function test(wasmBinary) {
    let instance
    let imports = {
        env: {
            foo: () => { }
        },
        env2: {
            bar: () => { }
        }
    }
    let wasm = await WebAssembly.instantiate(wasmBinary, imports)
    wasm.instance.exports.main()
}
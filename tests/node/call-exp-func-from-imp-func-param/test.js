export default async function test(wasmBinary) {
    let instance
    let imports = {
        env: {
            foo: () => {
                instance.exports.bar(1)
            },
            a: () => { },
            b: () => { }
        }
    }
    let wasm = await WebAssembly.instantiate(wasmBinary, imports)
    instance = wasm.instance
    instance.exports.main()
}
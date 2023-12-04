export default async function test(wasmBinary) {
    let instance
    let imports = {
        env: {
            foo: () => {
                instance.exports.table.get(0)()
                instance.exports.table.get(0)()
            },
            bar: () => { }
        }
    }
    let wasm = await WebAssembly.instantiate(wasmBinary, imports)
    instance = wasm.instance
    instance.exports.main()
}
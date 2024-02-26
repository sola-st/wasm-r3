export default async function test(wasmBinary) {
    let instance
    let imports = {
        env: {
            changeTable: () => (
                instance.exports.table.set(0, instance.exports.foo)
            ),
        }
    }
    let wasm = await WebAssembly.instantiate(wasmBinary, imports)
    instance = wasm.instance
    instance.exports.entry()
}
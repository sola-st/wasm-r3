export default async function test(wasmBinary) {
    let instance
    let imports = {
        env: {
            changeTable: () => {
                instance.exports.table.grow(2)
                instance.exports.table.set(3, instance.exports.foo)
                return 3
            },
        }
    }
    let wasm = await WebAssembly.instantiate(wasmBinary, imports)
    instance = wasm.instance
    instance.exports.entry()
}
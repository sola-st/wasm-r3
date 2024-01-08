export default async function test(wasmBinary) {
    let instance
    const table = new WebAssembly.Table({ initial: 2, maximum: 2, element: 'anyfunc' })
    let imports = {
        env: {
            table,
        }
    }
    let wasm = await WebAssembly.instantiate(wasmBinary, imports)
    instance = wasm.instance
    instance.exports.entry()
}
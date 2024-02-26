export default async function test(wasmBinary) {
    let instance
    let memory = new WebAssembly.Memory({ initial: 1, maximum: 1 })
    let imports = {
        env: {
            memory,
        }
    }
    let wasm = await WebAssembly.instantiate(wasmBinary, imports)
    instance = wasm.instance
    instance.exports.entry()
}
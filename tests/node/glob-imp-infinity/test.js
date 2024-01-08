export default async function test(wasmBinary) {
    let instance
    let imports = {
        env: {
            Infinity: Infinity
        }
    }
    let wasm = await WebAssembly.instantiate(wasmBinary, imports)
    instance = wasm.instance
    instance.exports.entry()
}
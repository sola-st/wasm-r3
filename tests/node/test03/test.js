export default async function test(wasmBinary) {
    let imports = {
        env: {
            add: (a, b) => a + b
        }
    }

    let wasm = await WebAssembly.instantiate(wasmBinary, imports)
    wasm.instance.exports.entry()
}
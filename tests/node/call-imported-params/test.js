export default async function test(wasmBinary) {
    let instance
    let imports = {
        env: {
            add: (a, b) => a + b
        }
    }
    let wasm = await WebAssembly.instantiate(wasmBinary, imports)
    instance = wasm.instance
    instance.exports.main(1, 2)
    instance.exports.main(3, 2)
    instance.exports.main(4, 4)
}

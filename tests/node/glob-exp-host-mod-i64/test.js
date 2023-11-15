export default async function test(wasmBinary) {
    let instance
    let imports = {
        env: {
            changeGlobal: (value) => {
                instance.exports.global.value = BigInt(value)
            }
        }
    }
    let wasm = await WebAssembly.instantiate(wasmBinary, imports)
    instance = wasm.instance
    instance.exports.main()
}
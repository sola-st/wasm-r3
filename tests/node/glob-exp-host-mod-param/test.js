export default async function test(wasmBinary) {
    let instance
    let imports = {
        env: {
            changeGlobal: (idx, value) => {
                if (idx === 0) {
                    instance.exports.global1.value = value
                } else {
                    instance.exports.global2.value = value
                }
            }
        }
    }
    let wasm = await WebAssembly.instantiate(wasmBinary, imports)
    instance = wasm.instance
    instance.exports.main()
}
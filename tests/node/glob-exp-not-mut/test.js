export default async function test(wasmBinary) {
    let instance
    let imports = {
        env: {
            changeGlobal: (idx, value) => {
                try {
                    instance.exports.global.value = 22
                } catch { }
            }
        }
    }
    let wasm = await WebAssembly.instantiate(wasmBinary, imports)
    instance = wasm.instance
    instance.exports.entry()
}
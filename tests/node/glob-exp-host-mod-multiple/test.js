export default async function test(wasmBinary) {
    let instance
    let imports = {
        env: {
            changeGlobal: (value) => {
                instance.exports.global.value = 1
                instance.exports.foo()
                instance.exports.global.value = 2
                instance.exports.foo()
            }
        }
    }
    let wasm = await WebAssembly.instantiate(wasmBinary, imports)
    instance = wasm.instance
    instance.exports.entry()
}
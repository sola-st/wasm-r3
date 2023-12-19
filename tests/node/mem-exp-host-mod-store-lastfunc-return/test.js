export default async function test(wasmBinary) {
    let instance
    let imports = {
        env: {
            changeMemAfterReentry: () => {
                instance.exports.reentry()
                new Uint8Array(instance.exports.memory.buffer)[1] = 1
                return 69
            },
            foo: () => {
                instance.exports.reentry2()
            },
            bar: () => {
                new Uint8Array(instance.exports.memory.buffer)[1] = 2
                return 420
            }
        }
    }
    let wasm = await WebAssembly.instantiate(wasmBinary, imports)
    instance = wasm.instance
    instance.exports.main()
}
export default async function test(wasmBinary) {
    let instance
    let imports = {
        env: {
            changeMemAfterReentry: () => {
                instance.exports.reentry()
                new Uint8Array(instance.exports.memory.buffer)[1] = 1
            },
            changeMemBeforeReentry: () => {
                new Uint8Array(instance.exports.memory.buffer)[1] = 1
                instance.exports.reentry()
            },
            foo: () => {
                instance.exports.reentry2()
            },
            bar: () => {
                new Uint8Array(instance.exports.memory.buffer)[1] = 2
            }
        }
    }
    let wasm = await WebAssembly.instantiate(wasmBinary, imports)
    instance = wasm.instance
    instance.exports.main()
}
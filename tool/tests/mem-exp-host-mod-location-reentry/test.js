let instance
let imports = {
    env: {
        changeMemAfterReentry: () => {
            module.exports.reentry()
            new Uint8Array(instance.exports.memory.buffer)[1] = 1
        },
        changeMemBeforeReentry: () => {
            new Uint8Array(instance.exports.memory.buffer)[1] = 1
            module.exports.reentry()
        }
    }
}
let wasm = await WebAssembly.instantiate(wasmBinary, imports)
instance = wasm.instance
instance.exports.main()
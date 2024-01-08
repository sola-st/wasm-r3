export default async function test(wasmBinary) {
    let instance
    let imports = {
        env: {
            changeMem: () => (
                new Uint8Array(instance.exports.memory.buffer)[1] = 1
            )
        }
    }
    let wasm = await WebAssembly.instantiate(wasmBinary, imports)
    instance = wasm.instance
    instance.exports.entry()
}
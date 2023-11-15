export default async function test(wasmBinary) {
    let instance
    let imports = {
        env: {
            changeMem: (addr, value) => (
                new Uint8Array(instance.exports.memory.buffer)[addr] = value
            )
        }
    }
    let wasm = await WebAssembly.instantiate(wasmBinary, imports)
    instance = wasm.instance
    instance.exports.main()
}
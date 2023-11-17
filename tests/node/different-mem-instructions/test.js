export default async function test(wasmBinary) {
    const memory = new WebAssembly.Memory({ initial: 1 })
    new Uint8Array(memory.buffer)[0] = 99
    new Uint8Array(memory.buffer)[2] = 100
    let instance
    let imports = {
        env: {
            memory
        }
    }
    let wasm = await WebAssembly.instantiate(wasmBinary, imports)
    instance = wasm.instance
    instance.exports.main()
}
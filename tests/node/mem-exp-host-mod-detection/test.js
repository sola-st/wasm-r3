export default async function test(wasmBinary) {
    let instance
    let imports = {
        env: {
            changeMem: (address, value) => {
                new Uint8Array(instance.exports.memory.buffer)[address] = value
                instance.exports.foo()
            }
        }
    }
    let wasm = await WebAssembly.instantiate(wasmBinary, imports)
    instance = wasm.instance
    instance.exports.main()
}
export default async function test(wasmBinary) {
    let instance
    let imports = {
        env: {
            changeMem: () => {
                instance.exports.memory.grow(1)
                let changeAddr = 100000
                new Uint8Array(instance.exports.memory.buffer)[changeAddr] = 60000
                instance.exports.reentry()
            }
        }
    }
    let wasm = await WebAssembly.instantiate(wasmBinary, imports)
    instance = wasm.instance
    instance.exports.entry()
}
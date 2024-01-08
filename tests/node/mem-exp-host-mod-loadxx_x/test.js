export default async function test(wasmBinary) {
    let instance
    let imports = {
        env: {
            changeMem: () => {
                new Uint8Array(instance.exports.memory.buffer)[1] = 1
            }
        }
    }
    let wasm = await WebAssembly.instantiate(wasmBinary, imports)
    instance = wasm.instance
    instance.exports.entry()
}

// if this test fails it is likely that instructions like ixx.loadxx_x dont get parsed correctly
// and that the byteLength calculated for those instructions is wrong
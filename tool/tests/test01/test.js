
export default async () => {
    const fs = await import('fs')
    const path = await import('path')

    let instance
    let imports = {
        env: {
            changeMem: () => (
                new Uint8Array(instance.exports.memory.buffer)[1] = 1
            )
        }
    }
    let wasmBinary = fs.readFileSync(path.join(import.meta.dir, './index.wasm'))
    let wasm = await WebAssembly.instantiate(wasmBinary, imports)
    instance = wasm.instance
    instance.exports.main()
    return trace
}
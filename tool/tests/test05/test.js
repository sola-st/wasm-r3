export default async function () {
    const fs = await import('fs')
    const path = await import('path')
    let imports = {
        env: {
            add: (a, b) => a + b,
            sub: (a, b) => a - b,
        },
        lib: {
            add: (a, b) => b + a
        }
    }
    let wasmBinary = fs.readFileSync(path.join(import.meta.dir, './index.wasm'))
    let wasm = await WebAssembly.instantiate(wasmBinary, imports)
    wasm.instance.exports.main()
    return trace
}

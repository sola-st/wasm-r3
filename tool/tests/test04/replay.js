const fs = await import('fs')
const path = await import('path')
let instance
let imports = {}
imports.env = {}
imports.env.add = (a0, a1) => {
    if (a0 === 1 && a1 === 2) {
        return 3
    }
    if (a0 === 5 && a1 === -4) {
        return 1
    }
}
let wasmBinary = fs.readFileSync(path.join(import.meta.dir, 'index.wasm'))
let wasm = await WebAssembly.instantiate(wasmBinary, imports)
instance = wasm.instance
await instance.exports.main()

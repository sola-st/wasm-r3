const fs = await import('fs')
const path = await import('path')

let instance
let imports = {
    env: {
        add: (a, b) => a + b,
        sub: (a, b) => a - b,
    },
    lib: {
        add: (a, b) => b + a
    }
}
WebAssembly.instantiate(fs.readFileSync(path.join(import.meta.dir, './index.wasm')), imports)
    .then((wasm) => {
        instance = wasm.instance
        instance.exports.main()
        fs.writeFileSync(path.join(import.meta.dir, 'trace.r3'), stringifyTrace(trace))
    })
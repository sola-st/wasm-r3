const fs = await import('fs')
const path = await import('path')

let instance
let imports = {
    env: {
        changeMem: (address, value) => {
            new Uint8Array(instance.exports.memory.buffer)[address] = value
            instance.exports.foo()
        }
    }
}
WebAssembly.instantiate(fs.readFileSync(path.join(import.meta.dir, './index.wasm')), imports)
    .then((wasm) => {
        instance = wasm.instance
        instance.exports.main()
        fs.writeFileSync(path.join(import.meta.dir, 'trace.r3'), stringifyTrace(trace))
    })
let instance
let imports = {
    env: {
        changeMem: () => {
            instance.exports.memory.grow(1)
            let changeAddr = memory.buffer.byteLength - 4
            new Uint8Array(instance.exports.memory.buffer)[changeAddr] = 60000
            return changeAddr
        }
    }
}
let wasm = await WebAssembly.instantiate(wasmBinary, imports)
instance = wasm.instance
instance.exports.main()
export default async function test(wasmBinary) {
    let instance
    const global = new WebAssembly.Global({ value: "i32", mutable: true }, 0);
    let imports = {
        env: {
            changeGlobal: () => {
                global.value = 5
            },
            global: global
        }
    }
    let wasm = await WebAssembly.instantiate(wasmBinary, imports)
    instance = wasm.instance
    instance.exports.main()
}
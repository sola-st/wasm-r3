export default async function test(wasmBinary) {
    let instance
    const global = new WebAssembly.Global({ value: "f64", mutable: true }, 900);
    let imports = {
        env: {
            global: global
        }
    }
    let wasm = await WebAssembly.instantiate(wasmBinary, imports)
    instance = wasm.instance
    instance.exports.main()
}
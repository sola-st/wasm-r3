export default async function test(wasmBinary) {
    let instance
    const global = new WebAssembly.Global({ value: "i32", mutable: true });
    let imports = {
        env: {
            global: global
        }
    }
    let wasm = await WebAssembly.instantiate(wasmBinary, imports)
    instance = wasm.instance
    instance.exports.entry()
}
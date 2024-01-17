// Refer to below issue for more information
// https://github.com/WebAssembly/binaryen/issues/6220#issuecomment-1888317914
export default async function test(wasmBinary) {
    let instance
    const global = new WebAssembly.Global({ value: "i32", mutable: false }, 0);
    let imports = {
        env: {
            DYNAMICTOP_PTR: global
        }
    }
    let wasm = await WebAssembly.instantiate(wasmBinary, imports)
    instance = wasm.instance
    instance.exports.entry()
}
export default async function test(wasmBinary) {
    let instance
    let imports = {}
    let wasm = await WebAssembly.instantiate(wasmBinary, imports)
    instance = wasm.instance
    instance.exports.main()
    throw Error('This is not yet implemented: Vector memory instructions. Also this testcase is not correct')
}
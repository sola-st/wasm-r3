export default async function test(wasmBinary) {
    let instance
    let imports = {
        env1: {
            changeTable1: () => (
                instance.exports.table1.set(0, instance.exports.d)
            )
        },
        env2: {
            changeTable2: () => (
                instance.exports.table2.set(0, instance.exports.a)
            )
        }
    }
    let wasm = await WebAssembly.instantiate(wasmBinary, imports)
    instance = wasm.instance
    instance.exports.main1()
    instance.exports.main2()
}
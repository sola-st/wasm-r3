const imports = {
    env: {
        add: (a0, a1) => {
            if (a0 === 1 && a1 === 2) {
                return 3
            }
            if (a0 === 5 && a1 === -4) {
                return 1
            }
        }
    }
}
const wasmBinary = fs.readFileSync('./index.wasm')
const { instance } = await WebAssembly.instantiate(wasmBinary, imports)
instance.exports.main()

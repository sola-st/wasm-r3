const fs = require('fs');
async function run() {
    const binary = fs.readFileSync('./store-instrumented.wasm');
    const wasm = await WebAssembly.instantiate(binary, {})
    console.log(wasm)
}
run()
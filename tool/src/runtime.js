const printWelcome = function () {
    console.log('---------------------------------------------')
    console.log('                   Wasm-R3                   ')
    console.log('---------------------------------------------')
    console.log('WebAssembly module instantiated. Recording...')
}

const importObjectWithHooks = function (importObject) {
    let importObjectWithHooks = importObject || {};
    importObjectWithHooks.__wasabi_hooks = Wasabi.module.lowlevelHooks;
    return importObjectWithHooks;
};

const wireInstanceExports = function (instance) {
    Wasabi.module.exports = instance.exports;
    Wasabi.module.tables = [];
    Wasabi.module.memories = [];
    Wasabi.module.globals = [];
    for (let exp in instance.exports) {
        if (Wasabi.module.info.tableExportNames.includes(exp)) {
            Wasabi.module.tables.push(instance.exports[exp]);
        }
        if (Wasabi.module.info.memoryExportNames.includes(exp)) {
            Wasabi.module.memories.push(instance.exports[exp]);
        }
        if (Wasabi.module.info.globalExportNames.includes(exp)) {
            Wasabi.module.globals.push(instance.exports[exp]);
        }
    }
};

const binaryString = atob(wasabiBinary);
const uint8Array = new Uint8Array(binaryString.length);
for (let i = 0; i < binaryString.length; i++) {
    uint8Array[i] = binaryString.charCodeAt(i);
}
const buffer = uint8Array.buffer;

initSync(buffer)
let original_instantiate = WebAssembly.instantiate;
WebAssembly.instantiate = function (buffer, importObject) {
    printWelcome()
    originalWasmBuffer = _.cloneDeep(buffer)
    const { instrumented, js } = instrument_wasm({ original: new Uint8Array(buffer) });
    Wasabi = eval(js + '\nWasabi')
    buffer = new Uint8Array(instrumented)
    importObject = importObjectWithHooks(importObject)
    setupTracer()
    let result = original_instantiate(buffer, importObject);
    result.then(({ module, instance }) => wireInstanceExports(instance))
    return result
};
// replace instantiateStreaming
WebAssembly.instantiateStreaming = async function (source, obj) {
    let response = await source;
    let body = await response.arrayBuffer();
    return WebAssembly.instantiate(body, obj);
}
//replace compile
// let original_compile = WebAssembly.compile;
// WebAssembly.compile = function (buffer) {
//     buffer = instrument_wasm(buffer)
//     return original_compile.call(WebAssembly, ...arguments);
// };
// replace compileStreaming
// WebAssembly.compileStreaming = async function (source) {
//     let response = await source;
//     let body = await response.arrayBuffer();
//     return WebAssembly.compile(body);
// };
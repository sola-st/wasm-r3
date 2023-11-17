
// in this runtime available available is:
// - setup(wasabiBinary) you need to call this to make the next function available
// - instrument_wasm() a function that takes a wasm buffer and instruments it with wasabi.
// - setupAnalysis() a function that takes a Wasabi object and adds its custom analysis. It returns the analysisResult
function setup() {
    if (self.monkeypatched === true) {
        return
    }
    self.monkeypatched = true
    self.analysisResults = []
    self.originalWasmBuffer = []
    let wasabis = []
    let i = 0
    const printWelcome = function () {
        console.log('---------------------------------------------')
        console.log('          Wasabi analysis attached           ')
        console.log('---------------------------------------------')
        console.log('WebAssembly module instantiated.             ')
    }

    const importObjectWithHooks = function (importObject, i) {
        let importObjectWithHooks = importObject || {};
        importObjectWithHooks.__wasabi_hooks = wasabis[i].module.lowlevelHooks;
        return importObjectWithHooks;
    };

    const wireInstanceExports = function (instance, i) {
        wasabis[i].module.exports = instance.exports;
        wasabis[i].module.tables = [];
        wasabis[i].module.memories = [];
        wasabis[i].module.globals = [];
        for (let exp in instance.exports) {
            if (wasabis[i].module.info.tableExportNames.includes(exp)) {
                wasabis[i].module.tables.push(instance.exports[exp]);
            }
            if (wasabis[i].module.info.memoryExportNames.includes(exp)) {
                wasabis[i].module.memories.push(instance.exports[exp])
            }
            if (wasabis[i].module.info.globalExportNames.includes(exp)) {
                wasabis[i].module.globals.push(instance.exports[exp]);
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
    let original_instantiate = WebAssembly.instantiate
    WebAssembly.instantiate = function (buffer, importObject) {
        const this_i = i
        i += 1
        console.log('WebAssembly.instantiate')
        printWelcome()
        self.originalWasmBuffer.push(Array.from(new Uint8Array(buffer)))
        const { instrumented, js } = instrument_wasm({ original: new Uint8Array(buffer) });
        wasabis.push(eval(js + '\nWasabi'))
        buffer = new Uint8Array(instrumented)
        importObject = importObjectWithHooks(importObject, this_i)
        self.analysisResults.push(setupAnalysis(wasabis[this_i]))
        let result
        result = original_instantiate(buffer, importObject)
        result.then(({ module, instance }) => {
            wireInstanceExports(instance, this_i)
        })
        return result
    };
    // replace instantiateStreaming
    WebAssembly.instantiateStreaming = async function (source, obj) {
        console.log('WebAssembly.instantiateStreaming')
        let response = await source;
        let body = await response.arrayBuffer();
        return WebAssembly.instantiate(body, obj);
    }
}
setup()

// in this runtime available available is:
// - setup(wasabiBinary) you need to call this to make the next function available
// - instrument_wasm() a function that takes a wasm buffer and instruments it with wasabi.
// - the setupAnalysis function returns a new Analysis instance when given the Wasabi object
// - performanceEvent() a function that takes a name and returns a PerformanceEntry
function setup() {
    if (self.monkeypatched === true) {
        return
    }
    self.monkeypatched = true
    self.performanceList = []
    self.analysis = []
    self.originalWasmBuffer = []
    let wasabis = []
    let i = 0
    const p_timeToFirstInstantiate = performanceEvent('time until instantiation of first wasm module in this context')
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
        self.performanceList.push(p_timeToFirstInstantiate.stop())
        const this_i = i
        i += 1
        const p_instantiationTime = performanceEvent(`Time to instantiate wasm module ${this_i}`)
        console.log('WebAssembly.instantiate')
        printWelcome()
        self.originalWasmBuffer.push(Array.from(new Uint8Array(buffer)))
        const p_instrumenting = performanceEvent(`instrumentation of wasm binary ${this_i}`)
        const { instrumented, js } = instrument_wasm(new Uint8Array(buffer));
        self.performanceList.push(p_instrumenting.stop())
        wasabis.push(eval(js + '\nWasabi'))
        buffer = new Uint8Array(instrumented)
        importObject = importObjectWithHooks(importObject, this_i)
        self.analysis.push(setupAnalysis(wasabis[this_i]))
        let result
        result = original_instantiate(buffer, importObject)
        result.then(({ module, instance }) => {
            wireInstanceExports(instance, this_i)
        })
        self.performanceList.push(p_instantiationTime.stop())
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

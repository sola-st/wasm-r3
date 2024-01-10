
// in this runtime available available is:
// - setup(wasabiBinary) you need to call this to make the next function available
// - instrument_wasm() a function that takes a wasm buffer and instruments it with wasabi.
// - the setupAnalysis function returns a new Analysis instance when given the Wasabi object
function setup() {
    if (self.monkeypatched === true) {
        return
    }
    self.monkeypatched = true
    self.originalWasmBuffer = []
    let i = 0
    // const p_timeToFirstInstantiate = performanceEvent('time until instantiation of first wasm module in this context')
    const printWelcome = function () {
        console.log('---------------------------------------------')
        console.log('             Instrumenting Wasm              ')
        console.log('---------------------------------------------')
        console.log('WebAssembly module instantiated.             ')
    }
    const script = `
        function chunkArray(array, chunkSize) {
            const chunks = [];
            for (let i = 0; i < array.length; i += chunkSize) {
                chunks.push(array.slice(i, i + chunkSize));
            }
            return chunks;
        }
        const socket = new WebSocket("ws://localhost:8080/trace.r3")
        self.onmessage = function(e) {
            console.log("SEND")
            socket.send(e.data)
        }
        socket.onerror = function(e) {
            console.log(e)
        }
        socket.onopen = function(e) {
            self.postMessage(true)
        }
        `
    const blob = new Blob([script], { type: 'application/javascript' });
    const workerUrl = URL.createObjectURL(blob);
    const worker = new Worker(workerUrl)
    let instance
    const r3 = {
        check_mem: () => {
            console.log("SEND", instance.exports.trace_byte_length.value)
            const trace = instance.exports.trace.buffer.slice(0, instance.exports.trace_byte_length.value)
            worker.postMessage(trace)
        }
    }

    const binaryString = atob(tracerBinary);
    const uint8Array = new Uint8Array(binaryString.length);
    for (let i = 0; i < binaryString.length; i++) {
        uint8Array[i] = binaryString.charCodeAt(i);
    }
    const buffer = uint8Array.buffer;

    initSync(buffer)
    let original_instantiate = WebAssembly.instantiate
    WebAssembly.instantiate = async function (buffer, importObject) {
        importObject.r3 = r3
        buffer = (buffer.byte) ? buffer.byte : buffer
        const this_i = i
        i += 1
        console.log('WebAssembly.instantiate')
        printWelcome()
        self.originalWasmBuffer.push(Array.from(new Uint8Array(buffer)))
        const instrumented = instrument_wasm_js(new Uint8Array(buffer));
        buffer = new Uint8Array(instrumented)
        result = await original_instantiate(buffer, importObject)
        instance = result.instance
        return result
    };
    // replace instantiateStreaming
    WebAssembly.instantiateStreaming = async function (source, obj) {
        console.log('WebAssembly.instantiateStreaming')
        let response = await source;
        let body = await response.arrayBuffer();
        return WebAssembly.instantiate(body, obj);
    }
    const original_module = WebAssembly.Module
    WebAssembly.Module = function (bytes) {
        console.log('WebAssembly.Module')
        const module = new original_module(bytes)
        module.bytes = bytes
        return module
    }
    const original_compile = WebAssembly.compile
    WebAssembly.compile = async function (bytes) {
        console.log('WebAssembly.compile')
        const module = await original_compile(bytes)
        module.bytes = bytes
        return module
    }
    WebAssembly.compileStreaming = async function (source) {
        console.log('WebAssembly.compileStreaming')
        const response = await source
        const bytes = await response.arrayBuffer()
        return await WebAssembly.compile(bytes)
    }
    const original_instance = WebAssembly.Instance
    WebAssembly.Instance = function (module, importObject) {
        importObject.r3 = r3
        let buffer = module.bytes
        const this_i = i
        i += 1
        console.log('WebAssembly.Instance')
        printWelcome()
        self.originalWasmBuffer.push(Array.from(new Uint8Array(buffer)))
        const instrumented = instrument_wasm_js(new Uint8Array(buffer));
        buffer = new Uint8Array(instrumented)
        module = new WebAssembly.Module(buffer)
        const instance = new original_instance(module, importObject)
        return instance
    }
}
setup()

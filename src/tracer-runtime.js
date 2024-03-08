// in this runtime available available is:
// - setup(wasabiBinary) you need to call this to make the next function available
// - instrument_wasm() a function that takes a wasm buffer and instruments it with wasabi.
// - the setupAnalysis function returns a new Analysis instance when given the Wasabi object
function setup() {
  if (self.monkeypatched === true) {
    return;
  }
  self.monkeypatched = true;
  self.originalWasmBuffer = [];
  let i = 0;
  // const p_timeToFirstInstantiate = performanceEvent('time until instantiation of first wasm module in this context')
  const printWelcome = function () {
    console.log("---------------------------------------------");
    console.log("             Instrumenting Wasm              ");
    console.log("---------------------------------------------");
    console.log("WebAssembly module instantiated.             ");
  };

  function generateUUID() {
    return "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx".replace(
      /[xy]/g,
      function (c) {
        var r = (Math.random() * 16) | 0,
          v = c === "x" ? r : (r & 0x3) | 0x8;
        return v.toString(16);
      }
    );
  }

  const traceWorkerScript = `
        const socket = new WebSocket("ws://localhost:8080/traces")
        self.onmessage = function(e) {
            console.log("send")
            socket.send(e.data)
        }
        socket.onerror = function(e) {
            console.log(e)
        }
        socket.onopen = function(e) {
            self.postMessage(true)
        }
        `;
  const traceBlob = new Blob([traceWorkerScript], {
    type: "application/javascript",
  });
  const traceWorkerUrl = URL.createObjectURL(traceBlob);
  const traceWorker = new Worker(traceWorkerUrl);
  let instances = [];
  let count = 0;
  const get_check = (href, i) => {
    return {
      check_mem: () => {
        console.log("check_mem", href, "time", performance.now());
        let trace = instances[i].exports.trace.buffer.slice(
          0,
          instances[i].exports.trace_byte_length.value
        );
        const message = new ArrayBuffer(trace.byteLength + href.length + 2); // 8 bytes for a 64-bit number
        if (message.byteLength === 0) {
          return;
        }
        const context = new TextEncoder().encode(href);
        let bufferView = new Uint8Array(message);
        bufferView.set(new Uint8Array(trace), 0);
        for (let j = 0; j <= href.length; j++) {
          bufferView[j + trace.byteLength] = context[j];
        }
        bufferView[bufferView.byteLength - 2] = href.length;
        bufferView[bufferView.byteLength - 1] = 0; // 0 for trace type
        console.log("to worker, bytelength", message.byteLength);
        traceWorker.postMessage(message);
        console.log("reset trace memory");
        instances[i].exports.trace_byte_length.value = 0;
        // while (count === 1) { }
        // count++
        // console.log('count increment', count)
      },
      // check_table: () => {
      //     console.log("check_table")
      //     const lookupTable = instances[i].exports.lookup;
      //     let funcIdxes = []
      //     for (let j = 0; j < instances[i].exports.lookup_table_pointer.value; j++) {
      //         let funcIdx = lookupTable.get(j).name - 2
      //         funcIdxes.push(funcIdx)
      //     }
      //     if (funcIdxes.length === 0) {
      //         return
      //     }
      //     const message = new ArrayBuffer(funcIdxes.length * 4 + href.length + 2);
      //     let bufferView32 = new Uint32Array(message)
      //     for (let i = 0; i < funcIdxes.length; i++) {
      //         bufferView32[i] = funcIdxes[i]
      //     }
      //     const context = new TextEncoder().encode(href)
      //     let bufferView = new Uint8Array(message);
      //     for (let i = 0; i <= href.length; i++) {
      //         bufferView[i + funcIdxes.length * 4] = context[i]
      //     }
      //     bufferView[bufferView.byteLength - 2] = href.length
      //     bufferView[bufferView.byteLength - 1] = 1 // 1 for lookup type

      //     traceWorker.postMessage(message)
      //     console.log('reset lookup table pointer')
      //     instances[i].exports.lookup_table_pointer.value = 0
      // }
    };
  };
  let checks = [];

  const binaryString = atob(tracerBinary);
  const uint8Array = new Uint8Array(binaryString.length);
  for (let i = 0; i < binaryString.length; i++) {
    uint8Array[i] = binaryString.charCodeAt(i);
  }
  const buffer = uint8Array.buffer;

  initSync(buffer);
  let original_instantiate = WebAssembly.instantiate;
  WebAssembly.instantiate = async function (buffer, importObject) {
    let href = generateUUID();
    while ((href.length + 2) % 4 !== 0) {
      href = href.substring(1);
    }
    importObject.r3 = get_check(href, i);
    checks.push(() => {
      importObject.r3.check_mem();
      importObject.r3.check_table();
    });
    i += 1;
    buffer = buffer.byte ? buffer.byte : buffer;
    console.log("WebAssembly.instantiate");
    printWelcome();
    self.originalWasmBuffer.push({
      buffer: Array.from(new Uint8Array(buffer)),
      href,
    });
    console.log("Instrumenting...");
    const { instrumented, stats } = instrument_wasm_js(new Uint8Array(buffer));
    // const customEvent = new CustomEvent("instrumented", {
    //   detail: {
    //     message: "Instrumentation done",
    //   },
    //   bubbles: true,
    //   cancelable: true,
    // });

    // document.dispatchEvent(customEvent);
    console.log("Done");
    console.log(stats);
    buffer = new Uint8Array(instrumented);
    result = await original_instantiate(buffer, importObject);
    instances.push(result.instance);
    return result;
  };
  // replace instantiateStreaming
  WebAssembly.instantiateStreaming = async function (source, obj) {
    console.log("WebAssembly.instantiateStreaming");
    let response = await source;
    let body = await response.arrayBuffer();
    return WebAssembly.instantiate(body, obj);
  };
  const original_module = WebAssembly.Module;
  WebAssembly.Module = function (bytes) {
    console.log("WebAssembly.Module");
    const module = new original_module(bytes);
    module.bytes = bytes;
    return module;
  };
  const original_compile = WebAssembly.compile;
  WebAssembly.compile = async function (bytes) {
    console.log("WebAssembly.compile");
    // bytes = new Uint8Array(instrument_wasm_js(new Uint8Array(bytes)));
    const module = await original_compile(bytes);
    module.bytes = bytes;
    return module;
  };
  WebAssembly.compileStreaming = async function (source) {
    console.log("WebAssembly.compileStreaming");
    const response = await source;
    const bytes = await response.arrayBuffer();
    return await WebAssembly.compile(bytes);
  };
  const original_instance = WebAssembly.Instance;
  WebAssembly.Instance = function (module, importObject) {
    let href = generateUUID();
    while ((href.length + 2) % 4 !== 0) {
      href = href.substring(1);
    }
    importObject.r3 = get_check(href, i);
    checks.push(() => {
      importObject.r3.check_mem();
      importObject.r3.check_table();
    });
    let buffer = module.bytes;
    i += 1;
    console.log("WebAssembly.Instance");
    printWelcome();
    self.originalWasmBuffer.push({
      buffer: Array.from(new Uint8Array(buffer)),
      href,
    });
    console.log("Instrumenting...");
    const { instrumented, stats } = instrument_wasm_js(new Uint8Array(buffer));
    const customEvent = new CustomEvent("instrumented", {
      detail: {
        message: "Instrumentation done",
      },
      bubbles: true,
      cancelable: true,
    });

    window.dispatchEvent(customEvent);
    console.log("Done");
    console.log(stats);
    buffer = new Uint8Array(instrumented);
    module = new WebAssembly.Module(buffer);
    const instance = new original_instance(module, importObject);
    instances.push(instance);
    return instance;
  };
  return checks;
}
var aspifdjgsadpfkjns = setup();
var r3_check_mems;
if (aspifdjgsadpfkjns !== undefined) {
  r3_check_mems = aspifdjgsadpfkjns;
}

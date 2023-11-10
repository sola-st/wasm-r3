"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.land = exports.launch = void 0;
const playwright_1 = require("playwright");
const readline_1 = __importDefault(require("readline"));
const tracer_cjs_1 = __importDefault(require("./tracer.cjs"));
function setup(setupTracer) {
    const initSync = window.initSync;
    const WebAssembly = window.WebAssembly;
    const instrument_wasm = window.instrument_wasm;
    const _ = window._;
    window.traces = [];
    window.originalWasmBuffer = [];
    const printWelcome = function () {
        console.log('---------------------------------------------');
        console.log('                   Wasm-R3                   ');
        console.log('---------------------------------------------');
        console.log('WebAssembly module instantiated. Recording...');
    };
    const importObjectWithHooks = function (importObject) {
        let importObjectWithHooks = importObject || {};
        importObjectWithHooks.__wasabi_hooks = window.Wasabi.module.lowlevelHooks;
        return importObjectWithHooks;
    };
    const wireInstanceExports = function (instance) {
        console.log(instance);
        window.Wasabi.module.exports = instance.exports;
        // window.Wasabi.module.tables = [];
        // window.Wasabi.module.memories = [];
        // window.Wasabi.module.globals = [];
        window.Wasabi.module.tables = Object.keys(instance.exports).map(exp => {
            if (window.Wasabi.module.info.tableExportNames.includes(exp)) {
                return instance.exports[exp];
            }
        }).filter(i => i !== undefined);
        window.Wasabi.module.memories = [instance.exports[Object.keys(instance.exports).filter(exp => window.Wasabi.module.info.memoryExportNames.includes(exp))[0]]];
        window.Wasabi.module.globals = Object.keys(instance.exports).map(exp => {
            if (window.Wasabi.module.info.globalExportNames.includes(exp)) {
                return instance.exports[exp];
            }
        }).filter(i => i !== undefined);
        console.log(window.Wasabi);
        // for (let exp in instance.exports) {
        //   if (window.Wasabi.module.info.tableExportNames.includes(exp)) {
        //     window.Wasabi.module.tables.push(instance.exports[exp]);
        //   }
        //   if (window.Wasabi.module.info.memoryExportNames.includes(exp)) {
        //     window.Wasabi.module.memories.push(instance.exports[exp]);
        //   }
        //   if (window.Wasabi.module.info.globalExportNames.includes(exp)) {
        //     window.Wasabi.module.globals.push(instance.exports[exp]);
        //   }
        // }
    };
    //@ts-ignore
    const binaryString = atob(wasabiBinary);
    const uint8Array = new Uint8Array(binaryString.length);
    for (let i = 0; i < binaryString.length; i++) {
        uint8Array[i] = binaryString.charCodeAt(i);
    }
    const buffer = uint8Array.buffer;
    initSync(buffer);
    let original_instantiate = WebAssembly.instantiate;
    WebAssembly.instantiate = function (buffer, importObject) {
        console.log('WebAssembly.instantiate');
        printWelcome();
        window.originalWasmBuffer.push(Array.from(new Uint8Array(buffer)));
        const { instrumented, js } = instrument_wasm({ original: new Uint8Array(buffer) });
        window.Wasabi = eval(js + '\nWasabi');
        buffer = new Uint8Array(instrumented);
        importObject = importObjectWithHooks(importObject);
        window.traces.push(eval(`(${setupTracer})(window.Wasabi)`));
        let result = original_instantiate(buffer, importObject);
        result.then(({ module, instance }) => wireInstanceExports(instance));
        return result;
    };
    // replace instantiateStreaming
    WebAssembly.instantiateStreaming = async function (source, obj) {
        console.log('WebAssembly.instantiateStreaming');
        let response = await source;
        let body = await response.arrayBuffer();
        return WebAssembly.instantiate(body, obj);
    };
}
async function launch(url, { headless } = { headless: false }) {
    const browser = await playwright_1.chromium.launch({ headless });
    const page = await browser.newPage();
    await page.addInitScript({ path: './dist/wasabi.js' });
    await page.addInitScript(setup, tracer_cjs_1.default.toString());
    await page.goto(url);
    return { browser, page };
}
exports.launch = launch;
async function land(browser, page) {
    const traces = await page.evaluate(() => {
        return traces;
    });
    traces.forEach(trace => trace.forEach(event => event.type === 'Load' && Array.from(event.data)));
    const originalWasmBuffer = await page.evaluate(() => {
        try {
            originalWasmBuffer;
        }
        catch {
            throw new Error('There is no WebAssembly instantiated on that page. Make sure this page actually uses WebAssembly and that you also invoked it through your interaction.');
        }
        return originalWasmBuffer.map(b => Array.from(new Uint8Array(b)));
    });
    browser.close();
    return traces.map((trace, i) => ({ binary: originalWasmBuffer[i], trace }));
}
exports.land = land;
async function record(url, options = { headless: false }) {
    const rl = readline_1.default.createInterface({
        input: process.stdin,
        output: process.stdout,
    });
    async function askQuestion(question) {
        return new Promise((resolve) => {
            rl.question(question, (answer) => {
                resolve(answer);
            });
        });
    }
    const { browser, page } = await launch(url, options);
    console.log(`Record is running. Enter 'Stop' to stop recording.`);
    await askQuestion('');
    rl.close();
    console.log(`Record stopped`);
    return await land(browser, page);
}
exports.default = record;
//# sourceMappingURL=instrumenter.cjs.map
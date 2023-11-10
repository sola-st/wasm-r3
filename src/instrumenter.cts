import { Browser, Page, chromium } from 'playwright'
import readline from 'readline'
import { Trace } from '../trace.cjs'
import { Wasabi } from '../wasabi.cjs';
import setupTracer from './tracer.cjs';
import { Record } from './benchmark.cjs';

// Extend the global window object
declare global {
  interface Window {
    traces: Trace[],
    originalWasmBuffer: number[][],
    Wasabi: Wasabi,
    wasabiBinary: any,
    initSync: Function,
    WebAssembly: any,
    instrument_wasm: Function,
    _: any
  }
}

function setup(setupTracer) {
  const initSync = window.initSync
  const WebAssembly = window.WebAssembly
  const instrument_wasm = window.instrument_wasm
  const _ = window._
  window.traces = []

  window.originalWasmBuffer = []
  const printWelcome = function () {
    console.log('---------------------------------------------')
    console.log('                   Wasm-R3                   ')
    console.log('---------------------------------------------')
    console.log('WebAssembly module instantiated. Recording...')
  }

  const importObjectWithHooks = function (importObject) {
    let importObjectWithHooks = importObject || {};
    importObjectWithHooks.__wasabi_hooks = window.Wasabi.module.lowlevelHooks;
    return importObjectWithHooks;
  };

  const wireInstanceExports = function (instance) {
    console.log(instance)
    window.Wasabi.module.exports = instance.exports;
    // window.Wasabi.module.tables = [];
    // window.Wasabi.module.memories = [];
    // window.Wasabi.module.globals = [];
    window.Wasabi.module.tables = Object.keys(instance.exports).map(exp => {
      if (window.Wasabi.module.info.tableExportNames.includes(exp)) {
        return instance.exports[exp]
      }
    }).filter(i => i !== undefined)
    window.Wasabi.module.memories = [instance.exports[Object.keys(instance.exports).filter(exp => window.Wasabi.module.info.memoryExportNames.includes(exp))[0]]]
    window.Wasabi.module.globals = Object.keys(instance.exports).map(exp => {
      if (window.Wasabi.module.info.globalExportNames.includes(exp)) {
        return instance.exports[exp]
      }
    }).filter(i => i !== undefined)
    console.log(window.Wasabi)
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

  initSync(buffer)
  let original_instantiate = WebAssembly.instantiate
  WebAssembly.instantiate = function (buffer: ArrayBuffer, importObject: Object) {
    console.log('WebAssembly.instantiate')
    printWelcome()
    window.originalWasmBuffer.push(Array.from(new Uint8Array(buffer)))
    const { instrumented, js } = instrument_wasm({ original: new Uint8Array(buffer) });
    window.Wasabi = eval(js + '\nWasabi')
    buffer = new Uint8Array(instrumented)
    importObject = importObjectWithHooks(importObject)
    window.traces.push(eval(`(${setupTracer})(window.Wasabi)`))
    let result = original_instantiate(buffer, importObject)
    result.then(({ module, instance }) => wireInstanceExports(instance))
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

export async function launch(url: string, { headless } = { headless: false }) {
  const browser = await chromium.launch({ headless });
  const page = await browser.newPage();

  await page.addInitScript({ path: './dist/wasabi.js' })
  await page.addInitScript(setup, setupTracer.toString())

  await page.goto(url)
  return { browser, page }
}

export async function land(browser: Browser, page: Page): Promise<Record> {
  const traces: Trace[] = await page.evaluate(() => {
    return traces
  })
  traces.forEach(trace => trace.forEach(event => event.type === 'Load' && Array.from(event.data)))
  const originalWasmBuffer: number[][] = await page.evaluate(() => {
    try { originalWasmBuffer } catch {
      throw new Error('There is no WebAssembly instantiated on that page. Make sure this page actually uses WebAssembly and that you also invoked it through your interaction.')
    }
    return originalWasmBuffer.map(b => Array.from(new Uint8Array(b)))
  });
  browser.close()
  return traces.map((trace, i) => ({ binary: originalWasmBuffer[i], trace }))
}

export default async function record(url: string, options = { headless: false }) {
  const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout,
  });

  async function askQuestion(question: string) {
    return new Promise((resolve) => {
      rl.question(question, (answer) => {
        resolve(answer);
      });
    });
  }
  const { browser, page } = await launch(url, options)
  console.log(`Record is running. Enter 'Stop' to stop recording.`)
  await askQuestion('')
  rl.close()
  console.log(`Record stopped`)
  return await land(browser, page)
}
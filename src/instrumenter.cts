import { Browser, Page, chromium, Worker } from 'playwright'
import readline from 'readline'
import { Trace } from '../trace.cjs'
import { Wasabi } from '../wasabi.cjs';
import setupTracer from './tracer.cjs';
import { Record } from './benchmark.cjs';
import fs from 'fs'
//@ts-ignore
import { instrument_wasm } from '../wasabi/wasabi_js.js'

// Extend the global self object
declare global {
  interface Window {
    traces: Trace[],
    originalWasmBuffer: number[][],
    wasabis: Wasabi[],
    wasabiBinary: any,
    initSync: Function,
    WebAssembly: any,
    instrument_wasm: Function,
    i: number
  }
}

function setup(setupTracer) {
  console.log('setup')
  const initSync = self.initSync
  const WebAssembly = self.WebAssembly
  const instrument_wasm = self.instrument_wasm
  self.traces = []
  self.wasabis = []
  self.i = 0

  self.originalWasmBuffer = []
  const printWelcome = function () {
    console.log('---------------------------------------------')
    console.log('                   Wasm-R3                   ')
    console.log('---------------------------------------------')
    console.log('WebAssembly module instantiated. Recording...')
  }

  const importObjectWithHooks = function (importObject, i) {
    let importObjectWithHooks = importObject || {};
    importObjectWithHooks.__wasabi_hooks = self.wasabis[i].module.lowlevelHooks;
    return importObjectWithHooks;
  };

  const wireInstanceExports = function (instance, i) {
    self.wasabis[i].module.exports = instance.exports;
    self.wasabis[i].module.tables = [];
    self.wasabis[i].module.memories = [];
    self.wasabis[i].module.globals = [];
    console.log(self.wasabis)
    for (let exp in instance.exports) {
      if (self.wasabis[i].module.info.tableExportNames.includes(exp)) {
        self.wasabis[i].module.tables.push(instance.exports[exp]);
      }
      if (self.wasabis[i].module.info.memoryExportNames.includes(exp)) {
        // console.log('I am here and I add to the memory', exp)
        self.wasabis[i].module.memories.push(instance.exports[exp])
        // console.log(i)
        // console.log(instance.exports[exp])
        // console.log(self.wasabis[i].module.memories)
        // console.log(self.wasabis)
        // console.log(self.wasabis[i].module.memories)
      }
      if (self.wasabis[i].module.info.globalExportNames.includes(exp)) {
        self.wasabis[i].module.globals.push(instance.exports[exp]);
      }
    }
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
    const i = self.i
    self.i += 1
    console.log('WebAssembly.instantiate')
    printWelcome()
    self.originalWasmBuffer.push(Array.from(new Uint8Array(buffer)))
    console.log('try to instrument')
    console.time('instrument')
    const { instrumented, js } = instrument_wasm({ original: new Uint8Array(buffer) });
    console.timeEnd('instrument')
    self.wasabis.push(eval(js + '\nWasabi'))
    buffer = new Uint8Array(instrumented)
    importObject = importObjectWithHooks(importObject, i)
    self.traces.push(eval(`(${setupTracer})(self.wasabis[i])`))
    let result
    result = original_instantiate(buffer, importObject)
    result.then(({ module, instance }) => {
      wireInstanceExports(instance, i)
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

let workerHandles: Worker[] = []

export async function launch(url: string, { headless } = { headless: false }) {
  const browser = await chromium.launch({ headless, args: ['--disable-web-security'] });
  const page = await browser.newPage();

  await page.addInitScript({ path: './dist/wasabi.js' })
  console.time('setup')
  await page.addInitScript(setup, setupTracer.toString())
  console.timeEnd('setup')

  await page.route('**/*worker.js*', async route => {
    const response = await route.fetch()
    const script = await response.text()
    const wasabi = fs.readFileSync('./dist/wasabi.js')
    const body = `${wasabi}\n(${setup.toString()})(\`${setupTracer.toString()}\`)\n${script}`
    await route.fulfill({ response, body: body })
  })

  page.on('worker', worker => {
    workerHandles.push(worker)
  })

  await page.goto(url)
  return { browser, page }
}

export async function land(browser: Browser, page: Page): Promise<Record> {
  console.log('landing...')
  console.time('trace download')
  const tracesString: string = (await page.evaluate(() => {
    console.time('stringify')
    const tracesString = JSON.stringify(traces)
    console.timeEnd('stringify')
    return tracesString
  }))
  console.time('parse')
  const traces: Trace[] = JSON.parse(tracesString)
  console.timeEnd('parse')
  console.timeEnd('trace download')
  const workerTracesStrings = await Promise.all(workerHandles.map((w) => w.evaluate(() => JSON.stringify(traces))))
  const workerTraces = workerTracesStrings.map(t => JSON.parse(t))
  if (workerTraces.length !== 0) {
    traces.push(...workerTraces.flat(1))
  }
  console.time('trace processing')
  traces.forEach(trace => trace.forEach(event => event.type === 'Load' && Array.from(event.data)))
  console.timeEnd('trace processing')
  console.time('wasm download')
  const originalWasmBufferString: string[] = await page.evaluate(() => {
    try { originalWasmBuffer } catch {
      throw new Error('There is no WebAssembly instantiated on that page. Make sure this page actually uses WebAssembly and that you also invoked it through your interaction.')
    }
    return originalWasmBuffer.map(b => {
      const uint8Array = new Uint8Array(b)
      const base64String = new TextDecoder().decode(uint8Array)
      return base64String
    })
  });
  const originalWasmBuffer: number[][] = originalWasmBufferString.map(b => Array.from(new TextEncoder().encode(b)))
  let workerBuffers = await Promise.all(workerHandles.map(w => w.evaluate(() => originalWasmBuffer)))
  if (workerBuffers.length !== 0) {
    originalWasmBuffer.push(...workerBuffers.flat(1))
  }
  console.timeEnd('wasm download')
  workerHandles = []
  console.time('browser close')
  browser.close()
  console.timeEnd('browser close')
  console.time('closed browser')
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

export async function record_deprecated(url: string): Promise<Record> {
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
  const browser = await chromium.launch({ headless: true })
  const page = await browser.newPage()
  let runtime: string
  let binary: number[]
  await page.route('**/*', async route => {
    const response = await route.fetch()
    if (response.headers()['content-type'] === 'application/wasm') {
      let body = await response.body()
      binary = Array.from(body)
      const out = instrument_wasm({ original: body })
      runtime = out.js
      console.log('instrumented')
      route.fulfill({
        response,
        body: out.instrumented,
      });
    } else {
      route.fulfill({
        response
      })
    }
  })
  await page.goto(url)
  await askQuestion('')
  await browser.close()
  const browser2 = await chromium.launch({ headless: false })
  const page2 = await browser2.newPage()
  page2.addInitScript(runtime)
  page2.addInitScript(`(${setupTracer.toString()})(Wasabi)`)
  await page2.route('**/*', async route => {
    const response = await route.fetch()
    if (response.headers()['content-type'] === 'application/wasm') {
      let body = await response.body()
      binary = Array.from(body)
      const out = instrument_wasm({ original: body })
      console.log(out.instrumented)
      route.fulfill({
        response,
        body: out.instrumented
      });
    } else {
      route.fulfill({
        response
      })
    }
  })
  page2.goto(url)
  await askQuestion('')
  let trace = await page2.evaluate(() => trace)
  await browser.close()
  return [{ binary, trace }]
}

function decodeBase64ToUint8Array(base64String) {
  const binaryString = atob(base64String);
  const uint8Array = new Uint8Array(binaryString.length);
  for (let i = 0; i < binaryString.length; i++) {
    uint8Array[i] = binaryString.charCodeAt(i);
  }
  return uint8Array;
}
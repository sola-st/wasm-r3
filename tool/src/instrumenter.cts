import { Route, chromium } from 'playwright'
import fs from 'fs'
import cp from 'child_process'
import readline from 'readline'
import { Trace } from '../trace.cjs'

async function intercept(route: Route) {
  const response = await route.fetch();
  if (response.headers()['content-type'] === 'application/wasm') {
    let body = await response.body()
    fs.writeFileSync('./pspdf.wasm', body)
    cp.execSync("wasabi /Users/jakob/Desktop/wasm-r3/tool/pspdf.wasm -o /Users/jakob/Desktop/wasm-r3/tool/")
    body = fs.readFileSync('./pspdf.wasm')
    route.fulfill({
      response,
      body,
    });
  } else {
    route.fulfill({
      response
    })
  }
}

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


async function replaceInstanciate() {
  let original_instantiate = WebAssembly.instantiate;
  function instrument(buffer: BufferSource) {
    // fs.writeFileSync('./pspdf.wasm', buffer as NodeJS.ArrayBufferView)
    // cp.execSync("wasabi /Users/jakob/Desktop/wasm-r3/tool/pspdf.wasm -o /Users/jakob/Desktop/wasm-r3/tool/")
    console.log(buffer)
    return buffer
  }

  WebAssembly.instantiate = function (buffer: BufferSource) {
    console.log('WebAssembly.instantiate')
    buffer = instrument(buffer)
    return original_instantiate.call(WebAssembly, ...arguments);
  };
  // replace instantiateStreaming
  WebAssembly.instantiateStreaming = async function (source, obj) {
    console.log('WebAssembly.instantiateStreaming')
    let response = await source;
    let body = await response.arrayBuffer();
    return WebAssembly.instantiate(body, obj);
  }
  //replace compile
  let original_compile = WebAssembly.compile;
  WebAssembly.compile = function (buffer) {
    console.log('WebAssembly.commpile')
    buffer = instrument(buffer)
    return original_compile.call(WebAssembly, ...arguments);
  };
  // replace compileStreaming
  WebAssembly.compileStreaming = async function (source) {
    console.log('WebAssembly.compileStreaming')
    let response = await source;
    let body = await response.arrayBuffer();
    return WebAssembly.compile(body);
  };
}

export default async function record(url: string) {
  const browser = await chromium.launch({
    headless: false,
    devtools: true,
    // channel: 'chrome-118.0.5993.117',
  });
  const page = await browser.newPage();

  await page.addInitScript({ path: '/Users/jakob/Desktop/wasm-r3/tool/src/replaceInstantiate.js' })

  await page.goto(url);
  await page.setViewportSize({ width: 2000, height: 800 })
  // await page.evaluate(replaceInstanciate)
  // await page.evaluate(() => WebAssembly.instantiate(new ArrayBuffer(4)))
  const res = await askQuestion('')
  const trace: Trace = await page.evaluate(() => trace);
  rl.close()
  browser.close()
  return trace
}



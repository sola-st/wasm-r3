import { Route, chromium } from 'playwright'
import readline from 'readline'
import { Trace } from '../trace.cjs'

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

export default async function record(url: string) {
  const browser = await chromium.launch({
    headless: false,
  });
  const page = await browser.newPage();

  await page.addInitScript({ path: '/Users/jakob/Desktop/wasm-r3/tool/src/long.js' })
  await page.addInitScript({ path: '/Users/jakob/Desktop/wasm-r3/tool/src/lodash.js' })
  await page.addInitScript({ path: '/Users/jakob/Desktop/wasm-r3/tool/dist/runtime.js' })

  await page.goto(url);
  console.log(`Record is running. Enter 'Stop' to stop recording.`)
  const res = await askQuestion('')
  const trace: Trace = await page.evaluate(() => trace);
  trace.forEach(event => event.type === 'Load' && Array.from(event.data))
  const originalWasmBuffer: number[] = await page.evaluate(() => {
    return Array.from(new Uint8Array(originalWasmBuffer))
  });
  rl.close()
  browser.close()
  return { binary: originalWasmBuffer, trace }
}
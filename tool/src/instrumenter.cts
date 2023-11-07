import { chromium } from 'playwright'
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

  await page.addInitScript({ path: './src/long.js' })
  await page.addInitScript({ path: './src/lodash.js' })
  await page.addInitScript({ path: './dist/runtime.js' })

  await page.goto(url);
  console.log(`Record is running. Enter 'Stop' to stop recording.`)
  const res = await askQuestion('')
  const trace: Trace = await page.evaluate(() => trace);
  trace.forEach(event => event.type === 'Load' && Array.from(event.data))
  const originalWasmBuffer: number[] = await page.evaluate(() => {
    try { originalWasmBuffer } catch {
      throw new Error('There is no WebAssembly instantiated on that page. Make sure this page actually uses WebAssembly and that you also invoked it through your interaction.')
    }
    return Array.from(new Uint8Array(originalWasmBuffer))
  });
  rl.close()
  browser.close()
  return { binary: originalWasmBuffer, trace }
}
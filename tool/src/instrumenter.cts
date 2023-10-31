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

export default async function record(url: string) {
  const browser = await chromium.launch({
    headless: false,
    channel: '118.0.5993.117',
  });
  const page = await browser.newPage();
  await page.addInitScript({ path: '/Users/jakob/Desktop/wasm-r3/tool/src/runtime.js' })
  await page.addInitScript({ path: '/Users/jakob/Desktop/wasm-r3/tool/src/lodash.js' })
  await page.addInitScript({ path: '/Users/jakob/Desktop/wasm-r3/tool/dist/src/tracer.cjs' })
  await page.route('**/*', intercept)
  await page.goto(url);
  const res = await askQuestion('')
  const trace: Trace = await page.evaluate(() => trace);
  rl.close()
  browser.close()
  return trace
}




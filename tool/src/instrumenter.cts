import { Route, chromium } from 'playwright'
import fs from 'fs'
import cp from 'child_process'
import readline from 'readline'
import { Trace } from '../trace.cjs'
import express from 'express'

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
    devtools: true,
    // channel: 'chrome-118.0.5993.117',
  });
  const page = await browser.newPage();

  await page.addInitScript({ path: '/Users/jakob/Desktop/wasm-r3/tool/src/long.js' })
  await page.addInitScript({ path: '/Users/jakob/Desktop/wasm-r3/tool/src/runtime.js' })
  await page.addInitScript({ path: '/Users/jakob/Desktop/wasm-r3/tool/src/lodash.js' })
  await page.addInitScript({ path: '/Users/jakob/Desktop/wasm-r3/tool/dist/src/tracer.cjs' })
  await page.addInitScript({ path: '/Users/jakob/Desktop/wasm-r3/tool/src/replaceInstantiate.js' })

  await page.goto(url);
  await page.setViewportSize({ width: 2000, height: 800 })
  const res = await askQuestion('')
  const trace: Trace = await page.evaluate(() => trace);
  rl.close()
  browser.close()
  return trace
}
import express from "express";
import Benchmark from "../src/benchmark.cjs";
//@ts-ignore
import { Analyser } from "../src/analyser.cjs";
import { expect } from "playwright/test";
import { exit } from "process";
import { Server } from "http";
import path from "path";
import { execSync } from "child_process";

export default async function runSliceDiceTests(names: string[], options) {
  // Serve the benchmark directory
  for (let name of names) {
    const benchmarkPath = path.join(process.cwd(), "benchmarks", name);
    const replayWasmPath = path.join(benchmarkPath, `${name}.wasm`)
    const subsetOfFidx = getSubsetFidx(replayWasmPath, name);
    for (let fidx of subsetOfFidx) {
      console.log(`${name}-${fidx}:`);
      const subsetPath = path.join(benchmarkPath, 'out', `${fidx}`)
      runSliceDice(replayWasmPath, fidx);
      const server: any = await startServer(subsetPath);
      const url = 'http://localhost:' + server.address().port
      await runWasmR3(options, url, subsetPath);
      checkResult(benchmarkPath, name, fidx);
    }
  }
  exit(0)
}

function getSubsetFidx(replayWasmPath: string, name: string) {
  const cache = {

    'fib': [8],
    'game-of-life': [1, 2],
    'mandelbrot': [1,7,13,17,22,26,34,37,38,42,45,47,48,55,57,59,60,61,68,69,92,98,99,102,105,106,109,111,117,131,132,134,160,161,162,163,164],
    'multiplyDouble': [8],
    'multiplyInt': [8],
    'sandspiel': [1,2,3,7,10,11,12,14,20,24,25,27,30,39,41,45,46,53,58,61,62,63,64,65,78,86,87,93],
  }
  // we can do this as it's deterministic
  if (cache[name]) {
    return cache[name];
  }
  process.stdout.write(`Getting fid candiates for ${name}: `);
  const startTime = Date.now();
  let subsetOfFidx = [];
  try {
    execSync(`./target/release/slice_dice ${replayWasmPath}`, { stdio: ['pipe', 'pipe', 'ignore'] });
  } catch (e) {
    const matches = e.stdout.toString().match(/\d+/g);
    if (matches) {
      // Parse each match as an integer and assign to subsetOfFidx
      subsetOfFidx = matches.map(Number);
    }
  }
  const endTime = Date.now();
  console.log(`${subsetOfFidx}`);
  return subsetOfFidx
}

function runSliceDice(replayWasmPath: string, fidx: number) {
  process.stdout.write('    Running slice-dice: ');
  const startTime = Date.now();
  const command = `./target/release/slice_dice ${replayWasmPath} ${fidx} 1`;
  execSync(command);
  const endTime = Date.now();
  console.log(`${endTime - startTime}ms`);
}

async function startServer(websitePath: string): Promise<Server> {
  const app = express();
  const port = 0;
  app.use(express.static(websitePath));
  return new Promise((resolve) => {
    const server = app.listen(port, () => {
      resolve(server);
    });
  });
}

async function runWasmR3(options: any, url: string, path: string) {
  process.stdout.write('    Running wasm-r3: ');
  const startTime = Date.now();
  let analyser = new Analyser('./dist/src/tracer.cjs', options);
  let page = await analyser.start(url, { headless: options.headless });
  await expect(page.getByText('milliseconds')).toBeVisible({ timeout: 60000 });
  const results = await analyser.stop();
  await Benchmark.fromAnalysisResult(results).save(`${path}/benchmarks`, { trace: options.dumpTrace, rustBackend: options.rustBackend });
  const endTime = Date.now();
  console.log(`${endTime - startTime}ms`);
}

function checkResult(benchmarkPath: string, name: string, fidx: any) {
  process.stdout.write(`    Running wasmtime: `);
  const startTime = Date.now();
  // TODO: is it always the case that bin_1 is the subset?
  execSync(`wasmtime ${path.join(benchmarkPath, 'out', `${fidx}`, 'benchmarks', 'bin_1', 'replay.wasm')}`);
  const endTime = Date.now();
  console.log(`${endTime - startTime}ms`);
}

import express from "express";
import Benchmark from "../src/benchmark.cjs";
//@ts-ignore
import { Analyser } from "../src/analyser.cjs";
import { expect } from "playwright/test";
import { exit } from "process";
import { Server } from "http";
import path from "path";
import { execSync } from "child_process";

export default async function runSliceDiceTests(names: string[], fidxs: number[], options) {
  for (let name of names) {
    const benchmarkPath = path.join(process.cwd(), "benchmarks", name);
    const replayWasmPath = path.join(benchmarkPath, `${name}.wasm`)
    if (fidxs == undefined) fidxs = getSubsetFidx(replayWasmPath, name);
    for (let fidx of fidxs) {
      console.log(`${name}-${fidx}:`);
      const subsetPath = path.join(benchmarkPath, 'out', `${fidx}`)
      runSliceDice(replayWasmPath, fidx);
      await runWasmR3(options, subsetPath);
      checkResult(benchmarkPath, name, fidx);
    }
  }
  exit(0)
}

function runSliceDice(replayWasmPath: string, fidx: number) {
  process.stdout.write('    Running slice-dice: ');
  const startTime = Date.now();
  const command = `./target/release/slice_dice ${replayWasmPath} ${fidx} 1`;
  execSync(command);
  const endTime = Date.now();
  console.log(`${endTime - startTime}ms`);
}

async function runWasmR3(options: any, path: string) {
  // Starting server to host the benchmark
  const app = express();
  const port = 0;
  app.use(express.static(path));
  const server: Server = await new Promise((resolve) => {
    const server = app.listen(port, () => {
      resolve(server);
    });
  });
  const address = server.address();
  if (address === null || typeof address === 'string') {
    throw new Error('Server address is not available');
  }
  const url = 'http://localhost:' + address.port
  // Running the actual Wasm-R3
  process.stdout.write('    Running wasm-r3: ');
  const startTime = Date.now();
  let analyser = new Analyser('./dist/src/tracer.cjs', options);
  let page = await analyser.start(url, { headless: options.headless });
  await expect(page.getByText('milliseconds')).toBeVisible({ timeout: 100000 });
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

function getSubsetFidx(replayWasmPath: string, name: string) {
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
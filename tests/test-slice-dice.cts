import express from "express";
//@ts-ignore
import { expect } from "playwright/test";
import { exit } from "process";
import { Server } from "http";
import path from "path";
import { execSync } from "child_process";
import Benchmark, { Analyser } from "../src/web.cjs";

export default async function runSliceDiceTests(names: string[], options) {
  for (let name of names) {
    const benchmarkPath = path.join(process.cwd(), "benchmarks", name);
    const replayWasmPath = path.join(benchmarkPath, `${name}.wasm`)
    if (options.fidxs == undefined) options.fidxs = getSubsetFidx(replayWasmPath, name);
    const fidx = options.fidxs.join(',')
    console.log(`${name}-${fidx}:`);
    const subsetPath = path.join(benchmarkPath, 'out', `${fidx}`)
    runSliceDice(replayWasmPath, fidx);
    await runWasmR3(options, subsetPath, benchmarkPath, fidx);
  }
  exit(0)
}

function runSliceDice(replayWasmPath: string, fidx: string) {
  const startTime = Date.now();
  process.stdout.write('    Running slice-dice: ');
  const command = `./target/release/slice_dice ${replayWasmPath} ${fidx} 1`;
  execSync(command);
  const endTime = Date.now();
  // We do not actually check what's generated runs to completion. This is misleading.
  // TODO: check for completion
  console.log(`${endTime - startTime}ms`);
}

async function runWasmR3(options: any, subsetPath: string, benchmarkPath: string, fidx: string) {
  const startTime = Date.now();
  process.stdout.write('    Running wasm-r3: ');
  // Starting server to host the benchmark
  const url = await startServer(subsetPath);
  // Running the actual Wasm-R3
  let analyser = new Analyser('./dist/src/tracer.cjs', options);
  let page = await analyser.start(url, { headless: options.headless });
  await expect(page.getByText('milliseconds')).toBeVisible({ timeout: 200000 });
  const results = await analyser.stop();
  await Benchmark.fromAnalysisResult(results).save(`${subsetPath}/benchmarks`, { trace: options.dumpTrace, rustBackend: options.rustBackend });
  // Checking the result
  checkResult(benchmarkPath, fidx)
  const endTime = Date.now();
  console.log(`${endTime - startTime}ms`);
}

async function startServer(websitePath: string): Promise<string> {
  const app = express();
  const port = 0;
  app.use(express.static(websitePath));
  const server: Server = await new Promise((resolve) => {
    const server = app.listen(port, () => {
      resolve(server);
    });
  })
  const address = server.address();
  if (address === null || typeof address === 'string') {
    throw new Error('Server address is not available');
  }
  const url = 'http://localhost:' + address.port
  return url
};

function checkResult(benchmarkPath: string, fidx: any) {
  // TODO: is it always the case that bin_1 is the subset?
  execSync(`wasmtime ${path.join(benchmarkPath, 'out', `${fidx}`, 'benchmarks', 'bin_1', 'replay.wasm')}`);
}

function getSubsetFidx(replayWasmPath: string, name: string) {
  process.stdout.write(`Getting fid candiates for ${name}: `);
  const startTime = Date.now();
  let subsetOfFidx = [];
  try {
  } catch (e) {
  }
  const command = `./target/release/slice_dice ${replayWasmPath}`;
  const stdout = execSync(command, { stdio: ['pipe', 'pipe', 'ignore'] });
  const matches = stdout.toString().match(/\d+/g);
  if (matches) {
    // Parse each match as an integer and assign to subsetOfFidx
    subsetOfFidx = matches.map(Number);
  }

  const endTime = Date.now();
  console.log(`${subsetOfFidx}`);
  return subsetOfFidx
}
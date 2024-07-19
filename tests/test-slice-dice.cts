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
    const subsetOfFidx = getSubsetFidx(replayWasmPath);
    for (let fidx of subsetOfFidx) {
      const subsetPath = path.join(benchmarkPath, 'out', `${fidx}`)
      runSliceDice(replayWasmPath, fidx);
      const server: any = await startServer(subsetPath);
      const url = 'http://localhost:' + server.address().port
      console.log(url)
      await runWasmR3(options, url, subsetPath);
      checkResult(benchmarkPath, fidx);
    }
  }
  exit(0)
}

function getSubsetFidx(replayWasmPath: string) {
  let subsetOfFidx = [];
  try {
    execSync(`./target/release/slice_dice ${replayWasmPath}`);
  } catch (e) {
    const matches = e.stdout.toString().match(/\d+/g);
    if (matches) {
      // Parse each match as an integer and assign to subsetOfFidx
      subsetOfFidx = matches.map(Number);
    }
  }
  return subsetOfFidx
}

function runSliceDice(replayWasmPath: string, fidx: number) {
  const command = `./target/release/slice_dice ${replayWasmPath} ${fidx}`;
  execSync(command);
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
  let analyser = new Analyser('./dist/src/tracer.cjs', options);
  let page = await analyser.start(url, { headless: options.headless });
  await expect(page.getByText('milliseconds')).toBeVisible();
  const results = await analyser.stop();
  await Benchmark.fromAnalysisResult(results).save(`${path}/benchmarks`, { trace: options.dumpTrace, rustBackend: options.rustBackend });
}

function checkResult(benchmarkPath: string, fidx: any) {
  // TODO: is it always the case that bin_1 is the subset?
  execSync(`wasmtime ${path.join(benchmarkPath, 'out', `${fidx}`, 'benchmarks', 'bin_1', 'replay.wasm')}`);
}

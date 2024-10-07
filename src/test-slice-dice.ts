//@ts-ignore
import { expect } from "playwright/test";
import { exit } from "process";
import { Server } from "http";
import path from "path";
import { execSync } from "child_process";
import fs from "fs";
import Benchmark, { Analyser } from "./web.ts";
import { startServer } from "./test.ts";

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
  process.stdout.write('    Running slice-dice: ');
  const command = `./crates/target/release/slice_dice ${replayWasmPath} ${fidx} 1`;
  const startTime = Date.now();
  execSync(command);
  const endTime = Date.now();
  // We do not actually check what's generated runs to completion. This is misleading.
  // TODO: check for completion
  console.log(`${endTime - startTime}ms`);
}

// TODO: this got slower by 2x from 01b34a3952ea29706d29d29d07b6f5148e119065. Investigate why.
async function runWasmR3(options: any, subsetPath: string, benchmarkPath: string, fidx: string) {
  process.stdout.write('    Running wasm-r3: ');
  const startTime = Date.now();
  // Starting server to host the benchmark
  const url = await startServer(subsetPath);
  // Running the actual Wasm-R3
  let analyser = new Analyser('./dist/src/tracer.cjs', options);
  let page = await analyser.start(url, { headless: options.headless });
  const timeout = 120_000; // could go high as 115 seconds
  let did_timeout = false;
  try {
    await expect(page.getByText('milliseconds')).toBeVisible({ timeout });
  } catch (e) {
    did_timeout = true;
    // console.log(`Timed out after ${timeout}ms`);
  }
  const results = await analyser.stop();
  await Benchmark.fromAnalysisResult(results).save(`${subsetPath}/benchmarks`, { trace: options.dumpTrace, rustBackend: options.rustBackend });
  const endTime = Date.now();
  console.log(`${endTime - startTime}ms${did_timeout ? '(timeout)': ''}`);
  // Checking the result
  checkResult(benchmarkPath, fidx)
}

function checkResult(benchmarkPath: string, fidx: any) {
  // TODO: is it always the case that bin_1 is the subset?
  const subsetReplayPath = path.join(benchmarkPath, 'out', `${fidx}`, 'benchmarks', 'bin_1', 'replay.wasm');
  if (!fs.existsSync(subsetReplayPath)) {
    throw new Error(`File not found: ${subsetReplayPath}`);
  } else {
    const deleteWatFilesRecursively = (dir: string) => {
      const files = fs.readdirSync(dir);
      for (const file of files) {
      const fullPath = path.join(dir, file);
      if (fs.statSync(fullPath).isDirectory()) {
        deleteWatFilesRecursively(fullPath);
      } else if (file.endsWith('.wat')) {
        fs.unlinkSync(fullPath);
      }
      }
    };
    deleteWatFilesRecursively(path.join(benchmarkPath, 'out', `${fidx}`));
  }
  process.stdout.write('    Sliced file size: ');
  const stats = fs.statSync(subsetReplayPath);
  console.log(`${stats.size}bytes`);
}

function getSubsetFidx(replayWasmPath: string, name: string) {
  process.stdout.write(`Getting fid candiates for ${name}: `);
  const startTime = Date.now();
  let subsetOfFidx = [];
  try {
  } catch (e) {
  }
  const command = `./crates/target/release/slice_dice ${replayWasmPath}`;
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
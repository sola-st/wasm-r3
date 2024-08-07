import fs from "fs/promises";
import path from "path";
import express from "express";
import { Server } from "http";
import commandLineArgs from "command-line-args";
import { execSync } from "child_process";
import { filter } from "./filter.ts";
import Benchmark, { Analyser } from "./web.ts";
import runSliceDiceTests from "./test-slice-dice.ts";

type Success = { success: true };
type Failure = { success: false };
type TestReport = (
  | Success
  | Failure
);

async function runWasmR3Tests(names: string[], options) {
  console.log(`Run ${options.category} tests`);
  let successful = 0;
  for (let name of names) {
    const report = await runSingleTest(options, name);
    const padded = name.padEnd(40, ' ')
    console.log(`${padded}: ${report.success ? "PASS" : "FAIL"}`);
    if (report.success === true) {
      successful++;
    }
  }
  const fail = names.length - successful;
  console.log(
    `finished running ${names.length} ${options.category} testcases. Pass: ${successful}, Fail: ${fail}, FailRate: ${(fail / names.length) * 100
    }%`
  );
}

async function runSingleTest(options, name: string): Promise<TestReport> {
  const { originalWebsitePath, replayWebsitePath, testJsPath, testPath, originalBenchmarkPath, replayBenchmarkPath, referenceTracePath } = getPaths(name, options);
  // TODO: generalize to multiple wasm modules
  const originalTracePath = await analyzeAndSaveBenchmark(options, testJsPath, originalWebsitePath, originalBenchmarkPath);
  try {
    execSync(`diff ${referenceTracePath} ${originalTracePath}`);
  } catch (e) {
    console.log(`Ref-to-Record diff failed for ${name}`);
    console.log(e);
    return {
      success: false,
    }
  }
  const replayTracePath = await analyzeAndSaveBenchmark(options, testJsPath, replayWebsitePath, replayBenchmarkPath);
  try {
    execSync(`diff ${originalTracePath} ${replayTracePath}`);
  } catch (e) {
    console.log(`Record-to-Replay diff failed for ${name}`);
    console.log(e);
    return {
      success: false,
    }
  }
  return {
    success: true,
  }
}

async function analyzeAndSaveBenchmark(options: any, testJsPath: string, websitePath: string, benchmarkPath: string): Promise<string> {
  try {
    const [server, url] = await startServer(websitePath);
    const analyser = new Analyser(path.join(process.cwd(), 'dist', 'src', 'tracer.cjs'), options);
    let analysisResult = await (await import(testJsPath)).default(analyser, url);
    const benchmark = Benchmark.fromAnalysisResult(analysisResult);
    await benchmark.save(benchmarkPath, options);
    const tracePath = path.join(benchmarkPath, 'bin_0', "trace.r3");
    const traceString = await fs.readFile(tracePath, "utf-8");
    return tracePath;
  } catch (e) {
    console.log(`${websitePath} failed:`);
    console.log(e);
  }
}

(async function run() {
  const optionDefinitions = [
    { name: "category", type: String, defaultOption: true },
    { name: "testcases", alias: "t", type: String, multiple: true },
    { name: "fidxs", alias: "i", type: Number, multiple: true },
    { name: "firefoxFrontend", alias: "f", type: Boolean },
    { name: "webkitFrontend", alias: "w", type: Boolean },
  ];
  const options = commandLineArgs(optionDefinitions);
  if (options.category === undefined || options.category === "core" || options.category === "proxy" || options.category === "online") {
    let testNames = await getDirectoryNames(
      path.join(process.cwd(), "tests", options.category)
    );
    if (filter[options.category]) {
      testNames = testNames.filter(name => !filter[options.category].includes(name));
    }
    if (options.testcases !== undefined) {
      testNames = testNames.filter((n) => options.testcases.includes(n));
      testNames = Array.from(new Set([...testNames, ...options.testcases]));
    }
    await runWasmR3Tests(testNames, options);
  }
  if (options.category === ("slicedice")) {
    let testNames = await getDirectoryNames(
      path.join(process.cwd(), "benchmarks")
    );
    if (options.testcases !== undefined) {
      testNames = testNames.filter((n) => options.testcases === (n));
    }
    await runSliceDiceTests(testNames, options);
  }
})();

function getPaths(name: string, options: any) {
  const testJsPath = path.join(process.cwd(), "tests", options.category, "test.js");
  const testPath = path.join(process.cwd(), "tests", options.category, name);
  const referenceTracePath = path.join(testPath, "reference.r3");
  const originalWebsitePath = path.join(testPath, "website");
  const originalBenchmarkPath = path.join(testPath, 'out', getFrontendPath(options));
  const replayWebsitePath = path.join(originalBenchmarkPath, 'bin_0')
  const replayBenchmarkPath = path.join(replayWebsitePath, 'out')
  return { originalWebsitePath, replayWebsitePath, testJsPath, testPath, originalBenchmarkPath, replayBenchmarkPath, referenceTracePath };
}

function getFrontendPath(options) {
  if (options.firefoxFrontend) {
    return "firefox";
  } else if (options.webkitFrontend) {
    return "webkit";
  } else {
    return "chromium";
  }
}

async function startServer(websitePath: string): Promise<[Server, string]> {
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
  const url = `http://localhost:${address.port}`;

  return [server, url]
}

export async function getDirectoryNames(folderPath: string) {
  const entries = await fs.readdir(folderPath, { withFileTypes: true });

  const directories: string[] = entries
      .filter((entry) => entry.isDirectory())
      .map((entry) => entry.name);

  return directories;
}

export async function delay(ms: number) {
  return new Promise(resolve => {
      setTimeout(resolve, ms);
  });
}

export function trimFromLastOccurance(str: string, substring: string) {
  const lastIndex = str.lastIndexOf(substring);
  if (lastIndex === -1) {
      // Substring not found, return original string or handle as needed
      return str;
  }
  return str.substring(0, lastIndex + substring.length);
}
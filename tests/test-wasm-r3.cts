import fs from "fs/promises";
import path from "path";
import express from "express";
//@ts-ignore
import { Server } from "http";
import commandLineArgs from "command-line-args";
import { getDirectoryNames, trimFromLastOccurance, writeWithSpaces } from "./test-utils.cjs";
import { filter } from "../src/filter.cjs";
import runSliceDiceTests from "./test-slice-dice.cjs";
import Benchmark, { Analyser } from "../src/web.cjs";
import { execSync } from "child_process";

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
    const report = await testWebPage(options, name);
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

async function testWebPage(options, name: string): Promise<TestReport> {
  const { originalWebsitePath, replayWebsitePath, testJsPath, testPath, originalBenchmarkPath, replayBenchmarkPath, referencePath } = getPaths(name, options);
  let originalTracePath;
  try {
    originalTracePath = await analyzeAndSaveBenchmark(options, testJsPath, originalWebsitePath, originalBenchmarkPath);
    // TODO: generalize to multiple wasm modules
    // const replayTracePath = await analyzeAndSaveBenchmark(options, testJsPath, replayWebsitePath, replayBenchmarkPath);
    const diffCommand = `diff ${referencePath} ${originalTracePath}`;
    const diffOutput = execSync(diffCommand, { encoding: "utf-8" });
  } catch (e) {
    console.log(`Test failed for ${name}`);
    if (originalTracePath) {
      console.log('diff erroed:\n', `diff ${referencePath} ${originalTracePath}`)
    }
    return {
      success: false,
    }
  }
  return {
    success: true,
  }
}

async function analyzeAndSaveBenchmark(options: any, testJsPath: string, websitePath: string, benchmarkPath: string): Promise<string> {
  const [server, url] = await startServer(websitePath);
  const analyser = new Analyser(path.join(process.cwd(), 'dist', 'src', 'tracer.cjs'), options);
  let analysisResult = await (await import(testJsPath)).default(analyser, url);
  const benchmark = Benchmark.fromAnalysisResult(analysisResult);
  await benchmark.save(benchmarkPath, options);
  const tracePath = path.join(benchmarkPath, 'bin_0', "trace.r3");
  const traceString = await fs.readFile(tracePath, "utf-8");
  server.close();
  return tracePath;
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
  const testPath = path.join(process.cwd(), "tests", options.category, name);
  const originalWebsitePath = path.join(testPath, "website");
  const testJsPath = path.join(process.cwd(), "tests", options.category, "test.js");
  const originalBenchmarkPath = path.join(testPath, 'out', getFrontendPath(options));
  const replayWebsitePath = path.join(originalBenchmarkPath, 'bin_0')
  const replayBenchmarkPath = path.join(replayWebsitePath, 'out')
  // TODO: remove hardcoded path
  const referencePath = path.join('/Users/don/research/wasm-r3-tests', name, 'trace.r3');
  return { originalWebsitePath, replayWebsitePath, testJsPath, testPath, originalBenchmarkPath, replayBenchmarkPath, referencePath };
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
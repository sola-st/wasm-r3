import fs from "fs/promises";
import path from "path";
import express from "express";
//@ts-ignore
import { Server } from "http";
import commandLineArgs from "command-line-args";
import { getDirectoryNames, trimFromLastOccurance, writeWithSpaces } from "./test-utils.cjs";
import { proxy_filter } from "../src/filter.cjs";
import { Analyser } from "../src/analyser.cjs";
import Benchmark from "../src/benchmark.cjs";
import runSliceDiceTests from "../src/test-slice-dice.cjs";

async function runTests(names: string[], options) {
  if (names.length === 0) {
    return;
  }
  console.log("=================");
  console.log(`Run ${options.category} tests`);
  console.log("=================");
  // ignore specific tests
  // names = names.filter((n) => !proxy_filter.includes(n));
  let successfull = 0;
  let roundTripTimes = [];
  for (let name of names) {
    const report = await testWebPage(options, name);
    await writeReport(name, report);
    if (report.success === true) {
      successfull++;
    }
    if (report.roundTripTime !== undefined) {
      roundTripTimes.push(report.roundTripTime);
    }
  }
  writeSummary("proxy", names.length, successfull, roundTripTimes);
}

async function testWebPage(options, name: string): Promise<TestReport> {
  const { originalWebsitePath, replayWebsitePath, testJsPath, testPath, originalBenchmarkPath, replayBenchmarkPath } = getPaths(name, options);
  const originalTrace = await analyzeAndSaveBenchmark(options, testJsPath, originalWebsitePath, originalBenchmarkPath);
  // TODO: generalize to multiple wasm modules
  const replayTrace = await analyzeAndSaveBenchmark(options, testJsPath, replayWebsitePath, replayBenchmarkPath);
  return compareResults(testPath, originalTrace, replayTrace);
}

async function analyzeAndSaveBenchmark(options: any, testJsPath: string, websitePath: string, benchmarkPath: string): Promise<string> {
  const [server, url] = await startServer(websitePath);
  const analyser = new Analyser(path.join(process.cwd(), 'dist', 'src', 'tracer.cjs'), options);
  let analysisResult = await (await import(testJsPath)).default(analyser, url);
  const benchmark = Benchmark.fromAnalysisResult(analysisResult);
  await benchmark.save(benchmarkPath, options);
  const tracePath = path.join(benchmarkPath, 'bin_0', "trace.r3");
  const traceString = await fs.readFile(tracePath, "utf-8");
  return traceString;
}

type Success = { success: true };
type Failure = { success: false; reason: string };
type TestReport = { testPath: string; roundTripTime?: DOMHighResTimeStamp } & (
  | Success
  | Failure
);

(async function run() {
  const optionDefinitions = [
    { name: "category", type: String, multiple: true, defaultOption: true },
    { name: "testcases", alias: "t", type: String, multiple: true },
    { name: "fidxs", alias: "i", type: Number, multiple: true },
    { name: "port", alias: "p", type: Number },
    { name: "firefoxFrontend", alias: "f", type: Boolean },
    { name: "webkitFrontend", alias: "w", type: Boolean },
  ];
  const options = commandLineArgs(optionDefinitions);
  if (options.category === undefined || options.category.includes("core")) {
    let testNames = await getDirectoryNames(
      path.join(process.cwd(), "tests", "core")
    );
    if (options.testcases !== undefined) {
      testNames = testNames.filter((n) => options.testcases.includes(n));
    }
    await runTests(testNames, options);
  }
  if (options.category === undefined || options.category.includes("proxy")) {
    let testNames = await getDirectoryNames(
      path.join(process.cwd(), "tests", "proxy")
    );
    if (options.testcases !== undefined) {
      testNames = testNames.filter((n) => options.testcases.includes(n));
    }
    await runTests(testNames, options);
  }
  if (options.category === undefined || options.category.includes("online")) {
    let testNames = await getDirectoryNames(
      path.join(process.cwd(), "tests", "online")
    );
    if (options.testcases !== undefined) {
      testNames = testNames.filter((n) => options.testcases.includes(n));
    }
    // await runOnlineTests(testNames, options);
  }
  if (options.category === undefined || options.category.includes("slicedice")) {
    let testNames = await getDirectoryNames(
      path.join(process.cwd(), "benchmarks")
    );
    if (options.testcases !== undefined) {
      testNames = testNames.filter((n) => options.testcases.includes(n));
    }
    await runSliceDiceTests(testNames, options.fidxs, options);
  }
})();

function getPaths(name: string, options: any) {
  const testPath = path.join(process.cwd(), "tests", options.category[0], name);
  const originalWebsitePath = path.join(testPath, "website");
  const testJsPath = path.join(process.cwd(), "tests", options.category[0], "test.js");
  const originalBenchmarkPath = path.join(testPath, 'out', getFrontendPath(options));
  const replayWebsitePath = path.join(testPath, 'out', getFrontendPath(options), 'bin_0')
  const replayBenchmarkPath = path.join(testPath, 'out', getFrontendPath(options), 'bin_0', 'out')
  return { originalWebsitePath, replayWebsitePath, testJsPath, testPath, originalBenchmarkPath, replayBenchmarkPath };
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

function writeSummary(
  type: string,
  testCount: number,
  successfull: number,
  roundTripTimes: DOMHighResTimeStamp[]
) {
  const fail = testCount - successfull;
  let avgRoundTripTime = undefined;
  if (roundTripTimes.length > 0) {
    avgRoundTripTime =
      roundTripTimes.reduce((p, c) => p + c) / roundTripTimes.length;
  }
  console.log(
    `finished running ${testCount} ${type} testcases. Pass: ${successfull}, Fail: ${fail}, FailRate: ${(fail / testCount) * 100
    }%, Avg time: ${avgRoundTripTime}`
  );
}

function compareResults(
  testPath: string,
  traceString: string,
  replayTraceString: string
): TestReport {
  if (traceString === "") {
    return { testPath, success: false, reason: "Empty trace string" };
  }
  let t = traceString.split("\n");
  let rt = replayTraceString.split("\n");
  let diffIdx;
  if (
    t.some((e, i) => {
      if (e === "") {
        return false;
      }
      if (e !== rt[i]) {
        diffIdx = i;
        return true;
      } else {
        return false;
      }
    })
  ) {
    let reason = `First diff in line ${diffIdx}\n\n`;
    reason += `[Expected]\n`;
    reason += traceString;
    reason += `\n\n`;
    reason += `[Actual]\n`;
    reason += replayTraceString;
    return { testPath, success: false, reason };
  }
  return { testPath, success: true };
}

async function writeReport(name: string, report: TestReport) {
  writeWithSpaces(name);
  const testReportPath = path.join(report.testPath, 'out', "report.txt");
  if (report.success === true) {
    await fs.writeFile(testReportPath, "Test successfull");
    process.stdout.write(`\u2713`);
  } else {
    process.stdout.write(`\u2717\t\t${testReportPath}`);
    await fs.writeFile(testReportPath, report.reason);
  }
  if (report.roundTripTime !== undefined) {
    process.stdout.write(`\t\tround-trip-time: ${report.roundTripTime}`);
  }
  process.stdout.write(`\n`);
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
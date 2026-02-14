import fs, { readFile, stat } from "fs/promises";
import path, { extname, join } from "path";
import { createServer, Server } from "http";
import commandLineArgs from "command-line-args";
import { execSync } from "child_process";
import { filter } from "./filter.ts";
import Benchmark, { Analyser, commonOptions } from "./web.ts";
import runSliceDiceTests from "./test-slice-dice.ts";
import { exit } from "process";

type Success = { success: true };
type Failure = { success: false };
type TestReport = (
  | Success
  | Failure
);

type RunResult = {
  fail: number,
  passedTests: string[]
}

async function runWasmR3Tests(names: string[], options, skipped = 0): Promise<RunResult> {
  console.log(`Run ${options.category} tests`);
  let successful = 0;
  const passedTests: string[] = [];
  for (let name of names) {
    const report = await runSingleTest(options, name);
    const padded = name.padEnd(40, ' ')
    console.log(`${padded}: ${report.success ? "PASS" : "FAIL"}`);
    if (report.success === true) {
      successful++;
      passedTests.push(name);
    }
  }
  const fail = names.length - successful;
  console.log(
    `finished running ${names.length} ${options.category} testcases. Pass: ${successful}, Fail: ${fail}, Skipped: ${skipped}`
  );
  return { fail, passedTests }
}

async function runSingleTest(options, name: string): Promise<TestReport> {
  const { originalWebsitePath, replayWebsitePath, testJsPath, replayTestJsPath, testPath, originalBenchmarkPath, replayBenchmarkPath, referenceTracePath } = getPaths(name, options);
  // TODO: generalize to multiple wasm modules
  const originalTracePath = await analyzeAndSaveBenchmark(options, testJsPath, originalWebsitePath, originalBenchmarkPath);
  const replayTracePath = await analyzeAndSaveBenchmark(options, replayTestJsPath, replayWebsitePath, replayBenchmarkPath);
  try {
    execSync(`diff ${originalTracePath} ${replayTracePath}`);
  } catch (e) {
    console.log(`Record-to-Replay diff failed for ${name}`);
    console.log(e);
    return {
      success: false,
    }
  }
  // Online tests can be inherently non-deterministic and their reference traces can change.
  // Keep the record-to-replay consistency check, but skip ref-to-record for online.
  if (options.category !== "online") {
    try {
      execSync(`diff ${referenceTracePath} ${originalTracePath}`);
    } catch (e) {
      console.log(`Ref-to-Record diff failed for ${name}`);
      console.log(e);
      return {
        success: false,
      }
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

const testOptions = [
  { name: "category", type: String, defaultOption: true },
  { name: "testcases", alias: "t", type: String, multiple: true },
  { name: "fidxs", alias: "i", type: Number, multiple: true },
  { name: "run-skipped", type: Boolean, defaultValue: false },
  { name: "repeat", alias: "r", type: Number, defaultValue: 1 },
];

(async function run() {
  const options = commandLineArgs([...commonOptions, ...testOptions]);
  await pruneUnusedFilterEntries();
  if (options.category === undefined || options.category === "core" || options.category === "proxy" || options.category === "online") {
    const discoveredTests = await getDirectoryNames(
      path.join(process.cwd(), "tests", options.category)
    );
    let testNames = discoveredTests;
    let skipped = 0;
    const filteredTests = filter[options.category] || [];
    const filteredSet = new Set(filteredTests);
    const runSkiped = options["run-skipped"] === true;
    if (filter[options.category]) {
      skipped = testNames.filter(name => filteredSet.has(name)).length;
      testNames = testNames.filter(name => !filteredSet.has(name));
      if (runSkiped) {
        testNames = Array.from(new Set([...testNames, ...filteredTests]));
        skipped = 0;
      }
    }
    if (options.testcases !== undefined) {
      const requestedTests = options.testcases as string[];
      testNames = testNames.filter((n) => requestedTests.includes(n));
      testNames = Array.from(new Set([...testNames, ...requestedTests]));
      const discoveredSet = new Set(discoveredTests);
      const explicitFiltered = Array.from(new Set(requestedTests)).filter(name => filteredSet.has(name) && discoveredSet.has(name)).length;
      skipped = Math.max(0, skipped - explicitFiltered);
    }
    const repeat = options.repeat;
    if (!Number.isInteger(repeat) || repeat < 1) {
      throw new Error(`--repeat/-r must be a positive integer. Received: ${repeat}`);
    }

    let totalFail = 0;
    let failedRuns = 0;
    const passedSkippedAcrossRuns = new Set<string>();

    for (let runIndex = 1; runIndex <= repeat; runIndex++) {
      if (repeat > 1) {
        console.log(`\nRepeat ${runIndex}/${repeat}`);
      }
      const runResult = await runWasmR3Tests(testNames, options, skipped);
      totalFail += runResult.fail;
      if (runResult.fail > 0) {
        failedRuns++;
      }
      if (runSkiped && filter[options.category]) {
        const passedSkipped = runResult.passedTests.filter(name => filteredSet.has(name));
        for (const passed of passedSkipped) {
          passedSkippedAcrossRuns.add(passed);
        }
      }
    }

    if (runSkiped && filter[options.category]) {
      if (passedSkippedAcrossRuns.size > 0) {
        filter[options.category] = filteredTests.filter(name => !passedSkippedAcrossRuns.has(name));
        await saveFilterFile();
        console.log(`Removed ${passedSkippedAcrossRuns.size} passing skipped testcase(s) from filter.${options.category}`);
      }
    }

    if (repeat > 1) {
      console.log(`\nFinished ${repeat} run(s). Failed runs: ${failedRuns}, Failed test executions: ${totalFail}`);
    }

    const failNumber = totalFail;
    if (failNumber > 0) {
      exit(1);
    } else {
      exit(0);
    }
  }
  if (options.category === "slicedice") {
    let testNames = await getDirectoryNames(
      path.join(process.cwd(), "benchmarks")
    );
    if (options.testcases !== undefined) {
      testNames = testNames.filter((n) => options.testcases.includes(n));
      testNames = Array.from(new Set([...testNames, ...options.testcases]));
    }
    await runSliceDiceTests(testNames, options);
  }
})();

async function pruneUnusedFilterEntries() {
  let changed = false;
  const categories = Object.keys(filter);
  for (const category of categories) {
    const testsPath = path.join(process.cwd(), "tests", category);
    let availableTests: string[] = [];
    try {
      availableTests = await getDirectoryNames(testsPath);
    } catch {
      continue;
    }
    const availableSet = new Set(availableTests);
    const filteredTests = filter[category] || [];
    const usedEntries = filteredTests.filter(name => availableSet.has(name));
    if (usedEntries.length !== filteredTests.length) {
      filter[category] = usedEntries;
      changed = true;
    }
  }

  if (changed) {
    await saveFilterFile();
  }
}

async function saveFilterFile() {
  const filterPath = path.join(process.cwd(), "src", "filter.ts");
  const serializedFilter = `export const filter = ${JSON.stringify(filter, null, 2)}\n`;
  await fs.writeFile(filterPath, serializedFilter, "utf-8");
}

function getPaths(name: string, options: any) {
  let testJsPath;
  let replayTestJsPath;
  if (options.category === "online") {
    testJsPath = path.join(process.cwd(), "tests", options.category, name, "test.js");
    replayTestJsPath = path.join(process.cwd(), "tests", options.category, "test.js");
    console.log(testJsPath)
  } else {
    testJsPath = path.join(process.cwd(), "tests", options.category, "test.js");
    replayTestJsPath = testJsPath;
  }
  const testPath = path.join(process.cwd(), "tests", options.category, name);
  const referenceTracePath = path.join(testPath, "reference.r3");
  const originalWebsitePath = path.join(testPath, "website");
  const originalBenchmarkPath = path.join(testPath, 'out', getFrontendPath(options));
  const replayWebsitePath = path.join(originalBenchmarkPath, 'bin_0')
  const replayBenchmarkPath = path.join(replayWebsitePath, 'out')
  return { originalWebsitePath, replayWebsitePath, testJsPath, replayTestJsPath, testPath, originalBenchmarkPath, replayBenchmarkPath, referenceTracePath };
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
export async function startServer(websitePath: string): Promise<[Server, string]> {
  const port = 0;

  const server = createServer(async (req, res) => {
    try {
      const filePath = join(websitePath, req.url === '/' ? 'index.html' : req.url!);
      const stats = await stat(filePath);

      if (stats.isDirectory()) {
        res.writeHead(404, { 'Content-Type': 'text/plain' });
        res.end('404 Not Found');
        return;
      }

      const content = await readFile(filePath);
      const contentType = getContentType(filePath);

      res.writeHead(200, { 'Content-Type': contentType });
      res.end(content);
    } catch (error) {
      res.writeHead(404, { 'Content-Type': 'text/plain' });
      res.end('404 Not Found');
    }
  });

  await new Promise<void>((resolve) => {
    server.listen(port, () => {
      resolve();
    });
  });

  const address = server.address();
  if (address === null || typeof address === 'string') {
    throw new Error('Server address is not available');
  }

  const url = `http://localhost:${address.port}`;
  return [server, url];
}

function getContentType(filePath: string): string {
  const ext = extname(filePath).toLowerCase();
  const contentTypes: Record<string, string> = {
    '.html': 'text/html',
    '.css': 'text/css',
    '.js': 'text/javascript',
    '.json': 'application/json',
    '.png': 'image/png',
    '.jpg': 'image/jpeg',
    '.gif': 'image/gif',
  };
  return contentTypes[ext] || 'application/octet-stream';
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

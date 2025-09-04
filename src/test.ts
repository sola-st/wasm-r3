import fs, { readFile, stat } from "fs/promises";
import path, { extname, join } from "path";
import { createServer, Server } from "http";
import commandLineArgs from "command-line-args";
import { execSync } from "child_process";
import Benchmark, { Analyser, commonOptions } from "./web.ts";
import runSliceDiceTests from "./test-slice-dice.ts";
import { exit } from "process";

type Success = { success: true };
type Failure = { success: false };
type TestReport = (
  | Success
  | Failure
);

async function runWasmR3Tests(names: string[], options): Promise<number> {
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
  return fail
}

async function runSingleTest(options, name: string): Promise<TestReport> {
  const { originalWebsitePath, replayWebsitePath, testJsPath, testPath, originalBenchmarkPath, replayBenchmarkPath, referenceTracePath } = getPaths(name, options);
  // TODO: generalize to multiple wasm modules
  const originalTracePath = await analyzeAndSaveBenchmark(options, testJsPath, originalWebsitePath, originalBenchmarkPath);
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
  try {
    execSync(`diff ${referenceTracePath} ${originalTracePath}`);
  } catch (e) {
    console.log(`Ref-to-Record diff failed for ${name}`);
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

const testOptions = [
  { name: "category", type: String, defaultOption: true },
  { name: "testcases", alias: "t", type: String, multiple: true },
  { name: "fidxs", alias: "i", type: Number, multiple: true },
  { name: "cache", alias: "c", type: Boolean },
];

(async function run() {
  const options = commandLineArgs([...commonOptions, ...testOptions]);
  if (options.category === undefined || options.category === "core" || options.category === "proxy" || options.category === "online") {
    let testNames = await getDirectoryNames(
      path.join(process.cwd(), "tests", options.category)
    );
    if (options.testcases !== undefined) {
      testNames = testNames.filter((n) => options.testcases.includes(n));
      testNames = Array.from(new Set([...testNames, ...options.testcases]));
    }
    const failNumber = await runWasmR3Tests(testNames, options);
    if (failNumber > 0) {
      exit(1);
    } else {
      exit(0);
    }
  }
  if (options.category === "slicedice") {
    let testNames = await getDirectoryNames(
      path.join(process.cwd(), "evaluation/benchmarks")
    );
    if (options.testcases !== undefined) {
      testNames = testNames.filter((n) => options.testcases.includes(n));
      testNames = Array.from(new Set([...testNames, ...options.testcases]));
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
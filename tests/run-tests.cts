import fs from "fs/promises";
import fss from "fs";
import path from "path";
import cp, { execSync } from "child_process";
import express from "express";
import Generator from "../src/replay-generator.cjs";
import Tracer, { Trace } from "../src/tracer.cjs";
import {
  delay,
  findWatNames,
  writeWithSpaces,
  getDirectoryNames,
  rmSafe,
  startSpinner,
  stopSpinner,
  trimFromLastOccurance,
} from "./test-utils.cjs";
import Benchmark from "../src/benchmark.cjs";
//@ts-ignore
import { instrument_wasm } from "../wasabi/wasabi_js.js";
import { Server } from "http";
import { Analyser, AnalysisResult, CustomAnalyser } from "../src/analyser.cjs";
import commandLineArgs from "command-line-args";
import { initPerformance } from "../src/performance.cjs";
import { generateJavascript } from "../src/js-generator.cjs";
import { createMeasure } from "../src/performance.cjs";
import { node_filter, offline_filter, online_filter } from "./filter.cjs";
import runSliceDiceTests from "./test-slice-dice.cjs";

let extended = false;
let frontend; // will be set later by options

async function cleanUp(testPath: string) {
  await rmSafe(path.join(testPath, "gen.js"));
  await rmSafe(path.join(testPath, "replayGen.js"));
  await rmSafe(path.join(testPath, "index.wasabi.cjs"));
  await rmSafe(path.join(testPath, "index.wasm"));
  await rmSafe(path.join(testPath, "trace.r3"));
  await rmSafe(path.join(testPath, "replay-trace.r3"));
  // await rmSafe(path.join(testPath, "replay.js"))
  // await rmSafe(path.join(testPath, "report.txt"));
  await rmSafe(path.join(testPath, "long.js"));
  await rmSafe(path.join(testPath, "call-graph.txt"));
  await rmSafe(path.join(testPath, "replay-call-graph.txt"));
  await rmSafe(path.join(testPath, "long.cjs"));
  // await rmSafe(path.join(testPath, frontend));
  // delete ablation study directories
  // await rmSafe(path.join(testPath, 'noopt'));
  // await rmSafe(path.join(testPath, 'split'));
  // await rmSafe(path.join(testPath, 'merge'));
  await rmSafe(path.join(testPath, "test-benchmark"));
  await rmSafe(path.join(testPath, "test-runtime.js"));
}

async function runNodeTestCustom(name: string, options): Promise<TestReport> {
  const testPath = path.join(process.cwd(), "tests", "node", name);
  const benchmarkPath = path.join(testPath, frontend);
  await cleanUp(testPath);
  await fs.mkdir(benchmarkPath);
  const testJsPath = path.join(testPath, "test.js");
  const watPath = path.join(testPath, "index.wat");
  const testJsRuntimePath = path.join(benchmarkPath, "test-runtime.js");
  const wasmPath = path.join(benchmarkPath, "index.wasm");
  const instrumentedPath = path.join(benchmarkPath, "instrumented.wasm");
  const tracePath = path.join(benchmarkPath, "trace.bin");
  const traceStringPath = path.join(benchmarkPath, "trace.r3");
  const callGraphPath = path.join(benchmarkPath, "call-graph.txt");
  const replayPath = path.join(benchmarkPath, "replay.js");
  const replayTracePath = path.join(benchmarkPath, "replay-trace.bin");
  const replayTraceStringPath = path.join(benchmarkPath, "replay-trace.r3");
  const replayCallGraphPath = path.join(benchmarkPath, "replay-call-graph.txt");

  // 1. Instrument with Wasabi !!Please use the newest version
  const indexRsPath = path.join(benchmarkPath, "index.rs");
  const indexCPath = path.join(benchmarkPath, "index.c");
  if (fss.existsSync(indexRsPath)) {
    cp.execSync(
      `rustc --crate-type cdylib ${indexRsPath} --target wasm32-unknown-unknown --crate-type cdylib -o ${wasmPath}`,
      { stdio: "ignore" }
    );
    cp.execSync(`wasm2wat ${wasmPath} -o ${watPath}`);
  } else if (fss.existsSync(indexCPath)) {
    // TODO
  } else {
    cp.execSync(`wat2wasm ${watPath} -o ${wasmPath}`);
  }

  try {
    let runtime = await fs.readFile("./dist/node-runtime.js", "utf-8");
    let testText = await fs.readFile(testJsPath, "utf-8");
    await fs.writeFile(
      testJsRuntimePath,
      `import fs from 'fs';\n${testText};\n${runtime};`
    );
    let test = await import(testJsRuntimePath);
    let check_mem = test.setup(tracePath);
    let wasmBinary = fss.readFileSync(wasmPath);
    await test.default(wasmBinary);
    check_mem();
    execSync(
      `./target/release/replay_gen stringify ${tracePath} ${wasmPath} ${traceStringPath}`
    );

    if (options.jsBackend == true) {
      execSync(
        `./target/release/replay_gen generate ${tracePath} ${wasmPath} true ${replayPath}`
      );
    } else {
      const replayWasmPath = path.join(benchmarkPath, "replay.wasm");
      execSync(
        `./target/release/replay_gen generate ${tracePath} ${wasmPath} true ${replayWasmPath}`
      );
    }

    let replay = await fs.readFile(replayPath, "utf-8");
    await fs.rm(replayPath);
    await fs.writeFile(replayPath, `${replay};\n${runtime};`);
    let replayBinary = await import(replayPath);
    let check_mem_2 = replayBinary.setup(replayTracePath);
    let wasm = await replayBinary.instantiate(wasmBinary);
    await replayBinary.replay(wasm);
    check_mem_2();
    execSync(
      `./target/release/replay_gen stringify ${replayTracePath} ${wasmPath} ${replayTraceStringPath}`
    );

    let traceString = await fs.readFile(traceStringPath, "utf-8");
    let replayTraceString = await fs.readFile(replayTraceStringPath, "utf-8");
    const comparison = compareResults(
      benchmarkPath,
      traceString,
      replayTraceString
    );
    return comparison;
  } catch (e: any) {
    if (typeof e === "string") {
      return { testPath: benchmarkPath, success: false, reason: e };
    }
    return { testPath: benchmarkPath, success: false, reason: e.stack };
  }
}

async function runNodeTest(name: string, options): Promise<TestReport> {
  const testPath = path.join(process.cwd(), "tests", "node", name);
  const benchmarkPath = path.join(testPath, 'bin_0', frontend);
  await cleanUp(testPath);
  await fs.mkdir(benchmarkPath, { recursive: true });
  const testJsPath = path.join(testPath, "test.js");
  const watPath = path.join(testPath, "index.wat");
  const wasmPath = path.join(benchmarkPath, "index.wasm");
  const instrumentedPath = path.join(benchmarkPath, "instrumented.wasm");
  const tracePath = path.join(benchmarkPath, "trace.r3");
  const callGraphPath = path.join(benchmarkPath, "call-graph.txt");
  const pureJsPath = path.join(benchmarkPath, "pure.js");
  const replayJsPath = path.join(benchmarkPath, "replay.js");
  const replayWasmPath = path.join(benchmarkPath, "replay.wasm");
  const mergedWasmPath = path.join(benchmarkPath, "merged.wasm");
  const replayTracePath = path.join(benchmarkPath, "replay-trace.r3");
  const replayCallGraphPath = path.join(benchmarkPath, "replay-call-graph.txt");

  // 1. Instrument with Wasabi !!Please use the newest version
  const indexRsPath = path.join(benchmarkPath, "index.rs");
  const indexCPath = path.join(benchmarkPath, "index.c");
  const p_roundTrip = createMeasure("round-trip time", {
    description:
      "The time it takes to start the browser instance, load the webpage, record the interaction, download the data, and generate the replay",
    phase: "all",
  });
  if (fss.existsSync(indexRsPath)) {
    cp.execSync(
      `rustc --crate-type cdylib ${indexRsPath} --target wasm32-unknown-unknown --crate-type cdylib -o ${wasmPath}`,
      { stdio: "ignore" }
    );
    cp.execSync(`wasm2wat ${wasmPath} -o ${watPath}`);
  } else if (fss.existsSync(indexCPath)) {
    // TODO
  } else {
    cp.execSync(`wat2wasm ${watPath} -o ${wasmPath}`);
  }
  // const wasabiCommand = `wasabi ${wasmPath} --node -o ${benchmarkPath}`
  // cp.exec(wasabiCommand, { stdio: 'ignore' });
  // fss.rename(wasabiRuntimePathJS, wasabiRuntimePath)
  // fss.rename(path.join(benchmarkPath, 'long.js'), path.join(benchmarkPath, 'long.cjs'))
  // modifyRuntime(wasabiRuntimePath)
  // const wat = await fs.readFile(watPath)
  // const wabtModule = await wabt()
  // const binary = wabtModule.parseWat(watPath, wat).toBinary({})
  const binary = await fs.readFile(wasmPath);
  let { instrumented, js } = instrument_wasm(binary);
  await fs.writeFile(instrumentedPath, Buffer.from(instrumented));

  // 2. Execute test and generate trace
  const wasmBinary = await fs.readFile(instrumentedPath);
  let tracer = new Tracer(eval(js + `\nWasabi`), { extended });
  let original_instantiate = WebAssembly.instantiate;
  //@ts-ignore
  WebAssembly.instantiate = async function (
    bytes: BufferSource,
    importObject?: WebAssembly.Imports
  ) {
    const result = await original_instantiate(bytes, importObject);
    tracer.init();
    return result;
  };
  try {
    await (await import(testJsPath)).default(wasmBinary);
  } catch (e: any) {
    return { testPath: benchmarkPath, success: false, reason: e.stack };
  }
  let trace = tracer.getResult();
  let traceString = trace.toString();
  await fs.writeFile(tracePath, traceString);

  // 3. Generate replay binary
  try {
    trace = Trace.fromString(traceString);
  } catch (e: any) {
    return { testPath: benchmarkPath, success: false, reason: e.stack };
  }
  let replayCode;
  try {
    if (options.legacyBackend === true) {
      replayCode = await new Generator().generateReplay(trace);
      await generateJavascript(fss.createWriteStream(replayJsPath), replayCode);
    } else {
      execSync(
        `./target/release/replay_gen generate ${tracePath} ${wasmPath} false ${replayWasmPath}`
      );
      execSync(`node ${replayJsPath}`, { cwd: benchmarkPath });
      execSync(`wasmtime  ${replayWasmPath}`);
      execSync(
        `./target/release/replay_gen generate ${tracePath} ${wasmPath} false ${pureJsPath}`
      );
    }
    await delay(0);
  } catch (e: any) {
    return { testPath: benchmarkPath, success: false, reason: e.stack };
  }
  let roundTripTime = p_roundTrip().duration;

  // 4. Execute replay and generate trace and compare
  let replayTracer = new Tracer(eval(js + `\nWasabi`), { extended });
  try {
    const replayBinary = await import(pureJsPath);
    const wasm = await replayBinary.instantiate(wasmBinary);
    replayTracer.init();
    replayBinary.replay(wasm);
  } catch (e: any) {
    return {
      testPath: benchmarkPath,
      roundTripTime,
      success: false,
      reason: e.stack,
    };
  }
  let replayTraceString = replayTracer.getResult().toString();
  await fs.writeFile(replayTracePath, replayTraceString);

  const result = compareResults(benchmarkPath, traceString, replayTraceString);
  result.roundTripTime = roundTripTime;
  if (result.success === false) {
    return result;
  }

  return result;
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

async function runNodeTests(names: string[], options) {
  if (names.length > 0) {
    console.log("==============");
    console.log("Run node tests");
    console.log("==============");
  }
  names = names.filter((n) => !node_filter.includes(n));
  let successfull = 0;
  // names = ["mem-imp-host-grow"]
  let roundTripTimes = [];
  for (let name of names) {
    const testPath = path.join(process.cwd(), "tests", "node", name);
    const cleanUpPerformance = await initPerformance(
      name,
      "node-auto-test",
      path.join(testPath, "performance.ndjson")
    );
    let report;
    if (options.customFrontend === true) {
      report = await runNodeTestCustom(name, options);
    } else {
      report = await runNodeTest(name, options);
    }
    cleanUpPerformance();
    await writeReport(name, report);
    if (report.success === true) {
      successfull++;
    }
    if (report.roundTripTime !== undefined) {
      roundTripTimes.push(report.roundTripTime);
    }
  }
  writeSummary("node", names.length, successfull, roundTripTimes);
}

function compareResults(
  testPath: string,
  traceString: string,
  replayTraceString: string
): TestReport {
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

async function runOnlineTests(names: string[], options) {
  if (names.length === 0) {
    return;
  }
  console.log("================");
  console.log("Run online tests");
  console.log("================");
  console.log("WARNING: You need a working internet connection");
  console.log(
    "WARNING: Tests depend on third party websites. If those websites changed since this testsuite was created, it might not work"
  );
  // ignore specific tests
  names = names.filter((n) => !online_filter.includes(n));
  let successfull = 0;
  let roundTripTimes = [];
  for (let name of names) {
    const spinner = startSpinner(name);
    const testPath = path.join(process.cwd(), "tests", "online", name);
    const cleanUpPerformance = await initPerformance(
      name,
      "online-auto-test",
      path.join(testPath, "performance.ndjson")
    );
    await cleanUp(testPath);
    let report;
    if (options.customFrontend) {
      report = await testWebPageCustomInstrumentation(testPath, options);
    } else {
      report = await testWebPage(testPath, options);
    }
    stopSpinner(spinner);
    cleanUpPerformance();
    await writeReport(name, report);
    if (report.success === true) {
      successfull++;
    }
    if (report.roundTripTime !== undefined) {
      roundTripTimes.push(report.roundTripTime);
    }
  }
  writeSummary("online", names.length, successfull, roundTripTimes);
  if (successfull !== names.length) {
    process.exit(1);
  }
}

async function runOfflineTests(names: string[], options) {
  if (names.length === 0) {
    return;
  }
  console.log("=================");
  console.log("Run offline tests");
  console.log("=================");
  // ignore specific tests
  names = names.filter((n) => !offline_filter.includes(n));
  let successfull = 0;
  let roundTripTimes = [];
  for (let name of names) {
    const spinner = startSpinner(name);
    const testPath = path.join(process.cwd(), "tests", "offline", name);
    const websitePath = path.join(testPath, "website");
    await cleanUp(testPath);
    const server = await startServer(websitePath);
    let report;
    if (options.customFrontend) {
      report = await testWebPageCustomInstrumentation(testPath, options);
    } else {
      report = await testWebPage(testPath, options);
    }
    server.close();
    stopSpinner(spinner);
    await writeReport(name, report);
    if (report.success === true) {
      successfull++;
    }
    if (report.roundTripTime !== undefined) {
      roundTripTimes.push(report.roundTripTime);
    }
  }
  writeSummary("offline", names.length, successfull, roundTripTimes);
}

type Success = { success: true };
type Failure = { success: false; reason: string };
type TestReport = { testPath: string; roundTripTime?: DOMHighResTimeStamp } & (
  | Success
  | Failure
);
async function writeReport(name: string, report: TestReport) {
  writeWithSpaces(name);
  const testReportPath = path.join(report.testPath, "report.txt");
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

function startServer(websitePath: string): Promise<Server> {
  const app = express();
  const port = 8000;
  app.use(express.static(websitePath));
  return new Promise((resolve) => {
    const server = app.listen(port, () => {
      resolve(server);
    });
  });
}

async function testWebPageCustomInstrumentation(
  testPath: string,
  options
): Promise<TestReport> {
  const testJsPath = path.join(testPath, "test.js");
  const benchmarkPath = path.join(testPath, frontend);

  let analysisResult: AnalysisResult;
  try {
    const analyser = new CustomAnalyser(benchmarkPath, options);
    const test = await import(testJsPath);
    analysisResult = await test.default(analyser);
    const subBenchmarkNames = await fs.readdir(benchmarkPath);
    if (subBenchmarkNames.length === 0) {
      return {
        testPath,
        success: false,
        reason: "No benchmark has been generated",
      };
    }
    for (let subBenchmark of subBenchmarkNames) {
      const traceFilePath = path.join(benchmarkPath, subBenchmark, "trace.bin");
      const traceTextPath = path.join(benchmarkPath, subBenchmark, "trace.r3");
      const replayTracePath = path.join(
        benchmarkPath,
        subBenchmark,
        "trace-replay.bin"
      );
      const replayTextTracePath = path.join(
        benchmarkPath,
        subBenchmark,
        "trace-replay.r3"
      );
      const wasmPath = path.join(benchmarkPath, subBenchmark, "index.wasm");
      const replayPath = path.join(benchmarkPath, subBenchmark, "replay.js");
      execSync(
        `./target/release/replay_gen stringify ${traceFilePath} ${wasmPath} ${traceTextPath}`
      );
      let runtime = await fs.readFile("./dist/node-runtime.js", "utf-8");
      let replay = await fs.readFile(replayPath, "utf-8");
      await fs.rm(replayPath);
      await fs.writeFile(replayPath, `${replay};\n${runtime};`);
      let replayBinary = await import(replayPath);
      let check_mem = replayBinary.setup(replayTracePath);
      let wasmBinary = fss.readFileSync(wasmPath);
      let wasm = await replayBinary.instantiate(wasmBinary);
      replayBinary.replay(wasm);
      check_mem();
      execSync(
        `./target/release/replay_gen stringify ${replayTracePath} ${wasmPath} ${replayTextTracePath}`
      );
      let traceString = await fs.readFile(traceTextPath, "utf-8");
      traceString = trimFromLastOccurance(traceString, 'FuncExit')
      let replayTraceString = await fs.readFile(replayTextTracePath, "utf-8");
      const comparison = compareResults(
        testPath,
        traceString,
        replayTraceString
      );
      return comparison;
    }
  } catch (e) {
    return { testPath, success: false, reason: e.stack };
  }
}

async function testWebPage(testPath: string, options): Promise<TestReport> {
  const testJsPath = path.join(testPath, "test.js");
  const benchmarkPath = path.join(testPath, frontend);
  let analysisResult: AnalysisResult;
  try {
    const p_roundTrip = createMeasure("round-trip time", {
      description:
        "The time it takes to start the browser instance, load the webpage, record the interaction, download the data, and generate the replay",
      phase: "all",
    });
    const analyser = new Analyser("./dist/src/tracer.cjs", options);
    analysisResult = await (await import(testJsPath)).default(analyser);
    const blockExtended = analyser.getExtended();

    // Sometimes during record we stop in the middle of wasm execution
    // we will generate the replay correctly, but it will run until the end
    // so we will end up with a longer replay trace.
    // Thats why we trim our trace to the position where the last wasm routine was finished
    for (let i = 0; i <= analysisResult.length - 1; i++) {
      analysisResult[i].result = trimFromLastOccurance(analysisResult[i].result, 'ER')
    }

    if (analysisResult.every(item => item.result == "")) {
      return {
        testPath,
        roundTripTime: undefined,
        success: false,
        reason: "empty benchmark generated",
      };
    }
    // process.stdout.write(` -e not available`)
    const benchmark = Benchmark.fromAnalysisResult(analysisResult);
    await benchmark.save(benchmarkPath, options);
    let m = p_roundTrip();
    let roundTripTime = m.duration;
    let subBenchmarkNames = await getDirectoryNames(benchmarkPath);
    if (subBenchmarkNames.length === 0) {
      return {
        testPath,
        roundTripTime,
        success: false,
        reason: "no benchmark was generated",
      };
    }
    let runtimes = benchmark.instrumentBinaries();
    // await copyDir(benchmarkPath, testBenchmarkPath)
    let results: any = { testPath, success: true };
    const record = benchmark.getRecord();
    for (let i = 0; i < record.length; i++) {
      const subBenchmarkPath = path.join(benchmarkPath, subBenchmarkNames[i]);
      const tracePath = path.join(subBenchmarkPath, "trace.r3");
      const refTracePath = path.join(subBenchmarkPath, "trace-ref.r3");
      await fs.rename(tracePath, refTracePath);
      const pureJsPath = path.join(subBenchmarkPath, "pure.js");
      const replayTracePath = path.join(subBenchmarkPath, "trace-replay.r3");
      const statsJsonPath = path.join(subBenchmarkPath, "stats.json");
      let tracer = new Tracer(eval(runtimes[i] + `\nWasabi`), {
        extended: blockExtended,
      });
      let replayBinary;
      try {
        replayBinary = await import(pureJsPath);
      } catch {
        throw new Error(
          "Apparently this is too stupid to parse the replay file. Even tho it should be written by now"
        );
      }
      const wasm = await replayBinary.instantiate(
        Buffer.from(record[i].binary)
      );
      tracer.init();
      await replayBinary.replay(wasm);
      let traceString = record[i].trace.toString();
      let replayTraceString = tracer.getResult().toString();
      await fs.writeFile(replayTracePath, replayTraceString);

      // 5. Check if original trace and replay trace match
      const newResult = compareResults(
        testPath,
        traceString,
        replayTraceString
      );
      results.roundTripTime = roundTripTime;
      if (newResult.success === false) {
        results.success = false;
        if (results.reason === undefined) {
          results.reason = "";
        }
        results.reason += `\n\n${newResult.reason}`;
      }
    }
    return results;
  } catch (e: any) {
    return { testPath, success: false, reason: e.stack };
  }
}

(async function run() {
  const optionDefinitions = [
    { name: "category", type: String, multiple: true, defaultOption: true },
    { name: "testcases", alias: "t", type: String, multiple: true },
    { name: "port", alias: "p", type: Number },
    { name: "customFrontend", alias: "c", type: Boolean },
    { name: "firefoxFrontend", alias: "f", type: Boolean },
    { name: "webkitFrontend", alias: "w", type: Boolean },
    { name: "jsBackend", alias: "j", type: Boolean },
    { name: "legacyBackend", alias: "l", type: Boolean },
    { name: "noRecord", type: Boolean },
    { name: "evalRecord", type: Boolean },
  ];
  const options = commandLineArgs(optionDefinitions);
  if (options.customFrontend === true) {
    frontend = "custom";
  } else if (options.firefoxFrontend === true) {
    frontend = "firefox";
  } else if (options.webkitFrontend === true) {
    frontend = "webkit";
  } else {
    frontend = "benchmark";
  }
  if (options.category === undefined || options.category.includes("node")) {
    let testNames = await getDirectoryNames(
      path.join(process.cwd(), "tests", "node")
    );
    if (options.testcases !== undefined) {
      testNames = testNames.filter((n) => options.testcases.includes(n));
    }
    await runNodeTests(testNames, options);
  }
  if (options.category === undefined || options.category.includes("offline")) {
    let testNames = await getDirectoryNames(
      path.join(process.cwd(), "tests", "offline")
    );
    if (options.testcases !== undefined) {
      testNames = testNames.filter((n) => options.testcases.includes(n));
    }
    await runOfflineTests(testNames, options);
  }
  if (options.category === undefined || options.category.includes("online")) {
    let testNames = await getDirectoryNames(
      path.join(process.cwd(), "tests", "online")
    );
    if (options.testcases !== undefined) {
      testNames = testNames.filter((n) => options.testcases.includes(n));
    }
    await runOnlineTests(testNames, options);
  }
  if (options.category === undefined || options.category.includes("slicedice")) {
    let testNames = await getDirectoryNames(
      path.join(process.cwd(), "benchmarks")
    );
    if (options.testcases !== undefined) {
      testNames = testNames.filter((n) => options.testcases.includes(n));
    }
    await runSliceDiceTests(testNames, options);
  }
})();

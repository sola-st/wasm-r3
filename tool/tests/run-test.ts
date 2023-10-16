import fs from "fs";
import path from "path";
import cp from "child_process";
import _ from 'lodash'
import Generator from "../src/replay-generator";
import parse from "../src/trace-parse";
import stringify from "../src/trace-stringify";
import { Wasabi } from '../wasabi'

const testDir = import.meta.dir;

let testNames = getDirectoryNames(testDir);
if (process.argv[2] === "clean") {
  for (let name of testNames) {
    const testPath = path.join(testDir, name);
    rmSafe(path.join(testPath, "gen.js"));
    rmSafe(path.join(testPath, "replayGen.js"));
    rmSafe(path.join(testPath, "index.wasabi.js"));
    rmSafe(path.join(testPath, "index.wasm"));
    rmSafe(path.join(testPath, "trace.r3"));
    rmSafe(path.join(testPath, "replay-trace.r3"));
    rmSafe(path.join(testPath, "replay.js"));
    rmSafe(path.join(testPath, "report.txt"));
    rmSafe(path.join(testPath, "long.js"));
  }
  process.exit(0);
}
if (process.argv.length > 2) {
  testNames = testNames.filter((n) => process.argv.includes(n));
}

// ignore specific tests
const filter = ['exported-called-param', 'glob-imp-host-mod', 'table-exp-host-mod']
testNames = testNames.filter((n) => !filter.includes(n))

// testNames = ["mem-exp-host-grow-no-return"]

process.stdout.write(`Executing Tests ... \n`);
for (let name of testNames) {
  process.stdout.write(writeTestName(name));
  const testPath = path.join(testDir, name);
  const testJsPath = path.join(testPath, 'test.js')
  const watPath = path.join(testPath, "index.wat");
  const wasmPath = path.join(testPath, "index.wasm");
  const wasabiRuntimePath = path.join(testPath, "index.wasabi.js");
  const tracerPath = path.join(testDir, "../src/tracer.js");
  const tracePath = path.join(testPath, "trace.r3");
  const replayPath = path.join(testPath, "replay.js");
  const replayTracePath = path.join(testPath, "replay-trace.r3");
  const testReportPath = path.join(testPath, "report.txt");

  // 1. Generate trace
  cp.execSync(`wat2wasm ${watPath} -o ${wasmPath}`);
  // cp.execSync(`wasabi ${wasmPath} --node --hooks=begin,store,load,call -o ${testPath}`);
  cp.execSync(`cd /Users/jakob/Desktop/wasabi-fork/crates/wasabi && cargo run ${wasmPath} --node --hooks=begin,store,load,call,return -o ${testPath}`);
  removeLinesWithConsole(wasabiRuntimePath)
  revertMonkeyPatch(wasabiRuntimePath)
  let trace = require(tracerPath).default(wasabiRuntimePath);
  try {
    await import(testJsPath)
  } catch (e: any) {
    fail(e.toString(), testReportPath)
    continue;
  }
  //@ts-ignore
  delete require.cache[wasabiRuntimePath]
  //@ts-ignore
  delete require.cache[testJsPath]
  let detailedTrace = detailedTracer(wasabiRuntimePath)
  try {
    await import(testJsPath)
  } catch (e: any) {
    fail(e.toString(), testReportPath);
    continue;
  }
  //@ts-ignore
  delete require.cache[wasabiRuntimePath]
  //@ts-ignore
  delete require.cache[tracerPath]
  //@ts-ignore
  delete require.cache[testJsPath]
  let traceString = stringify(trace);
  fs.writeFileSync(tracePath, traceString);

  // 2. Generate replay binary
  try {
    trace = parse(traceString)
  } catch (e: any) {
    fail(e.toString(), testReportPath)
    continue
  }
  let replayCode
  try {
    replayCode = new Generator().generateReplay(trace!).stringify()
  } catch (e: any) {
    fail(e.toString(), testReportPath)
    continue
  }
  fs.writeFileSync(replayPath, replayCode!)

  // 3. Execute replay
  let replayTrace = require(tracerPath).default(wasabiRuntimePath);
  try {
    await import(replayPath);
  } catch (e: any) {
    fail(e.toString(), testReportPath);
    continue;
  }
  //@ts-ignore
  delete require.cache[wasabiRuntimePath]
  //@ts-ignore
  delete require.cache[tracerPath]
  //@ts-ignore
  delete require.cache[replayPath]
  let replayDetailedTrace = detailedTracer(wasabiRuntimePath)
  try {
    await import(replayPath)
  } catch (e: any) {
    fail(e.toString(), testReportPath);
    continue;
  }
  //@ts-ignore
  delete require.cache[wasabiRuntimePath]
  //@ts-ignore
  delete require.cache[tracerPath]
  //@ts-ignore
  delete require.cache[replayPath]

  // 4. Check if original trace and replay trace match
  let replayTraceString = stringify(replayTrace);
  fs.writeFileSync(replayTracePath, replayTraceString);
  if (replayTraceString !== traceString) {
    let report = `[Expected]\n`;
    report += traceString;
    report += `\n\n`;
    report += `[Actual]\n`;
    report += replayTraceString;
    fail(report, testReportPath);
    continue
  }

  // 5. Check if the computing results of the original and replay execution match
  if (!_.isEqual(detailedTrace, replayDetailedTrace)) {
    let report = `Detailed Traces do not match! \n\n`
    report += `How about putting a breakpoint at the testrunner to compare the traces\n`
    report += `in the debugger, because I do not stringify them.\n\n`
    report += `[Expected]\n`;
    report += detailedTrace.toString();
    report += `\n\n`;
    report += `[Actual]\n`;
    report += replayDetailedTrace.toString();
    fail(report, testReportPath);
  } else {
    process.stdout.write(`\u2713\n`);
  }
}
process.stdout.write(`done running ${testNames.length} tests\n`);

function removeLinesWithConsole(filePath: string) {
  let s = fs.readFileSync(filePath, 'utf-8')
  const lines = s.split("\n");
  const filteredLines = lines.filter((line) => !line.includes("console"));
  fs.writeFileSync(filePath, filteredLines.join("\n"));
}

function revertMonkeyPatch(filePath: string) {
  let s = fs.readFileSync(filePath, 'utf-8')
  const lines = s.split('\n')
  lines.splice(172, 0, 'WebAssembly.instantiate = oldInstantiate')
  fs.writeFileSync(filePath, lines.join('\n'))
}

function getDirectoryNames(folderPath: string) {
  const entries = fs.readdirSync(folderPath, { withFileTypes: true });

  const directories = entries
    .filter((entry) => entry.isDirectory())
    .map((entry) => entry.name);

  return directories;
}

function fail(report: string, testReportPath: string) {
  process.stdout.write(`\u2717\t\t${testReportPath}\n`);
  fs.writeFileSync(testReportPath, report);
}

function writeTestName(name: string) {
  const totalLength = 40;
  if (totalLength < name.length) {
    throw "Total length should be greater than or equal to the length of the initial word.";
  }
  const spacesLength = totalLength - name.length;
  const spaces = " ".repeat(spacesLength);
  return `${name}${spaces}`;
}

function rmSafe(path: string) {
  try {
    fs.rmSync(path);
  } catch {
    // file doesnt exist, ok
  }
}

/**
 * This function returns another trace of the program which contains additional information
 * about the program runtime. This is used to additionally test the equivalence of the original
 * program and the replay
 * 
 * TODO
 */
function detailedTracer(runtimePath: string) {
  const Wasabi: Wasabi = require(runtimePath)
  let trace: any[] = []
  Wasabi.analysis = {
    return_(location, values) {
      trace.push(values)
    },
    begin(location, type) {
      if (type === 'function')
        if (Wasabi.module.memories.length === 1) {
          trace.push(_.cloneDeep(new Uint8Array(Wasabi.module.memories[0].buffer)))
        }
    }
  }
  return trace
}

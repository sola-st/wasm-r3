import fs from "fs";
import path from "path";
import cp from "child_process";
import _ from 'lodash'
import Generator from "../src/replay-generator";
import parse from "../src/trace-parse";
import stringify from "../src/trace-stringify";
import { Wasabi } from '../wasabi'
import { getDirectoryNames } from "./test-utils";

const tracerPath = path.join(import.meta.dir, "../src/tracer.js");

let testNames = getDirectoryNames(import.meta.dir);
// parse cli arguments, you can specify the specific testcases you want to run
if (process.argv.length > 2) {
  testNames = testNames.filter((n) => process.argv.includes(n));
}

// ignore specific tests
const filter = ['exported-called-param', 'table-exp-host-mod-multiple', 'table-exp-host-mod']
testNames = testNames.filter((n) => !filter.includes(n))

// if you want to run a specific test just uncomment below line and put your test
// testNames = ["call-imported-params"]

process.stdout.write(`Executing Tests ... \n`);
for (let name of testNames) {
  process.stdout.write(writeTestName(name));
  const testPath = path.join(import.meta.dir, name);
  const testJsPath = path.join(testPath, 'test.js')
  const watPath = path.join(testPath, "index.wat");
  const wasmPath = path.join(testPath, "index.wasm");
  const wasabiRuntimePath = path.join(testPath, "index.wasabi.js");
  const tracePath = path.join(testPath, "trace.r3");
  const replayPath = path.join(testPath, "replay.js");
  const replayTracePath = path.join(testPath, "replay-trace.r3");
  const testReportPath = path.join(testPath, "report.txt");

  // 1. Instrument with Wasabi !!Please use the newest version
  cp.execSync(`wat2wasm ${watPath} -o ${wasmPath}`);
  // cp.execSync(`wasabi ${wasmPath} --node --hooks=begin,store,load,call,memory_grow -o ${testPath}`);
  cp.execSync(`cd /Users/jakob/Desktop/wasabi-fork/crates/wasabi && cargo run ${wasmPath} --node --hooks=begin,store,load,call,return,global,memory_grow -o ${testPath}`);

  // 2. Execute test and generate trace as well as call graph
  let trace = await require(tracerPath).default(wasabiRuntimePath);
  try {
    await import(testJsPath)
  } catch (e: any) {
    fail(e.toString(), testReportPath)
    continue;
  }
  deleteRequireCaches()
  let traceString = stringify(trace);
  fs.writeFileSync(tracePath, traceString);

  let callGraph = callGraphConstructor(wasabiRuntimePath)
  try {
    await import(testJsPath)
  } catch (e: any) {
    fail(e.toString(), testReportPath);
    continue;
  }
  deleteRequireCaches()

  // 3. Generate replay binary
  try {
    trace = parse(traceString)
  } catch (e: any) {
    fail(e.toString(), testReportPath)
    continue
  }
  let replayCode
  try {
    replayCode = new Generator().generateReplay(trace).toString()
  } catch (e: any) {
    fail(e.toString(), testReportPath)
    continue
  }
  fs.writeFileSync(replayPath, replayCode)

  // 4. Execute replay and generate trace as well as call graph
  let replayTrace = require(tracerPath).default(wasabiRuntimePath);
  try {
    await import(replayPath);
  } catch (e: any) {
    fail(e.toString(), testReportPath);
    continue;
  }
  deleteRequireCaches()
  let replayTraceString = stringify(replayTrace);

  let replayCallGraph = callGraphConstructor(wasabiRuntimePath)
  try {
    await import(replayPath)
  } catch (e: any) {
    fail(e.toString(), testReportPath);
    continue;
  }
  deleteRequireCaches()

  // 5. Check if original trace and replay trace match
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

  // 6. Check if the computing results of the original and replay execution match
  if (!_.isEqual(callGraph, replayCallGraph)) {
    let report = `Call graphs do not match! \n\n`
    report += `[Expected]\n`;
    report += stringifyCallGraph(callGraph);
    report += `\n\n`;
    report += `[Actual]\n`;
    report += stringifyCallGraph(replayCallGraph);
    fail(report, testReportPath);
  }
  fs.writeFileSync(testReportPath, 'Test successfull')
  process.stdout.write(`\u2713\n`);

  function deleteRequireCaches() {
    delete (require as NodeJS.Require & { cache: any }).cache[wasabiRuntimePath]
    delete (require as NodeJS.Require & { cache: any }).cache[tracerPath]
    delete (require as NodeJS.Require & { cache: any }).cache[testJsPath]
    delete (require as NodeJS.Require & { cache: any }).cache[replayPath]
  }
}
process.stdout.write(`done running ${testNames.length} tests\n`);

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

type FromInit = { funcidx: 'h', host: true }
type FromHost = { funcidx: number, host: true }
type FromWasm = { funcidx: number, host: false }
type FromNode = FromInit | FromHost | FromWasm
type ToFromHost = { funcidx: number, host: false, memSizes: number[], tableSizes: number[] }
type ToFromWasm = { funcidx: number, host: boolean }
type Edge = {
  params: number[],
} & (
    | { from: FromInit, to: ToFromHost }
    | { from: FromHost, to: ToFromHost }
    | { from: FromWasm, to: ToFromWasm }
  )
type CallGraph = Edge[]

function callGraphConstructor(runtimePath: string) {

  let from: FromNode = { funcidx: 'h', host: true }
  let inHost: boolean | null = null
  let callGraph: CallGraph = []
  const Wasabi: Wasabi = require(runtimePath)
  Wasabi.analysis = {
    call_pre(locatation, targetFunc, args, indirectTableIdx) {
      inHost = Wasabi.module.info.functions.filter(f => f.import !== null).length <= locatation.func
      if (inHost) {
        let from: FromWasm = {
          funcidx: locatation.func,
          host: false as false,
        }
        let to = {
          funcidx: targetFunc,
          params: args,
          host: true,
        }
        callGraph.push({ from, params: args, to })
      }
      from = {
        funcidx: targetFunc,
        host: true,
      }
    },
    begin_function(location, args) {
      if (from.funcidx === 'h') {
        let from: FromInit = {
          funcidx: 'h' as 'h',
          host: true as true
        }
        let to: ToFromHost = {
          funcidx: location.func,
          host: false as false,
          memSizes: Wasabi.module.memories.map(m => m.buffer.byteLength),
          tableSizes: Wasabi.module.tables.map(t => t.length),
        }
        callGraph.push({ from, params: args, to })
        return
      }
      if (from.host) {
        let to: ToFromHost = {
          funcidx: location.func,
          host: false,
          memSizes: Wasabi.module.memories.map(m => m.buffer.byteLength),
          tableSizes: Wasabi.module.tables.map(t => t.length)
        }
        callGraph.push({ from, params: args, to })
        return
      }
      let to: ToFromWasm = {
        funcidx: location.func,
        host: false,
      }
      callGraph.push({ from, params: args, to })
    }
  }
  return callGraph
}

function stringifyCallGraph(callGraph: CallGraph) {
  let s = 'How to read this graph: $from -> [$params] -> $to [$memSizes] [$tableSizes]\n'
  callGraph.forEach((edge, i) => {
    s += `${i}: ${edge.from.funcidx} -> [${edge.params}] -> ${edge.to.funcidx}\t`
    if (edge.from.host) {
      s += `[${(edge.to as ToFromHost).memSizes}] [${(edge.to as ToFromHost).tableSizes}]`
    }
    s += `\n`
  })
  return s
}
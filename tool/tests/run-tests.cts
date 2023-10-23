import fs from "fs";
import path from "path";
import cp from "child_process";
import _ from 'lodash'
import Generator from "../src/replay-generator.cjs";
import parse from "../src/trace-parse.cjs";
import stringify from "../src/trace-stringify.cjs";
import { Wasabi } from '../wasabi.cjs'
import { getDirectoryNames } from "./test-utils.cjs";

async function run() {
  const tracerPath = path.join(process.cwd(), 'dist', "./src/tracer.cjs");

  let testNames = getDirectoryNames(path.join(process.cwd(), 'tests'));
  // parse cli arguments, you can specify the specific testcases you want to run
  if (process.argv.length > 2) {
    testNames = testNames.filter((n) => process.argv.includes(n));
  }

  // ignore specific tests because wasabi does not support this yet
  // let filter = ['table-exp-host-mod-multiple', 'table-exp-host-mod', 'call-indirect']
  // testNames = testNames.filter((n) => !filter.includes(n))

  // ignore specific tests
  let filter2 = [
    'rust-tictactoe',
    'mem-exp-vec-store-no-host-mod',
    'mem-exp-init-no-host-mod',
    'mem-exp-copy-no-host-mod',
    'mem-exp-fill-no-host-mod'

  ]
  testNames = testNames.filter((n) => !filter2.includes(n))

  // if you want to run a specific test just uncomment below line and put your test
  testNames = ['table-exp-host-mod', 'table-exp-host-mod-multiple', 'call-indirect']

  process.stdout.write(`Executing Tests ... \n`);
  for (let name of testNames) {
    process.stdout.write(writeTestName(name));
    const testPath = path.join(process.cwd(), 'tests', name);
    const testJsPath = path.join(testPath, 'test.js')
    const watPath = path.join(testPath, "index.wat");
    const wasmPath = path.join(testPath, "index.wasm");
    const wasabiRuntimePathJS = path.join(testPath, "index.wasabi.js");
    const wasabiRuntimePath = path.join(testPath, "index.wasabi.cjs");
    const tracePath = path.join(testPath, "trace.r3");
    const callGraphPath = path.join(testPath, "call-graph.txt");
    const replayPath = path.join(testPath, "replay.js");
    const replayTracePath = path.join(testPath, "replay-trace.r3");
    const replayCallGraphPath = path.join(testPath, "replay-call-graph.txt");
    const testReportPath = path.join(testPath, "report.txt");

    // 1. Instrument with Wasabi !!Please use the newest version
    const indexRsPath = path.join(testPath, 'index.rs')
    const indexCPath = path.join(testPath, 'index.c')
    if (fileExists(indexRsPath)) {
      cp.execSync(`rustc --crate-type cdylib ${indexRsPath} --target wasm32-unknown-unknown --crate-type cdylib -o ${wasmPath}`, { stdio: 'ignore' })
      cp.execSync(`wasm2wat ${wasmPath} -o ${watPath}`)
    } else if (fileExists(indexCPath)) {

    } else {
      cp.execSync(`wat2wasm ${watPath} -o ${wasmPath}`);
    }
    // cp.execSync(`wat2wasm ${watPath} -o ${wasmPath}`);
    // cp.execSync(`wasabi ${wasmPath} --node --hooks=begin,store,load,call,memory_grow -o ${testPath}`);
    // cp.execSync(`cd /Users/jakob/Desktop/wasabi-fork/crates/wasabi && cargo run ${wasmPath} --node --hooks=begin,store,load,call,return,global,memory_grow,table_get,table_set -o ${testPath}`, { stdio: 'ignore' });
    cp.execSync(`cd /Users/jakob/Desktop/wasabi-fork/crates/wasabi && cargo run ${wasmPath} --node -o ${testPath}`, { stdio: 'ignore' });
    fs.renameSync(wasabiRuntimePathJS, wasabiRuntimePath)
    fs.renameSync(path.join(testPath, 'long.js'), path.join(testPath, 'long.cjs'))
    modifyRuntime(wasabiRuntimePath)

    // 2. Execute test and generate trace as well as call graph
    let trace = require(tracerPath).default(wasabiRuntimePath);
    // trace = await trace
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
    fs.writeFileSync(callGraphPath, stringifyCallGraph(callGraph))
    callGraph = undefined

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
    fs.writeFileSync(replayTracePath, replayTraceString);

    // let replayCallGraph = callGraphConstructor(wasabiRuntimePath)
    // try {
    //   await import(replayPath)
    // } catch (e: any) {
    //   fail(e.toString(), testReportPath);
    //   continue;
    // }
    // fs.writeFileSync(replayCallGraphPath, stringifyCallGraph(replayCallGraph))

    // 5. Check if original trace and replay trace match
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
    // if (!_.isEqual(callGraph, replayCallGraph)) {
    //   let report = `Call graphs do not match! \n\n`
    //   report += `[Expected]\n`;
    //   report += stringifyCallGraph(callGraph);
    //   report += `\n\n`;
    //   report += `[Actual]\n`;
    //   report += stringifyCallGraph(replayCallGraph);
    //   fail(report, testReportPath);
    //   continue
    // }
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
}
run()

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

function fileExists(filePath: string) {
  try {
    fs.accessSync(filePath); // This will throw an error if the file doesn't exist
    return true;
  } catch (error: any) {
    if (error.code === 'ENOENT') {
      return false;
    } else {
      throw error; // Handle other errors appropriately
    }
  }
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
      //@ts-ignore
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

function modifyRuntime(path: string) {
  let runtimeCode = fs.readFileSync(path, 'utf8')
  // runtimeCode = runtimeCode.replace(new RegExp('require', 'g'), 'await import');
  // runtimeCode = runtimeCode.replace(new RegExp('let Wasabi', 'g'), 'export let Wasabi');
  // runtimeCode = runtimeCode.replace(new RegExp('module.exports = Wasabi;', 'g'), '');
  // runtimeCode = runtimeCode.replace(new RegExp("const Long = ", 'g'), '');
  runtimeCode = runtimeCode.replace(new RegExp("const Long = require\(.*\);", 'g'), 'const Long = require("./long.cjs")');
  fs.writeFileSync(path, runtimeCode)
}
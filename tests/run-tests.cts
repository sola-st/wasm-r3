import fss from 'fs'
import fs from 'fs/promises'
import path from 'path'
const cp = require("child_process")
import express from 'express'
import Generator from "../src/replay-generator.cjs";
import parse from "../src/trace-parse.cjs";
import stringify from "../src/trace-stringify.cjs";
import setupTracer from "../src/tracer.cjs";
import { Wasabi } from '../wasabi.cjs'
import { getDirectoryNames } from "./test-utils.cjs";
import { Record, saveBenchmark } from '../src/benchmark.cjs';
import { instrument_wasm } from '/Users/jakob/Desktop/wasm-r3/dist/wasabi/wasabi_js.js'
import { Server } from 'http'

async function rmSafe(path: string) {
  try {
    await fs.rm(path, { recursive: true });
  } catch {
    // file doesnt exist, ok
  }
}

async function cleanUp(testPath: string) {
  await rmSafe(path.join(testPath, "gen.js"))
  await rmSafe(path.join(testPath, "replayGen.js"))
  await rmSafe(path.join(testPath, "index.wasabi.cjs"))
  await rmSafe(path.join(testPath, "index.wasm"))
  await rmSafe(path.join(testPath, "trace.r3"))
  await rmSafe(path.join(testPath, "replay-trace.r3"))
  await rmSafe(path.join(testPath, "replay.js"))
  await rmSafe(path.join(testPath, "report.txt"))
  await rmSafe(path.join(testPath, "long.js"))
  await rmSafe(path.join(testPath, "call-graph.txt"))
  await rmSafe(path.join(testPath, "replay-call-graph.txt"))
  await rmSafe(path.join(testPath, "long.cjs"))
  await rmSafe(path.join(testPath, 'benchmark'))
  await rmSafe(path.join(testPath, 'test-benchmark'))
}

const tracerPath = path.join(process.cwd(), 'dist', "./src/tracer.cjs");

async function runNodeTest(name: string): Promise<TestReport> {
  const testPath = path.join(process.cwd(), 'tests', 'node', name)
  await cleanUp(testPath)
  const testJsPath = path.join(testPath, 'test.js')
  const watPath = path.join(testPath, "index.wat");
  const wasmPath = path.join(testPath, "index.wasm");
  const tracePath = path.join(testPath, "trace.r3");
  const callGraphPath = path.join(testPath, "call-graph.txt");
  const replayPath = path.join(testPath, "replay.js");
  const replayTracePath = path.join(testPath, "replay-trace.r3");
  const replayCallGraphPath = path.join(testPath, "replay-call-graph.txt");
  await cleanUp(testPath)

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
  // const wasabiCommand = `wasabi ${wasmPath} --node -o ${testPath}`
  // cp.execSync(wasabiCommand, { stdio: 'ignore' });
  // fss.renameSync(wasabiRuntimePathJS, wasabiRuntimePath)
  // fss.renameSync(path.join(testPath, 'long.js'), path.join(testPath, 'long.cjs'))
  // modifyRuntime(wasabiRuntimePath)
  // const wat = await fs.readFile(watPath)
  // const wabtModule = await wabt()
  // const binary = wabtModule.parseWat(watPath, wat).toBinary({})
  const binary = await fs.readFile(wasmPath)
  const { instrumented, js } = instrument_wasm({ original: binary })
  fss.writeFileSync(wasmPath, Buffer.from(instrumented))

  // 2. Execute test and generate trace as well as call graph

  let trace = setupTracer(eval(js + `\nWasabi`))
  try {
    await import(testJsPath)
  } catch (e: any) {
    return { testPath, success: false, reason: e.stack }
  }
  let traceString = stringify(trace);
  fss.writeFileSync(tracePath, traceString);

  // let callGraph = callGraphConstructor(eval(js + `\nWasabi`))
  // delete (require as NodeJS.Require & { cache: any }).cache[testJsPath]
  // try {
  //   await import(testJsPath)
  // } catch (e: any) {
  //   return { testPath, success: false, reason: e.stack }
  // }
  // await fs.writeFile(callGraphPath, stringifyCallGraph(callGraph))
  // callGraph = undefined

  // 3. Generate replay binary
  try {
    trace = parse(traceString)
  } catch (e: any) {
    return { testPath, success: false, reason: e.stack }
  }
  let replayCode
  try {
    replayCode = new Generator().generateReplay(trace).toString()
  } catch (e: any) {
    return { testPath, success: false, reason: e.stack }
  }
  fss.writeFileSync(replayPath, replayCode)

  // 4. Execute replay and generate trace as well as call graph
  let replayTrace = setupTracer(eval(js + `\nWasabi`))
  try {
    await import(replayPath);
  } catch (e: any) {
    return { testPath, success: false, reason: e.stack }
  }
  let replayTraceString = stringify(replayTrace);
  fss.writeFileSync(replayTracePath, replayTraceString);

  // let replayCallGraph = callGraphConstructor(eval(js + `\nWasabi`))
  // delete (require as NodeJS.Require & { cache: any }).cache[replayPath]
  // try {
  //   await import(replayPath)
  // } catch (e: any) {
  //   return { testPath, success: false, reason: e.stack }
  // }
  // await fs.writeFile(replayCallGraphPath, stringifyCallGraph(replayCallGraph))

  // 5. Check if original trace and replay trace match
  return compareTraces(testPath, traceString, replayTraceString)

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
}

async function runNodeTests(names: string[]) {

  // ignore specific tests
  let filter2 = [
    'rust-tictactoe',
    'mem-exp-vec-store-no-host-mod',
    'mem-exp-init-no-host-mod',
    'mem-exp-copy-no-host-mod',
    'mem-exp-fill-no-host-mod',
    'mem-exp-host-mod-load-vec',
    'table-imp-init-max',
    'table-exp-host-mod',
    'table-exp-host-grow',
  ]
  names = names.filter((n) => !filter2.includes(n))

  for (let name of names) {
    await writeReport(name, await runNodeTest(name))
  }
}

function compareTraces(testPath: string, traceString: string, replayTraceString: string): TestReport {
  if (replayTraceString !== traceString) {
    let reason = `[Expected]\n`;
    reason += traceString;
    reason += `\n\n`;
    reason += `[Actual]\n`;
    reason += replayTraceString;
    return { testPath, success: false, reason }
  }
  return { testPath, success: true }
}

async function runOnlineTests(names: string[]) {
  for (let name of names) {
    await writeReport(name, await runOnlineTest(name))
  }
}

async function runOnlineTest(name: string) {
  const testPath = path.join(process.cwd(), 'tests', 'online', name)
  await cleanUp(testPath)
  return testWebPage(testPath)
}

async function runOfflineTests(names: string[]) {
  for (let name of names) {
    await writeReport(name, await runOfflineTest(name))
  }
}

type Success = { success: true }
type Failure = { success: false, reason: string }
type TestReport = { testPath: string } & (Success | Failure)
async function writeReport(name: string, report: TestReport) {
  const totalLength = 40;
  if (totalLength < name.length) {
    throw "Total length should be greater than or equal to the length of the initial word.";
  }
  const spacesLength = totalLength - name.length;
  const spaces = " ".repeat(spacesLength);
  process.stdout.write(`${name}${spaces}`)
  const testReportPath = path.join(report.testPath, 'report.txt')
  if (report.success === true) {
    await fs.writeFile(testReportPath, 'Test successfull')
    process.stdout.write(`\u2713\n`)
  } else {
    process.stdout.write(`\u2717\t\t${testReportPath}\n`)
    await fs.writeFile(testReportPath, report.reason)
  }
}

function startServer(websitePath: string): Promise<Server> {
  const app = express()
  const port = 8000
  app.use(express.static(websitePath))
  return new Promise(resolve => {
    const server = app.listen(port, () => {
      resolve(server);
    });
  })
}

async function runOfflineTest(name: string): Promise<TestReport> {
  const testPath = path.join(process.cwd(), 'tests', 'offline', name)
  const websitePath = path.join(testPath, 'website')
  await cleanUp(testPath)
  const server = await startServer(websitePath)
  let report = await testWebPage(testPath)
  server.close()
  return report
}

async function testWebPage(testPath: string): Promise<TestReport> {
  const testJsPath = path.join(testPath, 'test.js')
  const benchmarkPath = path.join(testPath, 'benchmark')
  const testBenchmarkPath = path.join(testPath, 'test-benchmark')
  let record: Record
  try {
    record = await (await import(testJsPath)).default()
  } catch (e: any) {
    return { testPath, success: false, reason: e.stack }
  }
  await saveBenchmark(benchmarkPath, record)
  let subBenchmarkNames = getDirectoryNames(benchmarkPath)
  if (subBenchmarkNames.length === 0) {
    return { testPath, success: false, reason: 'no benchmark was generated' }
  }
  let Wasabi
  record = record.map(({ binary, trace }) => {
    const out = instrument_wasm({ original: binary })
    binary = out.instrumented
    Wasabi = eval(out.js + `\nWasabi`)
    return { binary, trace }
  })
  await saveBenchmark(testBenchmarkPath, record, { trace: false })
  for (let i = 0; i < subBenchmarkNames.length; i++) {
    const subBenchmarkPath = path.join(testBenchmarkPath, subBenchmarkNames[i])
    const replayPath = path.join(subBenchmarkPath, 'replay.js')
    const replayTracePath = path.join(subBenchmarkPath, 'trace.r3')
    let replayTrace = setupTracer(Wasabi)
    await import(replayPath)
    let traceString = stringify(record[i].trace)
    let replayTraceString = stringify(replayTrace);
    await fs.writeFile(replayTracePath, replayTraceString);

    // 5. Check if original trace and replay trace match
    if (replayTraceString !== traceString) {
      let reason = `[Expected]\n`;
      reason += traceString;
      reason += `\n\n`;
      reason += `[Actual]\n`;
      reason += replayTraceString;
      return { testPath, success: false, reason: reason }
    }
  }
  return { testPath, success: true }
}

(async function run() {
  console.log('==============')
  console.log('Run node tests')
  console.log('==============')
  let nodeTestNames = getDirectoryNames(path.join(process.cwd(), 'tests', 'node'));
  await runNodeTests(nodeTestNames)
  console.log('=================')
  console.log('Run offline tests')
  console.log('=================')
  let offlineTestNames = getDirectoryNames(path.join(process.cwd(), 'tests', 'offline'))
  await runOfflineTests(offlineTestNames)
  console.log('================')
  console.log('Run online tests')
  console.log('================')
  console.log('WARNING: You need a working internet connection')
  console.log('WARNING: Tests depend on third party websites. If those websites changed since this testsuite was created, it might not work')
  let webTestNames = getDirectoryNames(path.join(process.cwd(), 'tests', 'online'));
  await runOnlineTests(webTestNames)
  // process.stdout.write(`done running ${nodeTestNames.length + webTestNames.length} tests\n`);
})()

function fileExists(filePath: string) {
  try {
    fss.accessSync(filePath); // This will throw an error if the file doesn't exist
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

function callGraphConstructor(Wasabi: Wasabi) {
  let from: FromNode = { funcidx: 'h', host: true }
  let inHost: boolean | null = null
  let callGraph: CallGraph = []
  // delete (require as NodeJS.Require & { cache: any }).cache[runtimePath]
  Wasabi.analysis = {
    call_pre(locatation, op, targetFunc, args, tableTarget) {
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
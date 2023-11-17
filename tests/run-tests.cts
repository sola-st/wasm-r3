import fss from 'fs'
import fs from 'fs/promises'
import path from 'path'
const cp = require("child_process")
import express from 'express'
import Generator from "../src/replay-generator.cjs";
import stringify from "../src/trace-stringify.cjs";
import Trace from "../src/tracer.cjs";
import CallGraph from '../src/callgraph.cjs'
import { getDirectoryNames } from "./test-utils.cjs";
import { fromAnalysisResult, saveBenchmark } from '../src/benchmark.cjs';
//@ts-ignore
import { instrument_wasm } from '../wasabi/wasabi_js.js'
import { Server } from 'http'
import Analyser, { AnalysisResult } from '../src/analyser.cjs'

let generateCallGraphs = false
const tracerPath = path.join(process.cwd(), 'dist', "./src/tracer.cjs");

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
  let { instrumented, js } = instrument_wasm({ original: binary })
  fss.writeFileSync(wasmPath, Buffer.from(instrumented))

  // 2. Execute test and generate trace as well as call graph
  const wasmBinary = await fs.readFile(wasmPath)
  let trace = new Trace(eval(js + `\nWasabi`)).getResult()
  try {
    await (await import(testJsPath)).default(wasmBinary)
  } catch (e: any) {
    return { testPath, success: false, reason: e.stack }
  }
  let traceString = trace.toString();
  fss.writeFileSync(tracePath, traceString);

  // 3. Generate replay binary
  try {
    trace = trace.fromString(traceString)
  } catch (e: any) {
    return { testPath, success: false, reason: e.stack }
  }
  let replayCode
  try {
    replayCode = new Generator().generateReplay(trace.into()).toString()
  } catch (e: any) {
    return { testPath, success: false, reason: e.stack }
  }
  fss.writeFileSync(replayPath, replayCode)

  // 4. Execute replay and generate trace and compare
  let replayTrace = new Trace(eval(js + `\nWasabi`)).getResult()
  try {
    await (await import(replayPath)).default(wasmBinary)
  } catch (e: any) {
    return { testPath, success: false, reason: e.stack }
  }
  let replayTraceString = replayTrace.toString();
  fss.writeFileSync(replayTracePath, replayTraceString);

  const result = compareResults(testPath, traceString, replayTraceString)
  if (result.success === false) {
    return result
  }

  // 5. Compare call graphs
  if (generateCallGraphs === true) {
    let callGraph = new CallGraph(eval(js + `\nWasabi`)).getResult()
    try {
      await (await import(testJsPath)).default(wasmBinary)
    } catch (e: any) {
      return { testPath, success: false, reason: e.stack }
    }
    const callGraphString = JSON.stringify(callGraph)
    await fs.writeFile(callGraphPath, callGraphString)

    let replayCallGraph = new CallGraph(eval(js + `\nWasabi`)).getResult()
    delete (require as NodeJS.Require & { cache: any }).cache[replayPath]
    try {
      await (await import(replayPath)).default(wasmBinary)
    } catch (e: any) {
      return { testPath, success: false, reason: e.stack }
    }
    const replayCallGraphString = JSON.stringify(toString())
    await fs.writeFile(replayCallGraphPath, replayCallGraphString)
    return compareResults(testPath, callGraphString, replayCallGraphString)
  }
  return result
}

async function runNodeTests(names: string[]) {
  // ignore specific tests
  let filter = [
    'rust-tictactoe',
    'mem-exp-vec-store-no-host-mod',
    'mem-exp-init-no-host-mod',
    'mem-exp-copy-no-host-mod',
    'mem-exp-fill-no-host-mod',
    'mem-exp-host-mod-load-vec',
    'table-imp-init-max',
    'table-exp-host-mod',
    'table-exp-host-grow',
    'funky-kart',
  ]
  names = names.filter((n) => !filter.includes(n))

  for (let name of names) {
    await writeReport(name, await runNodeTest(name))
  }
}

function compareResults(testPath: string, traceString: string, replayTraceString: string): TestReport {
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
  // ignore specific tests
  let filter = [
    'funky-kart'
  ]
  // names = ['visual6502remix']
  names = names.filter((n) => !filter.includes(n))
  // names = ['pathfinding']
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
  // ignore specific tests
  let filter = [
    'sqllite'
  ]
  names = names.filter((n) => !filter.includes(n))
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
  let analysisResult: AnalysisResult
  try {
    analysisResult = await (await import(testJsPath)).default(new Analyser('./dist/src/tracer.cjs'))
    const record = fromAnalysisResult(analysisResult)
    await saveBenchmark(benchmarkPath, record)
    let subBenchmarkNames = getDirectoryNames(benchmarkPath)
    if (subBenchmarkNames.length === 0) {
      return { testPath, success: false, reason: 'no benchmark was generated' }
    }
    analysisResult = await (await import(testJsPath)).default(new Analyser('./dist/src/callgraph.cjs'))
    let callGraphs: string[] = []
    if (generateCallGraphs === true) {
      callGraphs = await Promise.all(analysisResult.map(async (r, i) => {
        const callGraphPath = path.join(benchmarkPath, `bin_${i}`, 'callpgraph.txt')
        await fs.writeFile(callGraphPath, r.result)
        return r.result
      }))
    }

    let runtimes = record.map(({ binary }, i) => {
      const out = instrument_wasm({ original: binary })
      record[i].binary = out.instrumented
      return out.js
    })
    await saveBenchmark(testBenchmarkPath, record, { trace: false })
    for (let i = 0; i < record.length; i++) {
      // Compare traces
      const subBenchmarkPath = path.join(testBenchmarkPath, subBenchmarkNames[i])
      const replayPath = path.join(subBenchmarkPath, 'replay.js')
      const replayTracePath = path.join(subBenchmarkPath, 'trace.r3')
      let replayTrace = new Trace(eval(runtimes[i] + `\nWasabi`)).getResult()
      await (await import(replayPath)).default(Buffer.from(record[i].binary))
      let traceString = stringify(record[i].trace)
      let replayTraceString = replayTrace.toString()
      await fs.writeFile(replayTracePath, replayTraceString);

      // 5. Check if original trace and replay trace match
      let result = compareResults(testPath, traceString, replayTraceString)
      if (result.success === false) {
        return result
      }

      // Compare call graphs
      if (generateCallGraphs === true) {
        const replayCallGraphPath = path.join(subBenchmarkPath, 'replay-call-graph.txt')
        let replayCallGraph = new CallGraph(eval(runtimes[i] + `\nWasabi`)).getResult()
        await (await import(replayPath)).default(Buffer.from(record[i].binary))
        const callGraphString = callGraphs[i].toString()
        const replayCallGraphString = JSON.stringify(replayCallGraph.into())
        await fs.writeFile(replayCallGraphPath, replayCallGraphString)
        result = compareResults(testPath, callGraphString, replayCallGraphString)
        if (result.success === false) {
          return result
        }
      }
    }
  } catch (e: any) {
    return { testPath, success: false, reason: e.stack}
  }
  return { testPath, success: true }
}

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

(async function run() {
  if (process.argv[2] === 'call') {
    generateCallGraphs = true
  }
  if (process.argv.includes('node') || process.argv[2] === undefined) {
    console.log('==============')
    console.log('Run node tests')
    console.log('==============')
    let nodeTestNames = getDirectoryNames(path.join(process.cwd(), 'tests', 'node'));
    await runNodeTests(nodeTestNames)
  }
  if (process.argv.includes('offline') || process.argv[2] === undefined) {
    console.log('=================')
    console.log('Run offline tests')
    console.log('=================')
    let offlineTestNames = getDirectoryNames(path.join(process.cwd(), 'tests', 'offline'))
    await runOfflineTests(offlineTestNames)
  }
  if (process.argv.includes('online') || process.argv[2] === undefined) {
    console.log('================')
    console.log('Run online tests')
    console.log('================')
    console.log('WARNING: You need a working internet connection')
    console.log('WARNING: Tests depend on third party websites. If those websites changed since this testsuite was created, it might not work')
    let webTestNames = getDirectoryNames(path.join(process.cwd(), 'tests', 'online'));
    await runOnlineTests(webTestNames)
  }
  // process.stdout.write(`done running ${nodeTestNames.length + webTestNames.length} tests\n`);
})()
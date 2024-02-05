import fs from 'fs/promises'
import fss from 'fs'
import path from 'path'
import cp, { execSync } from 'child_process'
import express from 'express'
import Generator from "../src/replay-generator.cjs";
import Tracer, { Trace } from "../src/tracer.cjs";
import { copyDir, delay, getDirectoryNames, rmSafe, startSpinner, stopSpinner, trimFromLastOccurance } from "./test-utils.cjs";
import Benchmark from '../src/benchmark.cjs';
//@ts-ignore
import { instrument_wasm } from '../wasabi/wasabi_js.js'
import { Server } from 'http'
import Analyser, { AnalysisResult } from '../src/analyser.cjs'
import commandLineArgs from 'command-line-args'
import { initPerformance } from '../src/performance.cjs'
import { generateJavascript } from '../src/js-generator.cjs'

let extended = false

async function cleanUp(testPath: string) {
  await rmSafe(path.join(testPath, "gen.js"))
  await rmSafe(path.join(testPath, "replayGen.js"))
  await rmSafe(path.join(testPath, "index.wasabi.cjs"))
  await rmSafe(path.join(testPath, "index.wasm"))
  await rmSafe(path.join(testPath, "trace.r3"))
  await rmSafe(path.join(testPath, "replay-trace.r3"))
  // await rmSafe(path.join(testPath, "replay.js"))
  await rmSafe(path.join(testPath, "report.txt"))
  await rmSafe(path.join(testPath, "long.js"))
  await rmSafe(path.join(testPath, "call-graph.txt"))
  await rmSafe(path.join(testPath, "replay-call-graph.txt"))
  await rmSafe(path.join(testPath, "long.cjs"))
  await rmSafe(path.join(testPath, 'benchmark'))
  await rmSafe(path.join(testPath, 'test-benchmark'))
}


async function runNodeTest(name: string, options): Promise<TestReport> {
  const testPath = path.join(process.cwd(), 'tests', 'node', name)
  await cleanUp(testPath)
  const testJsPath = path.join(testPath, 'test.js')
  const watPath = path.join(testPath, "index.wat");
  const wasmPath = path.join(testPath, "index.wasm");
  const instrumentedPath = path.join(testPath, "instrumented.wasm");
  const tracePath = path.join(testPath, "trace.r3");
  const callGraphPath = path.join(testPath, "call-graph.txt");
  const replayJsPath = path.join(testPath, "replay.js");
  const replayWasmPath = path.join(testPath, "replay.wasm");
  const mergedWasmPath = path.join(testPath, "merged.wasm");
  const replayTracePath = path.join(testPath, "replay-trace.r3");
  const replayCallGraphPath = path.join(testPath, "replay-call-graph.txt");
  await cleanUp(testPath)

  // 1. Instrument with Wasabi !!Please use the newest version
  const indexRsPath = path.join(testPath, 'index.rs')
  const indexCPath = path.join(testPath, 'index.c')
  if (fss.existsSync(indexRsPath)) {
    cp.execSync(`rustc --crate-type cdylib ${indexRsPath} --target wasm32-unknown-unknown --crate-type cdylib -o ${wasmPath}`, { stdio: 'ignore' })
    cp.execSync(`wasm2wat ${wasmPath} -o ${watPath}`)
  } else if (fss.existsSync(indexCPath)) {
    // TODO
  } else {
    cp.execSync(`wat2wasm ${watPath} -o ${wasmPath}`);
  }
  // const wasabiCommand = `wasabi ${wasmPath} --node -o ${testPath}`
  // cp.exec(wasabiCommand, { stdio: 'ignore' });
  // fss.rename(wasabiRuntimePathJS, wasabiRuntimePath)
  // fss.rename(path.join(testPath, 'long.js'), path.join(testPath, 'long.cjs'))
  // modifyRuntime(wasabiRuntimePath)
  // const wat = await fs.readFile(watPath)
  // const wabtModule = await wabt()
  // const binary = wabtModule.parseWat(watPath, wat).toBinary({})
  const binary = await fs.readFile(wasmPath)
  let { instrumented, js } = instrument_wasm(binary)
  await fs.writeFile(instrumentedPath, Buffer.from(instrumented))

  // 2. Execute test and generate trace
  const wasmBinary = await fs.readFile(instrumentedPath)
  let tracer = new Tracer(eval(js + `\nWasabi`), { extended })
  let original_instantiate = WebAssembly.instantiate
  //@ts-ignore
  WebAssembly.instantiate = async function (bytes: BufferSource, importObject?: WebAssembly.Imports) {
    const result = await original_instantiate(bytes, importObject)
    tracer.init()
    return result
  };
  try {
    await (await import(testJsPath)).default(wasmBinary)
  } catch (e: any) {
    return { testPath, success: false, reason: e.stack }
  }
  let trace = tracer.getResult()
  let traceString = trace.toString();
  await fs.writeFile(tracePath, traceString);

  // 3. Generate replay binary
  try {
    trace = Trace.fromString(traceString)
  } catch (e: any) {
    return { testPath, success: false, reason: e.stack }
  }
  let replayCode
  try {
    if (options.legacyBackend === true) {
      replayCode = await new Generator().generateReplay(trace)
      await generateJavascript(fss.createWriteStream(replayJsPath), replayCode)
    } else {
      if (options.jsBackend == true) {
        execSync(`./crates/target/debug/replay_gen ${tracePath} ${wasmPath} ${replayJsPath}`);
      } else {
        execSync(`./crates/target/debug/replay_gen ${tracePath} ${wasmPath} ${replayWasmPath}`);
        // we validate and early return as for single wasm accuracy test doesn't make sense
        execSync(`wasm-validate  ${replayWasmPath}`)
        return { testPath, success: true }
      }
    }

    await delay(0) // WTF why do I need this WHAT THE FUCK
  } catch (e: any) {
    return { testPath, success: false, reason: e.stack }
  }

  // 4. Execute replay and generate trace and compare
  let replayTracer = new Tracer(eval(js + `\nWasabi`), { extended })
  try {
    const replayBinary = await import(replayJsPath)
    const wasm = await replayBinary.instantiate(wasmBinary)
    replayTracer.init()
    replayBinary.replay(wasm)
  } catch (e: any) {
    return { testPath, success: false, reason: e.stack }
  }
  let replayTraceString = replayTracer.getResult().toString();
  await fs.writeFile(replayTracePath, replayTraceString);

  const result = compareResults(testPath, traceString, replayTraceString)
  if (result.success === false) {
    return result
  }

  return result
}

async function runNodeTests(names: string[], options) {
  if (names.length > 0) {
    console.log('==============')
    console.log('Run node tests')
    console.log('==============')
  }
  // ignore specific tests
  let filter = [
    'rust-tictactoe',
    'mem-exp-vec-store-no-host-mod',
    'mem-exp-init-no-host-mod',
    'mem-exp-copy-no-host-mod',
    'mem-exp-fill-no-host-mod',
    'mem-exp-host-mod-load-vec',
    'table-exp-host-mod',
    'table-exp-host-grow',
    'funky-kart',
    'table-exp-host-add-friend',
  ]
  names = names.filter((n) => !filter.includes(n))
  // names = ["mem-imp-host-grow"]
  for (let name of names) {
    const report = await runNodeTest(name, options)
    await writeReport(name, report)
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

async function runOnlineTests(names: string[], options) {
  if (names.length > 0) {
    console.log('================')
    console.log('Run online tests')
    console.log('================')
    console.log('WARNING: You need a working internet connection')
    console.log('WARNING: Tests depend on third party websites. If those websites changed since this testsuite was created, it might not work')
  }
  // ignore specific tests
  let filter = [
    'ogv', // TODO: additional ER at end of original trace
    'heatmap', // works fine, but too long so we skip it
    'uarm', // doesn't work for js because string is too long
    'image-convolute', // asm2wasm - f64-to-int is too large
  ]
  names = names.filter((n) => !filter.includes(n))
  for (let name of names) {
    const spinner = startSpinner(name)
    const testPath = path.join(process.cwd(), 'tests', 'online', name)
    const cleanUpPerformance = await initPerformance(name, 'online-auto-test', path.join(testPath, 'performance.ndjson'))
    await cleanUp(testPath);
    const report = await testWebPage(testPath, options)
    stopSpinner(spinner)
    cleanUpPerformance()
    await writeReport(name, report)
  }
}

async function runOfflineTests(names: string[], options) {
  if (names.length > 0) {
    console.log('=================')
    console.log('Run offline tests')
    console.log('=================')
  }
  // ignore specific tests
  let filter = [
    'sqllite',
  ]
  names = names.filter((n) => !filter.includes(n))
  for (let name of names) {
    const spinner = startSpinner(name)
    const testPath = path.join(process.cwd(), 'tests', 'offline', name)
    const websitePath = path.join(testPath, 'website')
    await cleanUp(testPath)
    const server = await startServer(websitePath)
    let report = await testWebPage(testPath, options)
    server.close()
    stopSpinner(spinner)
    await writeReport(name, report)
  }
}

type Success = { success: true }
type Failure = { success: false, reason: string }
type TestReport = { testPath: string } & (Success | Failure)
async function writeReport(name: string, report: TestReport) {
  const totalLength = 45;
  if (totalLength < name.length) {
    throw new Error("Total length should oe greater than or equal to the length of the initial word.");
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


async function testWebPage(testPath: string, options): Promise<TestReport> {
  const testJsPath = path.join(testPath, 'test.js')
  const benchmarkPath = path.join(testPath, 'benchmark')
  let analysisResult: AnalysisResult
  try {
    const analyser = new Analyser('./dist/src/tracer.cjs', { extended })
    analysisResult = await (await import(testJsPath)).default(analyser)
    const blockExtended = analyser.getExtended()

    // Sometimes during record we stop in the middle of wasm execution
    // we will generate the replay correctly, but it will run until the end
    // so we will end up with a longer replay trace.
    // Thats why we trim our trace to the position where the last wasm routine was finished
    for (let i = 0; i <= analysisResult.length - 1; i++) {
      analysisResult[i].result = trimFromLastOccurance(analysisResult[i].result, 'ER')
    }
    // process.stdout.write(` -e not available`)
    const benchmark = Benchmark.fromAnalysisResult(analysisResult)
    await benchmark.save(benchmarkPath, options)
    if (options.jsBackend != true) {
      return { testPath, success: true }
    }
    let subBenchmarkNames = await getDirectoryNames(benchmarkPath)
    if (subBenchmarkNames.length === 0) {
      return { testPath, success: false, reason: 'no benchmark was generated' }
    }

    let runtimes = benchmark.instrumentBinaries()
    // await copyDir(benchmarkPath, testBenchmarkPath)
    let results: any = { testPath, success: true }
    const record = benchmark.getRecord()
    for (let i = 0; i < record.length; i++) {
      const subBenchmarkPath = path.join(benchmarkPath, subBenchmarkNames[i])
      const tracePath = path.join(subBenchmarkPath, 'trace.r3')
      const refTracePath = path.join(subBenchmarkPath, 'trace-ref.r3')
      await fs.rename(tracePath, refTracePath)
      const replayPath = path.join(subBenchmarkPath, 'replay.js')
      const replayTracePath = path.join(subBenchmarkPath, 'trace-replay.r3')
      let tracer = new Tracer(eval(runtimes[i] + `\nWasabi`), { extended: blockExtended })
      let replayBinary
      try {
        replayBinary = (await import(replayPath))
      } catch {
        throw new Error('Apparently this is too stupid to parse the replay file. Even tho it should be written by now')
      }
      const wasm = await replayBinary.instantiate(Buffer.from(record[i].binary))
      tracer.init()
      await replayBinary.replay(wasm)
      let traceString = record[i].trace.toString()
      let replayTraceString = tracer.getResult().toString()
      await fs.writeFile(replayTracePath, replayTraceString);

      // 5. Check if original trace and replay trace match
      const newResult = compareResults(testPath, traceString, replayTraceString)
      if (newResult.success === false) {
        results.success = false;
        if (results.reason === undefined) {
          results.reason = ''
        }
        results.reason += `\n\n${newResult.reason}`
      }
    }
    return results
  } catch (e: any) {
    return { testPath, success: false, reason: e.stack }
  }
}

(async function run() {
  const optionDefinitions = [
    { name: 'jsBackend', alias: 'j', type: Boolean },
    { name: 'category', type: String, multiple: true, defaultOption: true },
    { name: 'testcases', alias: 't', type: String, multiple: true },
    { name: 'legacyBackend', alias: 'l', type: Boolean }
  ]
  const options = commandLineArgs(optionDefinitions)
  if (options.category === undefined || options.category.includes('node')) {
    let testNames = await getDirectoryNames(path.join(process.cwd(), 'tests', 'node'));
    if (options.testcases !== undefined) {
      testNames = testNames.filter(n => options.testcases.includes(n));
    }
    await runNodeTests(testNames, options)
  }
  if (options.category === undefined || options.category.includes('offline')) {
    let testNames = await getDirectoryNames(path.join(process.cwd(), 'tests', 'offline'))
    if (options.testcases !== undefined) {
      testNames = testNames.filter(n => options.testcases.includes(n));
    }
    await runOfflineTests(testNames, options)
  }
  if (options.category === undefined || options.category.includes('online')) {
    let testNames = await getDirectoryNames(path.join(process.cwd(), 'tests', 'online'));
    if (options.testcases !== undefined) {
      testNames = testNames.filter(n => options.testcases.includes(n));
    }
    await runOnlineTests(testNames, options)
  }
  // process.stdout.write(`done running ${nodeTestNames.length + webTestNames.length} tests\n`);
})()

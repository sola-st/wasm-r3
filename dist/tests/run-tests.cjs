"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const fs_1 = __importDefault(require("fs"));
const promises_1 = __importDefault(require("fs/promises"));
const path_1 = __importDefault(require("path"));
const cp = require("child_process");
const express_1 = __importDefault(require("express"));
const replay_generator_cjs_1 = __importDefault(require("../src/replay-generator.cjs"));
const trace_parse_cjs_1 = __importDefault(require("../src/trace-parse.cjs"));
const trace_stringify_cjs_1 = __importDefault(require("../src/trace-stringify.cjs"));
const tracer_cjs_1 = __importDefault(require("../src/tracer.cjs"));
const test_utils_cjs_1 = require("./test-utils.cjs");
const benchmark_cjs_1 = require("../src/benchmark.cjs");
const wasabi_js_js_1 = require("/Users/jakob/Desktop/wasm-r3/dist/wasabi/wasabi_js.js");
async function rmSafe(path) {
    try {
        await promises_1.default.rm(path, { recursive: true });
    }
    catch {
        // file doesnt exist, ok
    }
}
async function cleanUp(testPath) {
    await rmSafe(path_1.default.join(testPath, "gen.js"));
    await rmSafe(path_1.default.join(testPath, "replayGen.js"));
    await rmSafe(path_1.default.join(testPath, "index.wasabi.cjs"));
    await rmSafe(path_1.default.join(testPath, "index.wasm"));
    await rmSafe(path_1.default.join(testPath, "trace.r3"));
    await rmSafe(path_1.default.join(testPath, "replay-trace.r3"));
    await rmSafe(path_1.default.join(testPath, "replay.js"));
    await rmSafe(path_1.default.join(testPath, "report.txt"));
    await rmSafe(path_1.default.join(testPath, "long.js"));
    await rmSafe(path_1.default.join(testPath, "call-graph.txt"));
    await rmSafe(path_1.default.join(testPath, "replay-call-graph.txt"));
    await rmSafe(path_1.default.join(testPath, "long.cjs"));
    await rmSafe(path_1.default.join(testPath, 'benchmark'));
    await rmSafe(path_1.default.join(testPath, 'test-benchmark'));
}
const tracerPath = path_1.default.join(process.cwd(), 'dist', "./src/tracer.cjs");
async function runNodeTest(name) {
    const testPath = path_1.default.join(process.cwd(), 'tests', 'node', name);
    await cleanUp(testPath);
    const testJsPath = path_1.default.join(testPath, 'test.js');
    const watPath = path_1.default.join(testPath, "index.wat");
    const wasmPath = path_1.default.join(testPath, "index.wasm");
    const tracePath = path_1.default.join(testPath, "trace.r3");
    const callGraphPath = path_1.default.join(testPath, "call-graph.txt");
    const replayPath = path_1.default.join(testPath, "replay.js");
    const replayTracePath = path_1.default.join(testPath, "replay-trace.r3");
    const replayCallGraphPath = path_1.default.join(testPath, "replay-call-graph.txt");
    await cleanUp(testPath);
    // 1. Instrument with Wasabi !!Please use the newest version
    const indexRsPath = path_1.default.join(testPath, 'index.rs');
    const indexCPath = path_1.default.join(testPath, 'index.c');
    if (fileExists(indexRsPath)) {
        cp.execSync(`rustc --crate-type cdylib ${indexRsPath} --target wasm32-unknown-unknown --crate-type cdylib -o ${wasmPath}`, { stdio: 'ignore' });
        cp.execSync(`wasm2wat ${wasmPath} -o ${watPath}`);
    }
    else if (fileExists(indexCPath)) {
    }
    else {
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
    const binary = await promises_1.default.readFile(wasmPath);
    const { instrumented, js } = (0, wasabi_js_js_1.instrument_wasm)({ original: binary });
    fs_1.default.writeFileSync(wasmPath, Buffer.from(instrumented));
    // 2. Execute test and generate trace as well as call graph
    let trace = (0, tracer_cjs_1.default)(eval(js + `\nWasabi`));
    try {
        await import(testJsPath);
    }
    catch (e) {
        return { testPath, success: false, reason: e.stack };
    }
    let traceString = (0, trace_stringify_cjs_1.default)(trace);
    fs_1.default.writeFileSync(tracePath, traceString);
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
        trace = (0, trace_parse_cjs_1.default)(traceString);
    }
    catch (e) {
        return { testPath, success: false, reason: e.stack };
    }
    let replayCode;
    try {
        replayCode = new replay_generator_cjs_1.default().generateReplay(trace).toString();
    }
    catch (e) {
        return { testPath, success: false, reason: e.stack };
    }
    fs_1.default.writeFileSync(replayPath, replayCode);
    // 4. Execute replay and generate trace as well as call graph
    let replayTrace = (0, tracer_cjs_1.default)(eval(js + `\nWasabi`));
    try {
        await import(replayPath);
    }
    catch (e) {
        return { testPath, success: false, reason: e.stack };
    }
    let replayTraceString = (0, trace_stringify_cjs_1.default)(replayTrace);
    fs_1.default.writeFileSync(replayTracePath, replayTraceString);
    // let replayCallGraph = callGraphConstructor(eval(js + `\nWasabi`))
    // delete (require as NodeJS.Require & { cache: any }).cache[replayPath]
    // try {
    //   await import(replayPath)
    // } catch (e: any) {
    //   return { testPath, success: false, reason: e.stack }
    // }
    // await fs.writeFile(replayCallGraphPath, stringifyCallGraph(replayCallGraph))
    // 5. Check if original trace and replay trace match
    return compareTraces(testPath, traceString, replayTraceString);
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
async function runNodeTests(names) {
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
    ];
    names = names.filter((n) => !filter2.includes(n));
    for (let name of names) {
        await writeReport(name, await runNodeTest(name));
    }
}
function compareTraces(testPath, traceString, replayTraceString) {
    if (replayTraceString !== traceString) {
        let reason = `[Expected]\n`;
        reason += traceString;
        reason += `\n\n`;
        reason += `[Actual]\n`;
        reason += replayTraceString;
        return { testPath, success: false, reason };
    }
    return { testPath, success: true };
}
async function runOnlineTests(names) {
    for (let name of names) {
        await writeReport(name, await runOnlineTest(name));
    }
}
async function runOnlineTest(name) {
    const testPath = path_1.default.join(process.cwd(), 'tests', 'online', name);
    await cleanUp(testPath);
    return testWebPage(testPath);
}
async function runOfflineTests(names) {
    for (let name of names) {
        await writeReport(name, await runOfflineTest(name));
    }
}
async function writeReport(name, report) {
    const totalLength = 40;
    if (totalLength < name.length) {
        throw "Total length should be greater than or equal to the length of the initial word.";
    }
    const spacesLength = totalLength - name.length;
    const spaces = " ".repeat(spacesLength);
    process.stdout.write(`${name}${spaces}`);
    const testReportPath = path_1.default.join(report.testPath, 'report.txt');
    if (report.success === true) {
        await promises_1.default.writeFile(testReportPath, 'Test successfull');
        process.stdout.write(`\u2713\n`);
    }
    else {
        process.stdout.write(`\u2717\t\t${testReportPath}\n`);
        await promises_1.default.writeFile(testReportPath, report.reason);
    }
}
function startServer(websitePath) {
    const app = (0, express_1.default)();
    const port = 8000;
    app.use(express_1.default.static(websitePath));
    return new Promise(resolve => {
        const server = app.listen(port, () => {
            resolve(server);
        });
    });
}
async function runOfflineTest(name) {
    const testPath = path_1.default.join(process.cwd(), 'tests', 'offline', name);
    const websitePath = path_1.default.join(testPath, 'website');
    await cleanUp(testPath);
    const server = await startServer(websitePath);
    let report = await testWebPage(testPath);
    server.close();
    return report;
}
async function testWebPage(testPath) {
    const testJsPath = path_1.default.join(testPath, 'test.js');
    const benchmarkPath = path_1.default.join(testPath, 'benchmark');
    const testBenchmarkPath = path_1.default.join(testPath, 'test-benchmark');
    let record;
    try {
        record = await (await import(testJsPath)).default();
    }
    catch (e) {
        return { testPath, success: false, reason: e.stack };
    }
    await (0, benchmark_cjs_1.saveBenchmark)(benchmarkPath, record);
    let subBenchmarkNames = (0, test_utils_cjs_1.getDirectoryNames)(benchmarkPath);
    if (subBenchmarkNames.length === 0) {
        return { testPath, success: false, reason: 'no benchmark was generated' };
    }
    let Wasabi;
    record = record.map(({ binary, trace }) => {
        const out = (0, wasabi_js_js_1.instrument_wasm)({ original: binary });
        binary = out.instrumented;
        Wasabi = eval(out.js + `\nWasabi`);
        return { binary, trace };
    });
    await (0, benchmark_cjs_1.saveBenchmark)(testBenchmarkPath, record, { trace: false });
    for (let i = 0; i < subBenchmarkNames.length; i++) {
        const subBenchmarkPath = path_1.default.join(testBenchmarkPath, subBenchmarkNames[i]);
        const replayPath = path_1.default.join(subBenchmarkPath, 'replay.js');
        const replayTracePath = path_1.default.join(subBenchmarkPath, 'trace.r3');
        let replayTrace = (0, tracer_cjs_1.default)(Wasabi);
        await import(replayPath);
        let traceString = (0, trace_stringify_cjs_1.default)(record[i].trace);
        let replayTraceString = (0, trace_stringify_cjs_1.default)(replayTrace);
        await promises_1.default.writeFile(replayTracePath, replayTraceString);
        // 5. Check if original trace and replay trace match
        if (replayTraceString !== traceString) {
            let reason = `[Expected]\n`;
            reason += traceString;
            reason += `\n\n`;
            reason += `[Actual]\n`;
            reason += replayTraceString;
            return { testPath, success: false, reason: reason };
        }
    }
    return { testPath, success: true };
}
(async function run() {
    console.log('==============');
    console.log('Run node tests');
    console.log('==============');
    let nodeTestNames = (0, test_utils_cjs_1.getDirectoryNames)(path_1.default.join(process.cwd(), 'tests', 'node'));
    await runNodeTests(nodeTestNames);
    console.log('=================');
    console.log('Run offline tests');
    console.log('=================');
    let offlineTestNames = (0, test_utils_cjs_1.getDirectoryNames)(path_1.default.join(process.cwd(), 'tests', 'offline'));
    await runOfflineTests(offlineTestNames);
    console.log('================');
    console.log('Run online tests');
    console.log('================');
    console.log('WARNING: You need a working internet connection');
    console.log('WARNING: Tests depend on third party websites. If those websites changed since this testsuite was created, it might not work');
    let webTestNames = (0, test_utils_cjs_1.getDirectoryNames)(path_1.default.join(process.cwd(), 'tests', 'online'));
    await runOnlineTests(webTestNames);
    // process.stdout.write(`done running ${nodeTestNames.length + webTestNames.length} tests\n`);
})();
function fileExists(filePath) {
    try {
        fs_1.default.accessSync(filePath); // This will throw an error if the file doesn't exist
        return true;
    }
    catch (error) {
        if (error.code === 'ENOENT') {
            return false;
        }
        else {
            throw error; // Handle other errors appropriately
        }
    }
}
function callGraphConstructor(Wasabi) {
    let from = { funcidx: 'h', host: true };
    let inHost = null;
    let callGraph = [];
    // delete (require as NodeJS.Require & { cache: any }).cache[runtimePath]
    Wasabi.analysis = {
        call_pre(locatation, op, targetFunc, args, tableTarget) {
            inHost = Wasabi.module.info.functions.filter(f => f.import !== null).length <= locatation.func;
            if (inHost) {
                let from = {
                    funcidx: locatation.func,
                    host: false,
                };
                let to = {
                    funcidx: targetFunc,
                    params: args,
                    host: true,
                };
                callGraph.push({ from, params: args, to });
            }
            from = {
                funcidx: targetFunc,
                host: true,
            };
        },
        begin_function(location, args) {
            if (from.funcidx === 'h') {
                let from = {
                    funcidx: 'h',
                    host: true
                };
                let to = {
                    funcidx: location.func,
                    host: false,
                    memSizes: Wasabi.module.memories.map(m => m.buffer.byteLength),
                    tableSizes: Wasabi.module.tables.map(t => t.length),
                };
                callGraph.push({ from, params: args, to });
                return;
            }
            if (from.host) {
                let to = {
                    funcidx: location.func,
                    host: false,
                    memSizes: Wasabi.module.memories.map(m => m.buffer.byteLength),
                    tableSizes: Wasabi.module.tables.map(t => t.length)
                };
                callGraph.push({ from, params: args, to });
                return;
            }
            let to = {
                funcidx: location.func,
                host: false,
            };
            //@ts-ignore
            callGraph.push({ from, params: args, to });
        }
    };
    return callGraph;
}
function stringifyCallGraph(callGraph) {
    let s = 'How to read this graph: $from -> [$params] -> $to [$memSizes] [$tableSizes]\n';
    callGraph.forEach((edge, i) => {
        s += `${i}: ${edge.from.funcidx} -> [${edge.params}] -> ${edge.to.funcidx}\t`;
        if (edge.from.host) {
            s += `[${edge.to.memSizes}] [${edge.to.tableSizes}]`;
        }
        s += `\n`;
    });
    return s;
}
//# sourceMappingURL=run-tests.cjs.map
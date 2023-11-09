"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const fs = require("fs");
const path = require("path");
const cp = require("child_process");
const _ = require('lodash');
const replay_generator_cjs_1 = __importDefault(require("../src/replay-generator.cjs"));
const trace_parse_cjs_1 = __importDefault(require("../src/trace-parse.cjs"));
const trace_stringify_cjs_1 = __importDefault(require("../src/trace-stringify.cjs"));
const tracer_cjs_1 = __importDefault(require("../src/tracer.cjs"));
const test_utils_cjs_1 = require("./test-utils.cjs");
const benchmark_cjs_1 = require("../src/benchmark.cjs");
const tracerPath = path.join(process.cwd(), 'dist', "./src/tracer.cjs");
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
    ];
    names = names.filter((n) => !filter2.includes(n));
    for (let name of names) {
        process.stdout.write(writeTestName(name));
        const testPath = path.join(process.cwd(), 'tests', 'node', name);
        const testJsPath = path.join(testPath, 'test.js');
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
        const indexRsPath = path.join(testPath, 'index.rs');
        const indexCPath = path.join(testPath, 'index.c');
        if (fileExists(indexRsPath)) {
            cp.execSync(`rustc --crate-type cdylib ${indexRsPath} --target wasm32-unknown-unknown --crate-type cdylib -o ${wasmPath}`, { stdio: 'ignore' });
            cp.execSync(`wasm2wat ${wasmPath} -o ${watPath}`);
        }
        else if (fileExists(indexCPath)) {
        }
        else {
            cp.execSync(`wat2wasm ${watPath} -o ${wasmPath}`);
        }
        // cp.execSync(`wat2wasm ${watPath} -o ${wasmPath}`);
        // cp.execSync(`wasabi ${wasmPath} --node --hooks=begin,store,load,call,memory_grow -o ${testPath}`);
        // cp.execSync(`cd /Users/jakob/Desktop/wasabi-fork/crates/wasabi && cargo run ${wasmPath} --node --hooks=begin,store,load,call,return,global,memory_grow,table_get,table_set -o ${testPath}`, { stdio: 'ignore' });
        // const wasabiCommand = `cd /Users/jakob/Desktop/wasabi-fork/crates/wasabi && cargo run ${wasmPath} --node -o ${testPath}`
        const wasabiCommand = `wasabi ${wasmPath} --node -o ${testPath}`;
        cp.execSync(wasabiCommand, { stdio: 'ignore' });
        fs.renameSync(wasabiRuntimePathJS, wasabiRuntimePath);
        fs.renameSync(path.join(testPath, 'long.js'), path.join(testPath, 'long.cjs'));
        modifyRuntime(wasabiRuntimePath);
        // 2. Execute test and generate trace as well as call graph
        // let trace = require(tracerPath).default(wasabiRuntimePath);
        let trace = (0, tracer_cjs_1.default)(require(wasabiRuntimePath), _);
        // trace = await trace
        try {
            await import(testJsPath);
        }
        catch (e) {
            fail(e.stack, testReportPath);
            continue;
        }
        deleteRequireCaches();
        let traceString = (0, trace_stringify_cjs_1.default)(trace);
        fs.writeFileSync(tracePath, traceString);
        // let callGraph = callGraphConstructor(wasabiRuntimePath)
        // try {
        //   await import(testJsPath)
        // } catch (e: any) {
        //   fail(e.stack, testReportPath);
        //   continue;
        // }
        // fs.writeFileSync(callGraphPath, stringifyCallGraph(callGraph))
        // callGraph = undefined
        // 3. Generate replay binary
        try {
            trace = (0, trace_parse_cjs_1.default)(traceString);
        }
        catch (e) {
            fail(e.stack, testReportPath);
            continue;
        }
        let replayCode;
        try {
            replayCode = new replay_generator_cjs_1.default().generateReplay(trace).toString();
        }
        catch (e) {
            fail(e.stack, testReportPath);
            continue;
        }
        fs.writeFileSync(replayPath, replayCode);
        // 4. Execute replay and generate trace as well as call graph
        // let replayTrace = require(tracerPath).default(wasabiRuntimePath);
        let replayTrace = (0, tracer_cjs_1.default)(require(wasabiRuntimePath), _);
        try {
            await import(replayPath);
        }
        catch (e) {
            fail(e.stack, testReportPath);
            continue;
        }
        deleteRequireCaches();
        let replayTraceString = (0, trace_stringify_cjs_1.default)(replayTrace);
        fs.writeFileSync(replayTracePath, replayTraceString);
        // let replayCallGraph = callGraphConstructor(wasabiRuntimePath)
        // try {
        //   await import(replayPath)
        // } catch (e: any) {
        //   fail(e.stack, testReportPath);
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
            continue;
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
        fs.writeFileSync(testReportPath, 'Test successfull');
        process.stdout.write(`\u2713\n`);
        function deleteRequireCaches() {
            delete require.cache[wasabiRuntimePath];
            delete require.cache[tracerPath];
            delete require.cache[testJsPath];
            delete require.cache[replayPath];
            return;
        }
    }
}
async function runOnlineTests(names) {
    for (let name of names) {
        process.stdout.write(writeTestName(name));
        const testPath = path.join(process.cwd(), 'tests', 'online', name);
        const testJsPath = path.join(testPath, 'test.js');
        const benchmarkPath = path.join(testPath, 'benchmark');
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
        let record;
        try {
            record = await (await import(testJsPath)).default();
        }
        catch (e) {
            fail(e.stack, testReportPath);
            continue;
        }
        await (0, benchmark_cjs_1.saveBenchmark)(benchmarkPath, record);
        let subBenchmarkNames = (0, test_utils_cjs_1.getDirectoryNames)(benchmarkPath);
        for (let subBenchmarkName of subBenchmarkNames) {
            let binary = fs.readFileSync(path.join(benchmarkPath, subBenchmarkName, 'index.wasm'));
        }
    }
}
(async function run() {
    console.log('Run node tests');
    let nodeTestNames = (0, test_utils_cjs_1.getDirectoryNames)(path.join(process.cwd(), 'tests', 'node'));
    await runNodeTests(nodeTestNames);
    console.log('Run online tests');
    console.log('WARNING: You need a working internet connection');
    console.log('WARNING: Tests depend on third party websites. If those websites changed since this testsuite was created, it might not work');
    let webTestNames = (0, test_utils_cjs_1.getDirectoryNames)(path.join(process.cwd(), 'tests', 'online'));
    await runOnlineTests(webTestNames);
    process.stdout.write(`done running ${nodeTestNames.length + webTestNames.length} tests\n`);
})();
function fail(report, testReportPath) {
    process.stdout.write(`\u2717\t\t${testReportPath}\n`);
    fs.writeFileSync(testReportPath, report);
}
function writeTestName(name) {
    const totalLength = 40;
    if (totalLength < name.length) {
        throw "Total length should be greater than or equal to the length of the initial word.";
    }
    const spacesLength = totalLength - name.length;
    const spaces = " ".repeat(spacesLength);
    return `${name}${spaces}`;
}
function fileExists(filePath) {
    try {
        fs.accessSync(filePath); // This will throw an error if the file doesn't exist
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
function callGraphConstructor(runtimePath) {
    let from = { funcidx: 'h', host: true };
    let inHost = null;
    let callGraph = [];
    const Wasabi = require(runtimePath);
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
function modifyRuntime(path) {
    let runtimeCode = fs.readFileSync(path, 'utf8');
    // runtimeCode = runtimeCode.replace(new RegExp('require', 'g'), 'await import');
    // runtimeCode = runtimeCode.replace(new RegExp('let Wasabi', 'g'), 'export let Wasabi');
    // runtimeCode = runtimeCode.replace(new RegExp('module.exports = Wasabi;', 'g'), '');
    // runtimeCode = runtimeCode.replace(new RegExp("const Long = ", 'g'), '');
    runtimeCode = runtimeCode.replace(new RegExp("const Long = require\(.*\);", 'g'), 'const Long = require("./long.cjs")');
    fs.writeFileSync(path, runtimeCode);
}
//# sourceMappingURL=run-tests.cjs.map
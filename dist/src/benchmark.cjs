"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.readBenchmark = exports.saveBenchmark = void 0;
const promises_1 = __importDefault(require("fs/promises"));
const path_1 = __importDefault(require("path"));
const replay_generator_cjs_1 = __importDefault(require("./replay-generator.cjs"));
const trace_stringify_cjs_1 = __importDefault(require("./trace-stringify.cjs"));
const trace_parse_cjs_1 = __importDefault(require("./trace-parse.cjs"));
async function saveBenchmark(benchmarkPath, record, options = { trace: true }) {
    await promises_1.default.mkdir(benchmarkPath);
    await Promise.all(record.map(async ({ binary, trace }, i) => {
        const binPath = path_1.default.join(benchmarkPath, `bin_${i}`);
        await promises_1.default.mkdir(binPath);
        const jsString = new replay_generator_cjs_1.default().generateReplay(trace).toString();
        await promises_1.default.writeFile(path_1.default.join(binPath, 'trace.r3'), (0, trace_stringify_cjs_1.default)(trace));
        await promises_1.default.writeFile(path_1.default.join(binPath, 'replay.js'), jsString);
        await promises_1.default.writeFile(path_1.default.join(binPath, 'index.wasm'), Buffer.from(binary));
    }));
}
exports.saveBenchmark = saveBenchmark;
async function readBenchmark(benchmarkPath) {
    const dirnames = await promises_1.default.readdir(benchmarkPath);
    return await Promise.all(dirnames.map(async (name) => {
        const subBenchmarkPath = path_1.default.join(benchmarkPath, name);
        const binPath = path_1.default.join(subBenchmarkPath, 'index.wasm');
        const tracePath = path_1.default.join(subBenchmarkPath, 'trace.r3');
        let binary = Array.from(await promises_1.default.readFile(binPath));
        let trace = (0, trace_parse_cjs_1.default)(await promises_1.default.readFile(tracePath, 'utf-8'));
        return { binary, trace };
    }));
}
exports.readBenchmark = readBenchmark;
//# sourceMappingURL=benchmark.cjs.map
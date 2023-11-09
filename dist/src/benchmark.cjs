"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.saveBenchmark = void 0;
const promises_1 = __importDefault(require("fs/promises"));
const path_1 = __importDefault(require("path"));
const replay_generator_cjs_1 = __importDefault(require("./replay-generator.cjs"));
const trace_stringify_cjs_1 = __importDefault(require("./trace-stringify.cjs"));
async function saveBenchmark(benchmarkPath, record) {
    await promises_1.default.mkdir(benchmarkPath);
    record.map(async ({ binary, trace }, i) => {
        const binPath = path_1.default.join(benchmarkPath, `bin_${i}`);
        await promises_1.default.mkdir(binPath);
        const jsString = new replay_generator_cjs_1.default().generateReplay(trace).toString();
        promises_1.default.writeFile(path_1.default.join(binPath, 'trace.r3'), (0, trace_stringify_cjs_1.default)(trace));
        promises_1.default.writeFile(path_1.default.join(binPath, 'replay.js'), jsString);
        promises_1.default.writeFile(path_1.default.join(binPath, 'index.wasm'), Buffer.from(binary));
    });
}
exports.saveBenchmark = saveBenchmark;
//# sourceMappingURL=benchmark.cjs.map
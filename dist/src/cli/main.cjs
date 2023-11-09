"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const instrumenter_cjs_1 = __importDefault(require("../instrumenter.cjs"));
const benchmark_cjs_1 = require("../benchmark.cjs");
async function main() {
    const url = process.argv[2];
    const benchmarkPath = process.argv[3];
    const benchmark = await (0, instrumenter_cjs_1.default)(url);
    (0, benchmark_cjs_1.saveBenchmark)(benchmarkPath, benchmark);
}
main();
//# sourceMappingURL=main.cjs.map
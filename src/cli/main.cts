import record from '../instrumenter.cjs';
import { saveBenchmark } from '../benchmark.cjs';

async function main() {
    const url = process.argv[2]
    const benchmarkPath = process.argv[3]
    const benchmark = await record(url)
    saveBenchmark(benchmarkPath, benchmark)
}

main()
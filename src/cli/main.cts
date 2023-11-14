import record, { record_deprecated } from '../instrumenter.cjs';
import { saveBenchmark } from '../benchmark.cjs';

async function main() {
    const url = process.argv[2]
    const benchmarkPath = process.argv[3]
    let benchmark
    if ('dep' === process.argv[4]) {
        benchmark = await record_deprecated(url)
    } else {
        benchmark = await record(url)
    }
    console.time('save Benchmark')
    await saveBenchmark(benchmarkPath, benchmark)
    console.timeEnd('save Benchmark')
}

main()
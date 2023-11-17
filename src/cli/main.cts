import record from '../instrumenter.cjs';
import record_callgraph from '../callgraph-instrumenter.cjs'
import { saveBenchmark } from '../benchmark.cjs';

async function main() {
    const url = process.argv[2]
    const benchmarkPath = process.argv[3]
    let benchmark
    if ('call' === process.argv[4]) {
        await record_callgraph(url)
    } else {
        benchmark = await record(url)
    }
    console.time('save Benchmark')
    await saveBenchmark(benchmarkPath, benchmark)
    console.timeEnd('save Benchmark')
}

main()
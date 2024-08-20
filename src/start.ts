import readline from 'readline'
import commandLineArgs from 'command-line-args'
import Benchmark, { Analyser, commonOptions } from './web.ts'
import fs from 'fs';

const startOptions = [
    { name: 'url', type: String, defaultOption: true },
    { name: 'benchmarkPath', alias: 'b', type: String },
]

async function main() {
    const options = commandLineArgs([...commonOptions, ...startOptions])
    await run(options.url, options)
}

export default async function run(url: string, options) {
    let analyser = new Analyser('./dist/src/tracer.cjs', options)
    await analyser.start(url, options)
    await askQuestion(`Record is running. Enter 'Stop' to stop recording: `)
    console.log(`Record stopped. Downloading...`)
    const results = await analyser.stop()
    console.log('Download done. Generating Benchmark...')
    const benchmarkPath = getBenchmarkPath(options);
    Benchmark.fromAnalysisResult(results).save(benchmarkPath, { trace: options.dumpTrace, rustBackend: options.rustBackend })
}


function getBenchmarkPath(options) {
    if (options.benchmarkPath !== undefined) {
        return options.benchmarkPath;
    }
    let benchmarkPath = 'benchmark_0';
    let i = 0;
    while (fs.existsSync(benchmarkPath)) {
        i++;
        benchmarkPath = `benchmark_${i}`;
    }
    return benchmarkPath;
}

async function askQuestion(question: string) {
    const rl = readline.createInterface({
        input: process.stdin,
        output: process.stdout,
    });
    return new Promise((resolve) => {
        rl.question(question, (answer) => {
            rl.close()
            resolve(answer);
        });
    });
}

main() 
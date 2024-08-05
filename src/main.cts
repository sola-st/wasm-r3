import readline from 'readline'

async function main() {
    const options = getOptions()
    await run(options.url, options)
}

export default async function run(url: string, options: Options) {
    let analyser: AnalyserI
    analyser = new Analyser('./dist/src/tracer.cjs', options)
    await analyser.start(url, { headless: options.headless })
    await askQuestion(`Record is running. Enter 'Stop' to stop recording: `)
    console.log(`Record stopped. Downloading...`)
    const results = await analyser.stop()
    console.log('Download done. Generating Benchmark...')
    Benchmark.fromAnalysisResult(results).save(options.benchmarkPath, { trace: options.dumpTrace, rustBackend: options.rustBackend })
}

import commandLineArgs from 'command-line-args'
import fs from 'fs'
import Benchmark, { AnalyserI, Analyser } from './web.cjs'

export type Options = {
    headless: boolean,
    dumpPerformance: boolean,
    dumpTrace: boolean,
    benchmarkPath: string,
    file: string,
    extended: boolean,
    noRecord: boolean,
    rustBackend: boolean,
    customInstrumentation: boolean,
}

export function getOptions() {
    const optionDefinitions = [
        { name: 'performance', alias: 'p', type: Boolean },
        { name: 'trace', alias: 't', type: Boolean },
        { name: 'url', type: String, defaultOption: true },
        { name: 'benchmarkPath', alias: 'b', type: String },
        { name: 'headless', alias: 'h', type: Boolean },
        { name: 'file', alias: 'f', type: String },
        { name: 'extended', alias: 'e', type: Boolean },
        { name: 'no-record', alias: 'n', type: Boolean },
        { name: 'rustBackend', alias: 'r', type: Boolean },
        { name: 'customInstrumentation', alias: 'c', type: Boolean }
    ]
    const options: Options & { url: string } = commandLineArgs(optionDefinitions)
    if (options.headless === undefined) {
        options.headless = false
    }
    if (options.rustBackend) {
        console.log('CAUTION: Using experimental Rust backend')
    }
    if (fs.existsSync(options.benchmarkPath)) {
        throw new Error(`EEXIST: Directory at path ${options.benchmarkPath} does already exist`)
    }
    if (options.benchmarkPath === undefined || options.benchmarkPath === null) {
        let i = 0
        options.benchmarkPath = `benchmark`
        while (fs.existsSync(options.benchmarkPath)) {
            i++;
            options.benchmarkPath = `benchmark_${i}`
        }
    }
    return options
}

export async function askQuestion(question: string) {
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
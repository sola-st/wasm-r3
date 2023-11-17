import { Trace } from "../trace.cjs"
import fs from 'fs/promises'
import fss from 'fs'
import path from 'path'
import Generator from "./replay-generator.cjs"
import stringifyTrace from "./trace-stringify.cjs"
import parse from './trace-parse.cjs'
import { AnalysisResult } from "./analyser.cjs"

export type Record = { binary: number[], trace: Trace }[]

export function fromAnalysisResult(result: AnalysisResult): Record {
    return result.map(r => ({ trace: parse(r.result), binary: r.wasm }))
}

export async function saveBenchmark(benchmarkPath: string, record: Record, options = { trace: true }) {
    await fs.mkdir(benchmarkPath)
    await Promise.all(record.map(async ({ binary, trace }, i) => {
        const binPath = path.join(benchmarkPath, `bin_${i}`)
        await fs.mkdir(binPath)
        const jsString = new Generator().generateReplay(trace).toString()
        if (options.trace === true) {
            await fs.writeFile(path.join(binPath, 'trace.r3'), stringifyTrace(trace))
        }
        await fs.writeFile(path.join(binPath, 'replay.js'), jsString)
        await fs.writeFile(path.join(binPath, 'index.wasm'), Buffer.from(binary))
    }))
}

export async function readBenchmark(benchmarkPath: string): Promise<Record> {
    const dirnames = await fs.readdir(benchmarkPath)
    return await Promise.all(dirnames.map(async (name) => {
        const subBenchmarkPath = path.join(benchmarkPath, name)
        const binPath = path.join(subBenchmarkPath, 'index.wasm')
        const tracePath = path.join(subBenchmarkPath, 'trace.r3')
        let binary = Array.from(await fs.readFile(binPath))
        let trace = parse(await fs.readFile(tracePath, 'utf-8'))
        return { binary, trace }
    }))
}
import { Trace } from "../trace.cjs"
import fs from 'fs/promises'
import fss from 'fs'
import path from 'path'
import Generator from "./replay-generator.cjs"
import stringifyTrace from "./trace-stringify.cjs"

export type Record = { binary: number[], trace: Trace }[]

export async function saveBenchmark(benchmarkPath: string, record: Record) {
    await fs.mkdir(benchmarkPath)
    await record.map(async ({ binary, trace }, i) => {
        const binPath = path.join(benchmarkPath, `bin_${i}`)
        await fs.mkdir(binPath)
        const jsString = new Generator().generateReplay(trace).toString()
        await fs.writeFile(path.join(binPath, 'trace.r3'), stringifyTrace(trace))
        await fs.writeFile(path.join(binPath, 'replay.js'), jsString)
        await fs.writeFile(path.join(binPath, 'index.wasm'), Buffer.from(binary))
    })
}

export function saveBenchmarkSync(benchmarkPath: string, record: Record) {
    fss.mkdirSync(benchmarkPath)
    record.map(({ binary, trace }, i) => {
        const binPath = path.join(benchmarkPath, `bin_${i}`)
        fs.mkdir(binPath)
        const jsString = new Generator().generateReplay(trace).toString()
        fss.writeFileSync(path.join(binPath, 'trace.r3'), stringifyTrace(trace))
        fss.writeFileSync(path.join(binPath, 'replay.js'), jsString)
        fss.writeFileSync(path.join(binPath, 'index.wasm'), Buffer.from(binary))
    })
}
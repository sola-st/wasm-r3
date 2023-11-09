import { Trace } from "../trace.cjs"
import fs from 'fs/promises'
import path from 'path'
import Generator from "./replay-generator.cjs"
import stringifyTrace from "./trace-stringify.cjs"

export type Record = { binary: number[], trace: Trace }[]

export async function saveBenchmark(benchmarkPath: string, record: Record) {
    await fs.mkdir(benchmarkPath)
    record.map(async ({ binary, trace }, i) => {
        const binPath = path.join(benchmarkPath, `bin_${i}`)
        await fs.mkdir(binPath)
        const jsString = new Generator().generateReplay(trace).toString()
        fs.writeFile(path.join(binPath, 'trace.r3'), stringifyTrace(trace))
        fs.writeFile(path.join(binPath, 'replay.js'), jsString)
        fs.writeFile(path.join(binPath, 'index.wasm'), Buffer.from(binary))
    })
}
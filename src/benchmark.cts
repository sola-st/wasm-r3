import fs from 'fs/promises'
import fss from 'fs'
import path from 'path'
import Generator from "./replay-generator.cjs"
import { AnalysisResult } from "./analyser.cjs"
import { Trace } from "./tracer.cjs"
//@ts-ignore
import { instrument_wasm } from '../wasabi/wasabi_js.js'

export type Record = { binary: number[], trace: Trace }[]

type WasabiRuntime = string[]
export default class Benchmark {

    private record: Record
    private constructor() { }

    async save(benchmarkPath: string, options = { trace: false }) {
        await fs.mkdir(benchmarkPath)
        await Promise.all(this.record.map(async ({ binary, trace }, i) => {
            const binPath = path.join(benchmarkPath, `bin_${i}`)
            await fs.mkdir(binPath)
            if (options.trace === true) {
                await fs.writeFile(path.join(binPath, 'trace.r3'), trace.toString())
            }
            const diskSave = `temp-trace-${i}.r3`
            await fs.writeFile(diskSave, trace.toString())
            // console.log('wrote temp trace to disk and start stream code generation')
            const code = await new Generator().generateReplayFromStream(fss.createReadStream(diskSave))
            // console.log('stream code generation finished. Now stream js string to file')
            await code.toWriteStream(fss.createWriteStream(path.join(binPath, 'replay.js')))
            // const jsString = new Generator().generateReplay(trace).toString()
            // console.log('js code generation finished. Now dump wasm to file')
            // await fs.writeFile(path.join(binPath, 'replay.js'), jsString)
            await fs.writeFile(path.join(binPath, 'index.wasm'), Buffer.from(binary))
            // await fs.rm(diskSave)
        }))
    }

    static async read(benchmarkPath: string): Promise<Benchmark> {
        const self = new Benchmark()
        const dirnames = await fs.readdir(benchmarkPath)
        self.record = await Promise.all(dirnames.map(async (name) => {
            const subBenchmarkPath = path.join(benchmarkPath, name)
            const binPath = path.join(subBenchmarkPath, 'index.wasm')
            const tracePath = path.join(subBenchmarkPath, 'trace.r3')
            let binary = Array.from(await fs.readFile(binPath))
            let trace = Trace.fromString(await fs.readFile(tracePath, 'utf-8'))
            return { binary, trace }
        }))
        return self
    }

    static fromAnalysisResult(result: AnalysisResult): Benchmark {
        const self = new Benchmark()
        self.record = result.map(r => ({ trace: Trace.fromString(r.result), binary: r.wasm }))
        return self
    }

    getBinaries() {
        return this.record.map(r => r.binary)
    }

    instrumentBinaries(): WasabiRuntime[] {
        return this.record.map((r, i) => {
            const { instrumented, js } = instrument_wasm({ original: r.binary })
            this.record[i].binary = instrumented
            return js
        })
    }

    getRecord() {
        return this.record
    }
}
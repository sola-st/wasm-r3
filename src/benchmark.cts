import fs from 'fs/promises'
import fss from 'fs'
import path from 'path'
import { AnalysisResult } from "./analyser.cjs"
import { Trace } from "./tracer.cjs"
import { execSync } from 'child_process';
//@ts-ignore
import { instrument_wasm } from '../wasabi/wasabi_js.js'

export type Record = { binary: number[], trace: Trace }[]

type WasabiRuntime = string[]
export default class Benchmark {

    private record: Record
    private constructor() { }

    async save(benchmarkPath: string, options) {
        if (!fss.existsSync(benchmarkPath)) await fs.mkdir(benchmarkPath, {recursive: true})
        await Promise.all(this.record.map(async ({ binary, trace }, i) => {
            // FIXME: enable back after hacking on slicedice
            // if (i != 1) return;
            const binPath = path.join(benchmarkPath, `bin_${i}`)
            if (!fss.existsSync(binPath)) await fs.mkdir(binPath)
            const tracePath = path.join(binPath, 'trace.r3')
            await fs.writeFile(tracePath, trace.toString())
            await fs.writeFile(path.join(binPath, 'index.wasm'), Buffer.from(binary))
            // FIXME: enable back after hacking on slicedice
            execSync(`./target/release/replay_gen ${tracePath} ${path.join(binPath, 'index.wasm')} ${path.join(binPath, 'replay.wasm')}`);
            // execSync(`wasmtime ${path.join(binPath, 'replay.wasm')}`);
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
            const { instrumented, js } = instrument_wasm(r.binary)
            this.record[i].binary = instrumented
            return js
        })
    }

    getRecord() {
        return this.record
    }
}

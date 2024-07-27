import fs from 'fs/promises'
import fss from 'fs'
import path from 'path'
import Generator from "./replay-generator.cjs"
import { AnalysisResult } from "./analyser.cjs"
import { Trace } from "./tracer.cjs"
import { execSync } from 'child_process';
//@ts-ignore
import { instrument_wasm } from '../wasabi/wasabi_js.js'
import { createMeasure } from './performance.cjs'
import { generateJavascript } from './js-generator.cjs'

export type Record = { binary: number[], trace: Trace }[]

type WasabiRuntime = string[]
export default class Benchmark {

    private record: Record
    private constructor() { }

    async save(benchmarkPath: string, options) {
        const p_measureSave = createMeasure('save', { phase: 'replay-generation', description: 'The time it takes to save the benchmark to the disk. This means generating the intermediate representation code from the trace and streaming it to the file, as well as saving the wasm binaries.' })
        if (!fss.existsSync(benchmarkPath)) await fs.mkdir(benchmarkPath)
        await Promise.all(this.record.map(async ({ binary, trace }, i) => {
            const binPath = path.join(benchmarkPath, `bin_${i}`)
            if (!fss.existsSync(binPath)) await fs.mkdir(binPath)
            await fs.writeFile(path.join(binPath, 'trace.r3'), trace.toString())
            const diskSave = path.join(binPath, `temp-trace-${i}.r3`)
            await fs.writeFile(diskSave, trace.toString())
            await fs.writeFile(path.join(binPath, 'index.wasm'), Buffer.from(binary))
            if (options.legacyBackend == true) {
                const p_measureCodeGen = createMeasure('ir-gen', { phase: 'replay-generation', description: `The time it takes to generate the IR code for subbenchmark ${i}` })
                const code = await new Generator().generateReplayFromStream(fss.createReadStream(diskSave))
                p_measureCodeGen()
                const p_measureJSWrite = createMeasure('string-gen', { phase: 'replay-generation', description: `The time it takes to stream the replay code to the file for subbenchmark ${i}` })
                await generateJavascript(fss.createWriteStream(path.join(binPath, 'replay.js')), code)
                p_measureJSWrite()
            } else {
                const p_measureCodeGen = createMeasure('rust-backend', { phase: 'replay-generation', description: `The time it takes for rust backend to generate javascript` })
                // FIXME: enable back after hacking on slicedice
                // execSync(`./target/release/replay_gen generate ${diskSave} ${path.join(binPath, 'index.wasm')} false ${path.join(binPath, 'pure.js')}`);
                execSync(`./target/release/replay_gen generate ${diskSave} ${path.join(binPath, 'index.wasm')} false ${path.join(binPath, 'replay.wasm')}`);
                // execSync(`wasmtime ${path.join(binPath, 'replay.wasm')}`);
                p_measureCodeGen()
            }
            await fs.rm(diskSave)
        }))
        p_measureSave()
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

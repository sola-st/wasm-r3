//@ts-nocheck
import { Browser, chromium, Frame, Page, Worker } from 'playwright'
import { createMeasure, StopMeasure } from './performance.cjs'
import fs from 'fs/promises'
import cp from 'child_process'
import { Trace } from './tracer.cjs'
import acorn from 'acorn'

export interface AnalysisI<T> {
    getResult(): T,
    getResultChunk(size: number): T
}

export type AnalysisResult = {
    result: string,
    wasm: number[]
}[]

export interface AnalyserI {
    start(url: string, options: any): any,
    stop(): any
}

type Options = { extended: boolean }
export default class Analyser implements AnalyserI {

    private analysisPath: string
    private options: Options
    private isRunning = false
    private p_measureUserInteraction: StopMeasure
    private cp: cp.ChildProcessWithoutNullStreams


    constructor(analysisPath: string, options = { extended: false }) {
        this.analysisPath = analysisPath
        this.options = options
    }

    async start(url: string, args) {
        if (this.isRunning === true) {
            throw new Error('Analyser is already running. Stop the Analyser before starting again')
        }
        const p_measureStart = createMeasure('start', { phase: 'record', description: `The time it takes start the chromium browser and open the webpage until the 'load' event is fired.` })
        this.isRunning = true
        const initScriptPath = 'init.js'
        await fs.writeFile(initScriptPath, this.constructInitScript(url))
        this.cp = cp.spawn('node', [initScriptPath, ...args])

    }

    async stop(): Promise<AnalysisResult> {
        if (this.isRunning === false) {
            throw new Error('Analyser is not running. Start the Analyser before stopping')
        }
        this.p_measureUserInteraction()
        const p_measureStop = createMeasure('stop', { phase: 'record', description: `The time it takes to stop the recording, from when the user stopped the recording until all data is downloaded from the browser and the browser is closed.` })
        this.contexts = this.contexts.concat(this.page.frames())
        const p_measureDataDownload = createMeasure('data download', { phase: 'record', description: `The time it takes to download all data from the browser.` })
        const p_measureTraceDownload = createMeasure('trace download', { phase: 'record', description: `The time it takes to download all traces from the browser.` })
        const traces = await this.getResults()
        p_measureTraceDownload()
        const p_measureBufferDownload = createMeasure('buffer download', { phase: 'record', description: `The time it takes to download all wasm binaries from the browser.` })
        const originalWasmBuffer = await this.getBuffers()
        p_measureBufferDownload()
        p_measureDataDownload()
        this.contexts = []
        this.browser.close()
        this.isRunning = false
        p_measureStop()
        return traces.map((result, i) => ({ result: result, wasm: originalWasmBuffer[i] }))
    }



    private async constructInitScript() {
        const wasabiScript = await fs.readFile('./dist/wasabi.js') + '\n'
        let analysisScript = await fs.readFile(this.analysisPath) + '\n'
        analysisScript = analysisScript.split('Object.defineProperty(exports, "__esModule", { value: true });').join('')
        analysisScript = analysisScript.split('exports.default = setupAnalysis;').join('')
        analysisScript = analysisScript.split('exports.stringifyTrace = void 0;').join('')
        analysisScript = analysisScript.split('exports.stringifyTrace = stringifyTrace;').join('')
        analysisScript = analysisScript.split('exports.Trace = void 0;').join('')
        analysisScript = analysisScript.split('exports.Trace = Trace;').join('')
        analysisScript = analysisScript.split('exports.default = Analysis;').join('')
        analysisScript = `function setupAnalysis(Wasabi) {\n ${analysisScript};\n return new Analysis(Wasabi, { extended: ${this.options.extended}})}\n`
        const setupScript = await fs.readFile('./src/runtime.js') + '\n'
        return wasabiScript + ';' + analysisScript + ';' + setupScript + ';'
    }

    setExtended(extended: boolean) {
        this.options.extended = extended
    }

    getExtended() {
        return this.options.extended
    }
}


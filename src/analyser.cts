import { Browser, chromium, Frame, Page, Worker } from 'playwright'
import { PerformanceEntry, PerformanceList } from './performance.cjs'
import fs from 'fs/promises'
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

export default class Analyser {

    private analysisPath: string
    private browser: Browser
    private page: Page
    private contexts: (Frame | Worker)[] = []
    private isRunning = false
    private performanceTraceLocal = new PerformanceList('Node')
    private performanceTraceBrowser = new PerformanceList('Browser')


    constructor(analysisPath: string) {
        this.analysisPath = analysisPath
    }

    async start(url: string, { headless } = { headless: false }) {
        if (this.isRunning === true) {
            throw new Error('Analyser is already running. Stop the Analyser before starting again')
        }
        const p_start = new PerformanceEntry('start')
        this.isRunning = true
        this.browser = await chromium.launch({
            headless, args: [
                '--disable-web-security',
                '--js-flags="--max_old_space_size=8192"'
            ]
        });
        this.page = await this.browser.newPage();
        const initScript = await this.constructInitScript()

        await this.page.addInitScript({ content: initScript })

        await this.page.route(`**/*.js*`, async route => {
            const response = await route.fetch()
            const script = await response.text()
            try {
                acorn.parse(script, { ecmaVersion: 'latest' })
                const body = `${initScript}${script}`
                await route.fulfill({ response, body: body })
            } catch {
                route.fulfill({ response, body: script })
            }
        })
        this.page.on('worker', worker => {
            this.contexts.push(worker)
        })

        await this.page.goto(url)
        this.performanceTraceLocal.push(p_start.stop())
        this.performanceTraceLocal.push(new PerformanceEntry('user interaction'))
        return this.page
    }

    async stop(): Promise<AnalysisResult> {
        if (this.isRunning === false) {
            throw new Error('Analyser is not running. Start the Analyser before stopping')
        }
        this.performanceTraceLocal.top().stop()
        const p_stop = new PerformanceEntry('stop')
        this.contexts = this.contexts.concat(this.page.frames())
        const p_download = new PerformanceEntry('data download')
        const p_downloadTraces = new PerformanceEntry('trace download')
        const analysisResults = await this.getResults()
        this.performanceTraceLocal.push(p_downloadTraces.stop())
        const p_bufferDownload = new PerformanceEntry('buffer download')
        const originalWasmBuffer = await this.getBuffers()
        const p_bufferDownloadWorker = new PerformanceEntry('buffer download from workers')
        this.performanceTraceLocal.push(p_bufferDownloadWorker.stop())
        this.performanceTraceLocal.push(p_bufferDownload.stop())
        this.performanceTraceLocal.push(p_download.stop())

        await this.downloadPerformanceList()
        this.contexts = []
        this.browser.close()
        this.isRunning = false
        this.performanceTraceLocal.push(p_stop.stop())
        return analysisResults.map((result, i) => ({ result: result, wasm: originalWasmBuffer[i] }))
    }

    private async getResults() {
        const p_downloadTraces = new PerformanceEntry('traces download from workers')
        const results = await Promise.all(this.contexts.map(async (c) => {
            const p_downloadTrace = new PerformanceEntry(`download traces from context: ${c.url()}`)
            const traces = await c.evaluate((url) => {
                try {
                    //@ts-ignore
                    const p_compressTraces = performanceEvent(`compress traces from context ${url}`)
                    //@ts-ignore
                    const traces = (analysis as AnalysisI<Trace>[]).map((r, j) => {
                        //@ts-ignore
                        const p_compressTrace = performanceEvent(`compress trace ${j} from context ${url}`)
                        const trace = r.getResult().toString()
                        //@ts-ignore
                        self.performanceList.push(p_compressTrace.stop())
                        return trace
                    })
                    //@ts-ignore
                    self.performanceList.push(p_compressTraces.stop())
                    return traces
                } catch {
                    return []
                }
            }, c.url())
            this.performanceTraceLocal.push(p_downloadTrace.stop())
            return traces.map(t => t.toString())
        }))
        this.performanceTraceLocal.push(p_downloadTraces.stop())
        return results.flat(1)
    }


    private async getBuffers() {
        const p_downloadBuffer = new PerformanceEntry('buffer download from main context')
        const originalWasmBuffer = await Promise.all(this.contexts.map(c => c.evaluate(() => {
            try {
                return Array.from(originalWasmBuffer)
            } catch {
                return []
            }
        })))
        this.performanceTraceLocal.push(p_downloadBuffer.stop())
        return originalWasmBuffer.flat(1) as number[][]
    }

    private async downloadPerformanceList() {
        const p_performanceInfoDownload = new PerformanceEntry('performance info download')
        const performanceList: any[][] = await Promise.all(this.contexts.map(w => w.evaluate(() => {
            try {
                return performanceList
            } catch {
                return []
            }
        })))
        this.performanceTraceLocal.push(p_performanceInfoDownload.stop())
        performanceList.flat(1).forEach((p) => this.performanceTraceBrowser.push(new PerformanceEntry(p.name).buildFromObject(p)))

    }

    getPerformance() {
        return {
            analyser: this.performanceTraceLocal,
            browser: this.performanceTraceBrowser,
        }
    }

    async dumpPerformance(path: string) {
        await fs.writeFile(path, this.performanceTraceLocal.toString() + this.performanceTraceBrowser.toString())
    }

    private async constructInitScript() {
        let performanceScript = await fs.readFile('./dist/src/performance.cjs') + '\n'
        performanceScript = performanceScript.split('Object.defineProperty(exports, "__esModule", { value: true });').join('')
        performanceScript = performanceScript.split('exports.PerformanceList = exports.PerformanceEntry = void 0;').join('')
        performanceScript = performanceScript.split('exports.PerformanceEntry = PerformanceEntry;').join('')
        performanceScript = performanceScript.split('exports.PerformanceList = PerformanceList;').join('')
        performanceScript = 'function performanceEvent(name) {\n' + performanceScript + '\nreturn new PerformanceEntry(name)}\n'
        const wasabiScript = await fs.readFile('./dist/wasabi.js') + '\n'
        let analysisScript = await fs.readFile(this.analysisPath) + '\n'
        analysisScript = analysisScript.split('Object.defineProperty(exports, "__esModule", { value: true });').join('')
        analysisScript = analysisScript.split('exports.default = setupAnalysis;').join('')
        analysisScript = analysisScript.split('exports.stringifyTrace = void 0;').join('')
        analysisScript = analysisScript.split('exports.stringifyTrace = stringifyTrace;').join('')
        analysisScript = analysisScript.split('exports.Trace = void 0;').join('')
        analysisScript = analysisScript.split('exports.Trace = Trace;').join('')
        analysisScript = analysisScript.split('exports.default = Analysis;').join('')
        analysisScript = 'function setupAnalysis(Wasabi) {\n' + analysisScript + '\nreturn new Analysis(Wasabi)}\n'
        const setupScript = await fs.readFile('./src/runtime.js') + '\n'
        return performanceScript + ';' + wasabiScript + ';' + analysisScript + ';' + setupScript + ';'
    }
}


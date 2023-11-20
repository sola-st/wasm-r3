import { Browser, chromium, Page, Worker } from 'playwright'
import { PerformanceEntry, PerformanceList } from './performance.cjs'
import fs from 'fs/promises'
import { Trace } from '../trace.cjs'

export interface AnalysisI<T> {
    getResult(): T
}

export type AnalysisResult = {
    result: string,
    wasm: number[]
}[]

export default class Analyser {

    private analysisPath: string
    private browser: Browser
    private page: Page
    private workerHandles: Worker[] = []
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
        this.browser = await chromium.launch({ headless, args: ['--disable-web-security'] });
        this.page = await this.browser.newPage();
        const initScript = await this.constructInitScript()

        await this.page.addInitScript({ content: initScript })

        await this.page.route(`**/*.js*`, async route => {
            const response = await route.fetch()
            const script = await response.text()
            const body = `${initScript}${script}`
            await route.fulfill({ response, body: body })
        })
        this.page.on('worker', worker => {
            this.workerHandles.push(worker)
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
        const p_download = new PerformanceEntry('data download')
        const p_downloadTraces = new PerformanceEntry('trace download')
        const p_downloadTracesMain = new PerformanceEntry('trace download from main context')
        let analysis: AnalysisI<Trace>[]
        const analysisResults: string[] = (await this.page.evaluate(() => {
            // We cannot construct a string longer then a specific length
            // specifically for v8 the string must not be longer then 2^29 - 24 (~1GiB) for 64 bit systems
            // https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/length#
            //@ts-ignore
            const p_downloadTraces = performanceEvent(`compress traces from main thread`)
            const traces = analysis.map((r, i) => {
                //@ts-ignore
                const p_compressTrace = performanceEvent(`compress trace ${i} from main thread`)
                const trace = r.getResult().toString()
                //@ts-ignore
                self.performanceList.push(p_compressTrace.stop())
                return trace
            })
            //@ts-ignore
            self.performanceList.push(p_downloadTraces.stop())
            return traces
        }))
        this.performanceTraceLocal.push(p_downloadTracesMain.stop())
        const p_downloadTracesWorker = new PerformanceEntry('traces download from workers')
        const workerResults = await Promise.all(this.workerHandles.map(async (w, i) => {
            const p_downloadTrace = new PerformanceEntry(`download traces from worker ${i}`)
            const trace = await w.evaluate((i) => {
                //@ts-ignore
                const p_compressTraces = performanceEvent(`compress traces from worker ${i}`)
                const traces = analysis.map((r, j) => {
                    //@ts-ignore
                    const p_compressTrace = performanceEvent(`compress trace ${j} from worker ${i}`)
                    const trace = r.getResult().toString()
                    //@ts-ignore
                    self.performanceList.push(p_compressTrace.stop())
                    return trace
                })
                //@ts-ignore
                self.performanceList.push(p_compressTraces.stop())
                return traces
            }, i)
            this.performanceTraceLocal.push(p_downloadTrace.stop())
            return trace
        }))
        analysisResults.push(...workerResults.flat(1))
        this.performanceTraceLocal.push(p_downloadTracesWorker.stop())
        this.performanceTraceLocal.push(p_downloadTraces.stop())
        const p_bufferDownload = new PerformanceEntry('buffer download')
        const p_bufferDownloadMain = new PerformanceEntry('buffer download from main context')
        const originalWasmBuffer: number[][] = await this.page.evaluate(() => {
            try { originalWasmBuffer } catch {
                throw new Error('There is no WebAssembly instantiated on that page. Make sure this page actually uses WebAssembly and that you also invoked it through your interaction.')
            }
            return originalWasmBuffer.map(b => {
                return Array.from(b)
            })
        });
        this.performanceTraceLocal.push(p_bufferDownloadMain.stop())
        const p_bufferDownloadWorker = new PerformanceEntry('buffer download from workers')
        let workerBuffers = await Promise.all(this.workerHandles.map(w => w.evaluate(() => originalWasmBuffer)))
        if (workerBuffers.length !== 0) {
            originalWasmBuffer.push(...workerBuffers.flat(1))
        }
        this.performanceTraceLocal.push(p_bufferDownloadWorker.stop())
        this.performanceTraceLocal.push(p_bufferDownload.stop())
        this.performanceTraceLocal.push(p_download.stop())
        const p_performanceInfoDownload = new PerformanceEntry('performance info download')
        const performanceList: any = await this.page.evaluate(() => performanceList)
        const workerPerformanceLists = await Promise.all(this.workerHandles.map(w => w.evaluate(() => performanceList)))
        performanceList.push(...workerPerformanceLists.flat(1))
        performanceList.forEach(p => this.performanceTraceBrowser.push(new PerformanceEntry(p.name).buildFromObject(p)))
        this.performanceTraceLocal.push(p_performanceInfoDownload.stop())
        this.workerHandles = []
        this.browser.close()
        this.isRunning = false
        this.performanceTraceLocal.push(p_stop.stop())
        return analysisResults.map((result, i) => ({ result, wasm: originalWasmBuffer[i] }))
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


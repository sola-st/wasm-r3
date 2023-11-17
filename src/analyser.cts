import { Browser, chromium, Page, Worker } from 'playwright'
import fs from 'fs/promises'

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

    constructor(analysisPath: string) {
        this.analysisPath = analysisPath
    }

    async start(url: string, { headless } = { headless: false }) {
        if (this.isRunning === true) {
            throw new Error('Analyser is already running. Stop the Analyser before starting again')
        }
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
        return this.page
    }

    async stop(): Promise<AnalysisResult> {
        if (this.isRunning === false) {
            throw new Error('Analyser is not running. Start the Analyser before stopping')
        }
        const analysisResults: string[] = (await this.page.evaluate(() => {
            // We cannot construct a string longer then a specific length
            // specifically for v8 the string must not be longer then 2^29 - 24 (~1GiB) for 64 bit systems
            // https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/length#
            return analysisResults.map(r => JSON.stringify(r))
        }))

        const workerResults = await Promise.all(this.workerHandles.map((w) => w.evaluate(() => analysisResults.map(r => JSON.stringify(r)))))
        analysisResults.push(...workerResults.flat(1))
        const originalWasmBuffer: number[][] = await this.page.evaluate(() => {
            try { originalWasmBuffer } catch {
                throw new Error('There is no WebAssembly instantiated on that page. Make sure this page actually uses WebAssembly and that you also invoked it through your interaction.')
            }
            return originalWasmBuffer.map(b => {
                return Array.from(b)
            })
        });
        let workerBuffers = await Promise.all(this.workerHandles.map(w => w.evaluate(() => originalWasmBuffer)))
        if (workerBuffers.length !== 0) {
            originalWasmBuffer.push(...workerBuffers.flat(1))
        }
        this.workerHandles = []
        this.browser.close()
        this.isRunning = false
        return analysisResults.map((result, i) => ({ result, wasm: originalWasmBuffer[i] }))
    }

    private async constructInitScript() {
        const wasabiScript = await fs.readFile('./dist/wasabi.js') + '\n'
        let analysisScript = await fs.readFile(this.analysisPath) + '\n'
        analysisScript = analysisScript.split('Object.defineProperty(exports, "__esModule", { value: true });').join('')
        analysisScript = analysisScript.split('exports.default = setupAnalysis;').join('')
        const setupScript = await fs.readFile('./src/runtime.js') + '\n'
        return wasabiScript + analysisScript + setupScript
    }
}


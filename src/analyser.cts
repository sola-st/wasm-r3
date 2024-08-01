import { Browser, chromium, firefox, Frame, Page, webkit, Worker } from 'playwright'
import fs from 'fs/promises'
import { Trace } from './tracer.cjs'
import acorn from 'acorn'
import { trimFromLastOccurance } from '../tests/test-utils.cjs'

// read port from env
const CDP_PORT = process.env.CDP_PORT || 8080
export interface AnalysisI<T> {
    getResult(): T,
}

export interface AnalyserI {
    start: (url: string, options: { headless: boolean }) => Promise<Page>
    stop: () => Promise<AnalysisResult>
}

export type AnalysisResult = {
    result: string,
    wasm: number[]
}[]

type Options = { extended?: boolean, noRecord?: boolean, evalRecord?: boolean, firefox?: boolean, webkit?: boolean }
export class Analyser implements AnalyserI {

    private analysisPath: string
    private options: Options
    private browser: Browser
    private page: Page
    private downloadPaths: string[]
    private contexts: (Frame | Worker)[] = []
    private isRunning = false


    constructor(analysisPath: string, options: Options = { extended: false, noRecord: false }) {
        this.analysisPath = analysisPath
        this.options = options
    }

    async start(url, { headless } = { headless: false }) {
        if (this.isRunning === true) {
            throw new Error('Analyser is already running. Stop the Analyser before starting again')
        }
        this.isRunning = true
        let browserType = this.options.firefox ? firefox : this.options.webkit ? webkit : chromium;
        if (this.options.evalRecord) {
            this.browser = await chromium.connectOverCDP(`http://localhost:${CDP_PORT}`);
        } else {
            this.browser = await browserType.launch({
                headless, args: [
                    // '--disable-web-security',
                    '--js-flags="--max_old_space_size=8192"',
                    '--enable-experimental-web-platform-features',
                    '--experimental-wasm-multi-memory'
                ], downloadsPath: 'Downloads'
            });
        }
        this.page = await this.browser.newPage();
        this.page.on('pageerror', msg => {
            console.log(`Browser console error: ${msg}`);
        });
        this.downloadPaths = [];
        this.page.on('download', async (download) => {
            const suggestedFilename = download.suggestedFilename();
            await download.saveAs(suggestedFilename);
            this.downloadPaths.push(suggestedFilename);
        });
        this.page.setDefaultTimeout(120000);
        if (this.options.noRecord !== true) {
            await this.attachRecorder()
        }

        await this.page.goto(url, { timeout: 60000 })
        return this.page
    }

    async stop() {
        if (this.isRunning === false) {
            throw new Error('Analyser is not running. Start the Analyser before stopping')
        }
        this.contexts = this.contexts.concat(this.page.frames())
        const traces = (await this.getResults()).map(t => trimFromLastOccurance(t, 'ER'))
        const originalWasmBuffer = await this.getBuffers()
        this.contexts = []
        this.browser.close()
        this.isRunning = false
        return traces.map((result, i) => ({ result: result, wasm: originalWasmBuffer[i] }))
    }

    private async attachRecorder() {
        const initScript = await this.constructInitScript()

        await this.page.addInitScript({ content: initScript })

        await this.page.route('**/*', async (route) => {
            try {
                const response = await route.fetch()
                const headers = response.headers()

                // Remove or modify the CSP header
                delete headers['content-security-policy'];
                delete headers['content-security-policy-report-only']

                await route.fulfill({
                    status: response.status(),
                    headers: headers,
                    body: await response.body()
                });
            } catch (e) {
            }
        })

        await this.page.route(`**/*.js*`, async route => {
            let response
            try {
                response = await route.fetch()
            } catch {
                // this usually only happens when the browser is already closed. Only happens when running the test suite
                return
            }
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
    }

    private async getResults() {
        const results = await Promise.all(this.contexts.map(async (c) => {
            const traces = await c.evaluate(() => {
                try {
                    //@ts-ignore
                    const traces = (analysis as AnalysisI<Trace>[]).map((r, j) => {
                        const trace = r.getResult().toString()
                        return trace
                    })
                    return traces
                } catch {
                    return []
                }
            })
            return traces.map(t => t.toString())
        }))
        return results.flat(1)
    }

    private async getStats() {
        const stats = await Promise.all(
            this.contexts.map(async (c) => {
                const stats = await c.evaluate(() => {
                    try {
                        //@ts-ignore
                        const stats = analysis /*as AnalysisI<Trace>[]*/
                            .map((s, j) => {
                                const stat = s.getStats();
                                return stat;
                            });
                        return stats;
                    } catch {
                        return {};
                    }
                });
                return stats;
            })
        );
        return stats.flat(1);
    }

    private async getBuffers() {
        const downloadContents = await Promise.all(this.downloadPaths.map(async (filename) => {
            const content = await fs.readFile(filename);
            return Array.from(content);
        }));
        return downloadContents;
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
        const setupScript = await fs.readFile('./src/proxy.js') + '\n'
        return wasabiScript + ';' + analysisScript + ';' + setupScript + ';'
    }

    setExtended(extended: boolean) {
        this.options.extended = extended
    }

    getExtended() {
        return this.options.extended
    }
}

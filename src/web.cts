import { Browser, chromium, firefox, Frame, Page, webkit, Worker } from 'playwright'
import fs from 'fs/promises'
import acorn from 'acorn'
import { trimFromLastOccurance } from '../tests/test-utils.cjs'

// read port from env
const CDP_PORT = process.env.CDP_PORT || 8080

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
                ], downloadsPath: 'out'
            });
        }
        this.page = await this.browser.newPage();
        this.page.on('console', (message) => {
            // console.log(`Browser console: ${message.text()}`);
        });
        this.page.on('pageerror', msg => {
            console.log(`Browser pageerror: ${msg}`);
            throw new Error(`${msg}`);
        });
        this.downloadPaths = [];
        this.page.on('download', async (download) => {
            const suggestedFilename = './out' + download.suggestedFilename();
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
        let originalWasmBuffer;
        // make this configurable with options
        if (true) {
            originalWasmBuffer = await this.getBuffers()
        } else {
            originalWasmBuffer = await this.getBuffersThroughDownloads()
        }
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
                        const trace = r.trace.toString()
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

    private async getBuffers() {
        const originalWasmBuffer = await Promise.all(this.contexts.map(async (c) => {
            const buffer = await c.evaluate(() => {
                try {
                    return Array.from(originalWasmBuffer)
                } catch {
                    return []
                }
            })
            return buffer
        }))
        return originalWasmBuffer.flat(1) as number[][]
    }

    private async getBuffersThroughDownloads() {
        const downloadContents = await Promise.all(this.downloadPaths.map(async (filename) => {
            const content = await fs.readFile(filename);
            return Array.from(content);
        }));
        return downloadContents;
    }

    private async constructInitScript() {
        const wasabiScript = await fs.readFile('./wasabi/crates/wasabi_js/pkg/wasabi_js_merged.js') + '\n'
        const setupScript = await fs.readFile('./wasabi/crates/wasabi/js/r3.js') + '\n'
        return wasabiScript + ';' + setupScript + ';'
    }

    setExtended(extended: boolean) {
        this.options.extended = extended
    }

    getExtended() {
        return this.options.extended
    }
}

import fss from 'fs'
import path from 'path'
import { execSync } from 'child_process';
//@ts-ignore
import { instrument_wasm } from '../wasabi/wasabi_js.js'

export type Record = { binary: number[], trace: string }[]

type WasabiRuntime = string[]



export default class Benchmark {

    private record: Record
    private constructor() { }

    async save(benchmarkPath: string, options) {
        // await new Promise(resolve => setTimeout(resolve, 10 * 60 * 1000));
        if (!fss.existsSync(benchmarkPath)) await fs.mkdir(benchmarkPath, { recursive: true })
        await Promise.all(this.record.map(async ({ binary, trace }, i) => {
            // FIXME: enable back after hacking on slicedice
            // if (i != 1) return;
            const binPath = path.join(benchmarkPath, `bin_${i}`)
            if (!fss.existsSync(binPath)) await fs.mkdir(binPath)
            const tracePath = path.join(binPath, 'trace.r3')
            await fs.writeFile(tracePath, trace.toString())
            await fs.writeFile(path.join(binPath, 'index.wasm'), Buffer.from(binary))
            // FIXME: enable back after hacking on slicedice
            execSync(`./crates/target/release/replay_gen ${tracePath} ${path.join(binPath, 'index.wasm')} ${path.join(binPath, 'replay.wasm')}`);
            // execSync(`wasmtime ${path.join(binPath, 'replay.wasm')}`);
        }))
    }

    static fromAnalysisResult(result: AnalysisResult): Benchmark {
        const self = new Benchmark()
        self.record = result.map(r => ({ trace: r.result, binary: r.wasm }))
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
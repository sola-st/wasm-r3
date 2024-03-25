import { Browser, chromium, firefox, Frame, Page, webkit, Worker } from 'playwright'
import { createMeasure, StopMeasure } from './performance.cjs'
import fs from 'fs/promises'
import fss from 'fs'
import { Trace } from './tracer.cjs'
import acorn from 'acorn'
import { trimFromLastOccurance } from '../tests/test-utils.cjs'
import { WebSocketServer } from 'ws';
import path from 'path'
import { exec, execSync } from 'child_process'
import { askQuestion } from './util.cjs'

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
    private contexts: (Frame | Worker)[] = []
    private isRunning = false
    private p_measureUserInteraction: StopMeasure


    constructor(analysisPath: string, options: Options = { extended: false, noRecord: false }) {
        this.analysisPath = analysisPath
        this.options = options
    }

    async start(url, { headless } = { headless: false }) {
        if (this.isRunning === true) {
            throw new Error('Analyser is already running. Stop the Analyser before starting again')
        }
        const p_measureStart = createMeasure('start', { phase: 'record', description: `The time it takes start the chromium browser and open the webpage until the 'load' event is fired.` })
        this.isRunning = true
        let browserType = this.options.firefox ? firefox : this.options.webkit ? webkit : chromium;
        if (this.options.evalRecord) {
            let chromiumProcess = exec(`${chromium.executablePath()} --remote-debugging-port=9222 --js-flags='--slow-histograms'`, (err, stdout, stderr) => {
                if (err) {
                    console.error(err)
                    return
                }
                console.log(stdout)
            })
            process.on('exit', () => {
                chromiumProcess.kill();
            });
            this.browser = await chromium.connectOverCDP("http://localhost:9222/");
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
        this.page.setDefaultTimeout(120000);
        if (this.options.noRecord !== true) {
            await this.attachRecorder()
        }

        await this.page.goto(url, { timeout: 60000 })
        p_measureStart()
        this.p_measureUserInteraction = createMeasure('user interaction', { phase: 'record', description: `The time the user interacts with the webpage during recording, from the time the 'loal' event got fired in the browser until the user stopps the recording.` })
        return this.page
    }

    async stop() {
        if (this.isRunning === false) {
            throw new Error('Analyser is not running. Start the Analyser before stopping')
        }
        this.p_measureUserInteraction()
        const p_measureStop = createMeasure('stop', { phase: 'record', description: `The time it takes to stop the recording, from when the user stopped the recording until all data is downloaded from the browser and the browser is closed.` })
        this.contexts = this.contexts.concat(this.page.frames())
        const p_measureDataDownload = createMeasure('data download', { phase: 'record', description: `The time it takes to download all data from the browser.` })
        const p_measureTraceDownload = createMeasure('trace download', { phase: 'record', description: `The time it takes to download all traces from the browser.` })
        // const traces = (await this.getResults()).map(t => trimFromLastOccurance(t, 'ER'))
        const traces = await this.getResults()
        p_measureTraceDownload()
        const p_measureBufferDownload = createMeasure('buffer download', { phase: 'record', description: `The time it takes to download all wasm binaries from the browser.` })
        const originalWasmBuffer = await this.getBuffers()
        p_measureBufferDownload()
        p_measureDataDownload()
        await getHistogram(this.page)
        if (this.options.evalRecord) {
            process.exit(0)
        }
        this.contexts = []
        this.browser.close()
        this.isRunning = false
        p_measureStop()
        return traces.map((result, i) => ({ result: result, wasm: originalWasmBuffer[i] }))
    }

    private async attachRecorder() {
        const initScript = await this.constructInitScript()

        await this.page.addInitScript({ content: initScript })

        await this.page.route('**/*', async (route) => {
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
            const p_measureTraceDownload = createMeasure(`trace download from context: ${c.url()}`, { phase: 'record', description: `The time it takes to download the trace from the browser context: ${c.url}.` })
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
            p_measureTraceDownload()
            return traces.map(t => t.toString())
        }))
        return results.flat(1)
    }


    private async getBuffers() {
        const originalWasmBuffer = await Promise.all(this.contexts.map(async (c) => {
            const p_measureBufferDownload = createMeasure(`buffer download from context: ${c.url()}`, { phase: 'record', description: `The time it takes to download the wasm binary from the browser context: ${c.url}.` })
            const buffer = await c.evaluate(() => {
                try {
                    return Array.from(originalWasmBuffer)
                } catch {
                    return []
                }
            })
            p_measureBufferDownload()
            return buffer
        }))
        return originalWasmBuffer.flat(1) as number[][]
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
        const setupScript = await fs.readFile('./src/wasabi-runtime.js') + '\n'
        return wasabiScript + ';' + analysisScript + ';' + setupScript + ';'
    }

    setExtended(extended: boolean) {
        this.options.extended = extended
    }

    getExtended() {
        return this.options.extended
    }
}

export class CustomAnalyser implements AnalyserI {
    private browser: Browser
    private page: Page
    private contexts: (Frame | Worker)[] = []
    private isRunning = false
    private p_measureUserInteraction: StopMeasure
    private benchmarkPath: string
    private javascript: boolean;
    private wss: WebSocketServer;
    private port: number;

    constructor(benchmarkPath: string, options: any) {
        this.benchmarkPath = benchmarkPath;
        this.javascript = options.javascript;
        this.port = options.port ?? 8080;

        this.wss = new WebSocketServer({ port: this.port, maxPayload: 1_000_000_000 });
        let traceContexts: { [context: string]: fss.WriteStream } = {}
        let lookupContexts: { [context: string]: fss.WriteStream } = {}
        let nextSubbenchmarkIndex = 0
        this.wss.on('connection', async function connection(ws, request) {
            ws.on('error', console.error)
            ws.on('message', async function message(data) {
                let buffer: Buffer;
                if (data instanceof ArrayBuffer) {
                    // Convert ArrayBuffer to Buffer
                    buffer = Buffer.from(data);
                } else if (Array.isArray(data)) {
                    buffer = data[0]
                } else {
                    buffer = data;
                }
                const hrefLength = new Uint8Array(buffer)[buffer.length - 2]
                const hrefStartIndex = buffer.length - hrefLength - 2
                const type = new Uint8Array(buffer)[buffer.length - 1]
                const trace = buffer.slice(0, hrefStartIndex)
                const hrefBytes = buffer.slice(hrefStartIndex, buffer.length - 2)
                const href = new TextDecoder().decode(hrefBytes)

                if (type === 0) {
                    if (traceContexts[href] === undefined) {
                        const subBenchmarkPath = path.join(benchmarkPath, href)
                        const traceFilePath = path.join(subBenchmarkPath, 'trace.bin')
                        fss.mkdirSync(subBenchmarkPath, { recursive: true })
                        traceContexts[href] = fss.createWriteStream(traceFilePath)
                        nextSubbenchmarkIndex++
                    }
                    traceContexts[href].write(trace)
                } else if (type === 1) {
                    if (lookupContexts[href] === undefined) {
                        const subBenchmarkPath = path.join(benchmarkPath, href)
                        const lookupFilePath = path.join(subBenchmarkPath, 'trace.bin.lookup')
                        fss.mkdirSync(subBenchmarkPath, { recursive: true })
                        lookupContexts[href] = fss.createWriteStream(lookupFilePath)
                        nextSubbenchmarkIndex++
                    }
                    let array = new Uint8Array(trace)
                    let idxes = convertUint8ArrayToI32Array(array).join('\n')
                    lookupContexts[href].write(idxes)
                    console.log("Wrote")
                } else {
                    throw new Error(`Type ${type} of data is neither trace nor lookup`)
                }
            })
        })
    }

    async start(url: string, { headless } = { headless: false }) {
        if (this.isRunning === true) {
            throw new Error('Analyser is already running. Stop the Analyser before starting again')
        }
        const p_measureStart = createMeasure('start', { phase: 'record', description: `The time it takes start the chromium browser and open the webpage until the 'load' event is fired.` })
        fss.mkdirSync(this.benchmarkPath);
        this.isRunning = true
        this.browser = await chromium.launch({ // chromium version: 119.0.6045.9 (Developer Build) (x86_64); V8 version: V8 11.9.169.3; currently in node I run version 11.8.172.13-node.12
            headless, args: [
                // '--disable-web-security',
                '--js-flags="--max_old_space_size=8192"',
                '--enable-experimental-web-platform-features',
                '--enable-features=WebAssemblyUnlimitedSyncCompilation',
            ]
        });
        // this.browser = await chromium.launch({ // chromium version: 119.0.6045.9 (Developer Build) (x86_64); V8 version: V8 11.9.169.3; currently in node I run version 11.8.172.13-node.12
        //     headless, args: ['--experimental-wasm-multi-memory', '--start-fullscreen']
        //     // headless, args: ['--start-maximized']
        // });
        let context = await this.browser.newContext()
        this.page = await context.newPage();
        this.page.setDefaultTimeout(120000);
        await this.attachRecorder()

        await this.page.goto(url, { timeout: 60000 })
        p_measureStart()
        this.p_measureUserInteraction = createMeasure('user interaction', { phase: 'record', description: `The time the user interacts with the webpage during recording, from the time the 'load' event got fired in the browser until the user stops the recording.` })
        return this.page
    }

    async stop(): Promise<AnalysisResult> {
        if (this.isRunning === false) {
            throw new Error('Analyser is not running. Start the Analyser before stopping')
        }
        this.p_measureUserInteraction()
        const p_measureStop = createMeasure('stop', { phase: 'record', description: `The time it takes to stop the recording, from when the user stopped the recording until all data is downloaded from the browser and the browser is closed.` })
        this.contexts = this.contexts.concat(this.page.frames())
        const p_measureDataDownload = createMeasure('data download', { phase: 'record', description: `The time it takes to download all data from the browser.` })
        await this.traceToServer()
        // await askQuestion("Downloading trace. Continue? ")
        console.log("Downloading buffers...")
        const p_measureBufferDownload = createMeasure('buffer download', { phase: 'record', description: `The time it takes to download all wasm binaries from the browser.` })
        const originalWasmBuffer = await this.getBuffers()
        p_measureBufferDownload()
        p_measureDataDownload()
        this.contexts = []
        await this.wss.close()
        await this.browser.close()
        this.isRunning = false
        p_measureStop()
        const binName = 'index.wasm'
        const watName = 'index.wat'
        const replayName = 'replay.js'
        const replayWasm = 'replay.wasm'
        const traceName = 'trace.bin'
        const traceTextName = 'trace.r3'
        const p_measureCodeGen = createMeasure('rust-backend', { phase: 'replay-generation', description: `The time it takes for rust backend to generate javascript` })
        originalWasmBuffer.forEach(({ href, buffer }, i) => {
            const subBenchmarkPath = path.join(this.benchmarkPath, href)
            if (!fss.existsSync(path.join(subBenchmarkPath))) {
                return
            }
            fss.writeFileSync(path.join(subBenchmarkPath, binName), new Int8Array(buffer))
            const tracePath = path.join(subBenchmarkPath, traceName)
            const traceTextPath = path.join(subBenchmarkPath, traceTextName)
            const binPath = path.join(subBenchmarkPath, binName)
            const watPath = path.join(subBenchmarkPath, watName)
            const jsPath = path.join(subBenchmarkPath, replayName)
            const wasmPath = path.join(subBenchmarkPath, replayWasm)
            execSync(`wasm-tools print ${binPath} -o ${watPath}`)
            console.log(i, "done")
            console.log(i, "stringify trace...")
            execSync(`./target/release/replay_gen stringify ${tracePath} ${binPath} ${traceTextPath}`)
            console.log(i, "done")
            console.log(i, "generate replay...")
            if (this.javascript) {
                execSync(`./target/release/replay_gen generate ${tracePath} ${binPath} true ${jsPath}`);
            } else {
                execSync(`./target/release/replay_gen generate ${tracePath} ${binPath} true ${wasmPath}`);
            }

            console.log(i, "done")
        })
        p_measureCodeGen()
        return originalWasmBuffer.map(({ href, buffer }) => {
            return ({ result: '', wasm: buffer })
        })
    }

    async forceQuit() {
        if (this.isRunning == false) {
            return
        }
        this.browser.close()
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
                // I dont really care if something is messed up here. Honestly
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

    private async traceToServer() {
        const results = await Promise.all(this.contexts.map(async (c) => {
            try {
                await c.evaluate(() => {
                    try {
                        //@ts-ignore
                        for (let check of r3_check_mems) {
                            check()
                        }
                    } catch {
                        // ok
                    }
                })
            } catch (e) {
                console.log(e.message)
            }
        }))
    }


    private async getBuffers() {
        const originalWasmBuffer = await Promise.all(this.contexts.map(async (c) => {
            const p_measureBufferDownload = createMeasure(`buffer download from context: ${c.url()}`, { phase: 'record', description: `The time it takes to download the wasm binary from the browser context: ${c.url}.` })
            try {
                const buffer = await c.evaluate(() => {
                    try {
                        return Array.from(originalWasmBuffer)
                    } catch {
                        return []
                    }
                })
                p_measureBufferDownload()
                return buffer
            } catch (e) {
                console.log(e.message)
            }
        }))
        // TODO: is it okay to filter undefined?
        return originalWasmBuffer.flat(1).filter(v => v != undefined) as { buffer: any, href: string }[]
    }

    private async constructInitScript() {
        const tracerScript = await fs.readFile('./dist/tracer.js') + '\n'
        let setupScript = await fs.readFile('./src/tracer-runtime.js', 'utf-8')
        setupScript = setupScript.replace('8080', `${this.port}`) + '\n'
        return tracerScript + ';' + setupScript + ';'
    }
}

async function getHistogram(page: Page) {
    await page.goto('chrome://histograms/')
    let ems = await page.locator('css=span.histogram-header-text').allTextContents()
    let histogramValue = ems.find(value => value.startsWith('Histogram: V8.ExecuteMicroSeconds'))
    console.log(histogramValue)
}

function convertUint8ArrayToI32Array(uint8Array: Uint8Array) {
    let i32Array = [];
    for (let i = 0; i < uint8Array.length; i += 4) {
        // Combine 4 bytes (uint8) into one 32-bit integer
        let i32 = (uint8Array[i + 3] << 24) | (uint8Array[i + 2] << 16) | (uint8Array[i + 1] << 8) | uint8Array[i + 0];

        // Handle sign (since bitwise operations in JavaScript use signed 32-bit integers)
        i32 = i32 >>> 0;

        i32Array.push(i32);
    }
    return i32Array;
}
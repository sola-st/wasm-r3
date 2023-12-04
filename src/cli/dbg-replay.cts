import path from "path"
import Benchmark from "../benchmark.cjs"
import Tracer from '../tracer.cjs'

async function run() {
    const bPath = './ffmpeg'
    const benchmark = await Benchmark.read(bPath)
    const runtime = benchmark.instrumentBinaries()[0]
    const { binary, trace } = benchmark.getRecord()[0]
    const replayPath = '/Users/jakob/Desktop/wasm-r3/ffmpeg/bin_0/replay.js'

    let tracer = new Tracer(eval(runtime + `\nWasabi`), { extended: true })
    let replayBinary
    console.log(replayPath)
    replayBinary = (await import(replayPath))
    const wasm = await replayBinary.instantiate(Buffer.from(binary))
    tracer.init()
    await replayBinary.replay(wasm)
}
run()
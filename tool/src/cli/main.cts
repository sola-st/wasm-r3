import fs from 'fs'
import path from 'path'
import Generator from "../replay-generator.cjs";
import record from '../instrumenter.cjs';
import stringifyTrace from '../trace-stringify.cjs';

async function main() {
    const url = process.argv[2]
    const benchmarkPath = process.argv[3]
    const { binary, trace } = await record(url)
    fs.mkdirSync(benchmarkPath)
    fs.writeFileSync(path.join(benchmarkPath, 'trace.r3'), stringifyTrace(trace))

    // const traceString = fs.readFileSync(path.join(process.cwd(), process.argv[3]), 'utf-8')
    // const trace = parse(traceString)
    const jsString = new Generator().generateReplay(trace).toString()
    fs.writeFileSync(path.join(benchmarkPath, 'replay.js'), jsString)
    fs.writeFileSync(path.join(benchmarkPath, 'index.wasm'), Buffer.from(binary))
}

main()
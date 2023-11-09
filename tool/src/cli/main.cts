import fs from 'fs'
import path from 'path'
import Generator from "../replay-generator.cjs";
import record from '../instrumenter.cjs';
import stringifyTrace from '../trace-stringify.cjs';

async function main() {
    const url = process.argv[2]
    const benchmarkPath = process.argv[3]
    const results = await record(url)
    fs.mkdirSync(benchmarkPath)
    results.map(({ binary, trace }, i) => {
        const binPath = path.join(benchmarkPath, `bin_${i}`)
        fs.mkdirSync(binPath)
        fs.writeFileSync(path.join(binPath, 'trace.r3'), stringifyTrace(trace))
        const jsString = new Generator().generateReplay(trace).toString()
        fs.writeFileSync(path.join(binPath, 'replay.js'), jsString)
        fs.writeFileSync(path.join(binPath, 'index.wasm'), Buffer.from(binary))
    })
}

main()
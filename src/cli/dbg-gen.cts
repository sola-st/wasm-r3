import Generator from "../replay-generator.cjs"
import fs from 'fs'

async function run() {
    const tPath = './jsc/bin_0/trace.r3'
    const stream = fs.createReadStream(tPath)
    new Generator().generateReplayFromStream(stream)
}
run()
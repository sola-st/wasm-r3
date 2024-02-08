import cp from 'child_process'
import fs from 'fs/promises'
import path from 'path'
import { stdout } from 'process'
import { writeWithSpaces } from './test-utils.cjs'

const onlinePath = './tests/online'

async function run() {
    console.log('Deno, Bun and Node need to be installed')
    console.log('Also you should probably run run-tests.cts -j first to have the benchmarks available')
    let folders = await fs.readdir(onlinePath);
    // folders = ['funky-kart']
    for (let folder of folders) {
        let benchmarkPath = path.join(onlinePath, folder, 'benchmark')
        let subBenchmarks
        try {
            subBenchmarks = await fs.readdir(benchmarkPath)
        } catch {
            continue
        }
        let node: any = true
        let deno: any = true
        let bun: any = true
        writeWithSpaces(folder + ':')
        for (let subBenchmark of subBenchmarks) {
            let replay = path.join(benchmarkPath, subBenchmark, 'replay.js')
            try {
                cp.execSync(`node ${replay} run`)
            } catch (e) {
                node = e
            }
            try {
                cp.execSync(`deno run --allow-read ${replay} run`)
            } catch (e) {
                deno = e
            }
            try {
                cp.execSync(`bun run ${replay} run`)
            } catch (e) {
                bun = e
            }
        }
        console.log(`Node: ${node},\tDeno: ${deno},\tBun: ${bun}`)
    }
}


run();
console.log("You have to first run `run-tests.cts` with `-j` option because the replays should be already generated.")
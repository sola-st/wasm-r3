import fs from 'fs'
import path from 'path'
import cp from 'child_process'
import { parse, generate } from '../replay-generator'

const testDir = import.meta.dir

let testNames = getDirectoryNames(testDir)
if (process.argv.length > 2) {
    testNames = testNames.filter(n => process.argv.includes(n))
}
testNames = ['test05']

console.log(`running tests: ${testNames}`)

console.log('First lets generate the traces')
for (let name of testNames) {
    let testPath = path.join(testDir, name)
    cp.execSync(`wat2wasm ${path.join(testPath, 'index.wat')} -o ${path.join(testPath, 'index.wasm')}`)
    cp.execSync(`wasabi ${path.join(testPath, 'index.wasm')} -o ${testPath}`)
    let gen = fs.readFileSync(path.join(testPath, 'index.wasabi.js')) + '\n'
    gen = removeLinesWithConsole(gen)
    gen += fs.readFileSync(path.join(testDir, '../recorder/tracer.js')) + '\n'
    gen += fs.readFileSync(path.join(testPath, 'test.js')) + '\n'
    const genPath = path.join(testPath, 'gen.js')
    fs.writeFileSync(genPath, gen)
    await import(genPath)
    await delay(1000)
    cleanUp(testPath)
}

console.log('Second lets generate the replay binaries')
for (let name of testNames) {
    let testPath = path.join(testDir, name)
    let traceString = fs.readFileSync(path.join(testPath, 'trace.r3'), 'utf-8')
    let trace = parse(traceString)
    let replayCode = generate(trace)
    fs.writeFileSync(path.join(testPath, 'replay.js'), replayCode)
}

console.log(`done running ${testNames.length} tests`)


function removeLinesWithConsole(inputString: string) {
    const lines = inputString.split('\n');
    const filteredLines = lines.filter(line => !line.includes('console'));
    return filteredLines.join('\n');
}

function getDirectoryNames(folderPath: string) {
    const entries = fs.readdirSync(folderPath, { withFileTypes: true });

    const directories = entries
        .filter((entry) => entry.isDirectory())
        .map((entry) => entry.name);

    return directories;
}

function cleanUp(testPath: string) {
    fs.rmSync(path.join(testPath, 'gen.js'))
    fs.rmSync(path.join(testPath, 'index.wasabi.js'))
    fs.rmSync(path.join(testPath, 'index.wasm'))
}

function delay(ms: number) {
    return new Promise(resolve => {
        setTimeout(resolve, ms);
    });
}
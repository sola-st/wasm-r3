import fs from 'fs'
import path from 'path'
import cp from 'child_process'
import generate from '../src/replay-generator'
import parse from '../src/trace-parser'

const testDir = import.meta.dir

let testNames = getDirectoryNames(testDir)
if (process.argv[2] === 'clean') {
    for (let name of testNames) {
        const testPath = path.join(testDir, name)
        rmSafe(path.join(testPath, 'gen.js'))
        rmSafe(path.join(testPath, 'replayGen.js'))
        rmSafe(path.join(testPath, 'index.wasabi.js'))
        rmSafe(path.join(testPath, 'index.wasm'))
        rmSafe(path.join(testPath, 'trace.r3'))
        rmSafe(path.join(testPath, 'replay-trace.r3'))
        rmSafe(path.join(testPath, 'replay.js'))
        rmSafe(path.join(testPath, 'report.txt'))
    }
    process.exit(0)
}
if (process.argv.length > 2) {
    testNames = testNames.filter(n => process.argv.includes(n))
}

// testNames = ["test01"]

process.stdout.write(`Executing Tests ... \n`)
for (let name of testNames) {
    process.stdout.write(writeTestName(name))
    const testPath = path.join(testDir, name)
    const watPath = path.join(testPath, 'index.wat')
    const wasmPath = path.join(testPath, 'index.wasm')
    const wasabiRuntimePath = path.join(testPath, 'index.wasabi.js')
    const tracerPath = path.join(testDir, '../src/tracer.js')
    const genPath = path.join(testPath, 'gen.js')
    const tracePath = path.join(testPath, 'trace.r3')
    const replayPath = path.join(testPath, 'replay.js')
    const replayGenPath = path.join(testPath, 'replayGen.js')
    const replayTracePath = path.join(testPath, 'replay-trace.r3')
    const testReportPath = path.join(testPath, 'report.txt')

    // console.log('1. Generate trace')
    cp.execSync(`wat2wasm ${watPath} -o ${path.join(testPath, 'index.wasm')}`)
    cp.execSync(`wasabi ${wasmPath} --hooks=begin,store,load,call -o ${testPath}`)
    const stream = fs.createWriteStream(genPath)
    stream.write(`const fs = require('fs')\n`)
    stream.write(`const path = require('path')\n`)
    // stream.write(`${lodashDependency}\n`)
    stream.write(removeLinesWithConsole(fs.readFileSync(wasabiRuntimePath, 'utf-8')) + '\n')
    stream.write(fs.readFileSync(tracerPath) + '\n')
    stream.write(`async function run() {\n`)
    stream.write(`let wasmBinary = fs.readFileSync('${wasmPath}')\n`)
    stream.write(fs.readFileSync(path.join(testPath, 'test.js')) + '\n')
    stream.write(`fs.writeFileSync('${tracePath}', stringifyTrace(trace))\n`)
    stream.write(`}\n`)
    stream.write(`run()\n`)
    stream.end()
    try {
        cp.execSync(`bun ${genPath}`)
    } catch (e: any) {
        fail(e.toString(), testReportPath)
        continue
    }

    // console.log('2. Generate replay binary')
    const traceString = fs.readFileSync(tracePath, 'utf-8')
    let trace
    try {
        trace = parse(traceString)
    } catch (e: any) {
        fail(e.toString(), testReportPath)
        continue
    }
    let replayCode
    try {
        replayCode = generate(trace!)
    } catch (e: any) {
        fail(e.toString(), testReportPath)
        continue
    }
    fs.writeFileSync(replayPath, replayCode!)

    // console.log('3. Check if original trace and replay trace match')
    const replayStream = fs.createWriteStream(replayGenPath)
    // replayStream.write(`${lodashDependency}\n`)
    replayStream.write(removeLinesWithConsole(fs.readFileSync(wasabiRuntimePath, 'utf-8')) + '\n')
    replayStream.write(fs.readFileSync(tracerPath) + '\n')
    replayStream.write(`async function run() {\n`)
    replayStream.write(fs.readFileSync(replayPath) + '\n')
    replayStream.write(`}\n`)
    replayStream.write(`run().then(() => require('fs').writeFileSync('${replayTracePath}', stringifyTrace(trace)))\n`)
    replayStream.end()
    try {
        cp.execSync(`bun ${replayGenPath}`)
    } catch (e: any) {
        fail(e.toString(), testReportPath)
        continue
    }
    let replayTrace = fs.readFileSync(replayTracePath, 'utf-8')
    if (replayTrace !== traceString) {
        let report = `[Expected]\n`
        report += traceString
        report += `\n\n`
        report += `[Actual]\n`
        report += replayTrace
        fail(report, testReportPath)
    } else {
        process.stdout.write(`\u2713\n`)
    }
}

// console.log('Lets cleanup the test folders because we generated a lot of junk...')
// for (let name of testNames) {
//     let testPath = path.join(testDir, name)
//     cleanUp(testPath)
// }

process.stdout.write(`done running ${testNames.length} tests\n`)


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
    fs.rmSync(path.join(testPath, 'replayGen.js'))
    fs.rmSync(path.join(testPath, 'index.wasabi.js'))
    fs.rmSync(path.join(testPath, 'index.wasm'))
}

function fail(report: string, testReportPath: string) {
    process.stdout.write(`\u2717\t\t${testReportPath}\n`)
    fs.writeFileSync(testReportPath, report)
}

function writeTestName(name: string) {
    const totalLength = 35
    if (totalLength < name.length) {
        throw 'Total length should be greater than or equal to the length of the initial word.'
    }
    const spacesLength = totalLength - name.length
    const spaces = ' '.repeat(spacesLength)
    return `${name}${spaces}`
}

function rmSafe(path: string) {
    try {
        fs.rmSync(path)
    } catch {
        // file doesnt exist, ok
    }
}
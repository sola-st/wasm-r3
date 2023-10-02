import fs from 'fs'
import path from 'path'
import cp from 'child_process'
import { parse, generate } from '../replay-generator'
import stringifyTrace from '../recorder/stringify'
import assert from 'assert'

const testDir = import.meta.dir

let testNames = getDirectoryNames(testDir)
if (process.argv.length > 2) {
    testNames = testNames.filter(n => process.argv.includes(n))
}

console.log(`running tests: ${testNames}`)

for (let name of testNames) {
    console.log(`Test ${name}`)
    let testPath = path.join(testDir, name)

    console.log('1. Generate trace')
    cp.execSync(`wat2wasm ${path.join(testPath, 'index.wat')} -o ${path.join(testPath, 'index.wasm')}`)
    cp.execSync(`wasabi ${path.join(testPath, 'index.wasm')} --hooks=begin,store,load,call -o ${testPath}`)
    let gen = fs.readFileSync(path.join(testPath, 'index.wasabi.js')) + '\n'
    gen = removeLinesWithConsole(gen)
    gen += fs.readFileSync(path.join(testDir, '../recorder/tracer.js')) + '\n'
    gen += fs.readFileSync(path.join(testPath, 'test.js')) + '\n'
    const genPath = path.join(testPath, 'gen.js')
    fs.writeFileSync(genPath, gen)
    let test
    test = await import(genPath)
    let trace = await test.default()
    fs.writeFileSync(path.join(testPath, 'trace.r3'), stringifyTrace(trace))

    console.log('2. Generate replay binary')
    // trace = parse(stringifyTrace(trace)) // test out if string conversion works
    let replayCode = generate(trace)
    fs.writeFileSync(path.join(testPath, 'replay.js'), replayCode)
    let origTrace = stringifyTrace(trace)

    console.log('3. Check if original trace and replay trace match')
    let gen2 = ''
    gen2 = fs.readFileSync(path.join(testPath, 'index.wasabi.js')) + '\n'
    gen2 = removeLinesWithConsole(gen2)
    gen2 += fs.readFileSync(path.join(testDir, '../recorder/tracer.js')) + '\n'
    gen2 += `export default async function() {\n`
    gen2 += fs.readFileSync(path.join(testPath, 'replay.js')) + '\n'
    // gen2 += `fs.writeFileSync(path.join('${testPath}', 'replay-trace.r3'), stringifyTrace(trace))\n`
    gen2 += `return trace\n`
    gen2 += `}`
    const replayGenPath = path.join(testPath, 'replayGen.js')
    fs.writeFileSync(replayGenPath, gen2)
    let ref = await import(replayGenPath)
    let refTrace = await ref.default()
    console.log(refTrace)
    let replayTrace = stringifyTrace(refTrace)
    if (replayTrace !== origTrace) {
        console.error(`Test ${name} failed`)
        console.error(`Expected:\n ${origTrace}`)
        console.error(`Actual:\n ${replayTrace}`)
    } else {
        console.log(`Test ${name} successfull`)
    }
}

// console.log('Lets cleanup the test folders because we generated a lot of junk...')
// for (let name of testNames) {
//     let testPath = path.join(testDir, name)
//     cleanUp(testPath)
// }

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
    fs.rmSync(path.join(testPath, 'replayGen.js'))
    fs.rmSync(path.join(testPath, 'index.wasabi.js'))
    fs.rmSync(path.join(testPath, 'index.wasm'))
}

function delay(ms: number) {
    return new Promise(resolve => {
        setTimeout(resolve, ms);
    });
}
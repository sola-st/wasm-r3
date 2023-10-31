import fs from 'fs'
import path from 'path'
import cp from 'child_process'

const tracerContent = fs.readFileSync(path.join(path.dirname(import.meta.url.replace(/^file:/, '')), './src/tracer.cts'), 'utf-8')
let lines = tracerContent.split('\n')

const writeStream = fs.createWriteStream(path.join(path.dirname(import.meta.url.replace(/^file:/, '')), './src/tracer-node.cts'))
writeStream.write(`${lines[0]}\n`)
writeStream.write(`${lines[1]}\n`)
writeStream.write(`import _ from 'lodash'\n`)
writeStream.write(`export default function tracer(runtimePath: string) {\n`)
writeStream.write(`let Wasabi = require(runtimePath)\n`)
for (let i = 4; i < lines.length; ++i) {
    writeStream.write(`${lines[i]}\n`)
}
writeStream.write(`return trace\n`)
writeStream.write(`}`)

cp.execSync('npx tsc')

const tracerPath = path.join(path.dirname(import.meta.url.replace(/^file:/, '')), './dist/src/tracer.cjs')
const tracer = fs.readFileSync(tracerPath, 'utf-8')
lines = tracer.split("\n")
lines.splice(1, 1)
fs.writeFileSync(tracerPath, lines.join('\n'))
import fs from 'fs'
import path from 'path'
import cp from 'child_process'

const dirname = path.dirname(import.meta.url.replace(/^file:/, ''))

// Compile Typescript
cp.execSync('npx tsc')
const jsTracerPath = path.join(dirname, './dist/src/tracer.cjs')
const tracer = fs.readFileSync(jsTracerPath, 'utf-8')
let lines = tracer.split("\n")
// lines.splice(1, 1)
// fs.writeFileSync(jsTracerPath, lines.join('\n'))

// Create the r3 browser runtime
const runtimeWS = fs.createWriteStream(path.join(dirname, './dist/wasabi.js'))
runtimeWS.write(`const wasabiBinary = '`)
runtimeWS.write(fs.readFileSync(path.join(dirname, 'wasabi/wasabi_base64'), 'utf-8'))
runtimeWS.write(`'\n`)
let wasabiJsApi = fs.readFileSync(path.join(dirname, 'wasabi/wasabi_js.js'), 'utf-8')
wasabiJsApi = wasabiJsApi.replace(/export function/g, 'function')
wasabiJsApi = wasabiJsApi.replace(/export { initSync }/g, '')
wasabiJsApi = wasabiJsApi.replace(/export default __wbg_init;/g, '')
wasabiJsApi = wasabiJsApi.replace(/input = new URL\('wasabi_js_bg\.wasm', import\.meta\.url\);/g, '')
runtimeWS.write(wasabiJsApi)
runtimeWS.write('\n')
// runtimeWS.write(fs.readFileSync(path.join(dirname, 'src/runtime.js'), 'utf-8'))
// runtimeWS.write('\n')
// runtimeWS.write('function setupTracer() {\n')
// for (let i = 0; i < 11; i++) {
//     runtimeWS.write(lines[i] + '\n')
// }
// runtimeWS.write('function setupTracer() {\n')
// for (let i = 11; i < lines.length; i++) {
//     runtimeWS.write(lines[i] + '\n')
// }
// runtimeWS.write('return trace\n')
// runtimeWS.write('}\n')
runtimeWS.close()
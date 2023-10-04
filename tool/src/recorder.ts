import path from 'path'
import { execSync } from 'child_process'

// let folder = '/Users/jakob/Desktop/wasm-r3/tool/recorder/tests/bb'
// let filename = 'bb.wasm'
let folder = '/Users/jakob/Desktop/wasm-r3/tool/recorder/tests/tictactoe-game-wasm'
let filename = "tic_tac_toe.wasm"
let js_file = "tic_tac_toe.js"
let html_file = "index.html"

function addMemExportHack(pathToWasm: string) {
    execSync(`wasm2wat ${pathToWasm} -o ${pathToWasm}.wat`)
    let sedCmd = `sed -i '/(memory/a (export "memory")' ${pathToWasm}`
    console.log(sedCmd)
    execSync(sedCmd)
    // execSync(`sed -i '/(memory/a (export "memory")' ${pathToWasm}`)
    execSync(`wat2wasm ${pathToWasm} -o ${pathToWasm}`)
    execSync(`rm ${pathToWasm}`)
}

function instrument(folder: string, wasmFile: string): boolean {
    console.log('Instrumenting...')
    let pathToWasm = path.join(folder, wasmFile)
    // addMemExportHack(pathToWasm)
    let wasabiCmd = `wasabi ${pathToWasm} -o ${path.join(folder, 'out')}`
    console.log(wasabiCmd)
    execSync(wasabiCmd)
    execSync(`cp ${path.join(import.meta.dir, 'tracer.js')} ${path.join(folder, 'tracer.js')}`)
    execSync(`mv ${pathToWasm} ${pathToWasm}.bak`)
    execSync(`mv ${path.join(folder, 'out', wasmFile)} ${pathToWasm}`)
    let awkCmd = `awk '/<script async type="text\\\/javascript" src="${js_file}"><\\\/script>/ {print; print "<script src=\\\".\\\/out\\\/${path.parse(wasmFile).name}.wasabi.js\\\"><\\\/script>"; print "<script src=\\\"tracer.js\\\"><\\\/script>"; next} 1' ${path.join(folder, html_file)} > /tmp/${html_file} && mv /tmp/${html_file} ${path.join(folder, html_file)}`
    execSync(awkCmd)
    console.log('done')
    return true
}

function serve_application(folder: string): boolean {
    console.log('Serving...')
    execSync(`cd ${folder} && python3 -m http.server`)
    console.log('done')
    return true
}


instrument(folder, filename)
serve_application(folder)
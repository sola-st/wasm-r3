import path from 'path'
import { execSync } from 'child_process'

function instrument(folder: string, wasmFile: string): boolean {
    console.log('Instrumenting...')
    let wasabiCmd = `wasabi ${path.join(folder, wasmFile)} -o ${path.join(folder, 'out')}`
    execSync(wasabiCmd)
    execSync(`cp ${path.join(import.meta.dir, 'tracer.js')} ${path.join(folder, 'tracer.js')}`)
    execSync(`mv ${path.join(folder, wasmFile)} ${path.join(folder, wasmFile)}.bak`)
    execSync(`mv ${path.join(folder, 'out', wasmFile)} ${path.join(folder, wasmFile)}`)
    let awkCmd = `awk '/<script async type="text\\\/javascript" src="bb.js"><\\\/script>/ {print; print "<script src=\\\".\\\/out\\\/${path.parse(wasmFile).name}.wasabi.js\\\"><\\\/script>"; print "<script src=\\\"tracer.js\\\"><\\\/script>"; next} 1' ${path.join(folder, 'bb.html')} > /tmp/bb.html && mv /tmp/bb.html ${path.join(folder, 'bb.html')}`
    execSync(awkCmd)
    console.log('done')
    return true
}

function serve_application(folder: string): boolean {
    console.log('Serving...')
    execSync(`cd /Users/jakob/Desktop/wasm-r3/tool/recorder/tests/bb && python3 -m http.server`)
    console.log('done')
    return true
}

let folder = '/Users/jakob/Desktop/wasm-r3/tool/recorder/tests/bb'
let filename = 'bb.wasm'
instrument(folder, filename)
serve_application(folder)

// awk '/<script async type="text\/javascript" src="bb.js"><\/script>/ {print; print "<script src=\".\/out\/bb.wasabi.js\"><\/script>"; print "<script src=\"\/Users\/jakob\/Desktop\/wasm-r3\/tool\/recorder\/tracer.js\"><\/script>"; next} 1' /Users/jakob/Desktop/wasm-r3/tool/recorder/tests/bb/bb.html > /tmp/bb.html && mv /tmp/bb.html /Users/jakob/Desktop/wasm-r3/tool/recorder/tests/bb/bb.html
// awk '/<script async type="text\/javascript" src="bb.js"><\/script>/ {print; print "<script src=\".\/out\/bb.wasabi.js\"><\/script>"; print "<script src=\"\/Users\/jakob\/Desktop\/wasm-r3\/tool\/recorder\/tracer.js\"><\/script>"; next} 1' /Users/jakob/Desktop/wasm-r3/tool/recorder/tests/bb/bb.html > /tmp/bb.html && mv /tmp/bb.html /Users/jakob/Desktop/wasm-r3/tool/recorder/tests/bb/bb.html
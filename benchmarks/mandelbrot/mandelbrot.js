import fs from 'fs'
import { execSync } from 'child_process';

execSync('wasm-tools parse mandelbrot_whole.wat -o mandelbrot_whole.wasm');
execSync('wasm-tools parse mandelbrot_part.wat -o mandelbrot_part.wasm');

export default async function test() {
    let part
    let imports = {
        part: {
            66: () => {
                part.exports["66"]();
            },
        }
    }
    let wholeBinary = fs.readFileSync('./mandelbrot_whole.wasm')
    let partBinary = fs.readFileSync('./mandelbrot_part.wasm')
    let whole = await WebAssembly.instantiate(wholeBinary, imports)
    let partImports = {
        whole: whole.instance.exports
    }
    part = await WebAssembly.instantiate(partBinary, partImports)
    whole.instance.exports.main()
}

await test()
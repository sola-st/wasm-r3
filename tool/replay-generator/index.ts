import fs from "fs"
import path from "path"

function generate(trace: Trace, outputFile: string, wasmPath: string) {
    let stream = fs.createWriteStream(path.join(process.cwd(), outputFile))
    for (let event of trace) {
        switch (event.type) {
            case "ExportCall":
                break
            case "ImportCall":
                break
            case "ImportReturn":
                break
            case "Load":
                break
            case "TableGet":
                throw "TableGet not supported yet"
                break
            default:
                throw "Not a valid trace event"
        }
    }
    stream = instanciateModule(stream, wasmPath)
}

function instanciateModule(stream: fs.WriteStream, wasmPath: string) {
    stream.write(`const wasmBinary = fs.readFileSync(${wasmPath})`)
    stream.write(`const { instance } = await WebAssembly.instantiate(wasmBinary, {})`)
    return stream
}
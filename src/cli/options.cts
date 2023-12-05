import commandLineArgs from 'command-line-args'
import fs from 'fs'

export type Options = {
    headless: boolean,
    dumpPerformance: boolean,
    dumpTrace: boolean,
    benchmarkPath: string,
    file: string,
    extended: boolean,
    noRecord: boolean,
}

export default function getOptions() {
    const optionDefinitions = [
        { name: 'performance', alias: 'p', type: Boolean },
        { name: 'trace', alias: 't', type: Boolean },
        { name: 'url', type: String, defaultOption: true },
        { name: 'benchmarkPath', alias: 'b', type: String },
        { name: 'headless', alias: 'h', type: Boolean },
        { name: 'file', alias: 'f', type: String },
        { name: 'extended', alias: 'e', type: Boolean },
        { name: 'no-record', alias: 'n', type: Boolean}
    ]
    const options: Options & { url: string } = commandLineArgs(optionDefinitions)
    if (options.headless === undefined) {
        options.headless = false
    }
    if (fs.existsSync(options.benchmarkPath)) {
        throw new Error(`EEXIST: Directory at path ${options.benchmarkPath} does already exist`)
    }
    if (options.benchmarkPath === undefined || options.benchmarkPath === null) {
        let i = 0
        options.benchmarkPath = `benchmark`
        while (fs.existsSync(options.benchmarkPath)) {
            i++;
            options.benchmarkPath = `benchmark_${i}`
        }
    }
    return options
}
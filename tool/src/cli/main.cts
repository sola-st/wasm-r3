import fs from 'fs'
import path from 'path'
import parse from '../trace-parse.cjs'
import Generator from "../replay-generator.cjs";
import record from '../instrumenter.cjs';
import stringifyTrace from '../trace-stringify.cjs';

type SubCommand = 'record' | 'generate'

let subCommand: SubCommand
switch (process.argv[2]) {
    case 'record':
    case 'generate':
        subCommand = process.argv[2] as SubCommand
        break
    default:
        throw Error('not a valid subcommand' + process.argv[2])
}

if (subCommand === 'record') {
    record(process.argv[3])
        .then(trace => fs.writeFileSync(process.argv[4], stringifyTrace(trace)))
}

if (subCommand === 'generate') {
    const traceString = fs.readFileSync(path.join(process.cwd(), process.argv[3]), 'utf-8')
    const trace = parse(traceString)
    const jsString = new Generator().generateReplay(trace).toString()
    fs.writeFileSync(path.join(process.cwd(), process.argv[4]), jsString)
    process.exit(0)
}

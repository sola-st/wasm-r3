import fs from 'fs'
import path from 'path'
import cp from 'child_process'
import generate from './replay-generator'
import parse from './trace-parser'

cp.execSync(`wat2wasm index.wat -o index.wasm`)
cp.execSync(`wasabi index.wasm --node --hooks=begin,store,load,call -o .`)

let trace = require('./tracer').default('./index.wasabi.js')
import('./test.ts')
    .then(() => console.log(trace))
cp.execSync(`wat2wasm index2.wat -o index2.wasm`)
cp.execSync(`wasabi index2.wasm --node --hooks=begin,store,load,call -o .`)
trace = require('./tracer').default('./index2.wasabi.js')
import('./test2.js')
    .then(() => console.log(trace))
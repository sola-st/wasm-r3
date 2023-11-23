import path from 'path';
import fss from 'fs'
import Analyser from './analyser.cjs';
import Benchmark from './benchmark.cjs';
import { askQuestion } from './util.cjs';
import { Options } from './cli/options.cjs'
import Generator from './replay-generator.cjs';

export default async function run(url: string, options: Options) {
  if (options.file !== undefined) {
    const code = await new Generator().generateReplayFromStream(fss.createReadStream(options.file))
    code.toWriteStream(fss.createWriteStream(options.file + '.js'))
    return
  }
  if (options.callGraph === true) {
    throw new Error('Option callGraph currently not supported')
  } else {
    const analyser = new Analyser('./dist/src/tracer.cjs')
    // const analyser = new Analyser('./dist/src/tracer-ext.cjs')
    await analyser.start(url, { headless: options.headless })
    await askQuestion(`Record is running. Enter 'Stop' to stop recording: `)
    console.log(`Record stopped. Downloading...`)
    const results = await analyser.stop()
    console.log('Download done. Generating Benchmark...')
    Benchmark.fromAnalysisResult(results).save(options.benchmarkPath, { trace: options.dumpTrace })
    await analyser.dumpPerformance(path.join(options.benchmarkPath, 'performance.txt')).catch(e => console.log(e))
  }
}
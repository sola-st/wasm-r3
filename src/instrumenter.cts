import path from 'path';
import Analyser from './analyser.cjs';
import { fromAnalysisResult, saveBenchmark } from './benchmark.cjs';
import { askQuestion } from './util.cjs';
import { Options } from './cli/options.cjs'

export default async function run(url: string, options: Options) {
  if (options.callGraph === true) {
    throw new Error('Option callGraph currently not supported')
  } else {
    const analyser = new Analyser('./dist/src/tracer.cjs')
    await analyser.start(url, { headless: options.headless })
    await askQuestion(`Record is running. Enter 'Stop' to stop recording: `)
    console.log(`Record stopped`)
    const results = await analyser.stop()
    await saveBenchmark(options.benchmarkPath, fromAnalysisResult(results), { trace: options.dumpTrace })
    await analyser.dumpPerformance(path.join(options.benchmarkPath, 'performance.txt')).catch(e => console.log(e))
  }
}
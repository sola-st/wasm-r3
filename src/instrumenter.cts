import { Analyser } from './analyser.cjs';
import Benchmark from './benchmark.cjs';
import { askQuestion } from './util.cjs';
import { Options } from './cli/options.cjs'
import { AnalyserI } from './analyser.cjs';

export default async function run(url: string, options: Options) {
  let analyser: AnalyserI
  analyser = new Analyser('./dist/src/tracer.cjs', options)
  await analyser.start(url, { headless: options.headless })
  await askQuestion(`Record is running. Enter 'Stop' to stop recording: `)
  console.log(`Record stopped. Downloading...`)
  const results = await analyser.stop()
  console.log('Download done. Generating Benchmark...')
  Benchmark.fromAnalysisResult(results).save(options.benchmarkPath, { trace: options.dumpTrace, rustBackend: options.rustBackend })
}
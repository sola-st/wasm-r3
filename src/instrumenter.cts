import readline from 'readline'
import Analyser from './analyser.cjs';
import { fromAnalysisResult } from './benchmark.cjs';

export default async function record(url: string, options = { headless: false, dumpPerformance: false }) {
  const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout,
  });

  async function askQuestion(question: string) {
    return new Promise((resolve) => {
      rl.question(question, (answer) => {
        resolve(answer);
      });
    });
  }
  const analyser = new Analyser('./dist/src/tracer.cjs')
  await analyser.start(url, { headless: options.headless })
  console.log(`Record is running. Enter 'Stop' to stop recording: `)
  await askQuestion('')
  rl.close()
  console.log(`Record stopped`)
  const results = await analyser.stop()
  if (options.dumpPerformance === true) {
    analyser.dumpPerformance('./performance.txt')
  }
  return fromAnalysisResult(results)
}
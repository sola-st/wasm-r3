import { delay } from '../../../dist/tests/test-utils.cjs'

export default async function test(analyser) {
  const url = 'https://w3reality.github.io/async-thread-worker/examples/wasm-ffmpeg/index.html'
  const page = await analyser.start(url, { headless: true })
  await delay(5000)
  // TODO
  // - upload mp4
  // - click estimate
  // - click convert takes potentially asctronomically long
  return await analyser.stop()
}

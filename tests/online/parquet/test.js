import { delay } from '../../../dist/tests/test-utils.cjs'

export default async function test(analyser) {
  const url = 'https://google.github.io/filament/webgl/parquet.html'
  const page = await analyser.start(url, { headless: true })

  // the webpage is just showcase.. so just wait
  await delay(10000)

  return await analyser.stop()
}

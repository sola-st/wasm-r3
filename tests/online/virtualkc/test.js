import { delay } from '../../../dist/tests/test-utils.cjs'

export default async function test(analyser) {
  const url = 'https://floooh.github.io/virtualkc/index_wasm.html'
  const page = await analyser.start(url, { headless: true })

  await delay(10000)

  return await analyser.stop()
}

import { delay } from '../../../dist/tests/test-utils.cjs'

export default async function test(analyser) {
  const url = 'https://aurium.gitlab.io/wasm-heatmap/'
  const page = await analyser.start(url, { headless: true })
  await delay(5000)
  return await analyser.stop()
}

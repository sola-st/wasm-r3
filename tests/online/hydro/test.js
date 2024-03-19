import { delay } from '../../../dist/tests/test-utils.cjs'

export default async function test(analyser) {
  const url = 'https://cselab.github.io/aphros/wasm/hydro.html'
  const page = await analyser.start(url, { headless: true })

  await delay(10000)
  // currently emits browser error

  return await analyser.stop()
}

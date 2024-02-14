import { delay } from '../../../dist/tests/test-utils.cjs'

export default async function test(analyser) {
  const url = 'https://boyan.io/wasm-wheel/'
  const page = await analyser.start(url, { headless: false })

  const button = page.locator('#spinBtn')
  await button.waitFor({state: 'visible'})

  await button.click()
  console.log(1)

  await delay(10000)

  return await analyser.stop()
}

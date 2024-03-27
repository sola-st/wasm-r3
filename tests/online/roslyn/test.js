import { delay } from '../../../dist/tests/test-utils.cjs'

export default async function test(analyser) {
  const url = 'http://roslynquoter-wasm.platform.uno/'
  const page = await analyser.start(url, { headless: false })

  const genButton = page.locator('[id="23090"]')
  await genButton.waitFor({state: 'visible'})
  console.log('button loaded')

  await genButton.click()
  // not working now

  await delay(100_000)

  return await analyser.stop()
}

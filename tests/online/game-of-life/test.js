import { delay } from '../../../dist/tests/test-utils.cjs'

export default async function test(analyser) {
  const url = 'https://playgameoflife.com/'
  const page = await analyser.start(url, { headless: false })

  // const button = page.locator('#start')
  // await button.waitFor({ state: 'visible' })
  // await button.click()
  // await delay(500)
  // await button.click()

  const nextButton = page.locator('#button')
  await nextButton.wasabi({state: 'visible'})
  const N = 5
  for (let i = 0; i < N; i++) {
    await nextButton.click()
    await delay(1000)
  }

  return await analyser.stop()
}

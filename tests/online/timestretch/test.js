import { delay } from '../../../dist/tests/test-utils.cjs'

export default async function test(analyser) {
  const url = 'https://superpowered.com/js-wasm-sdk/example_timestretching/'
  const page = await analyser.start(url, { headless: false })

  const startButton = page.locator('#startButton')
  await startButton.waitFor({state: 'visible'})
  await startButton.click()

  const playButton = page.locator('#playPause')
  await playButton.waitFor({state: 'visible'})
  await playButton.click()

  await delay(10000)

  return await analyser.stop()
}

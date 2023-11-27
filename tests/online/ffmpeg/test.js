import { delay } from '../../../dist/tests/test-utils.cjs'

export default async function test(analyser) {
  const url = 'https://w3reality.github.io/async-thread-worker/examples/wasm-ffmpeg/index.html'
  const page = await analyser.start(url, { headless: true })
  // const estimateButton = page.locator('#devHelpButton')
  // const logWindow = page.locator('#log')
  // await estimateButton.waitFor({ state: 'visible' })
  // await logWindow.waitFor({ state: 'visible' })
  // await estimateButton.click()
  // await logWindow.waitFor(() => this.textContent().includes('set the subtitle options to the indicated preset'), { timeout: 240000 })
  await delay(3000)
  const button = await page.$('#devHelpButton')
  await delay(1000)
  button.click()
  await delay(5000)
  return await analyser.stop()
}

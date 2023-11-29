import { delay } from '../../../dist/tests/test-utils.cjs'

export default async function test(analyser) {
  const url = 'https://takahirox.github.io/WebAssembly-benchmark/tests/multiplyDouble.html' 
  let page = await analyser.start(url, { headless: true })

  const runLoc = page.locator('#run_button')
  await runLoc.waitFor({state: 'visible'}) 
  const doneLoc = page.locator('#message')

  await runLoc.click()
  await doneLoc.waitFor({state: 'visible', timeout: 240000})
  await doneLoc.waitFor(() => this.textContent().includes('Done'), {timeout: 240000})

  return await analyser.stop()
}

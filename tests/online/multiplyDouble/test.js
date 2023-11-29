import { delay } from '../../../dist/tests/test-utils.cjs'
import { createMeasure } from '../../../dist/src/performance.cjs'

export default async function test(analyser) {
  const url = 'https://takahirox.github.io/WebAssembly-benchmark/tests/multiplyDouble.html' 
  let page = await analyser.start(url, { headless: true })

  const runLoc = page.locator('#run_button')
  await runLoc.waitFor({state: 'visible'}) 
  const doneLoc = page.locator('#message')
  
  const p_measureRun = createMeasure('runButton', { phase: 'record', description: 'during user interaction, before clicking run button'} )

  await runLoc.click()
  await doneLoc.waitFor({state: 'visible', timeout: 240000})
  await doneLoc.waitFor(() => this.textContent().includes('Done'), {timeout: 240000})

  p_measureRun()

  return await analyser.stop()
}

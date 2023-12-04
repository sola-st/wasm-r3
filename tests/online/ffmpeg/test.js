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
  //

  
  const consoleLoc = page.locator('#log') 
  await consoleLoc.waitFor({state: 'visible' })
  //console.log('log located')

  const helpButton = page.locator('#devHelpButton')
  await helpButton.waitFor({state: 'visible'})
  await helpButton.click()
  //console.log('button clicked')

  await consoleLoc.getByText(/\[run\].*help/).waitFor({state: 'visible'})
  //console.log('located the run span')
  await consoleLoc.getByText(/\[info\] done in.*/).waitFor({state: 'visible'})
  //console.log('located the done span')

  //await delay(5000)

  const versionButton = page.locator('#devVersionButton')
  await versionButton.waitFor({state: 'visible'})
  await versionButton.click()
  //console.log('version button clicked')

  await consoleLoc.getByText(/\[run\].*version/).waitFor({state: 'visible'})
  //console.log('located the run span')
  await consoleLoc.getByText(/\[info\] done in.*/).waitFor({state: 'visible'})
  //console.log('located the done span')

  return await analyser.stop()
}

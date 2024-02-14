import { delay } from '../../../dist/tests/test-utils.cjs'

export default async function test(analyser) {
  const url = 'https://takahirox.github.io/WebAssembly-benchmark/'
  const page = await analyser.start(url, { headless: false })

  const collLink = page.getByText('collisionDetection')
  await collLink.waitFor({state: 'visible'})
  console.log('link loaded')

  await collLink.click()
  console.log('link clicked')

  const frameLoc = page.frameLocator('iframe')
  //await frameLoc.waitFor({state: 'visible'})
  console.log('iframe loaded')

  const runButton = frameLoc.getByRole('button')
  await runButton.waitFor({state: 'visible'})
  console.log('run button loaded')

  await runButton.click()
  console.log('runbutton clicked')
  
  const messageSpan = frameLoclocator('#message')
  await messageSpan.waitFor({state: 'visible'})
  await expect(messageSpan).toContainText('Done', {timeout: 100000}) 


  return await analyser.stop()
}

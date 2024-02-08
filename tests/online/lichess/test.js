import { delay } from '../../../dist/tests/test-utils.cjs'

export default async function test(analyser) {
  const url = 'https://lichess.org/analysis'
  const page = await analyser.start(url, { headless: false })


  const switchButton = page.locator('#analyse-toggle-ceval')
  //await switchButton.waitFor({state: 'visible'})

  await switchButton.dispatchEvent('click')

  await delay(10000)

  return await analyser.stop()
}

import { delay } from '../../../dist/tests/test-utils.cjs'

export default async function test(analyser) {
  const url = 'https://brionv.com/misc/ogv.js/demo/'
  const page = await analyser.start(url, { headless: true })

  const beSelect = page.locator("#player-backend")
  await beSelect.waitFor({state: 'visible'}) 

  const playButton = page.getByTitle('Play')
  await playButton.waitFor({state: 'visible'})

  await beSelect.selectOption('Web Assembly')

  await playButton.click()
  
  await delay(10000)

  return await analyser.stop()
}

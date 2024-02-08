import { delay } from '../../../dist/tests/test-utils.cjs'

export default async function test(analyser) {
  const url = 'http://jqkungfu.com/'
  const page = await analyser.start(url, { headless: true})

  const queryBox = page.locator('#query')  
  await queryBox.waitFor({state: 'visible'})

  const goButton = page.locator('#btnRun')
  await goButton.waitFor({state: 'visible'})


  await queryBox.fill('')
  await queryBox.press('.')
  await queryBox.press('[')
  await queryBox.press('1')
  await queryBox.press(']')
  await goButton.click() 

  await queryBox.fill('')
  await queryBox.press('.')
  await queryBox.press('[')
  await queryBox.press('2')
  await queryBox.press(']')
  await goButton.click() 

  return await analyser.stop()
}

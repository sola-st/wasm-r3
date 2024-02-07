import { delay } from '../../../dist/tests/test-utils.cjs'
import { expect } from 'playwright/test'

export default async function test(analyser) {
  const url = 'https://www.hellorust.com/demos/factorial/index.html'
  const page = await analyser.start(url, { headless: true })

  const textInput = page.locator('#input')
  await textInput.waitFor({state: 'visible'})

  const numberOut = page.locator('#number-out')
  await numberOut.waitFor({state: 'visible'})

  await textInput.fill('')  
  await textInput.press('1')
  await textInput.press('0')
  await expect(numberOut).toContainText('fact(10)', {timeout: 10000})

  await textInput.fill('')  
  await textInput.press('2')
  await textInput.press('0')
  await expect(numberOut).toContainText('fact(20)', {timeout: 10000})

  await textInput.fill('')  
  await textInput.press('4')
  await textInput.press('2')
  await expect(numberOut).toContainText('fact(42)', {timeout: 10000})

  return await analyser.stop()
}

import { delay } from '../../../dist/tests/test-utils.cjs'
import { expect } from 'playwright/test'

export default async function test(analyser) {
  const url = 'https://www.hellorust.com/demos/factorial/index.html'
  const page = await analyser.start(url, { headless: false })

  const textInput = page.locator('#input')
  await textInput.waitFor({state: 'visible'})

  const numberOut = page.locator('#number-out')
  await numberOut.waitFor({state: 'visible'})

  await textInput.fill('')  

  await textInput.fill('0')  
  await expect(numberOut).toContainText('fact(0)', {timeout: 10000})

  await textInput.fill('1')  
  await expect(numberOut).toContainText('fact(1)', {timeout: 10000})

  await textInput.fill('2')  
  await expect(numberOut).toContainText('fact(2)', {timeout: 10000})


  return await analyser.stop()
}

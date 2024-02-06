import { delay } from '../../../dist/tests/test-utils.cjs'
import { expect } from 'playwright/test'

export default async function test(analyser) {
  const url = 'https://gotemplate.io/'
  const page = await analyser.start(url, { headless: false })

  const templateText = page.locator('#input-tmpl')
  await templateText.waitFor({state: 'visible'})

  const dataText = page.locator('#input-data')
  await dataText.waitFor({state: 'visible'})

  const outputText = page.locator('#output')
  await outputText.waitFor({state: 'visible'})

  await templateText.fill('what, {{.planet}}') 
  await expect(outputText).toContainText('what, World', {timeout: 100000})

  await delay(5000)

  return await analyser.stop()
}

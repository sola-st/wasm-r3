import { delay } from '../../../dist/tests/test-utils.cjs'
import { createMeasure } from '../../../dist/src/performance.cjs'

export default async function test(analyser) {
  const url = 'https://sql.js.org/examples/GUI/'
  const page = await analyser.start(url, { headless: true })

  const buttonLocator = page.locator('#execute')
  await buttonLocator.waitFor({ state: 'visible' })
  await buttonLocator.click()

  const resultLocator = page.locator('#output')
  await resultLocator.waitFor({ state: 'visible'})
  // finding the output table with test 'designation' only works for the
  // initial example. if the executing SQL code is changed,
  // the output table should be differently found
  const tableLocator = resultLocator.getByText('designation')
  await tableLocator.waitFor({state: 'visible'})
  await delay(3000)
  return await analyser.stop()
}

import { delay } from '../../../dist/tests/test-utils.cjs'

export default async function test(analyser) {
  const url = 'https://sepiropht.github.io/tic-tac-toe-wasm/'
  const page = await analyser.start(url, { headless: true })

  await delay(5000)
 
  const sizeSelect = page.getByLabel('Size of the board')
  await sizeSelect.waitFor({state: 'visible'})

  await sizeSelect.fill('3')

  /*
  const upperright = page.locator('[data-cell="0_2"]')
  await upperright.waitFor({state: 'visible'})
  await upperright.click()
  */

  await delay(100_000)

  return await analyser.stop()
}

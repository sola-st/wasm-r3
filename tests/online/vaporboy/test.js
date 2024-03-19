import { delay } from '../../../dist/tests/test-utils.cjs'

export default async function test(analyser) {
  const url = 'https://vaporboy.net/'
  const page = await analyser.start(url, { headless: false })

  const startButton = page.getByText('🖥️ Start', {exact: true})
  await startButton.click({force: true})
  //console.log(0)

  const romButton = page.getByText('🎮 Select a ROM', {exact: true})
  await romButton.click()
  //console.log(1)

  const brewButton = page.getByText('🍺', {exact: true})
  await brewButton.click()
  //console.log(2)

  const romImg = page.locator('button[aria-label="Tobu Tobu Girl Play ROM"]')
  await romImg.click()
  //console.log(3)

  await delay(10000)

  return await analyser.stop()
}

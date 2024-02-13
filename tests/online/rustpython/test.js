import { delay } from '../../../dist/tests/test-utils.cjs'

export default async function test(analyser) {
  const url = 'https://rustpython.github.io/demo/'
  const page = await analyser.start(url, { headless: false })

  const runButton = page.locator('#run-btn')
  console.log('button found')
  await runButton.click()
  console.log('clicked')

  await delay(10000)

  return await analyser.stop()
}

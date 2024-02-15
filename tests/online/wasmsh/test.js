import { delay } from '../../../dist/tests/test-utils.cjs'

export default async function test(analyser) {
  const url = 'https://webassembly.sh/'
  const page = await analyser.start(url, { headless: true })

  const textInput = page.locator('#wasm-terminal')
  await textInput.waitFor({ state: 'visible' })
  console.log(1)

  await textInput.pressSequentially('quickjs\n')
  await delay(100)



  await delay(1000)

  return await analyser.stop()
}

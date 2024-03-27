import { delay } from '../../../dist/tests/test-utils.cjs'

export default async function test(analyser) {
  const url = 'https://el-tramo.be/waforth'
  const page = await analyser.start(url, { headless: true })
  
  const textInput = page.locator('.Console')
  await textInput.waitFor({state: 'visible'})
  console.log(1)

  await delay(2000)

  await textInput.pressSequentially('asdf\n')

  await delay(2000)

  return await analyser.stop()
}

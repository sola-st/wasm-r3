import { delay } from '../../../dist/tests/test-utils.cjs'

export default async function test(analyser) {
  const url = 'https://el-tramo.be/waforth'
  const page = await analyser.start(url, { headless: false })
  
  const textInput = page.getByRole('pre')
  await textInput.waitFor({state: 'visible'})
  console.log(1)

  await delay(5000)

  await textInput.pressSequentially('asdf\n')

  await delay(10000)

  return await analyser.stop()
}

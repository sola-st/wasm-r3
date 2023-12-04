import { delay } from '../../../dist/tests/test-utils.cjs'

export default async function test(analyser) {
  // analyser.setExtended(false)
  const url = 'https://www.figma.com'
  const page = await analyser.start(url, { headless: true })
  await delay(3000)
  return await analyser.stop()
}
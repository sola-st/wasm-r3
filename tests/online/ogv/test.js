import { delay } from '../../../dist/tests/test-utils.cjs'

export default async function test(analyser) {
  const url = 'https://brionv.com/misc/ogv.js/demo/'
  const page = await analyser.start(url, { headless: true })
  await delay(5000)
  return await analyser.stop()
}

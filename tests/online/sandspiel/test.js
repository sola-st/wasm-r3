import { delay } from '../../../dist/tests/test-utils.cjs'

export default async function test(analyser) {
  const url = 'https://sandspiel.club/'
  const page = await analyser.start(url, { headless: true })
  await delay(5000)
  return await analyser.stop()
}

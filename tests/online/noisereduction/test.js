import { delay } from '../../../dist/tests/test-utils.cjs'

export default async function test(analyser) {
  const url = 'https://mediaedits.io/noisereduction'
  const page = await analyser.start(url, { headless: true })

  await delay(10000)

  return await analyser.stop()
}

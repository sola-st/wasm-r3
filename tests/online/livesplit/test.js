import { delay } from '../../../dist/tests/test-utils.cjs'

export default async function test(analyser) {
  const url = 'https://one.livesplit.org/'
  const page = await analyser.start(url, { headless: false })

  await delay(10000)

  return await analyser.stop()
}

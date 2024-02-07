import { delay } from '../../../dist/tests/test-utils.cjs'

export default async function test(analyser) {
  const url = 'https://raw.githack.com/gorhill/uBlock/master/docs/tests/hnset-benchmark.html'
  const page = await analyser.start(url, { headless: true })

  const lookupButton = page.locator('#lookupBenchmark')
  await lookupButton.waitFor({state: 'visible'})

  await lookupButton.click()

  await delay(10000)

  return await analyser.stop()
}

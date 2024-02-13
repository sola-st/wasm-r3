import { delay } from '../../../dist/tests/test-utils.cjs'

export default async function test(analyser) {
  const url = 'https://raylibtech.itch.io/rguistyler'
  const page = await analyser.start(url, { headless: false })

  const canv = page.locator('#canvas')
  await canv.waitFor({state: 'visible'})
  console.log('canvas loaded')

  await delay(10000)

  return await analyser.stop()
}

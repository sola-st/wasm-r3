import { delay } from '../../../dist/tests/test-utils.cjs'

export default async function test(analyser) {
  const url = 'https://www.jamesfmackenzie.com/chocolatekeen/'
  const page = await analyser.start(url, { headless: true })

  const canvasLoc = page.locator('#canvas')
  await canvasLoc.waitFor({ state: 'visible' })

  await canvasLoc.click({
    button: 'left',
    position: { x: 500, y: 500 },
  })

  await delay(50000)
  return await analyser.stop()
}

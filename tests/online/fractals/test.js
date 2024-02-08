import { delay } from '../../../dist/tests/test-utils.cjs'

export default async function test(analyser) {
  const url = 'https://raw-wasm.pages.dev/'
  const page = await analyser.start(url, { headless: true })

  const canvas = page.locator('#mandelImage')
  await canvas.waitFor({state: 'visible'})

  await canvas.click({
    button: 'left',
    position: {x: 200, y: 200},
  })

  await delay(10000)

  return await analyser.stop()
}

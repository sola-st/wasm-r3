import { delay } from '../../../dist/tests/test-utils.cjs'

export default async function test(analyser) {
  const url = 'https://raw-wasm.pages.dev/'
  const page = await analyser.start(url, { headless: false })

  const canvas = page.locator('#mandelImage')
  await canvas.waitFor({state: 'visible'})

  console.log('visible')

  await canvas.click({
    button: 'left',
    position: {x: 200, y: 200},
  })
  
  console.log('clicked')

  await delay(10000)

  return await analyser.stop()
}

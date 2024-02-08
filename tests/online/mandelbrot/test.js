import { delay } from '../../../dist/tests/test-utils.cjs'

export default async function test(analyser) {
  const url = 'http://whealy.com/Rust/mandelbrot.html'
  const page = await analyser.start(url, { headless: true })

  const canvas = page.locator('#mandelImage') 
  await canvas.waitFor({state: 'visible' })

  for (let i = 0; i < 10; i++){
    await canvas.click({
      button: 'left',
      position: {x: 400, y: 200},
    })
    await delay(1000)
  }
  

  await delay(1000)

  return await analyser.stop()
}

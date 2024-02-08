import { delay } from '../../../dist/tests/test-utils.cjs'

export default async function test(analyser) {
  const url = 'http://whealy.com/acoustics/PA_Calculator/index.html'
  const page = await analyser.start(url, { headless: true})

  const resisSlider = page.locator('#flow_resistivity')  
  await resisSlider.waitFor({state: 'visible'})

  const sliderOffsetWidth = await resisSlider.evaluate(el => {
    return el.getBoundingClientRect().width
  }) 

  await resisSlider.hover({ force: true, position: {x: 0, y:0}})
  await page.mouse.down()
  await page.mouse.up()

  await delay(500)

  await resisSlider.hover({ force: true, position: {x: 50, y:0}})
  await page.mouse.down()
  await page.mouse.up()

  await delay(500)

  await resisSlider.hover({ force: true, position: {x: 100, y:0}})
  await page.mouse.down()
  await page.mouse.up()

  await delay(500)

  return await analyser.stop()
}

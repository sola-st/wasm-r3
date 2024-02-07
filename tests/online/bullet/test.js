import { delay } from '../../../dist/tests/test-utils.cjs'

export default async function test(analyser) {
  const url = 'https://magnum.graphics/showcase/bullet/'
  const page = await analyser.start(url, { headless: true })

  const mainCanv = page.locator('#canvas')
  await mainCanv.waitFor({state: 'visible'})
  
  await mainCanv.click({
    button: 'left',
    position: {x: 100, y: 100},
    delay: 100
  }) 

  await delay(10000)

  return await analyser.stop()
}

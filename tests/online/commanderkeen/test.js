import { delay } from '../../../dist/tests/test-utils.cjs'

export default async function test(analyser) {
  const url = 'https://www.jamesfmackenzie.com/chocolatekeen/'
  const page = await analyser.start(url, {headless: false })
 
  const canvasLoc = page.locator('#canvas')
  await canvasLoc.waitFor({state: 'visible'})
  console.log('canvas located')

  await canvasLoc.click({
    button: 'left',
    position: {x: 500, y: 500},
  })
  console.log('canvas clicked')

  await delay(20000)     
}

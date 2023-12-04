import { delay } from '../../../dist/tests/test-utils.cjs'

async function clicker(loc, pos) {
  await loc.click({
    button: 'left',
    position: pos,
    delay: 1000
  })
}

export default async function test(analyser) {
  analyser.setExtended(false)
  const url = 'https://sandspiel.club/'
  const page = await analyser.start(url, { headless: true })

  // wait for initial thing : 5s
  await delay(5000)

  // find the canvas
  const canvasLoc = page.locator('#sand-canvas')  
  await canvasLoc.waitFor({state: 'visible'})

  const arr = [
    {x: 50, y: 50},
    {x: 100, y: 100},
    {x: 150, y: 150},
    {x: 200, y: 200},
    {x: 250, y: 250},
  ]

  for (const pos of arr) {
    await clicker(canvasLoc, pos)
  }


  // wait for another 5s
  await delay(5000)
  
  return await analyser.stop()
}

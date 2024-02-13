import { delay } from '../../../dist/tests/test-utils.cjs'

export default async function test(analyser) {
  const url = 'https://playnox.xyz/'
  const page = await analyser.start(url, { headless: true })

  const goButton = page.getByText('Yes, I like data.')
  await goButton.waitFor({state: 'visible'})
  await goButton.click()

  const canv = page.locator('#canvas')
  await canv.waitFor({state: 'visible'})

  
  await delay(10000)
  await canv.click({
    button: 'left',
    position: {x: 725, y: 446},
  })
  console.log('clicked')

  // await delay(10000)

  return await analyser.stop()
}

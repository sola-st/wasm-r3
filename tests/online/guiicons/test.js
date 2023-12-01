import { delay } from '../../../dist/tests/test-utils.cjs'

export default async function test(analyser) {
    const url = 'https://raylibtech.itch.io/rguiicons'
    let page = await analyser.start(url, { headless: false })
    await delay(1000)
    // How to animate this properly?
    // We need to obtain the canvas inside the iframe and then click around
    // const iframe = await page.$('#game_drop')
    // const content = await iframe.contentFrame()
    // const canvas = await page.locator('canvas')
    // await canvas.waitFor({ state: 'visible' })
    // await canvas.click({ position: { x: 50, y: 100 } })
    // await canvas.click({ position: { x: 50, y: 200 } })
    return await analyser.stop()
}

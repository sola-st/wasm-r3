import { delay } from '../../../dist/tests/test-utils.cjs'

export default async function test(analyser) {
    const url = 'https://raylibtech.itch.io/rguiicons'
    let page = await analyser.start(url, { headless: false })
    await delay(6000)
    const iframe = await page.$('#game_drop')
    const content = await iframe.contentFrame()
    const canvas = await content.$('canvas')
    canvas.click({ position: { x: 50, y: 100 } })
    await page.waitForTimeout(5000)
    canvas.click({ position: { x: 50, y: 200 } })
    await page.waitForTimeout(5000)
    return await analyser.stop()
}
import { delay } from '../../../dist/tests/test-utils.cjs'

export default async function test(analyser) {
    analyser.setExtended(false)
    const url = 'https://wasm4.org/play/kittygame'
    let page = await analyser.start(url, { headless: true })
    await delay(2000)
    const iframe = await page.$('.game-embed')
    const content = await iframe.contentFrame()
    const canvas = await content.$('canvas')
    await canvas.press('x')
    await page.waitForTimeout(1000)
    await canvas.press('x')
    await page.waitForTimeout(1000)
    await canvas.press('ArrowLeft')
    await page.waitForTimeout(1000)
    await canvas.press('ArrowRight')
    await delay(2000)
    return await analyser.stop()
}
import { launch, land } from '../../../dist/src/instrumenter.cjs'
import { delay } from '../../../dist/tests/test-utils.cjs'

export default async function test() {
    const url = 'https://handytools.xd-deng.com/'
    let { browser, page } = await launch(url, { headless: true })
    await delay(10000)
    const canvas = await page.$('#Main')
    const canvasBox = await canvas.boundingBox();
    const randomX = Math.floor(Math.random() * canvasBox.width);
    const randomY = Math.floor(Math.random() * canvasBox.height);
    await page.mouse.move(canvasBox.x + randomX, canvasBox.y + randomY);
    await delay(1000)
    return await land(browser, page)
}
import { delay } from '../../../dist/tests/test-utils.cjs'

export default async function test(analyser) {
    // analyser.setExtended(false)
    const url = 'https://www.funkykarts.rocks/demo.html'
    let page = await analyser.start(url, { headless: true })
    await delay(5000)
    const canvas = await page.$('#display')
    const canvasBox = await canvas.boundingBox();
    const startButtonX = Math.floor(canvasBox.x + canvasBox.width * 9 / 10);
    const startButtonY = Math.floor(canvasBox.height * 9 / 10);
    // click init
    await page.mouse.click(startButtonX, startButtonY);
    await delay(2000)
    // click start
    await page.mouse.click(startButtonX, startButtonY);
    // drive a little bit
    await page.keyboard.down('ArrowLeft')
    await page.waitForTimeout(2000)
    await page.keyboard.up('ArrowLeft')
    // jump
    await page.keyboard.press('ArrowUp')
    await delay(3000)
    return await analyser.stop()
}
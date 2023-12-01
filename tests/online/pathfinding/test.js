import { delay } from '../../../dist/tests/test-utils.cjs'

export default async function test(analyser) {
    analyser.setExtended(false)
    const url = 'https://jacobdeichert.github.io/wasm-astar/'
    const page = await analyser.start(url, { headless: true })
    await delay(5000)
    const canvas = await page.$('#Main')
    const canvasBox = await canvas.boundingBox();
    const randomX = Math.floor(Math.random() * canvasBox.width);
    const randomY = Math.floor(Math.random() * canvasBox.height);
    await page.mouse.move(canvasBox.x + randomX, canvasBox.y + randomY);
    await delay(1000)
    return await analyser.stop()
}
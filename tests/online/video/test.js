import { delay } from '../../../dist/tests/test-utils.cjs'

export default async function test(analyser) {
    const url = 'https://d2jta7o2zej4pf.cloudfront.net/'
    const page = await analyser.start(url, { headless: true })
    page.context().grantPermissions(['camera'], {
        origin: url
    })
    const webcamButton = page.locator('#webcamButton')
    const grayscaleButton = page.locator('text=Grayscale');
    await webcamButton.waitFor({ state: 'visible' })
    await grayscaleButton.waitFor({ state: 'visible' })
    await webcamButton.click()
    await delay(1000)
    grayscaleButton.click()
    await delay(3000)
    return await analyser.stop()
}
import { launch, land } from '../../../dist/src/instrumenter.cjs'
import { delay } from '../../../dist/tests/test-utils.cjs'

export default async function test() {
    const url = 'https://playgameoflife.com/'
    let { browser, page } = await launch(url, { headless: true })
    const startButton = await page.$('#start')
    await startButton.click()
    await delay(500)
    await startButton.click()
    return await land(browser, page)
}
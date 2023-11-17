import { delay } from '../../../dist/tests/test-utils.cjs'

export default async function test(analyser) {
    const url = 'https://playgameoflife.com/'
    const page = await analyser.start(url, { headless: true })
    const startButton = await page.$('#start')
    await startButton.click()
    await delay(500)
    await startButton.click()
    return await analyser.stop()
}
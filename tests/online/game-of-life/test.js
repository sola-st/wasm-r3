import { delay } from '../../../dist/tests/test-utils.cjs'

export default async function test(analyser) {
    const url = 'https://playgameoflife.com/'
    const page = await analyser.start(url, { headless: true })
    const button = page.locator('#start')
    await button.waitFor({ state: 'visible' })
    await button.click()
    await delay(500)
    await button.click()
    return await analyser.stop()
}
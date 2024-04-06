import { delay } from '../../../dist/tests/test-utils.cjs'

export default async function test(analyser) {
    const url = 'https://boajs.dev/playground'
    const page = await analyser.start(url, { headless: true })
    await delay(3000) // wait until instrumentation is done
    await page.locator('div').filter({ hasText: /^greet\('World'\)$/ }).click();
    await page.keyboard.press('Backspace');
    await page.keyboard.press('Backspace');
    return await analyser.stop()
}

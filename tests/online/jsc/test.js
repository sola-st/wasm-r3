import { delay } from '../../../dist/tests/test-utils.cjs'

export default async function test(analyser) {
    const url = 'https://mbbill.github.io/JSC.js/demo/index.html'
    const page = await analyser.start(url, { headless: false })
    const terminalWrapper = page.locator('.terminal-wrapper')
    const prompt = page.locator('.cmd')
    await terminalWrapper.waitFor({ state: 'visible' })
    await prompt.waitFor({ state: 'visible' })
    await terminalWrapper.focus()
    await delay(1000)
    await terminalWrapper.type('1 + 1');
    await page.keyboard.press('Enter');
    await delay(1000)
    return await analyser.stop()
}

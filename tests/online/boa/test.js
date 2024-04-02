import { delay } from '../../../dist/tests/test-utils.cjs'

export default async function test(analyser) {
    const url = 'https://boajs.dev/boa/playground/'
    const page = await analyser.start(url, { headless: true })
    await delay(3000) // wait until instrumentation is done
    // const terminalWrapper = page.locator('.textbox')
    // await terminalWrapper.waitFor({ state: 'visible' })
    // await delay(5000)
    // await terminalWrapper.focus()
    // doesnt work yet :(
    // await terminalWrapper.type('console.log("yo mama!")');
    // await delay(2000)
    // page.pause()
    return await analyser.stop()
}

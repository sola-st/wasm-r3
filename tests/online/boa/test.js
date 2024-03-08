import { delay } from '../../../dist/tests/test-utils.cjs'

export default async function test(analyser) {
    const url = 'https://boajs.dev/boa/playground/'
    const page = await analyser.start(url, { headless: false })
    console.log('waiting for instrumentation (60 seconds)...')
    await delay(60_000) // wait until instrumentation is done
    console.log('done waiting')
    // const terminalWrapper = page.locator('.textbox')
    // await terminalWrapper.waitFor({ state: 'visible' })
    await delay(5000)
    // await terminalWrapper.focus()
    // doesnt work yet :(
    // await terminalWrapper.type('console.log("yo mama!")');
    // await delay(2000)
    // page.pause()
    return await analyser.stop()
}

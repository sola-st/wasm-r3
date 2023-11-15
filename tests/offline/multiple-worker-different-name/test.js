import { launch, land } from '../../../dist/src/instrumenter.cjs'
import { delay } from '../../../dist/tests/test-utils.cjs'

export default async function test(wasmBinary) {
    const url = 'http://localhost:8000'
    let { browser, page } = await launch(url, { headless: true })
    await delay(1000)
    return await land(browser, page)
}
import { delay } from '../../../dist/tests/test-utils.cjs'

export default async function test(analyser, url) {
    await analyser.start(url, { headless: true })
    await delay(3000)
    return await analyser.stop()
}
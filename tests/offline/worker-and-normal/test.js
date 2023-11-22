import { delay } from '../../../dist/tests/test-utils.cjs'

export default async function test(analyser) {
    const url = 'http://localhost:8000'
    await analyser.start(url, { headless: true })
    await delay(10)
    return await analyser.stop()
}
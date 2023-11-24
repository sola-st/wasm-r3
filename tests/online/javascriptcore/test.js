import { delay } from '../../../dist/tests/test-utils.cjs'

export default async function test(analyser) {
    const url = 'https://mbbill.github.io/JSC.js/demo/index.html'
    const page = await analyser.start(url)
    await delay(10000)
    return await analyser.stop()
}

import { delay } from '../../../dist/tests/test-utils.cjs'
import { askQuestion } from '../../../dist/src/util.cjs'

export default async function test(analyser) {
    analyser.setExtended(false)
    const url = 'https://handytools.xd-deng.com/'
    const page = await analyser.start(url, { headless: true })
    const linkLocator = page.locator('a:has-text("Base64 Encode/Decode")');
    await linkLocator.waitFor({ state: 'visible' })
    await linkLocator.click()
    const box = page.locator('#tab_base64_encode_decode')
    await box.waitFor({ state: 'visible' })
    await box.locator('textarea').fill('Hello, World!')
    await box.getByText('Encode').click()
    await box.locator('textarea').fill('SGVsbG8sIFdvcmxkIQ==')
    await box.getByText('Decode').click()
    // await askQuestion('')
    return await analyser.stop()
}
import { delay } from '../../../dist/tests/test-utils.cjs'
import { createMeasure } from '../../../dist/src/performance.cjs'

export default async function test(analyser) {
  const url = 'https://handytools.xd-deng.com/'
  const page = await analyser.start(url, { headless: true})
  
  // base 64 encode decode
  const p_measureBase64 = createMeasure('runBase64', {phase: 'record', description: 'Testing base64 encode and decode'})

  const linkLocator = page.locator('a:has-text("Base64 Encode/Decode")');
  await linkLocator.waitFor({ state: 'visible' })
  await linkLocator.click()
  const box = page.locator('#tab_base64_encode_decode')
  await box.waitFor({ state: 'visible' })
  await box.locator('textarea').fill('Hello, World!')
  await box.getByText('Encode').click()
  await box.locator('textarea').fill('SGVsbG8sIFdvcmxkIQ==')
  await box.getByText('Decode').click()

  p_measureBase64()

  // url encode decode
  const p_measureUrl = createMeasure('runUrl', {phase: 'record', description: 'Testing URL encode and decode'})

  const urlLocator = page.locator('a:has-text("URL Encode/Decode")');
  await urlLocator.waitFor({state: 'visible'})
  await urlLocator.click()
  const urlBox = page.locator('#tab_url_encode_decode')
  await urlBox.waitFor({state: 'visible'})
  await urlBox.locator('textarea').fill('https://handytools.xd-deng.com/')
  await urlBox.getByText('Encode').click()
  await urlBox.locator('textarea').fill('https:%2F%2Fhandytools.xd-deng.com%2F')
  await urlBox.getByText('Decode').click()


  p_measureUrl()

  // hash
  const p_measureHash = createMeasure('runHash', {phase: 'record', description: 'Testing hash calculation'})

  const hashLocator = page.locator('a:has-text("Hash Calculation")');
  await hashLocator.waitFor({state: 'visible'})
  await hashLocator.click()
  const hashBox = page.locator('#tab_hash_calculation')
  await hashBox.waitFor({state: 'visible'})
  await hashBox.locator('input').fill('hello')
  await hashBox.getByText('Calculate').click()

  p_measureHash()
  

  return await analyser.stop()
}

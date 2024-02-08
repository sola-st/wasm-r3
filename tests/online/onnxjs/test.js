import { delay } from '../../../dist/tests/test-utils.cjs'

export default async function test(analyser) {
  const url = 'https://microsoft.github.io/onnxjs-demo/#/squeezenet'
  const page = await analyser.start(url, { headless: true })

  const beSelector = page.locator('div').filter({ hasText: /^GPU-WebGLarrow_drop_down$/ }).nth(1)
  await beSelector.waitFor({state: 'visible'})

  await beSelector.click()

  
  const wasmOption = page.locator('div').filter({ hasText: /^CPU-WebAssembly$/ }).nth(1)
  await wasmOption.waitFor({state: 'visible'})

  await wasmOption.click()

  await delay(10000)

  return await analyser.stop()
}

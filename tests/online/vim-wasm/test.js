import { delay } from '../../../dist/tests/test-utils.cjs'

export default async function test(analyser) {
  const url = 'https://rhysd.github.io/vim.wasm/'
  const page = await analyser.start(url, { headless: true })

  const vimCanv = page.locator('#vim-screen') 
  await vimCanv.waitFor({state: 'visible'})

  // cannot programmatically wait until load 
  await delay(5000)

  await vimCanv.click()
  console.log('1')
  await vimCanv.pressSequentially(':q\n')
  console.log('2')

  return await analyser.stop()
}

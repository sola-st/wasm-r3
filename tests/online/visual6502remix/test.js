import { launch, land } from '../../../dist/src/instrumenter.cjs'
import { delay } from '../../../dist/tests/test-utils.cjs'

export default async function test() {
  const url = 'https://floooh.github.io/visual6502remix/'
  let {browser, page } = await launch(url, {headless: true})
  await delay(500)
  return await land(browser, page)
}

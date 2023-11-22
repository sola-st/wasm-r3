import { delay } from '../../../dist/tests/test-utils.cjs'

export default async function test(analyser) {
  const url = 'https://floooh.github.io/visual6502remix/'
  const page = await analyser.start(url, { headless: true })
  await delay(10000)
  // Todo automate canvas interaction
  return await analyser.stop()
}

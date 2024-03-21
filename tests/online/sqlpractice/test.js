import { delay } from '../../../dist/tests/test-utils.cjs'

export default async function test(analyser) {
  const url = 'https://www.sql-practice.com'
  const page = await analyser.start(url, { headless: true })

  const runButton = page.getByText('Run', {exact: true})
  await runButton.waitFor({state: 'visible'})
  console.log('runButton found')

  await delay(1000)
  await runButton.click()
  console.log('runButton clicked')

  await delay(10000)

  return await analyser.stop()
}

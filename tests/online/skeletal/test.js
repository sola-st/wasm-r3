import { delay } from '../../../dist/tests/test-utils.cjs'

export default async function test(analyser) {
  const url = 'http://aws-website-webassemblyskeletalanimation-ffaza.s3-website-us-east-1.amazonaws.com/'
  const page = await analyser.start(url, { headless: false })

  await delay(1_000_000)

  return await analyser.stop()
}

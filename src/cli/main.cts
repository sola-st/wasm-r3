import run from '../instrumenter.cjs'
import constructOptions from './options.cjs'

async function main() {
    const options = constructOptions()
    await run(options.url, options)
}

main()
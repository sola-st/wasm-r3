import { launch, land } from '../../../src/instrumenter.cjs';
export default async function test() {
    const url = 'https://playgameoflife.com/';
    const { browser, page } = await launch(url);
    // animate user interaction
    return await land(browser, page);
}
//# sourceMappingURL=test.js.map
import path from 'path'
import { delay } from '../../../dist/tests/test-utils.cjs'

export default async function test(analyser) {
    const url = 'https://cloudpilot-emu.github.io/uarm-preview/'
    const page = await analyser.start(url, { headless: true })
    const basePath = path.join(process.cwd(), 'tests', 'online', 'uarm')

    const fileChooserPromise1 = page.waitForEvent('filechooser');
    await page.getByRole('button', { name: 'Upload SD' }).click();
    const fileChooser1 = await fileChooserPromise1;
    await fileChooser1.setFiles(path.join(basePath, 'bin/sd.img'));

    const fileChooserPromise2 = page.waitForEvent('filechooser');
    await page.getByRole('button', { name: 'Upload NAND' }).click();
    const fileChooser2 = await fileChooserPromise2;
    await fileChooser2.setFiles(path.join(basePath, 'bin/nand.bin'));

    const fileChooserPromise3 = page.waitForEvent('filechooser');
    await page.getByRole('button', { name: 'Upload NOR' }).click();
    const fileChooser3 = await fileChooserPromise3;
    await fileChooser3.setFiles(path.join(basePath, 'bin/nor.bin'))

    await delay(10000)
    return await analyser.stop()
}

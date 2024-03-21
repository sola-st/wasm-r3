import path from 'path'
import { delay } from '../../../dist/tests/test-utils.cjs'

export default async function test(analyser) {
    const url = 'https://cloudpilot-emu.github.io/uarm-preview/'
    const page = await analyser.start(url, { headless: true })

    let __dirname = path.join(process.cwd(), 'tests', 'online', 'uarm', 'resource')
    const fileChooserPromise_1 = page.waitForEvent('filechooser');
    await page.getByRole('button', { name: 'Upload SD' }).click();
    const fileChooser_1 = await fileChooserPromise_1;
    await fileChooser_1.setFiles(path.join(__dirname, 'repro.img'));


    const fileChooserPromise_2 = page.waitForEvent('filechooser');
    await page.getByRole('button', { name: 'Upload NAND' }).click();
    const fileChooser_2 = await fileChooserPromise_2;
    await fileChooser_2.setFiles(path.join(__dirname, 'nand.bin'));


    const fileChooserPromise_3 = page.waitForEvent('filechooser');
    await page.getByRole('button', { name: 'Upload NOR' }).click();
    const fileChooser_3 = await fileChooserPromise_3;
    await fileChooser_3.setFiles(path.join(__dirname, 'nor.bin'));

    // wait for emulator to boot up
    await delay(60000)

    return await analyser.stop()
}

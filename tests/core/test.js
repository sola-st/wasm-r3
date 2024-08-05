import { expect } from "playwright/test";

export default async function test(analyser, url) {
    const page = await analyser.start(url, { headless: true })
    await expect(page.getByText('milliseconds')).toBeVisible({ timeout: 1000 });
    return await analyser.stop()
}
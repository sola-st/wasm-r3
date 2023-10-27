import { Route, chromium } from 'playwright'
import fs from 'fs'
import cp from 'child_process'

// async function interceptResponse(route: Route) {
//   const response = await route.fulfill();

//   // Check the "Content-Type" header
//   const contentType = response.headers()['content-type'];
//   if (contentType && contentType.toLowerCase() === 'application/wasm') {
//     // Handle the "application/wasm" response here
//     console.log('Intercepted a "application/wasm" response');
//   }
// }

// async function interceptResponse(response: Response) {
//   const contentType = response.headers()['content-type'];
//   if (contentType && contentType.toLowerCase() === 'application/wasm') {
//     response.
//   }
// }

async function intercept(route: Route) {
  const response = await route.fetch();
  if (response.headers()['content-type'] === 'application/wasm') {
    let body = await response.body()
    fs.writeFileSync('./pspdf.wasm', body)
    // cp.execSync("cd /Users/jakob/Desktop/wasabi-fork/crates/wasabi && cargo run -- /Users/jakob/Desktop/wasm-r3/tool/pspdf.wasm --hooks=begin,store,load,call,memory_grow -o /Users/jakob/Desktop/wasm-r3/tool/")
    // cp.execSync("cd /Users/jakob/Desktop/wasabi-fork/crates/wasabi && cargo run -- /Users/jakob/Desktop/wasm-r3/tool/pspdf.wasm --hooks=store,load,memory_grow -o /Users/jakob/Desktop/wasm-r3/tool/")
    cp.execSync("cd /Users/jakob/Desktop/wasabi-fork/crates/wasabi && cargo run -- /Users/jakob/Desktop/wasm-r3/tool/pspdf.wasm -o /Users/jakob/Desktop/wasm-r3/tool/")
    // cp.execSync("wasabi /Users/jakob/Desktop/wasm-r3/tool/pspdf.wasm -o /Users/jakob/Desktop/wasm-r3/tool/")
    body = fs.readFileSync('./pspdf.wasm')
    console.log('finished instrumenting')
    route.fulfill({
      response,
      body,
    });
  } else if (response.headers()['content-type']?.startsWith('text/html')) {
    let body = await response.text()
    let i = body.indexOf('<body>') + 6
    body = body.slice(0, i) + `<script type="text/javascript">${fs.readFileSync('/Users/jakob/Desktop/wasm-r3/tool/src/runtime.js')}</script>` + body.slice(i);
    // console.log(body)
    route.fulfill({
      response,
      body,
    })
  } else {
    // console.log(response.headers())
    route.fulfill({
      response
    })
  }
}

(async () => {
  const browser = await chromium.launch({ headless: false });
  const page = await browser.newPage();

  // Intercept network requests and modify responses
  // page.route('**/*', (route) => interceptResponse(route));
  // page.on('response', response => interceptResponse(response))
  await page.route('**/*', intercept)

  // Navigate to a website
  await page.goto('https://playgameoflife.com');

  // Wait for some time to see the effect
  // await page.waitForTimeout(5000);

  // Close the browser
  // await browser.close();
})();





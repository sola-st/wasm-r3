import init, { greet } from './pkg/demo.js';

async function run() {
    await init();

    console.log(greet("Hello"));
    console.log(greet("World"));
}


run();

import cp from "child_process";
import path from "path";
import fs from "fs/promises";

async function run(names: string[], n: number) {
  let results: any = {};
  for (let name of names) {
    console.log(name)
    results[name] = [];
    for (let i = 0; i < n; i++) {
        console.log(i)
      let start = performance.now();
      cp.execSync(
        `node ${path.join("./tests/online", name, "benchmark/bin_0/replay.js")} run`
      );
      let duration = performance.now() - start;
      results[name].push(duration);
    }
  }
  await fs.writeFile('replay-times.json', JSON.stringify(results))
}

const names = [
  "boa",
  "commanderkeen",
  "ffmpeg",
  "fib",
  "figma-startpage",
  "funky-kart",
  "game-of-life",
  "guiicons",
  "handy-tools",
  "jsc",
  "kittygame",
  "pathfinding",
  "riconpacker",
  "rtexviewer",
  "sqlgui",
  "video",
  "multiplyInt",
];

run(names, 5);

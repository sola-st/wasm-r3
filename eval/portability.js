import cp from "child_process";
import fs from "fs/promises";
import path from "path";

const onlinePath = "./tests/online";

function writeWithSpaces(name) {
  const totalLength = 45;
  if (totalLength < name.length) {
    throw new Error(
      "Total length should oe greater than or equal to the length of the initial word."
    );
  }
  const spacesLength = totalLength - name.length;
  const spaces = " ".repeat(spacesLength);
  process.stdout.write(spaces + " " + name);
}

async function run() {
  console.log("Deno, Bun and Node need to be installed");
  console.log(
    "Also you should probably run run-tests.cts -j first to have the benchmarks available"
  );
  let folders = await fs.readdir(onlinePath);
  // folders = ['funky-kart']
  for (let folder of folders) {
    let benchmarkPath = path.join(onlinePath, folder, "benchmark");
    let subBenchmarks;
    try {
      subBenchmarks = await fs.readdir(benchmarkPath);
    } catch {
      continue;
    }
    let node = true;
    let deno = true;
    let bun = true;
    writeWithSpaces(folder + ":");
    for (let subBenchmark of subBenchmarks) {
      let replay = path.join(benchmarkPath, subBenchmark, "replay.js");
      try {
        cp.execSync(`node ${replay} run`);
      } catch (e) {
        node = false;
      }
      try {
        cp.execSync(`deno run --allow-read ${replay} run`);
      } catch (e) {
        deno = false;
      }
      try {
        cp.execSync(`bun run ${replay} run`);
      } catch (e) {
        bun = false;
      }
    }
    console.log(`Node: ${node},\tDeno: ${deno},\tBun: ${bun}`);
  }
}

run();
console.log(
  "You have to first run `run-tests.cts` with `-j` option because the replays should be already generated."
);

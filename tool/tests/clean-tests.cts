import fs from 'fs'
import path from 'path'
import { getDirectoryNames } from './test-utils.cjs';

const testDir = path.join(process.cwd(), 'tests');

let testNames = getDirectoryNames(testDir);
for (let name of testNames) {
    const testPath = path.join(testDir, name);
    rmSafe(path.join(testPath, "gen.js"));
    rmSafe(path.join(testPath, "replayGen.js"));
    rmSafe(path.join(testPath, "index.wasabi.cjs"));
    rmSafe(path.join(testPath, "index.wasm"));
    rmSafe(path.join(testPath, "trace.r3"));
    rmSafe(path.join(testPath, "replay-trace.r3"));
    rmSafe(path.join(testPath, "replay.js"));
    rmSafe(path.join(testPath, "report.txt"));
    rmSafe(path.join(testPath, "long.js"));
    rmSafe(path.join(testPath, "call-graph.txt"));
    rmSafe(path.join(testPath, "replay-call-graph.txt"));
    rmSafe(path.join(testPath, "long.cjs"));
}

function rmSafe(path: string) {
    try {
        fs.rmSync(path);
    } catch {
        // file doesnt exist, ok
    }
}
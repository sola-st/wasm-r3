import fs from "fs/promises";
import cp from "child_process";
import path from "path";

async function run(names: string[], repeat: number) {
  const summary = {
    replayGenTimeMean: 0,
    relativeReplayGenTimeMean: 0,
    loadsRatioMean: 0,
    tableGetsRatioMean: 0,
    globalGetsRatioMean: 0,
    functionEntriesRatioMean: 0,
    functionExitsRatioMean: 0,
    callsRatioMean: 0,
    callReturnsRatioMean: 0,
    roundTripTimeMean: 0,
    relativeRoundTripTimeMean: 0
  };
  for (let name of names) {
    summary[name] = {
      results: [],
      roundTripTimeMean: 0,
      relativeRoundTripTime: 0,
      replayGenTimeMean: 0,
      relativeReplayGenTimeMean: 0,
    };
  }
  let firstEntry = true;
  for (let i = 0; i < repeat; i++) {
    console.log('repetition', i)
    for (let name of names) {
      console.log('test', name)
      cp.execSync(`npm t -- online -t ${name}`);
      const testPath = path.join("tests/online", name);
      const performancePath = path.join(testPath, "performance.ndjson");
      const subBenchmarkPath = path.join(testPath, "benchmark/bin_0");
      const tracePath = path.join(subBenchmarkPath, "trace-ref.r3");
      const jsons = await fs.readFile(performancePath, "utf8");
      const results = jsons.split("\n").filter((r) => r !== "");
      let parsed = {};
      for (let result of results) {
        const p = JSON.parse(result);
        parsed[p.name.replace(" ", "_")] = p;
      }
      const traceSize = (await fs.readFile(tracePath, "utf8")).split(
        "\n"
      ).length;
      let roundResult = {
        roundTripTime:
          parsed["round-trip_time"].duration -
          parsed["user_interaction"].duration,
        replayGenTime: parsed["replay-generation"].duration,
        traceSize,
        relativeReplayGenTime: parsed["replay-generation"].duration / traceSize,
        recordTime: parsed["user_interaction"].duration
      };
      summary[name].results.push(roundResult);
      if (firstEntry === true) {
        const statsPath = path.join(subBenchmarkPath, "stats.json");
        const statsString = await fs.readFile(statsPath, "utf-8");
        let stats = JSON.parse(statsString);
        // if division by 0, infinity gets assigned which turns into null when written to json
        stats.loadsRatio = stats.relevantLoads / stats.loads;
        stats.globalGetsRatio = stats.relevantGlobalGets / stats.globalGets;
        stats.tableGetsRatio = stats.relevantTableGets / stats.tableGets;
        stats.callsRatio = stats.relevantCalls / stats.calls;
        stats.callReturnsRatio = stats.relevantCallReturns / stats.callReturns;
        stats.functionEntriesRatio =
          stats.relevantFunctionEntries / stats.functionEntries;
        stats.functionExitsRatio =
          stats.relevantFunctionExits / stats.functionExits;
        summary[name].stats = stats;
        summary[name].traceSize = traceSize;
      }
    }
    firstEntry = false;
  }
  let loadsValues = 0;
  let tableGetsValues = 0;
  let globalGetsValues = 0;
  let functionEntriesValues = 0;
  let functionExitsValues = 0;
  let callsValues = 0;
  let callReturnsValues = 0;
  for (let name of names) {
    const current = summary[name];
    const stats = current.stats;
    for (let result of current.results) {
      current.roundTripTimeMean += result.roundTripTime;
      current.replayGenTimeMean += result.replayGenTime;
      current.relativeReplayGenTimeMean += result.relativeReplayGenTime;
    }
    current.roundTripTimeMean /= repeat;
    current.relativeRoundTripTime / current.traceSize;
    current.replayGenTimeMean /= repeat;
    current.relativeReplayGenTimeMean /= repeat;
    
    summary.replayGenTimeMean += current.replayGenTimeMean;
    summary.relativeReplayGenTimeMean += current.relativeReplayGenTimeMean;
    summary.roundTripTimeMean += current.roundTripTimeMean;
    summary.relativeRoundTripTimeMean += current.relativeRoundTripTime;
    if (Number.isFinite(stats.loadsRatio)) {
      summary.loadsRatioMean += stats.loadsRatio;
      loadsValues++;
    }
    if (Number.isFinite(stats.tableGetsRatio)) {
      summary.tableGetsRatioMean += stats.tableGetsRatio;
      tableGetsValues++;
    }
    if (Number.isFinite(stats.globalGetsRatio)) {
      summary.globalGetsRatioMean += stats.globalGetsRatio;
      globalGetsValues++;
    }
    if (Number.isFinite(stats.functionEntriesRatio)) {
      summary.functionEntriesRatioMean += stats.functionEntriesRatio;
      functionEntriesValues++;
    }
    if (Number.isFinite(stats.functionExitsRatio)) {
      summary.functionExitsRatioMean += stats.functionExitsRatio;
      functionExitsValues++;
    }
    if (Number.isFinite(stats.callsRatio)) {
      summary.callsRatioMean += stats.callsRatio;
      callsValues++;
    }
    if (Number.isFinite(stats.callReturnsRatio)) {
      summary.callReturnsRatioMean += stats.callReturnsRatio;
      callReturnsValues++;
    }
  }
  summary.relativeRoundTripTimeMean /= names.length;
  summary.replayGenTimeMean /= names.length;
  summary.relativeReplayGenTimeMean /= names.length;
  summary.loadsRatioMean /= loadsValues;
  summary.tableGetsRatioMean /= tableGetsValues;
  summary.globalGetsRatioMean /= globalGetsValues;
  summary.functionEntriesRatioMean /= functionEntriesValues;
  summary.functionExitsRatioMean /= functionExitsValues;
  summary.callsRatioMean /= callsValues;
  summary.callReturnsRatioMean /= callReturnsValues;
  await fs.writeFile("evaluation.json", JSON.stringify(summary));
}

const names = [
  // "boa",
  // "commanderkeen",
  "ffmpeg",
  "fib",
  // "figma-startpage",
  // "funky-kart",
  // "game-of-life",
  // "guiicons",
  "handy-tools",
  // "jsc",
  // "kittygame",
  // "pathfinding",
  // "riconpacker",
  // "rtexviewer",
  "sqlgui",
  // "video",
  "multiplyInt",
];
run(names, 5);

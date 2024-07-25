import express from "express";
import Benchmark from "../src/benchmark.cjs";
//@ts-ignore
import { Analyser } from "../src/analyser.cjs";
import { expect } from "playwright/test";
import { exit } from "process";
import { Server } from "http";
import path from "path";
import { execSync } from "child_process";

export default async function runSliceDiceTests(names: string[], options) {
  // Serve the benchmark directory
  for (let name of names) {
    const benchmarkPath = path.join(process.cwd(), "benchmarks", name);
    const replayWasmPath = path.join(benchmarkPath, `${name}.wasm`)
    const subsetOfFidx = getSubsetFidx(replayWasmPath, name);
    for (let fidx of subsetOfFidx) {
      console.log(`${name}-${fidx}:`);
      const subsetPath = path.join(benchmarkPath, 'out', `${fidx}`)
      runSliceDice(replayWasmPath, fidx);
      const server: any = await startServer(subsetPath);
      const url = 'http://localhost:' + server.address().port
      await runWasmR3(options, url, subsetPath);
      checkResult(benchmarkPath, name, fidx);
    }
  }
  exit(0)
}

function getSubsetFidx(replayWasmPath: string, name: string) {
  const cache = fidxCache
  // we can do this as it's deterministic
  if (cache[name]) {
    return cache[name];
  }
  process.stdout.write(`Getting fid candiates for ${name}: `);
  const startTime = Date.now();
  let subsetOfFidx = [];
  try {
    execSync(`./target/release/slice_dice ${replayWasmPath}`, { stdio: ['pipe', 'pipe', 'ignore'] });
  } catch (e) {
    const matches = e.stdout.toString().match(/\d+/g);
    if (matches) {
      // Parse each match as an integer and assign to subsetOfFidx
      subsetOfFidx = matches.map(Number);
    }
  }
  const endTime = Date.now();
  console.log(`${subsetOfFidx}`);
  return subsetOfFidx
}

function runSliceDice(replayWasmPath: string, fidx: number) {
  process.stdout.write('    Running slice-dice: ');
  const startTime = Date.now();
  const command = `./target/release/slice_dice ${replayWasmPath} ${fidx} 1`;
  execSync(command);
  const endTime = Date.now();
  console.log(`${endTime - startTime}ms`);
}

async function startServer(websitePath: string): Promise<Server> {
  const app = express();
  const port = 0;
  app.use(express.static(websitePath));
  return new Promise((resolve) => {
    const server = app.listen(port, () => {
      resolve(server);
    });
  });
}

async function runWasmR3(options: any, url: string, path: string) {
  process.stdout.write('    Running wasm-r3: ');
  const startTime = Date.now();
  let analyser = new Analyser('./dist/src/tracer.cjs', options);
  let page = await analyser.start(url, { headless: options.headless });
  await expect(page.getByText('milliseconds')).toBeVisible({ timeout: 100000 });
  const results = await analyser.stop();
  await Benchmark.fromAnalysisResult(results).save(`${path}/benchmarks`, { trace: options.dumpTrace, rustBackend: options.rustBackend });
  const endTime = Date.now();
  console.log(`${endTime - startTime}ms`);
}

function checkResult(benchmarkPath: string, name: string, fidx: any) {
  process.stdout.write(`    Running wasmtime: `);
  const startTime = Date.now();
  // TODO: is it always the case that bin_1 is the subset?
  execSync(`wasmtime ${path.join(benchmarkPath, 'out', `${fidx}`, 'benchmarks', 'bin_1', 'replay.wasm')}`);
  const endTime = Date.now();
  console.log(`${endTime - startTime}ms`);
}

const fidxCache = {
  'commanderkeen': [1, 10, 11, 12, 17, 18, 19, 20, 22, 23, 27, 41, 42, 43, 44, 45, 62, 63, 118, 119, 120, 121, 122, 123, 124, 125, 127, 131, 132, 133, 134, 136, 138, 139, 140, 141, 144, 148, 149, 150, 151, 152, 157, 159, 162, 163, 165, 166, 168, 169, 172, 173, 174, 175, 176, 177, 178, 179, 180, 181, 182, 183, 185, 187, 192, 200, 219, 220, 223, 225, 231, 236, 237, 238, 239, 240, 243, 246, 247, 248, 257, 311, 312, 313, 314, 315, 316, 318, 319, 320, 322, 355, 433, 435, 436, 442, 443, 444, 446, 450, 452, 467, 468, 469, 473, 475, 476, 477, 480, 481, 482, 485, 488, 489, 490, 491, 492, 493, 494, 495, 556, 559, 567, 569, 570, 571, 572, 585, 587, 588, 590, 591, 593, 596, 597, 599, 601, 602, 603, 604, 606, 610, 611, 612, 613, 614, 624, 625, 627, 628, 629, 630, 651, 654, 655, 656, 657, 658, 659, 660, 663, 666, 667, 668, 689, 690, 704, 705, 709, 710, 711, 715, 717, 719, 721, 724, 725, 726, 727, 728, 729, 730, 731, 732, 733, 734, 735, 736, 737, 738, 739, 740, 741, 742, 743, 744, 745, 753, 757, 761, 762, 769, 803, 809, 980, 981, 983, 984, 985, 986, 987, 988, 989, 990, 991, 992, 993, 996, 998, 999, 1002, 1005, 1007, 1008, 1010, 1011, 1014, 1015, 1016, 1017, 1018, 1021, 1022, 1023, 1024, 1026, 1027, 1031, 1032, 1033, 1034, 1035, 1036, 1037, 1038, 1039, 1040, 1041, 1043, 1051, 1058, 1059, 1061, 1067, 1068, 1070, 1071, 1074, 1075, 1076, 1077, 1157, 1158, 1159, 1160, 1163, 1164, 1168, 1177, 1178, 1186, 1187, 1191, 1192, 1193, 1194, 1195, 1199, 1201, 1205, 1206, 1207, 1208, 1212, 1214, 1229, 1231, 1234, 1238, 1239, 1256, 1258, 1259, 1260, 1263, 1266, 1268, 1270, 1271, 1272, 1273, 1274, 1275, 1276, 1277, 1282, 1284, 1285, 1295, 1297, 1298, 1300, 1301, 1302, 1303, 1305, 1306, 1307, 1308, 1310, 1311, 1313, 1314, 1318, 1321, 1327, 1341, 1342, 1343, 1348, 1349, 1350, 1351, 1352, 1356, 1357, 1359, 1362, 1363, 1364, 1367, 1368, 1372, 1374, 1375, 1381, 1382, 1383, 1384, 1386, 1389, 1391, 1392, 1398, 1399, 1400, 1401, 1402, 1404, 1409, 1411, 1414, 1416, 1419, 1421, 1422, 1423, 1424, 1425, 1426, 1427, 1428, 1432, 1470, 1471, 1473, 1474, 1484, 1499, 1500, 1501, 1502, 1503, 1509, 1510, 1511, 1513, 1514, 1515, 1516, 1517, 1522, 1524, 1525, 1526, 1527, 1528, 1529, 1530, 1531, 1533, 1542, 1543, 1544, 1545, 1546, 1547, 1548, 1549, 1550, 1551, 1552, 1553, 1554, 1555, 1556, 1558, 1559, 1561, 1562, 1563, 1566, 1567, 1568, 1569, 1570, 1572, 1573, 1574, 1576, 1579, 1582, 1585, 1590, 1591, 1592, 1593, 1594, 1595, 1596, 1597, 1598, 1602, 1604, 1605, 1606, 1607, 1608, 1610, 1612, 1613, 1614, 1628, 1629, 1630, 1632, 1633, 1634, 1635, 1636, 1639, 1640, 1641, 1645, 1646, 1647, 1648, 1649, 1650, 1653, 1655, 1656, 1657, 1658, 1661, 1662, 1663, 1664, 1666, 1667, 1668, 1688, 1689, 1693, 1697, 1731, 1732, 1733, 1734, 1735, 1737, 1738, 1739, 1740, 1741, 1742, 1743, 1746, 1747, 1748, 1749, 1750, 1751, 1752, 1753, 1754, 1755, 1757, 1758, 1759, 1762, 1763, 1764, 1766, 1768, 1770, 1771, 1775, 1776, 1778, 1779, 1780, 1781, 1782, 1783, 1784, 1785, 1786, 1787, 1788, 1789, 1790, 1791, 1792, 1793, 1794, 1795, 1796, 1797, 1798, 1820, 1821, 1822, 1823, 1826, 1832, 1833, 1835, 1836, 1840, 1845, 1846, 1853, 1858, 1859, 1860, 1863, 1869, 1873, 1883, 1884, 1887, 1896, 1909, 1910, 1918, 1925, 1928, 1930, 1933, 1949, 1950, 1960, 1961, 1962, 1963, 1964, 1965, 1966, 1968],
  'fib': [8],
  'game-of-life': [1, 2],
  'multiplyDouble': [8],
  'multiplyInt': [8],
  'sandspiel': [1, 2, 3, 7, 10, 11, 12, 14, 20, 24, 25, 27, 30, 39, 41, 45, 46, 53, 58, 61, 62, 63, 64, 65, 78, 86, 87, 93],
  // Known cases that don't work
  'guiicons': [9, 30, 54, 66, 157, 198, 213, 215, 210, 486, 488],
  'hydro': [62, 96, 173, 411, 664, 1370, 1398, 1400, 1495, 1500],
  'mandelbrot': [17, 22, 26, 38, 42, 47, 48, 57, 59, 60, 61, 92, 98, 99, 102, 105, 109, 111, 131, 161, 163, 164],
};
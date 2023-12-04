import fs from 'fs'
import path from 'path'
let instance
let imports = {}
imports['a'] = {}
let global_0 = -1
imports['a']['a'] = () => {
global_0++
}
let global_1 = -1
imports['a']['b'] = () => {
global_1++
}
let global_2 = -1
imports['a']['c'] = () => {
global_2++
}
let global_3 = -1
imports['a']['d'] = () => {
global_3++
}
let global_4 = -1
imports['a']['e'] = () => {
global_4++
}
let global_5 = -1
imports['a']['f'] = () => {
global_5++
switch (global_5) {
case 0:
new Uint8Array(instance.exports.I.buffer)[138104] = 20
new Uint8Array(instance.exports.I.buffer)[138016] = 1
break
case 1:
new Uint8Array(instance.exports.I.buffer)[137384] = 1
break
}
if ((global_5 >= 0) && global_5 < 2) {
return 0 }
}
let global_6 = -1
imports['a']['g'] = () => {
global_6++
}
let global_7 = -1
imports['a']['h'] = () => {
global_7++
}
let global_8 = -1
imports['a']['i'] = () => {
global_8++
}
let global_9 = -1
imports['a']['j'] = () => {
global_9++
}
let global_10 = -1
imports['a']['k'] = () => {
global_10++
}
let global_11 = -1
imports['a']['l'] = () => {
global_11++
}
let global_12 = -1
imports['a']['m'] = () => {
global_12++
switch (global_12) {
}
if ((global_12 >= 0) && global_12 < 1) {
return 0 }
}
let global_13 = -1
imports['a']['n'] = () => {
global_13++
}
let global_14 = -1
imports['a']['o'] = () => {
global_14++
}
let global_15 = -1
imports['a']['p'] = () => {
global_15++
}
let global_16 = -1
imports['a']['q'] = () => {
global_16++
}
let global_17 = -1
imports['a']['r'] = () => {
global_17++
}
let global_18 = -1
imports['a']['s'] = () => {
global_18++
}
let global_19 = -1
imports['a']['t'] = () => {
global_19++
}
let global_20 = -1
imports['a']['u'] = () => {
global_20++
}
let global_21 = -1
imports['a']['v'] = () => {
global_21++
}
let global_22 = -1
imports['a']['w'] = () => {
global_22++
}
let global_23 = -1
imports['a']['x'] = () => {
global_23++
switch (global_23) {
}
if ((global_23 >= 0) && global_23 < 1) {
return 0 }
}
let global_24 = -1
imports['a']['y'] = () => {
global_24++
switch (global_24) {
}
if ((global_24 >= 0) && global_24 < 1) {
return 3 }
}
let global_25 = -1
imports['a']['z'] = () => {
global_25++
}
let global_26 = -1
imports['a']['A'] = () => {
global_26++
switch (global_26) {
}
if ((global_26 >= 0) && global_26 < 1) {
return 0 }
}
let global_27 = -1
imports['a']['B'] = () => {
global_27++
switch (global_27) {
case 0:
new Uint8Array(instance.exports.I.buffer)[138764] = 7
new Uint8Array(instance.exports.I.buffer)[138760] = 98
break
}
if ((global_27 >= 0) && global_27 < 1) {
return 0 }
}
let global_28 = -1
imports['a']['C'] = () => {
global_28++
switch (global_28) {
case 0:
new Uint8Array(instance.exports.I.buffer)[134432] = 47
break
}
if ((global_28 >= 0) && global_28 < 1) {
return 2 }
}
let global_29 = -1
imports['a']['D'] = () => {
global_29++
}
let global_30 = -1
imports['a']['E'] = () => {
global_30++
}
let global_31 = -1
imports['a']['F'] = () => {
global_31++
switch (global_31) {
}
if ((global_31 >= 0) && global_31 < 1) {
return -44 }
}
let global_32 = -1
imports['a']['G'] = () => {
global_32++
switch (global_32) {
case 0:
new Uint8Array(instance.exports.I.buffer)[137352] = 20
break
}
if ((global_32 >= 0) && global_32 < 1) {
return 0 }
}
let global_33 = -1
imports['a']['H'] = () => {
global_33++
}
export function replay(wasm) {instance = wasm.instance
instance.exports.J()
instance.exports.Fa(4)
instance.exports.Da()
instance.exports.Fa(18)
instance.exports.xa(138720,138752)
new Uint8Array(instance.exports.I.buffer)[138776] = 64
new Uint8Array(instance.exports.I.buffer)[138777] = 30
new Uint8Array(instance.exports.I.buffer)[138778] = 2
new Uint8Array(instance.exports.I.buffer)[138816] = 85
new Uint8Array(instance.exports.I.buffer)[138780] = 78
new Uint8Array(instance.exports.I.buffer)[138781] = 30
new Uint8Array(instance.exports.I.buffer)[138782] = 2
new Uint8Array(instance.exports.I.buffer)[138830] = 76
new Uint8Array(instance.exports.I.buffer)[138784] = 95
new Uint8Array(instance.exports.I.buffer)[138785] = 30
new Uint8Array(instance.exports.I.buffer)[138786] = 2
new Uint8Array(instance.exports.I.buffer)[138847] = 80
new Uint8Array(instance.exports.I.buffer)[138788] = 102
new Uint8Array(instance.exports.I.buffer)[138789] = 30
new Uint8Array(instance.exports.I.buffer)[138790] = 2
new Uint8Array(instance.exports.I.buffer)[138854] = 80
new Uint8Array(instance.exports.I.buffer)[138792] = 108
new Uint8Array(instance.exports.I.buffer)[138793] = 30
new Uint8Array(instance.exports.I.buffer)[138794] = 2
new Uint8Array(instance.exports.I.buffer)[138860] = 72
new Uint8Array(instance.exports.I.buffer)[138796] = 128
new Uint8Array(instance.exports.I.buffer)[138797] = 30
new Uint8Array(instance.exports.I.buffer)[138798] = 2
new Uint8Array(instance.exports.I.buffer)[138880] = 76
new Uint8Array(instance.exports.I.buffer)[138800] = 145
new Uint8Array(instance.exports.I.buffer)[138801] = 30
new Uint8Array(instance.exports.I.buffer)[138802] = 2
new Uint8Array(instance.exports.I.buffer)[138897] = 95
new Uint8Array(instance.exports.I.buffer)[138720] = 100
new Uint8Array(instance.exports.I.buffer)[138721] = 98
new Uint8Array(instance.exports.I.buffer)[138722] = 102
new Uint8Array(instance.exports.I.buffer)[138723] = 105
new Uint8Array(instance.exports.I.buffer)[138724] = 108
new Uint8Array(instance.exports.I.buffer)[138725] = 101
new Uint8Array(instance.exports.I.buffer)[138726] = 95
new Uint8Array(instance.exports.I.buffer)[138727] = 49
new Uint8Array(instance.exports.I.buffer)[138728] = 48
new Uint8Array(instance.exports.I.buffer)[138729] = 48
new Uint8Array(instance.exports.I.buffer)[138730] = 57
new Uint8Array(instance.exports.I.buffer)[138731] = 51
new Uint8Array(instance.exports.I.buffer)[138732] = 57
new Uint8Array(instance.exports.I.buffer)[138733] = 48
new Uint8Array(instance.exports.I.buffer)[138734] = 55
new Uint8Array(instance.exports.I.buffer)[138735] = 54
new Uint8Array(instance.exports.I.buffer)[138736] = 54
instance.exports.Ea(138752)
instance.exports.Ba(138928)
}
export function instantiate(wasmBinary) {
return WebAssembly.instantiate(wasmBinary, imports)
}
if (process.argv[2] === 'run') {
const p = path.join(path.dirname(import.meta.url).replace(/^file:/, ''), 'index.wasm')
const wasmBinary = fs.readFileSync(p)
instantiate(wasmBinary).then((wasm) => replay(wasm))
}

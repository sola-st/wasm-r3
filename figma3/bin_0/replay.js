import fs from 'fs'
import path from 'path'
let instance
let imports = {}
imports['a'] = {}
let global_0 = -1
imports['a']['a'] = () => {
global_0++
switch (global_0) {
}
if ((global_0 >= 0) && global_0 < 66) {
return undefined }
}
let global_1 = -1
imports['a']['b'] = () => {
global_1++
}
let global_2 = -1
imports['a']['c'] = () => {
global_2++
switch (global_2) {
}
if ((global_2 >= 0) && global_2 < 42) {
return undefined }
}
let global_3 = -1
imports['a']['d'] = () => {
global_3++
switch (global_3) {
}
if ((global_3 >= 0) && global_3 < 32) {
return undefined }
}
let global_4 = -1
imports['a']['e'] = () => {
global_4++
switch (global_4) {
}
if ((global_4 >= 0) && global_4 < 28) {
return undefined }
}
let global_5 = -1
imports['a']['f'] = () => {
global_5++
}
let global_6 = -1
imports['a']['g'] = () => {
global_6++
switch (global_6) {
}
if ((global_6 >= 0) && global_6 < 17) {
return undefined }
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
switch (global_9) {
}
if ((global_9 >= 0) && global_9 < 9) {
return undefined }
}
let global_10 = -1
imports['a']['k'] = () => {
global_10++
switch (global_10) {
}
if ((global_10 >= 0) && global_10 < 8) {
return undefined }
}
let global_11 = -1
imports['a']['l'] = () => {
global_11++
switch (global_11) {
}
if ((global_11 >= 0) && global_11 < 7) {
return undefined }
}
let global_12 = -1
imports['a']['m'] = () => {
global_12++
}
let global_13 = -1
imports['a']['n'] = () => {
global_13++
}
let global_14 = -1
imports['a']['o'] = () => {
global_14++
switch (global_14) {
}
if ((global_14 >= 0) && global_14 < 5) {
return undefined }
}
let global_15 = -1
imports['a']['p'] = () => {
global_15++
}
let global_16 = -1
imports['a']['q'] = () => {
global_16++
switch (global_16) {
}
if ((global_16 >= 0) && global_16 < 4) {
return undefined }
}
let global_17 = -1
imports['a']['r'] = () => {
global_17++
}
let global_18 = -1
imports['a']['s'] = () => {
global_18++
switch (global_18) {
}
if ((global_18 >= 0) && global_18 < 3) {
return undefined }
}
let global_19 = -1
imports['a']['t'] = () => {
global_19++
switch (global_19) {
}
if ((global_19 >= 0) && global_19 < 3) {
return undefined }
}
let global_20 = -1
imports['a']['u'] = () => {
global_20++
switch (global_20) {
}
if ((global_20 >= 0) && global_20 < 2) {
return undefined }
}
let global_21 = -1
imports['a']['v'] = () => {
global_21++
switch (global_21) {
}
if ((global_21 >= 0) && global_21 < 2) {
return undefined }
}
let global_22 = -1
imports['a']['w'] = () => {
global_22++
}
let global_23 = -1
imports['a']['x'] = () => {
global_23++
}
let global_24 = -1
imports['a']['y'] = () => {
global_24++
}
let global_25 = -1
imports['a']['z'] = () => {
global_25++
switch (global_25) {
}
if ((global_25 >= 0) && global_25 < 2) {
return undefined }
}
let global_26 = -1
imports['a']['A'] = () => {
global_26++
}
let global_27 = -1
imports['a']['B'] = () => {
global_27++
}
let global_28 = -1
imports['a']['C'] = () => {
global_28++
}
let global_29 = -1
imports['a']['D'] = () => {
global_29++
switch (global_29) {
}
if ((global_29 >= 0) && global_29 < 1) {
return undefined }
}
let global_30 = -1
imports['a']['E'] = () => {
global_30++
switch (global_30) {
}
if ((global_30 >= 0) && global_30 < 1) {
return undefined }
}
let global_31 = -1
imports['a']['F'] = () => {
global_31++
switch (global_31) {
}
if ((global_31 >= 0) && global_31 < 1) {
return undefined }
}
let global_32 = -1
imports['a']['G'] = () => {
global_32++
}
let global_33 = -1
imports['a']['H'] = () => {
global_33++
}
let global_34 = -1
imports['a']['I'] = () => {
global_34++
}
let global_35 = -1
imports['a']['J'] = () => {
global_35++
switch (global_35) {
}
if ((global_35 >= 0) && global_35 < 1) {
return undefined }
}
let global_36 = -1
imports['a']['K'] = () => {
global_36++
switch (global_36) {
}
if ((global_36 >= 0) && global_36 < 4) {
return undefined }
}
let global_37 = -1
imports['a']['L'] = () => {
global_37++
switch (global_37) {
}
if ((global_37 >= 0) && global_37 < 1) {
return undefined }
}
export function replay(wasm) {instance = wasm.instance
instance.exports.N()
instance.exports.P(22)
}
export function instantiate(wasmBinary) {
return WebAssembly.instantiate(wasmBinary, imports)
}
if (process.argv[2] === 'run') {
const p = path.join(path.dirname(import.meta.url).replace(/^file:/, ''), 'index.wasm')
const wasmBinary = fs.readFileSync(p)
instantiate(wasmBinary).then((wasm) => replay(wasm))
}

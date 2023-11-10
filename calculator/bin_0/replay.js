import fs from 'fs'
import path from 'path'
const p = path.join(path.dirname(import.meta.url).replace(/^file:/, ''), 'index.wasm')
const wasmBinary = fs.readFileSync(p)
let instance
let imports = {}
imports.go = {}
let global_0  = -1
imports.go.debug = () => {
global_0 ++
switch (global_0 ) {
}
}
let global_1  = -1
imports.go.runtime.wasmExit = () => {
global_1 ++
switch (global_1 ) {
}
}
let global_2  = -1
imports.go.runtime.wasmWrite = () => {
global_2 ++
switch (global_2 ) {
}
}
let global_3  = -1
imports.go.runtime.nanotime = () => {
global_3 ++
switch (global_3 ) {
case 0:
new Uint8Array(instance.exports.mem.buffer)[1877776] = 0
new Uint8Array(instance.exports.mem.buffer)[1877777] = 244
new Uint8Array(instance.exports.mem.buffer)[1877778] = 130
new Uint8Array(instance.exports.mem.buffer)[1877779] = 155
new Uint8Array(instance.exports.mem.buffer)[1877780] = 190
new Uint8Array(instance.exports.mem.buffer)[1877781] = 44
new Uint8Array(instance.exports.mem.buffer)[1877782] = 150
new Uint8Array(instance.exports.mem.buffer)[1877783] = 23
return undefined 
case 1:
new Uint8Array(instance.exports.mem.buffer)[1877824] = 0
new Uint8Array(instance.exports.mem.buffer)[1877825] = 185
new Uint8Array(instance.exports.mem.buffer)[1877826] = 122
new Uint8Array(instance.exports.mem.buffer)[1877827] = 184
new Uint8Array(instance.exports.mem.buffer)[1877828] = 190
new Uint8Array(instance.exports.mem.buffer)[1877829] = 44
new Uint8Array(instance.exports.mem.buffer)[1877830] = 150
new Uint8Array(instance.exports.mem.buffer)[1877831] = 23
return undefined 
case 2:
new Uint8Array(instance.exports.mem.buffer)[1877648] = 0
new Uint8Array(instance.exports.mem.buffer)[1877649] = 94
new Uint8Array(instance.exports.mem.buffer)[1877650] = 22
new Uint8Array(instance.exports.mem.buffer)[1877651] = 185
new Uint8Array(instance.exports.mem.buffer)[1877652] = 190
new Uint8Array(instance.exports.mem.buffer)[1877653] = 44
new Uint8Array(instance.exports.mem.buffer)[1877654] = 150
new Uint8Array(instance.exports.mem.buffer)[1877655] = 23
return undefined 
case 3:
new Uint8Array(instance.exports.mem.buffer)[4343384] = 0
new Uint8Array(instance.exports.mem.buffer)[4343385] = 23
new Uint8Array(instance.exports.mem.buffer)[4343386] = 228
new Uint8Array(instance.exports.mem.buffer)[4343387] = 193
new Uint8Array(instance.exports.mem.buffer)[4343388] = 190
new Uint8Array(instance.exports.mem.buffer)[4343389] = 44
new Uint8Array(instance.exports.mem.buffer)[4343390] = 150
new Uint8Array(instance.exports.mem.buffer)[4343391] = 23
return undefined 
case 4:
new Uint8Array(instance.exports.mem.buffer)[4345600] = 0
new Uint8Array(instance.exports.mem.buffer)[4345601] = 56
new Uint8Array(instance.exports.mem.buffer)[4345602] = 245
new Uint8Array(instance.exports.mem.buffer)[4345603] = 194
new Uint8Array(instance.exports.mem.buffer)[4345604] = 190
new Uint8Array(instance.exports.mem.buffer)[4345605] = 44
new Uint8Array(instance.exports.mem.buffer)[4345606] = 150
new Uint8Array(instance.exports.mem.buffer)[4345607] = 23
return undefined 
case 5:
new Uint8Array(instance.exports.mem.buffer)[4343648] = 0
new Uint8Array(instance.exports.mem.buffer)[4343649] = 229
new Uint8Array(instance.exports.mem.buffer)[4343650] = 28
new Uint8Array(instance.exports.mem.buffer)[4343651] = 195
new Uint8Array(instance.exports.mem.buffer)[4343652] = 190
new Uint8Array(instance.exports.mem.buffer)[4343653] = 44
new Uint8Array(instance.exports.mem.buffer)[4343654] = 150
new Uint8Array(instance.exports.mem.buffer)[4343655] = 23
return undefined 
case 6:
new Uint8Array(instance.exports.mem.buffer)[4343648] = 0
new Uint8Array(instance.exports.mem.buffer)[4343649] = 121
new Uint8Array(instance.exports.mem.buffer)[4343650] = 33
new Uint8Array(instance.exports.mem.buffer)[4343651] = 195
new Uint8Array(instance.exports.mem.buffer)[4343652] = 190
new Uint8Array(instance.exports.mem.buffer)[4343653] = 44
new Uint8Array(instance.exports.mem.buffer)[4343654] = 150
new Uint8Array(instance.exports.mem.buffer)[4343655] = 23
return undefined 
case 7:
new Uint8Array(instance.exports.mem.buffer)[4343256] = 0
new Uint8Array(instance.exports.mem.buffer)[4343257] = 87
new Uint8Array(instance.exports.mem.buffer)[4343258] = 241
new Uint8Array(instance.exports.mem.buffer)[4343259] = 196
new Uint8Array(instance.exports.mem.buffer)[4343260] = 190
new Uint8Array(instance.exports.mem.buffer)[4343261] = 44
new Uint8Array(instance.exports.mem.buffer)[4343262] = 150
new Uint8Array(instance.exports.mem.buffer)[4343263] = 23
return undefined 
case 8:
new Uint8Array(instance.exports.mem.buffer)[4351640] = 0
new Uint8Array(instance.exports.mem.buffer)[4351641] = 10
new Uint8Array(instance.exports.mem.buffer)[4351642] = 84
new Uint8Array(instance.exports.mem.buffer)[4351643] = 200
new Uint8Array(instance.exports.mem.buffer)[4351644] = 190
new Uint8Array(instance.exports.mem.buffer)[4351645] = 44
new Uint8Array(instance.exports.mem.buffer)[4351646] = 150
new Uint8Array(instance.exports.mem.buffer)[4351647] = 23
return undefined 
case 9:
new Uint8Array(instance.exports.mem.buffer)[4343256] = 0
new Uint8Array(instance.exports.mem.buffer)[4343257] = 180
new Uint8Array(instance.exports.mem.buffer)[4343258] = 152
new Uint8Array(instance.exports.mem.buffer)[4343259] = 200
new Uint8Array(instance.exports.mem.buffer)[4343260] = 190
new Uint8Array(instance.exports.mem.buffer)[4343261] = 44
new Uint8Array(instance.exports.mem.buffer)[4343262] = 150
new Uint8Array(instance.exports.mem.buffer)[4343263] = 23
return undefined 
case 10:
new Uint8Array(instance.exports.mem.buffer)[4347656] = 0
new Uint8Array(instance.exports.mem.buffer)[4347657] = 138
new Uint8Array(instance.exports.mem.buffer)[4347658] = 172
new Uint8Array(instance.exports.mem.buffer)[4347659] = 200
new Uint8Array(instance.exports.mem.buffer)[4347660] = 190
new Uint8Array(instance.exports.mem.buffer)[4347661] = 44
new Uint8Array(instance.exports.mem.buffer)[4347662] = 150
new Uint8Array(instance.exports.mem.buffer)[4347663] = 23
return undefined 
case 11:
new Uint8Array(instance.exports.mem.buffer)[4349696] = 0
new Uint8Array(instance.exports.mem.buffer)[4349697] = 78
new Uint8Array(instance.exports.mem.buffer)[4349698] = 137
new Uint8Array(instance.exports.mem.buffer)[4349699] = 204
new Uint8Array(instance.exports.mem.buffer)[4349700] = 190
new Uint8Array(instance.exports.mem.buffer)[4349701] = 44
new Uint8Array(instance.exports.mem.buffer)[4349702] = 150
new Uint8Array(instance.exports.mem.buffer)[4349703] = 23
return undefined 
case 12:
new Uint8Array(instance.exports.mem.buffer)[4435448] = 0
new Uint8Array(instance.exports.mem.buffer)[4435449] = 227
new Uint8Array(instance.exports.mem.buffer)[4435450] = 191
new Uint8Array(instance.exports.mem.buffer)[4435451] = 86
new Uint8Array(instance.exports.mem.buffer)[4435452] = 192
new Uint8Array(instance.exports.mem.buffer)[4435453] = 44
new Uint8Array(instance.exports.mem.buffer)[4435454] = 150
new Uint8Array(instance.exports.mem.buffer)[4435455] = 23
return undefined 
case 13:
new Uint8Array(instance.exports.mem.buffer)[4435376] = 0
new Uint8Array(instance.exports.mem.buffer)[4435377] = 210
new Uint8Array(instance.exports.mem.buffer)[4435378] = 132
new Uint8Array(instance.exports.mem.buffer)[4435379] = 118
new Uint8Array(instance.exports.mem.buffer)[4435380] = 192
new Uint8Array(instance.exports.mem.buffer)[4435381] = 44
new Uint8Array(instance.exports.mem.buffer)[4435382] = 150
new Uint8Array(instance.exports.mem.buffer)[4435383] = 23
return undefined 
case 14:
new Uint8Array(instance.exports.mem.buffer)[4343464] = 0
new Uint8Array(instance.exports.mem.buffer)[4343465] = 71
new Uint8Array(instance.exports.mem.buffer)[4343466] = 237
new Uint8Array(instance.exports.mem.buffer)[4343467] = 120
new Uint8Array(instance.exports.mem.buffer)[4343468] = 192
new Uint8Array(instance.exports.mem.buffer)[4343469] = 44
new Uint8Array(instance.exports.mem.buffer)[4343470] = 150
new Uint8Array(instance.exports.mem.buffer)[4343471] = 23
return undefined 
case 15:
new Uint8Array(instance.exports.mem.buffer)[4345632] = 0
new Uint8Array(instance.exports.mem.buffer)[4345633] = 98
new Uint8Array(instance.exports.mem.buffer)[4345634] = 64
new Uint8Array(instance.exports.mem.buffer)[4345635] = 107
new Uint8Array(instance.exports.mem.buffer)[4345636] = 194
new Uint8Array(instance.exports.mem.buffer)[4345637] = 44
new Uint8Array(instance.exports.mem.buffer)[4345638] = 150
new Uint8Array(instance.exports.mem.buffer)[4345639] = 23
return undefined 
case 16:
new Uint8Array(instance.exports.mem.buffer)[4345592] = 0
new Uint8Array(instance.exports.mem.buffer)[4345593] = 15
new Uint8Array(instance.exports.mem.buffer)[4345594] = 202
new Uint8Array(instance.exports.mem.buffer)[4345595] = 108
new Uint8Array(instance.exports.mem.buffer)[4345596] = 194
new Uint8Array(instance.exports.mem.buffer)[4345597] = 44
new Uint8Array(instance.exports.mem.buffer)[4345598] = 150
new Uint8Array(instance.exports.mem.buffer)[4345599] = 23
return undefined 
case 17:
new Uint8Array(instance.exports.mem.buffer)[4345632] = 0
new Uint8Array(instance.exports.mem.buffer)[4345633] = 4
new Uint8Array(instance.exports.mem.buffer)[4345634] = 210
new Uint8Array(instance.exports.mem.buffer)[4345635] = 226
new Uint8Array(instance.exports.mem.buffer)[4345636] = 195
new Uint8Array(instance.exports.mem.buffer)[4345637] = 44
new Uint8Array(instance.exports.mem.buffer)[4345638] = 150
new Uint8Array(instance.exports.mem.buffer)[4345639] = 23
return undefined 
case 18:
new Uint8Array(instance.exports.mem.buffer)[4345592] = 0
new Uint8Array(instance.exports.mem.buffer)[4345593] = 232
new Uint8Array(instance.exports.mem.buffer)[4345594] = 74
new Uint8Array(instance.exports.mem.buffer)[4345595] = 228
new Uint8Array(instance.exports.mem.buffer)[4345596] = 195
new Uint8Array(instance.exports.mem.buffer)[4345597] = 44
new Uint8Array(instance.exports.mem.buffer)[4345598] = 150
new Uint8Array(instance.exports.mem.buffer)[4345599] = 23
return undefined 
}
}
let global_4  = -1
imports.go.runtime.walltime = () => {
global_4 ++
switch (global_4 ) {
}
}
let global_5  = -1
imports.go.runtime.scheduleTimeoutEvent = () => {
global_5 ++
switch (global_5 ) {
}
}
let global_6  = -1
imports.go.runtime.clearTimeoutEvent = () => {
global_6 ++
switch (global_6 ) {
}
}
let global_7  = -1
imports.go.runtime.getRandomData = () => {
global_7 ++
switch (global_7 ) {
case 0:
new Uint8Array(instance.exports.mem.buffer)[1861408] = 242
new Uint8Array(instance.exports.mem.buffer)[1861409] = 229
new Uint8Array(instance.exports.mem.buffer)[1861410] = 128
new Uint8Array(instance.exports.mem.buffer)[1861411] = 27
new Uint8Array(instance.exports.mem.buffer)[1861412] = 255
new Uint8Array(instance.exports.mem.buffer)[1861413] = 229
new Uint8Array(instance.exports.mem.buffer)[1861414] = 23
new Uint8Array(instance.exports.mem.buffer)[1861415] = 111
new Uint8Array(instance.exports.mem.buffer)[1861416] = 142
new Uint8Array(instance.exports.mem.buffer)[1861417] = 51
new Uint8Array(instance.exports.mem.buffer)[1861418] = 170
new Uint8Array(instance.exports.mem.buffer)[1861419] = 165
new Uint8Array(instance.exports.mem.buffer)[1861420] = 210
new Uint8Array(instance.exports.mem.buffer)[1861421] = 39
new Uint8Array(instance.exports.mem.buffer)[1861422] = 235
new Uint8Array(instance.exports.mem.buffer)[1861423] = 26
new Uint8Array(instance.exports.mem.buffer)[1861424] = 73
new Uint8Array(instance.exports.mem.buffer)[1861425] = 89
new Uint8Array(instance.exports.mem.buffer)[1861426] = 46
new Uint8Array(instance.exports.mem.buffer)[1861427] = 218
new Uint8Array(instance.exports.mem.buffer)[1861428] = 176
new Uint8Array(instance.exports.mem.buffer)[1861429] = 117
new Uint8Array(instance.exports.mem.buffer)[1861430] = 81
new Uint8Array(instance.exports.mem.buffer)[1861431] = 26
new Uint8Array(instance.exports.mem.buffer)[1861432] = 131
new Uint8Array(instance.exports.mem.buffer)[1861433] = 129
new Uint8Array(instance.exports.mem.buffer)[1861434] = 21
new Uint8Array(instance.exports.mem.buffer)[1861435] = 68
new Uint8Array(instance.exports.mem.buffer)[1861436] = 213
new Uint8Array(instance.exports.mem.buffer)[1861437] = 247
new Uint8Array(instance.exports.mem.buffer)[1861438] = 88
new Uint8Array(instance.exports.mem.buffer)[1861439] = 20
return undefined 
}
}
let global_8  = -1
imports.go.syscall/js.stringVal = () => {
global_8 ++
switch (global_8 ) {
case 0:
return undefined 
case 1:
return undefined 
}
}
let global_9  = -1
imports.go.syscall/js.valueGet = () => {
global_9 ++
switch (global_9 ) {
case 0:
instance.exports.getsp()
return undefined 
case 1:
instance.exports.getsp()
return undefined 
case 2:
instance.exports.getsp()
return undefined 
case 3:
instance.exports.getsp()
return undefined 
case 4:
instance.exports.getsp()
return undefined 
case 5:
instance.exports.getsp()
return undefined 
case 6:
instance.exports.getsp()
return undefined 
case 7:
instance.exports.getsp()
return undefined 
case 8:
instance.exports.getsp()
return undefined 
case 9:
instance.exports.getsp()
return undefined 
case 10:
instance.exports.getsp()
return undefined 
case 11:
instance.exports.getsp()
return undefined 
case 12:
instance.exports.getsp()
return undefined 
case 13:
instance.exports.getsp()
return undefined 
case 14:
instance.exports.getsp()
return undefined 
case 15:
instance.exports.getsp()
return undefined 
case 16:
instance.exports.getsp()
return undefined 
case 17:
instance.exports.getsp()
return undefined 
case 18:
instance.exports.getsp()
return undefined 
case 19:
instance.exports.getsp()
return undefined 
}
}
let global_10  = -1
imports.go.syscall/js.valueSet = () => {
global_10 ++
switch (global_10 ) {
case 0:
return undefined 
case 1:
return undefined 
case 2:
return undefined 
case 3:
return undefined 
case 4:
return undefined 
case 5:
return undefined 
case 6:
return undefined 
case 7:
return undefined 
case 8:
return undefined 
case 9:
return undefined 
}
}
let global_11  = -1
imports.go.syscall/js.valueIndex = () => {
global_11 ++
switch (global_11 ) {
case 0:
return undefined 
case 1:
return undefined 
case 2:
return undefined 
case 3:
return undefined 
case 4:
return undefined 
case 5:
return undefined 
}
}
let global_12  = -1
imports.go.syscall/js.valueSetIndex = () => {
global_12 ++
switch (global_12 ) {
}
}
let global_13  = -1
imports.go.syscall/js.valueCall = () => {
global_13 ++
switch (global_13 ) {
case 0:
instance.exports.getsp()
return undefined 
case 1:
instance.exports.getsp()
return undefined 
case 2:
instance.exports.getsp()
return undefined 
case 3:
instance.exports.getsp()
return undefined 
case 4:
instance.exports.getsp()
return undefined 
case 5:
instance.exports.getsp()
return undefined 
}
}
let global_14  = -1
imports.go.syscall/js.valueNew = () => {
global_14 ++
switch (global_14 ) {
}
}
let global_15  = -1
imports.go.syscall/js.valueLength = () => {
global_15 ++
switch (global_15 ) {
case 0:
return undefined 
case 1:
return undefined 
}
}
let global_16  = -1
imports.go.syscall/js.valuePrepareString = () => {
global_16 ++
switch (global_16 ) {
case 0:
return undefined 
case 1:
return undefined 
case 2:
return undefined 
case 3:
return undefined 
case 4:
return undefined 
case 5:
return undefined 
}
}
let global_17  = -1
imports.go.syscall/js.valueLoadString = () => {
global_17 ++
switch (global_17 ) {
case 0:
new Uint8Array(instance.exports.mem.buffer)[4612138] = 115
new Uint8Array(instance.exports.mem.buffer)[4612139] = 97
new Uint8Array(instance.exports.mem.buffer)[4612140] = 117
new Uint8Array(instance.exports.mem.buffer)[4612141] = 100
new Uint8Array(instance.exports.mem.buffer)[4612142] = 102
new Uint8Array(instance.exports.mem.buffer)[4612143] = 97
new Uint8Array(instance.exports.mem.buffer)[4612144] = 115
new Uint8Array(instance.exports.mem.buffer)[4612145] = 100
new Uint8Array(instance.exports.mem.buffer)[4612130] = 97
new Uint8Array(instance.exports.mem.buffer)[4612131] = 117
new Uint8Array(instance.exports.mem.buffer)[4612132] = 115
new Uint8Array(instance.exports.mem.buffer)[4612133] = 100
new Uint8Array(instance.exports.mem.buffer)[4612134] = 104
new Uint8Array(instance.exports.mem.buffer)[4612135] = 102
new Uint8Array(instance.exports.mem.buffer)[4612136] = 107
new Uint8Array(instance.exports.mem.buffer)[4612137] = 106
new Uint8Array(instance.exports.mem.buffer)[4612129] = 112
new Uint8Array(instance.exports.mem.buffer)[4612130] = 97
new Uint8Array(instance.exports.mem.buffer)[4612131] = 117
new Uint8Array(instance.exports.mem.buffer)[4612132] = 115
new Uint8Array(instance.exports.mem.buffer)[4612133] = 100
new Uint8Array(instance.exports.mem.buffer)[4612134] = 104
new Uint8Array(instance.exports.mem.buffer)[4612135] = 102
new Uint8Array(instance.exports.mem.buffer)[4612136] = 107
new Uint8Array(instance.exports.mem.buffer)[4612128] = 105
new Uint8Array(instance.exports.mem.buffer)[4612129] = 112
new Uint8Array(instance.exports.mem.buffer)[4612130] = 97
new Uint8Array(instance.exports.mem.buffer)[4612131] = 117
new Uint8Array(instance.exports.mem.buffer)[4612132] = 115
new Uint8Array(instance.exports.mem.buffer)[4612133] = 100
new Uint8Array(instance.exports.mem.buffer)[4612134] = 104
new Uint8Array(instance.exports.mem.buffer)[4612135] = 102
return undefined 
case 1:
new Uint8Array(instance.exports.mem.buffer)[4317397] = 101
new Uint8Array(instance.exports.mem.buffer)[4317398] = 0
new Uint8Array(instance.exports.mem.buffer)[4317399] = 0
new Uint8Array(instance.exports.mem.buffer)[4317400] = 0
new Uint8Array(instance.exports.mem.buffer)[4317401] = 0
new Uint8Array(instance.exports.mem.buffer)[4317402] = 0
new Uint8Array(instance.exports.mem.buffer)[4317403] = 0
new Uint8Array(instance.exports.mem.buffer)[4317404] = 0
new Uint8Array(instance.exports.mem.buffer)[4317396] = 100
new Uint8Array(instance.exports.mem.buffer)[4317397] = 101
new Uint8Array(instance.exports.mem.buffer)[4317398] = 0
new Uint8Array(instance.exports.mem.buffer)[4317399] = 0
new Uint8Array(instance.exports.mem.buffer)[4317400] = 0
new Uint8Array(instance.exports.mem.buffer)[4317401] = 0
new Uint8Array(instance.exports.mem.buffer)[4317402] = 0
new Uint8Array(instance.exports.mem.buffer)[4317403] = 101
new Uint8Array(instance.exports.mem.buffer)[4317395] = 111
new Uint8Array(instance.exports.mem.buffer)[4317396] = 100
new Uint8Array(instance.exports.mem.buffer)[4317397] = 101
new Uint8Array(instance.exports.mem.buffer)[4317398] = 0
new Uint8Array(instance.exports.mem.buffer)[4317399] = 0
new Uint8Array(instance.exports.mem.buffer)[4317400] = 0
new Uint8Array(instance.exports.mem.buffer)[4317401] = 0
new Uint8Array(instance.exports.mem.buffer)[4317402] = 100
new Uint8Array(instance.exports.mem.buffer)[4317394] = 99
new Uint8Array(instance.exports.mem.buffer)[4317395] = 111
new Uint8Array(instance.exports.mem.buffer)[4317396] = 100
new Uint8Array(instance.exports.mem.buffer)[4317397] = 101
new Uint8Array(instance.exports.mem.buffer)[4317398] = 0
new Uint8Array(instance.exports.mem.buffer)[4317399] = 0
new Uint8Array(instance.exports.mem.buffer)[4317400] = 0
new Uint8Array(instance.exports.mem.buffer)[4317401] = 111
new Uint8Array(instance.exports.mem.buffer)[4317393] = 110
new Uint8Array(instance.exports.mem.buffer)[4317394] = 99
new Uint8Array(instance.exports.mem.buffer)[4317395] = 111
new Uint8Array(instance.exports.mem.buffer)[4317396] = 100
new Uint8Array(instance.exports.mem.buffer)[4317397] = 101
new Uint8Array(instance.exports.mem.buffer)[4317398] = 0
new Uint8Array(instance.exports.mem.buffer)[4317399] = 0
new Uint8Array(instance.exports.mem.buffer)[4317400] = 99
new Uint8Array(instance.exports.mem.buffer)[4317392] = 101
new Uint8Array(instance.exports.mem.buffer)[4317393] = 110
new Uint8Array(instance.exports.mem.buffer)[4317394] = 99
new Uint8Array(instance.exports.mem.buffer)[4317395] = 111
new Uint8Array(instance.exports.mem.buffer)[4317396] = 100
new Uint8Array(instance.exports.mem.buffer)[4317397] = 101
new Uint8Array(instance.exports.mem.buffer)[4317398] = 0
new Uint8Array(instance.exports.mem.buffer)[4317399] = 110
return undefined 
case 2:
new Uint8Array(instance.exports.mem.buffer)[4317413] = 52
new Uint8Array(instance.exports.mem.buffer)[4317414] = 0
new Uint8Array(instance.exports.mem.buffer)[4317415] = 0
new Uint8Array(instance.exports.mem.buffer)[4317416] = 0
new Uint8Array(instance.exports.mem.buffer)[4317417] = 0
new Uint8Array(instance.exports.mem.buffer)[4317418] = 0
new Uint8Array(instance.exports.mem.buffer)[4317419] = 0
new Uint8Array(instance.exports.mem.buffer)[4317420] = 0
new Uint8Array(instance.exports.mem.buffer)[4317412] = 54
new Uint8Array(instance.exports.mem.buffer)[4317413] = 52
new Uint8Array(instance.exports.mem.buffer)[4317414] = 0
new Uint8Array(instance.exports.mem.buffer)[4317415] = 0
new Uint8Array(instance.exports.mem.buffer)[4317416] = 0
new Uint8Array(instance.exports.mem.buffer)[4317417] = 0
new Uint8Array(instance.exports.mem.buffer)[4317418] = 0
new Uint8Array(instance.exports.mem.buffer)[4317419] = 52
new Uint8Array(instance.exports.mem.buffer)[4317411] = 101
new Uint8Array(instance.exports.mem.buffer)[4317412] = 54
new Uint8Array(instance.exports.mem.buffer)[4317413] = 52
new Uint8Array(instance.exports.mem.buffer)[4317414] = 0
new Uint8Array(instance.exports.mem.buffer)[4317415] = 0
new Uint8Array(instance.exports.mem.buffer)[4317416] = 0
new Uint8Array(instance.exports.mem.buffer)[4317417] = 0
new Uint8Array(instance.exports.mem.buffer)[4317418] = 54
new Uint8Array(instance.exports.mem.buffer)[4317410] = 115
new Uint8Array(instance.exports.mem.buffer)[4317411] = 101
new Uint8Array(instance.exports.mem.buffer)[4317412] = 54
new Uint8Array(instance.exports.mem.buffer)[4317413] = 52
new Uint8Array(instance.exports.mem.buffer)[4317414] = 0
new Uint8Array(instance.exports.mem.buffer)[4317415] = 0
new Uint8Array(instance.exports.mem.buffer)[4317416] = 0
new Uint8Array(instance.exports.mem.buffer)[4317417] = 101
new Uint8Array(instance.exports.mem.buffer)[4317409] = 97
new Uint8Array(instance.exports.mem.buffer)[4317410] = 115
new Uint8Array(instance.exports.mem.buffer)[4317411] = 101
new Uint8Array(instance.exports.mem.buffer)[4317412] = 54
new Uint8Array(instance.exports.mem.buffer)[4317413] = 52
new Uint8Array(instance.exports.mem.buffer)[4317414] = 0
new Uint8Array(instance.exports.mem.buffer)[4317415] = 0
new Uint8Array(instance.exports.mem.buffer)[4317416] = 115
new Uint8Array(instance.exports.mem.buffer)[4317408] = 98
new Uint8Array(instance.exports.mem.buffer)[4317409] = 97
new Uint8Array(instance.exports.mem.buffer)[4317410] = 115
new Uint8Array(instance.exports.mem.buffer)[4317411] = 101
new Uint8Array(instance.exports.mem.buffer)[4317412] = 54
new Uint8Array(instance.exports.mem.buffer)[4317413] = 52
new Uint8Array(instance.exports.mem.buffer)[4317414] = 0
new Uint8Array(instance.exports.mem.buffer)[4317415] = 97
return undefined 
case 3:
new Uint8Array(instance.exports.mem.buffer)[4612304] = 100
new Uint8Array(instance.exports.mem.buffer)[4612305] = 87
new Uint8Array(instance.exports.mem.buffer)[4612306] = 82
new Uint8Array(instance.exports.mem.buffer)[4612307] = 109
new Uint8Array(instance.exports.mem.buffer)[4612308] = 89
new Uint8Array(instance.exports.mem.buffer)[4612309] = 88
new Uint8Array(instance.exports.mem.buffer)[4612310] = 78
new Uint8Array(instance.exports.mem.buffer)[4612311] = 107
new Uint8Array(instance.exports.mem.buffer)[4612296] = 97
new Uint8Array(instance.exports.mem.buffer)[4612297] = 71
new Uint8Array(instance.exports.mem.buffer)[4612298] = 90
new Uint8Array(instance.exports.mem.buffer)[4612299] = 114
new Uint8Array(instance.exports.mem.buffer)[4612300] = 97
new Uint8Array(instance.exports.mem.buffer)[4612301] = 110
new Uint8Array(instance.exports.mem.buffer)[4612302] = 78
new Uint8Array(instance.exports.mem.buffer)[4612303] = 104
new Uint8Array(instance.exports.mem.buffer)[4612288] = 97
new Uint8Array(instance.exports.mem.buffer)[4612289] = 88
new Uint8Array(instance.exports.mem.buffer)[4612290] = 66
new Uint8Array(instance.exports.mem.buffer)[4612291] = 104
new Uint8Array(instance.exports.mem.buffer)[4612292] = 100
new Uint8Array(instance.exports.mem.buffer)[4612293] = 88
new Uint8Array(instance.exports.mem.buffer)[4612294] = 78
new Uint8Array(instance.exports.mem.buffer)[4612295] = 107
return undefined 
case 4:
new Uint8Array(instance.exports.mem.buffer)[4317437] = 101
new Uint8Array(instance.exports.mem.buffer)[4317438] = 0
new Uint8Array(instance.exports.mem.buffer)[4317439] = 0
new Uint8Array(instance.exports.mem.buffer)[4317440] = 0
new Uint8Array(instance.exports.mem.buffer)[4317441] = 0
new Uint8Array(instance.exports.mem.buffer)[4317442] = 0
new Uint8Array(instance.exports.mem.buffer)[4317443] = 0
new Uint8Array(instance.exports.mem.buffer)[4317444] = 0
new Uint8Array(instance.exports.mem.buffer)[4317436] = 100
new Uint8Array(instance.exports.mem.buffer)[4317437] = 101
new Uint8Array(instance.exports.mem.buffer)[4317438] = 0
new Uint8Array(instance.exports.mem.buffer)[4317439] = 0
new Uint8Array(instance.exports.mem.buffer)[4317440] = 0
new Uint8Array(instance.exports.mem.buffer)[4317441] = 0
new Uint8Array(instance.exports.mem.buffer)[4317442] = 0
new Uint8Array(instance.exports.mem.buffer)[4317443] = 0
new Uint8Array(instance.exports.mem.buffer)[4317435] = 111
new Uint8Array(instance.exports.mem.buffer)[4317436] = 100
new Uint8Array(instance.exports.mem.buffer)[4317437] = 101
new Uint8Array(instance.exports.mem.buffer)[4317438] = 0
new Uint8Array(instance.exports.mem.buffer)[4317439] = 0
new Uint8Array(instance.exports.mem.buffer)[4317440] = 0
new Uint8Array(instance.exports.mem.buffer)[4317441] = 0
new Uint8Array(instance.exports.mem.buffer)[4317442] = 0
new Uint8Array(instance.exports.mem.buffer)[4317434] = 99
new Uint8Array(instance.exports.mem.buffer)[4317435] = 111
new Uint8Array(instance.exports.mem.buffer)[4317436] = 100
new Uint8Array(instance.exports.mem.buffer)[4317437] = 101
new Uint8Array(instance.exports.mem.buffer)[4317438] = 0
new Uint8Array(instance.exports.mem.buffer)[4317439] = 0
new Uint8Array(instance.exports.mem.buffer)[4317440] = 0
new Uint8Array(instance.exports.mem.buffer)[4317441] = 0
new Uint8Array(instance.exports.mem.buffer)[4317433] = 101
new Uint8Array(instance.exports.mem.buffer)[4317434] = 99
new Uint8Array(instance.exports.mem.buffer)[4317435] = 111
new Uint8Array(instance.exports.mem.buffer)[4317436] = 100
new Uint8Array(instance.exports.mem.buffer)[4317437] = 101
new Uint8Array(instance.exports.mem.buffer)[4317438] = 0
new Uint8Array(instance.exports.mem.buffer)[4317439] = 0
new Uint8Array(instance.exports.mem.buffer)[4317440] = 0
new Uint8Array(instance.exports.mem.buffer)[4317432] = 100
new Uint8Array(instance.exports.mem.buffer)[4317433] = 101
new Uint8Array(instance.exports.mem.buffer)[4317434] = 99
new Uint8Array(instance.exports.mem.buffer)[4317435] = 111
new Uint8Array(instance.exports.mem.buffer)[4317436] = 100
new Uint8Array(instance.exports.mem.buffer)[4317437] = 101
new Uint8Array(instance.exports.mem.buffer)[4317438] = 0
new Uint8Array(instance.exports.mem.buffer)[4317439] = 0
return undefined 
case 5:
new Uint8Array(instance.exports.mem.buffer)[4317451] = 52
new Uint8Array(instance.exports.mem.buffer)[4317452] = 0
new Uint8Array(instance.exports.mem.buffer)[4317453] = 0
new Uint8Array(instance.exports.mem.buffer)[4317454] = 0
new Uint8Array(instance.exports.mem.buffer)[4317455] = 0
new Uint8Array(instance.exports.mem.buffer)[4317456] = 0
new Uint8Array(instance.exports.mem.buffer)[4317457] = 0
new Uint8Array(instance.exports.mem.buffer)[4317458] = 0
new Uint8Array(instance.exports.mem.buffer)[4317450] = 54
new Uint8Array(instance.exports.mem.buffer)[4317451] = 52
new Uint8Array(instance.exports.mem.buffer)[4317452] = 0
new Uint8Array(instance.exports.mem.buffer)[4317453] = 0
new Uint8Array(instance.exports.mem.buffer)[4317454] = 0
new Uint8Array(instance.exports.mem.buffer)[4317455] = 0
new Uint8Array(instance.exports.mem.buffer)[4317456] = 0
new Uint8Array(instance.exports.mem.buffer)[4317457] = 0
new Uint8Array(instance.exports.mem.buffer)[4317449] = 101
new Uint8Array(instance.exports.mem.buffer)[4317450] = 54
new Uint8Array(instance.exports.mem.buffer)[4317451] = 52
new Uint8Array(instance.exports.mem.buffer)[4317452] = 0
new Uint8Array(instance.exports.mem.buffer)[4317453] = 0
new Uint8Array(instance.exports.mem.buffer)[4317454] = 0
new Uint8Array(instance.exports.mem.buffer)[4317455] = 0
new Uint8Array(instance.exports.mem.buffer)[4317456] = 0
new Uint8Array(instance.exports.mem.buffer)[4317448] = 115
new Uint8Array(instance.exports.mem.buffer)[4317449] = 101
new Uint8Array(instance.exports.mem.buffer)[4317450] = 54
new Uint8Array(instance.exports.mem.buffer)[4317451] = 52
new Uint8Array(instance.exports.mem.buffer)[4317452] = 0
new Uint8Array(instance.exports.mem.buffer)[4317453] = 0
new Uint8Array(instance.exports.mem.buffer)[4317454] = 0
new Uint8Array(instance.exports.mem.buffer)[4317455] = 0
new Uint8Array(instance.exports.mem.buffer)[4317447] = 97
new Uint8Array(instance.exports.mem.buffer)[4317448] = 115
new Uint8Array(instance.exports.mem.buffer)[4317449] = 101
new Uint8Array(instance.exports.mem.buffer)[4317450] = 54
new Uint8Array(instance.exports.mem.buffer)[4317451] = 52
new Uint8Array(instance.exports.mem.buffer)[4317452] = 0
new Uint8Array(instance.exports.mem.buffer)[4317453] = 0
new Uint8Array(instance.exports.mem.buffer)[4317454] = 0
new Uint8Array(instance.exports.mem.buffer)[4317446] = 98
new Uint8Array(instance.exports.mem.buffer)[4317447] = 97
new Uint8Array(instance.exports.mem.buffer)[4317448] = 115
new Uint8Array(instance.exports.mem.buffer)[4317449] = 101
new Uint8Array(instance.exports.mem.buffer)[4317450] = 54
new Uint8Array(instance.exports.mem.buffer)[4317451] = 52
new Uint8Array(instance.exports.mem.buffer)[4317452] = 0
new Uint8Array(instance.exports.mem.buffer)[4317453] = 0
return undefined 
}
}
let global_18  = -1
imports.go.syscall/js.copyBytesToGo = () => {
global_18 ++
switch (global_18 ) {
}
}
let global_19  = -1
imports.go.syscall/js.copyBytesToJS = () => {
global_19 ++
switch (global_19 ) {
}
}
let wasm = await WebAssembly.instantiate(wasmBinary, imports) 
instance = wasm.instance
await instance.exports.run(1,4104) 
await instance.exports.resume() 
await instance.exports.resume() 

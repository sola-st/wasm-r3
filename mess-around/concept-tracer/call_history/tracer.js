// Our final trace will be the call history of all imported functions
// This call history contains all informations that we need in order to generate the replay binary
//
// type ImportCall = { funcIdx, args, results, events: Events[] }
// type ImportCallHistory = ImportCall[]
let callHistory = [] // type ImportCallHistory
let shadowMem
let evtCount = 0

let functions = Wasabi.module.info.functions
let importFuncNumber
for (let i = 0; i < functions.length; i++) {
  if (functions[i].import === null) {
    importFuncNumber = i + 1
    break
  }
}

Wasabi.analysis =  {
  call_pre(location, targetFunc, args, indirecttableIdx) {
    if (targetFunc >= importFuncNumber) {
      return
    }
    callHistory.push({targetFunc, args, events: []})
  },
  call_post(location, values) {
    for (let i = callHistory.length - 1; i >= 0; i--) {
      if (callHistory[i].values === undefined) {
        callHistory[i].values = values;
        break
      }
    }
  },
  begin(location, type) {
    if (type != "function") {
      return
    }
    if (evtCount != 0) {
      if (callHistory[callHistory.length - 1].values == undefined) {
        callHistory[callHistory.length - 1].events.push({
          type: 'wasm_call',
          func: location.func,
        })
      }
      return
    }
    shadowMem = new ArrayBuffer(Wasabi.module.exports.mem.buffer.byteLength)
    const initMem = new Int8Array(Wasabi.module.exports.mem.buffer)
    let view = new Int8Array(shadowMem)
    for (let i = 0; i < Wasabi.module.exports.mem.buffer.byteLength; i++) {
      view[i] = initMem[i]
    }
    evtCount++;
  },

  store(location, op, memarg, value) {
    let view = new Int8Array(shadowMem)
    view[memarg.addr] = value
  },

  load(location, op, memarg, value) {
    let currentView = new Uint8Array(shadowMem)
    let newView = new Uint8Array(Wasabi.module.exports.mem.buffer)
    if (currentView[memarg.addr] === newView[memarg.addr]) {
      return
    }
    // it is not important to know when the memory change happened exactly
    // it is sufficient to just assign it to the youngest imported function in the ImportCallHistory
    callHistory[callHistory.length - 1].events.push({
      type: "mem_change",
      addr: memarg.addr,
      from: currentView[memarg.addr],
      to: value,
    })
    currentView[memarg.addr] = value
  },
}

let shadowMem
let evtCount = 0
let trace = []

Wasabi.analysis =  {
  start(location) {
    console.log("start")
  },
  begin(location, type) {
    if (evtCount != 0) {
      return
    }
    if (type != "function") {
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
    trace.push({
      type: "mem_change",
      addr: memarg.addr,
      from: currentView[memarg.addr],
      to: value,
    })
    currentView[memarg.addr] = value
  },
}

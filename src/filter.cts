export const filter = {
  core: [
    'table-exp-call-private-function',
    'call-exp-after-import-call-table-get',
    'table-exp-call-private-function-params',
    'table-exp-call-private-function-mul-table',
    'table-exp-host-mod-multiple',
    'table-exp-host-add-friend',
    'table-exp-host-grow',
    'table-exp-host-mod',
    'table-get',
    'table-get-big',
    'table-imp-host-mod',
    'test04',
    "mem-imp-different-size"
  ],
  proxy: [
    // Regressions: revisit after unit
    "external-call",
  ],
  online: [
    // "ogv", // TODO: additional ER at end of original trace
    // "image-convolute", // asm2wasm - f64-to-int is too large
    "heatmap", // works fine, but too long so we skip it
    "lichess", // failing test
    "livesplit", // uses simd, filter for now
    "onnxjs", // // unknown func: failed to find name `$1000008`"
    "gotemplate", // timeout for locator('#output')
    "playnox", // test doesn't end
    "hnset-bench", // no benchmark generated
    "video", // empty benchmark generated
    "wasmsh", // empty benchmark generated
    "roslyn", // not working
    "rustpython", // not working
    "skeletal", // not working
    "sqlpractice", // not working
    "takahirox", // not working
    "timestretch", // not working
    "wheel", // not working
  ]
}
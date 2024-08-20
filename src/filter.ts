export const filter = {
  core: [
    'table-get',
    'table-get-big',
    'table-exp-call-private-function', // unknown function wasabi
    'table-exp-call-private-function-params', // unknown function wasabi
    'table-exp-call-private-function-mul-table', // unreachable
    'table-exp-host-mod-multiple', // unreachable
    'table-exp-host-add-friend', // unreachable
    'table-exp-internal-mod',
    'table-exp-host-grow', // no ref trace
    'table-exp-host-mod', // no ref trace
    'table-imp-host-mod', // trace diff
    'table-imp-init-max',
    'call-exp-after-import-call-table-get', // unknown function wasabi
    'test04', // duplicate func export
    'rust-game-of-life', // fail only at CI
  ],
  proxy: [
    // Regressions: revisit after unit
    "external-call",
  ],
  online: [
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
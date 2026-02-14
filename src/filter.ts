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
    "pass-big-number" // better handling of i64 value is needed
  ],
  proxy: [
    // TODO: fix these regressions
    "basic-new-Instance-module", // TypeError: Cannot read properties of undefined (reading 'forEach')
    "basic-new-Instance-compile", // TypeError: Cannot read properties of undefined (reading 'forEach')
    "basic-new-Instance-compileStreaming", // TypeError: Cannot read properties of undefined (reading 'forEach')
    "external-call", // SyntaxError: Identifier 'wasm' has already been declared
    "multiple-worker-different-name", // SyntaxError: Identifier 'MEM_PAGE_SIZE' has already been declared
  ],
  online: [
    "boa",
    "bullet",
    "commanderkeen",
    "factorial",
    "fib",
    "figma-startpage",
    "fractals",
    "funky-kart",
    "game-of-life",
    "gotemplate",
    "guiicons",
    "handy-tools",
    "heatmap",
    "hnset-bench",
    "image-convolute",
    "jqkungfu",
    "jsc",
    "kittygame",
    "lichess",
    "livesplit",
    "mandelbrot",
    "multiplyDouble",
    "multiplyInt",
    "noisereduction",
    "ogv",
    "onnxjs",
    "pacalc",
    "parquet",
    "pathfinding",
    "playnox",
    "rfxgen",
    "rguilayout",
    "rguistyler",
    "riconpacker",
    "roslyn",
    "rustpython",
    "sandspiel",
    "skeletal",
    "sqlgui",
    "sqlpractice",
    "takahirox",
    "timestretch",
    "uarm",
    "visual6502remix",
    "waforth",
    "wheel",
  ]
}

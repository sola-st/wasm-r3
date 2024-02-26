export const node_filter = [
    'rust-tictactoe',
    'rust-game-of-life', // trace keeps changing.
    'mem-exp-vec-store-no-host-mod',
    'mem-exp-init-no-host-mod',
    'mem-exp-copy-no-host-mod',
    'mem-exp-fill-no-host-mod',
    'mem-exp-host-mod-load-vec',
    'table-exp-host-mod',
    'table-exp-host-grow',
    'funky-kart',
    'table-exp-host-add-friend',
    // 'fib',
    // ffmpeg
    // fib
    // jsc
    // multiplyDouble
    // multiplyInt
    // virtualkc
]

export const offline_filter = [
    'sqllite',
    // 'multiple-wasm-files-mainframe', recover from custom-instr-3
]

export const online_filter = [
    'ogv', // TODO: additional ER at end of original trace
    'heatmap', // works fine, but too long so we skip it
    'uarm', // doesn't work for js because string is too long
    'image-convolute', // asm2wasm - f64-to-int is too large
    'lichess', // failing test
    'livesplit', // uses simd, filter for now
    'onnxjs', // // unknown func: failed to find name `$1000008`"
    'gotemplate', // timeout for locator('#output')
    'commanderkeen', // unreachable
    'playnox', // test doesn't end
    'hnset-bench', // no benchmark generated
    'fractals', // no benchmark generated
    'video', // empty benchmark generated
    'wasmsh', // empty benchmark generated
    'rfxgen', // not working
    'rguilayout', // not working
    'rguistyler', // not working
    'roslyn', // not working
    'rtexpacker', //not working
    'rtexviewer', // not working
    'rustpython', // not working
    'skeletal', // not working
    'sqlpractice', // not working
    'takahirox', // not working
    'timestretch', // not working
    'wheel', // not working
]

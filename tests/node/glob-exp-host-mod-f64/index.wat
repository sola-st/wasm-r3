(module
  (import "env" "changeGlobal" (func $changeGlobal (param f64)))
  (func $main (export "entry")
    f64.const 5
    call $changeGlobal
    global.get 0
    drop
  )
  (global (export "global") (mut f64) f64.const 1)
)

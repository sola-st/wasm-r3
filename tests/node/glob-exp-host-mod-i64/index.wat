(module
  (import "env" "changeGlobal" (func $changeGlobal (param i64)))
  (func $main (export "main")
    i64.const 5
    call $changeGlobal
    global.get 0
    drop
  )
  (global (export "global") (mut i64) i64.const 1)
)

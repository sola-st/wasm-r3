(module
  (import "env" "changeGlobal" (func $changeGlobal (param i32 i32)))
  (func $main (export "entry")
    i32.const 0
    i32.const 5
    call $changeGlobal
    global.get 0
    drop
    i32.const 1
    i32.const -2
    call $changeGlobal
    global.get 0
    drop
  )
  (global (export "global1") (mut i32) i32.const 1)
  (global (export "global2") (mut i32) i32.const 2)
)

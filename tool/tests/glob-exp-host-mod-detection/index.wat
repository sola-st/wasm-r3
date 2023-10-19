(module
  (import "env" "changeGlobal" (func $changeGlobal (param i32)))
  (func $main (export "main")
    i32.const 2
    global.set 0
    i32.const 5
    call $changeGlobal
  )
  (func $foo (export "foo")
    global.get 0
    drop
  )
  (global (export "global") (mut i32) i32.const 1)
)

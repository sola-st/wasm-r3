(module
  (import "env" "changeGlobal" (func $changeGlobal (param i32)))
  (func $main (export "main")
    i32.const 4
    call $changeGlobal
    global.get $global
    drop
  )
   (global $global (export "global") (mut i32) (i32.const 0))
)

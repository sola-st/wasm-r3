(module
  (import "env" "changeGlobal" (func $changeGlobal))
  (func $main (export "main")
    call $changeGlobal
    global.get $global
    drop
  )
   (global $global (export "global") (mut i32) (i32.const 0))
)

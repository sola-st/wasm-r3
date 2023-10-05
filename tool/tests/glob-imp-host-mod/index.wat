(module
  (import "env" "changeGlobal" (func $changeGlobal))
  (global $global (import "env" "global") (mut i32))
  (func $main (export "main")
    call $changeGlobal
    global.get $global
    drop
  )
)

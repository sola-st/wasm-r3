(module
  (import "env" "changeGlobal" (func $changeGlobal))
  (import "env" "inspect" (func $inspect (param i32)))
  (import "env" "global" (global $global (mut i32)))
  (func $main (export "main")
    call $changeGlobal
    global.get $global
    call $inspect
  )
)

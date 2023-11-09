(module
  (import "env" "changeGlobal" (func $changeGlobal))
  (func $main (export "main")
    call $changeGlobal
    global.get 0
    drop
  )
  (global (export "global") i32 i32.const 1)
)

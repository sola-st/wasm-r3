(module
  (import "env" "changeGlobal" (func $changeGlobal))
  (func $main (export "entry")
    call $changeGlobal
    global.get 0
    drop
  )
  (global (export "global") i32 i32.const 1)
)

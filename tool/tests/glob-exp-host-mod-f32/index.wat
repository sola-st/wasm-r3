(module
  (import "env" "changeGlobal" (func $changeGlobal (param f32)))
  (func $main (export "main")
    f32.const 5
    call $changeGlobal
    global.get 0
    drop
  )
  (global (export "global") (mut f32) f32.const 1)
)

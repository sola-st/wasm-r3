(module
  (import "env" "changeMem" (func $changeMemHost (param i32 i32)))
  (func $main (export "main")
    i32.const 0
    i32.const 0
    i32.store
    i32.const 3
    i32.const 5
    call $changeMemHost
    i32.const 0
    i32.load
    drop
  )
  (memory (export "memory") 1)
)

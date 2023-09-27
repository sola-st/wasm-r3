(module
  (import "env" "changeMem" (func $changeMemHost (param i32 i32)))
  (func $main (export "main")
    i32.const 1
    i32.const 1
    call $changeMemHost
    i32.const 1
    i32.load
    drop
  )
  (memory (export "memory") 1)
)

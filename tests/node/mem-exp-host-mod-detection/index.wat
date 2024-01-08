(module
  (import "env" "changeMem" (func $changeMemHost (param i32 i32)))
  (func $main (export "entry")
    i32.const 0
    i32.const 0
    i32.store
    i32.const 3
    i32.const 5
    call $changeMemHost
  )
  (func $foo (export "foo")
    i32.const 2
    i32.load16_s
    drop
  )
  (memory (export "memory") 1)
)

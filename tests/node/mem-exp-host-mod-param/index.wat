(module
  (import "env" "changeMem" (func $changeMem (param i32 i32)))
  (func $main (export "entry")
    i32.const 5
    i32.const 60000
    call $changeMem
    i32.const 5
    i32.load
    drop
  )
  (memory (export "memory") 1)
)

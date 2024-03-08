(module
  (import "env" "changeMem" (func $changeMem))
  (func $main (export "entry")
    call $changeMem
    i32.const 4
    i64.load
    drop
    i32.const 0
    i32.load
    drop
  )
  (memory (export "memory") 1)
)

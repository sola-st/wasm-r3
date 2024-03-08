(module
  (import "env" "changeMem" (func $changeMem))
  (func $main (export "entry")
    call $changeMem
    i32.const 2
    i32.load
    drop
    i32.const 0
    i32.load16_u
    drop
  )
  (memory (export "memory") 1)
)

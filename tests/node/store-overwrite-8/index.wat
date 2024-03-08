(module
  (import "env" "changeMem" (func $changeMem))
  (func $main (export "entry")
    call $changeMem
    i32.const 1
    i32.load8_u
    drop
    i32.const 0
    i32.load8_u
    drop
  )
  (memory (export "memory") 1)
)

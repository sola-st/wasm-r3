(module
  (import "env" "changeMem" (func $changeMem))
  (import "env" "nop" (func $nop))
  (func $main (export "entry")
    call $nop
    i32.const 1
    i32.load
    drop
    call $changeMem
    i32.const 1
    i32.load
    drop
  )
  (memory (export "memory") 1)
)

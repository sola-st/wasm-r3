(module
  (import "env" "changeMem" (func $changeMem (result i32)))
  (func $main (export "entry")
    call $changeMem
    i32.load
    drop
  )
  (memory (export "memory") 1 4)
)

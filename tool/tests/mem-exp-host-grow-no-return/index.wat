(module
  (import "env" "changeMem" (func $changeMem (result i32)))
  (func $main (export "main")
    call $changeMem
    i32.load
    drop
  )
  (func $reentry (export "reentry")
    i32.const 100000
    i32.load
    drop
  )
  (memory (export "memory") 1 2)
)

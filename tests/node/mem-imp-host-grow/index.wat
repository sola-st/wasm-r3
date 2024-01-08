(module
  (import "env" "changeMem" (func $changeMem (result i32)))
  (import "env2" "mem" (memory 1))
  (func $main (export "entry")
    call $changeMem
    i32.load
    drop
  )
)

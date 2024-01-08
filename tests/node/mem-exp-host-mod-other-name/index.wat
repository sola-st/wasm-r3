(module
  (import "env" "changeMem" (func $changeMem))
  (func $main (export "entry")
    call $changeMem
    i32.const 1
    i32.load
    drop
  )
  (memory (export "yromem") 1)
)

(module
  (import "env" "memory" (memory 1))
  (func $main (export "main")
    i32.const 1
    i32.load
    drop
  )
)

(module
  (memory (import "env" "memory") 1 1)
  (func $main (export "entry")
    i32.const 0
    i32.load align=1
    drop
  )
)

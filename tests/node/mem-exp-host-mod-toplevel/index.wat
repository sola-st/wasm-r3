(module
  (func $main (export "main")
    i32.const 1
    i32.load
    drop
  )
  (memory (export "memory") 1)
)

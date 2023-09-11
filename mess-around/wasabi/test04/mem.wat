(module
  (func (export "main")
    i32.const 69
    drop
  )
  (table (export "table") 1 funcref)
  (memory (export "memory") 1)
)

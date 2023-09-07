(module
  (func (export "main")
    i32.const 69
    drop
  )
  (memory (export "mem") 1)
  (table (export "table") 1 funcref)
)

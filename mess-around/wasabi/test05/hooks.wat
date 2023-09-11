(module
  (func (export "main")
    i32.const 69
    drop
    call $callee
  )
  (func $callee)
  (table (export "table1") 3 funcref)
  (table (export "table2") 1 funcref)
  (memory (export "memory") 1)
)

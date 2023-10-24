(module
  (func $main (export "main") (result i32)
    i32.const 0
    (call_indirect (result i32))
    drop
    call $changeTable
    i32.const 0
    (call_indirect (result i32))
  )
  (func $changeTable
    
  )
  (func $a (result i32)
    i32.const 1
  )
  (func $b (result i32)
    i32.const 2
  )
  (table (export "table") 2 2 funcref)
  (elem (i32.const 0) $a $b)
)

(module
  (import "env" "table" (table 2 2 funcref))
  (func $main (export "main") (result i32)
    i32.const 0
    (call_indirect (result i32))
  )
  (func $a (result i32)
    i32.const 0
  )
  (func $b (result i32)
    i32.const 1
  )
  (elem (i32.const 0) $a $b)
)

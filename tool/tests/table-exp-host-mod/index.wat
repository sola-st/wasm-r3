(module
  (import "env" "changeTable" (func $changeTable))
  (import "env" "a" (func $a (result i32)))
  (import "env" "b" (func $b (result i32)))
  (func $main (export "main") (result i32)
    i32.const 0
    (call_indirect (result i32))
    drop
    call $changeTable
    i32.const 0
    (call_indirect (result i32))
  )
  (table (export "table") 2 2 funcref)
  (elem (i32.const 0) $a $b)
)

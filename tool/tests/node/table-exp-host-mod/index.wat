(module
  (import "env" "changeTable" (func $changeTable))
  (import "env" "changeTable2" (func $changeTable2))
  (import "env" "a" (func $a (result i32)))
  (import "env" "b" (func $b (result i32)))
  (func $main (export "main") (result i32)
    i32.const 0
    (call_indirect (result i32))
    drop
    call $changeTable
    i32.const 0
    table.get
    drop
    call $changeTable2
    i32.const 0
    (call_indirect (result i32))
  )
  (func (export "foo") (result i32)
    i32.const 3
  )
  (func (export "bar") (result i32)
    i32.const 4
  )
  (table (export "table") 2 2 funcref)
  (elem (i32.const 0) $a $b)
)


(module
  (import "env" "changeTable" (func $changeTable))
  (func $main (export "entry")
    i32.const 0
    table.get $table
    drop
    call $changeTable
    i32.const 0
    table.get $table
    drop
    i32.const 1
    table.get $table
    drop
  )
  (func $a (export "a"))
  (func (export "foo"))
  (func $b)
  (table $table (export "table") 2 funcref)
  (elem (i32.const 0) $a $b)
)

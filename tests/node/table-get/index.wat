
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
  )
  (func $a)
  (func (export "foo"))
  (table $table (export "table") 1 funcref)
  (elem (i32.const 0) $a)
)

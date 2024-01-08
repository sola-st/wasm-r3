(module
  (import "env" "changeTable" (func $changeTable (result i32)))
  (func $main (export "entry")
    call $changeTable
    table.get
    drop
  )
  (table (export "table") 2 4 funcref)
  (func (export "foo"))
)

(module
  (import "env" "DYNAMICTOP_PTR" (global i32))
  (table 1 funcref)
  (elem (;0;) (global.get 0) func 0)
  (func (export "entry") (param i32)
    (table.get 0 (i32.const 0))
    return
  )
)
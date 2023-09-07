(module
  (import "js" "mem" (memory 1))
  (import "js" "table" (table 1 funcref))
  (func (export "main")
    i32.const 69
    drop
  )
)

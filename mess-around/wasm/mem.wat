(module
  (import "js" "mem" (memory 1))
  (func (export "getMemState") (result i32)
    i32.const 0
    i32.load
  )
)

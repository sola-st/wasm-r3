(module
  (import "js" "changeMem" (func $changeMem (param) (result)))
  (func $testChangeMem (export "testChangeMem") (result i32)
    i32.const 0
    i32.const 42 
    i32.store
    call $changeMem
    i32.const 0
    i32.load
  )
  (memory $mem (export "mem") 1)
)

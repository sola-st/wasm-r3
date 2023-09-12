(module
  (import "js" "func1" (func $func1 (param i32 i32) (result i32)))
  (import "js" "func2" (func $func2 (param) (result)))
  (import "js" "changeMem" (func $changeMem (param) (result)))
  (func (export "main")
    i32.const 0 
    i32.const 0
    call $func1
    call $testChangeMem
    i32.const 0
    call $func2
    call $randomFunc
    call $func1
    call $testChangeMem
    i32.const 1
    call $func1
    drop
  )
  (func $randomFunc (param i32) (result i32)
    local.get 0
  )
  (func $exportFunc (export "exportFunc")
    call $changeMem
  )
  (func $testChangeMem (export "testChangeMem")
    i32.const 0
    i32.load
    drop
  )
  (memory $mem (export "mem") 1)
)

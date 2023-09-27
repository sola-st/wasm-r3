(module
  (import "env" "add" (func $add (param i32 i32) (result i32)))
  (func $main (export "main")
    i32.const 1
    i32.const 2
    call $add
    drop
    i32.const 5
    i32.const -4
    call $add
    drop
  )
  (func $foo (export "foo")
    i32.const 2
    i32.load16_s
    drop
  )
  (memory (export "memory") 1)
)

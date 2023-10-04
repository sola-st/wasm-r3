(module
  (import "env" "add" (func $add (param i32 i32) (result i32)))
  (import "env" "sub" (func $sub (param f64 f64) (result f64)))
  (import "lib" "add" (func $lib_add (param f32 f32) (result f64)))
  (func $main (export "main")
    i32.const 1
    i32.const 2
    call $add
    drop
    i32.const 5
    i32.const -4
    call $add
    drop
    f64.const 5
    f64.const 2.5
    call $sub
    drop
    f32.const 2.5
    f32.const 2.5
    call $lib_add
    drop
  )
  (memory (export "memory") 1)
)

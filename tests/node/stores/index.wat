(module
  (func $main (export "entry")
    i32.const 1
    i32.const 8746
    i32.store8

    i32.const 1
    i32.const 8746
    i32.store16

    i32.const 1
    i32.const 8746
    i32.store

    i32.const 1
    i64.const 8746
    i64.store8

    i32.const 1
    i64.const 8746
    i64.store16

    i32.const 1
    i64.const 8746
    i64.store32

    i32.const 1
    i64.const 8746
    i64.store

    i32.const 1
    f32.const 8746
    f32.store

    i32.const 1
    f64.const 8746
    f64.store
  )
  (memory (export "memory") 1)
)

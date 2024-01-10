(module
    (type (func (param i32 f32) (result f64)))
    (func $foo (type 0) f64.const 1)
    (func
        i32.const 0
        f32.const 0
        i32.const 0
        call_indirect (type 0)
        drop
    )
    (table 1 funcref)
    (elem (i32.const 0) $foo)
)
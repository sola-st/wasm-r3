(module
    (func $foo (param i32 i32) (result f64) f64.const 0)
    (func (param i32 i32)
        local.get 0
        local.get 1
        call $foo
        drop
    )
)
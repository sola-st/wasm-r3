(module
    (func $foo)
    (func (export "entry")
        i32.const 0
        call_indirect (type 0)
    )
    (table 1 funcref)
    (elem (i32.const 0) $foo)
)
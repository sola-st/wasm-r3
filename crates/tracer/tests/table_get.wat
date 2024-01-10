(module
    (func $foo)
    (func
        i32.const 0
        table.get
        drop
    )
    (table 1 funcref)
    (elem 0 $foo)
)
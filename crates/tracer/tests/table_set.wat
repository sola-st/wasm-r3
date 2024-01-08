(module
    (func $foo)
    (func
        i32.const 0
        i32.const 0
        table.get
        table.set
    )
    (table 1 funcref)
    (elem 0 $foo)
)
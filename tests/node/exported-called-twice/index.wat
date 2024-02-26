(module 
    (func $main (export "entry")
        i32.const 0
        i32.load
        drop
        call $bar
    )
    (func $foo (export "foo")
        i32.const 0
        i32.load
        drop
    )
    (func $bar (export "bar"))
    (memory (export "memory") 1 1)
)

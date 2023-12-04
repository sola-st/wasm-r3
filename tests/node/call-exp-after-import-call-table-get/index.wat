(module
    (import "env" "foo" (func $foo))
    (import "env" "bar" (func $bar))
    (func $main (export "main")
        call $foo
    )
    (func $exp
        call $bar
    )
    (table (export "table") 1 1 funcref)
    (elem (i32.const 0) $exp)
)

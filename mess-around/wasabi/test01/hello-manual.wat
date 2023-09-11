(module
    (import "host" "print" (func $i (param i32)))
    (func $somefun
    i32.const 42
    call $i)
    (export "somefun" (func $somefun))
)

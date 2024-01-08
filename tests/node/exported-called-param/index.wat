(module
    (import "env" "foo" (func $foo))
    (import "env" "bar" (func $bar))
    (func $main (export "entry") (param i32)
        local.get 0
        (if (then (call $foo)) (else (call $bar)))
    )
)

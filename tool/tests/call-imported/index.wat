(module
    (import "env" "func" (func $foo))
    (func $main (export "main")
        call $foo
    )
)

(module
    (import "env" "add" (func $foo))
    (func $main (export "main")
        call $foo
    )
    (func $bar)
)

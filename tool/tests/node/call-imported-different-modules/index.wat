(module
    (import "env" "foo" (func $foo))
    (import "env2" "bar" (func $bar))
    (func $main (export "main")
        call $foo
        call $bar
    )
)

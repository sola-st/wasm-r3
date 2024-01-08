(module
    (import "env" "foo" (func $foo))
    (import "env2" "bar" (func $bar))
    (func $main (export "entry")
        call $foo
        call $bar
    )
)

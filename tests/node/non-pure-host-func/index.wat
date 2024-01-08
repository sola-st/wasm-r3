(module
    (import "env" "foo" (func $foo))
    (func $main (export "entry")
        call $foo
        call $foo
    )
)

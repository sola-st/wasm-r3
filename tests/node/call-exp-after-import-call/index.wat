(module
    (import "env" "foo" (func $foo))
    (import "env" "bar" (func $bar))
    (func $main (export "main")
        call $foo
    )
    (func (export "exp")
        call $bar
    )
)

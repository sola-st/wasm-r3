(module
    (import "env" "foo" (func $foo (result i32)))
    (import "env" "bar" (func $bar (result i32)))
    (func $main (export "entry")
        call $foo
        drop
    )
    (func (export "exp")
        call $bar
        drop
    )
)

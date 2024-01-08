(module
    (import "env" "foo" (func $foo))
    (func $main (export "entry")
        call $foo
    )
    (func $bar (export "bar"))
)

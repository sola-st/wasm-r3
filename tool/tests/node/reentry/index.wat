(module
    (import "env" "foo" (func $foo))
    (func $main (export "main")
        call $foo
    )
    (func $bar (export "bar"))
)

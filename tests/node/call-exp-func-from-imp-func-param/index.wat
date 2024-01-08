(module
    (import "env" "foo" (func $foo))
    (import "env" "a" (func $a))
    (import "env" "b" (func $b))
    (func (export "entry")
        call $foo
    )
    (func (export "bar") (param i32)
        (if (i32.eqz (local.get 0))
            (then call $a)
            (else call $b)
        )
    )
)
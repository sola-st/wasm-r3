(module
    (import "env" "memory" (memory 1))
    (func $main (export "entry")
        i32.const 1
        i32.load8_u
        drop
        i32.const 0
        i32.load8_u
        drop
        i32.const 2
        i32.load
        drop
    )
)
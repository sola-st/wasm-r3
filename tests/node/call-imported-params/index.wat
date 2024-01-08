(module
    (import "env" "add" (func $add (param i32 i32) (result i32)))
    (func $main (export "entry") (param i32 i32)
        local.get 1
        local.set 0
        local.get 0
        local.get 1
        call $add
        i32.const 5
        call $add
        i32.const -4
        call $add
        drop
    )
)

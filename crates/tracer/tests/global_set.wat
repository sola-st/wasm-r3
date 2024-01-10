(module
    (global $glob (mut i32) (i32.const 0))
    (func
        i32.const 1
        global.set $glob
    )
)
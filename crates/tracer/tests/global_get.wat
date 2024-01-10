(module
    (global $glob i32 (i32.const 1))
    (func
        global.get $glob
        drop
    )
    (memory 1)
)
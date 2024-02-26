(module
    (func $main (export "entry")
        call $asdf.store
        call $asdf.load
    )
    (func $asdf.store)
    (func $asdf.load)
    (memory 1)
    (data (i32.const 0) ".store.load")
)
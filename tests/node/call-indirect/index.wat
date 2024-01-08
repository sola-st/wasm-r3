(module
    (func $a)
    (func $main (export "entry")
    i32.const 0
    call_indirect)
    (table 1 1 funcref)
    (elem (i32.const 0) $a)
)
(module
    (type $empty (func))
    (type $one_param (func (param i32)))
    (func $a (type $one_param)
        local.get 0
        i32.const 1
        i32.sub
        local.tee 0
        i32.eqz
        (if (then) (else 
            local.get 0
            i32.const 0
            call_indirect (type $one_param)
        ))
    )
    (func $b (type $one_param))
    (func $main (export "entry") (type $empty)
        i32.const 1000
        i32.const 0
        call_indirect (type $one_param)
    )
    (table (export "table") 2 2 funcref)
    (elem (i32.const 0) $a $b)
)
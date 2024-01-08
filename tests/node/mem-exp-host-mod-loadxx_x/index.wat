(module
  (import "env" "changeMem" (func $changeMem))
  (func $main (export "entry")
    call $setup
    i32.load16_u
    (if (i32.eqz) (then unreachable))
    
    call $setup
    i32.load16_s
    (if (i32.eqz) (then unreachable))

    call $setup
    i64.load16_u
    (if (i64.eqz) (then unreachable))

    call $setup
    i64.load16_s
    (if (i64.eqz) (then unreachable))

    call $setup
    i64.load32_u
    (if (i64.eqz) (then unreachable))
    
    call $setup
    i64.load32_s
    (if (i64.eqz) (then unreachable))
  )
  (func $setup (result i32)
    i32.const 1
    i32.const 0
    i32.store
    call $changeMem
    i32.const 0
  )
  (memory (export "memory") 1)
)

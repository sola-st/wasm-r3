(module
;; page size of memory is 65536
  (func $main (export "entry")
    i32.const 1
    memory.grow
    i32.const -1
    i32.eq
    (if (then unreachable) (else))
    i32.const 65533
    i32.const 1
    i32.store
  )
  (memory (export "memory") 1 10)
)

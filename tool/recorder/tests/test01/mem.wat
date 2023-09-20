(module
  (func (export "changeMem")
    i32.const 420
    i32.const 69
    i32.store
  )
  (func (export "resetMem")
    i32.const 420
    i32.const 0
    i32.store
  )
  (func (export "loadMem")
    i32.const 420
    i32.load
    drop
  )
  (memory (export "memory") 1)
)

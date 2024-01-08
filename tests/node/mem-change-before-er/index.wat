(module
  (import "env" "foo" (func $foo))
  (func $main (export "entry")
    call $foo
  )
  (func (export "exp")
    i32.const 1
    i32.load
    drop
  )
  (memory (export "memory") 1)
)

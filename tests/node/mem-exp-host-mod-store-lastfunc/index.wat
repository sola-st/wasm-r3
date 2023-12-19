(module
  (import "env" "changeMemAfterReentry" (func $changeMemAfterReentry))
  (import "env" "foo" (func $foo))
  (import "env" "bar" (func $bar))
  (func $main (export "main")
    call $changeMemAfterReentry
    i32.const 1
    i32.load
    drop
  )
  (func (export "reentry")
    call $foo
    i32.const 1
    i32.load
    drop
  )
  (func (export "reentry2")
    call $bar
  )
  (memory (export "memory") 1)
)

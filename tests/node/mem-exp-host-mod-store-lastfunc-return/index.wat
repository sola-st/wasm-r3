(module
  (import "env" "changeMemAfterReentry" (func $changeMemAfterReentry (result i32)))
  (import "env" "foo" (func $foo))
  (import "env" "bar" (func $bar (result i32)))
  (func $main (export "main")
    call $changeMemAfterReentry
    drop
    i32.const 1
    i32.load
    drop
    call $changeMemAfterReentry
    drop
    i32.const 1
    i32.load
    drop
    call $changeMemAfterReentry
    drop
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
    drop
  )
  (memory (export "memory") 1)
)

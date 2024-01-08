(module
  (import "env" "changeMemAfterReentry" (func $changeMemAfterReentry))
  (import "env" "changeMemBeforeReentry" (func $changeMemBeforeReentry))
  (import "env2" "foo" (func $foo))
  (import "env2" "bar" (func $bar))
  (func $main (export "entry")
    call $changeMemAfterReentry
    i32.const 1
    i32.load
    drop
    i32.const 1
    i32.const 0
    i32.store
    call $changeMemBeforeReentry
    i32.const 1
    i32.load
    drop
  )
  (func (export "reentry")
    call $foo
  )
  (func (export "reentry2")
    call $bar
  )
  (memory (export "memory") 1)
)

(module
  (import "env" "changeMemAfterReentry" (func $changeMemAfterReentry))
  (import "env" "changeMemBeforeReentry" (func $changeMemBeforeReentry))
  (func $main (export "main")
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
    i32.const 1
    i32.load
    drop
  )
  (memory (export "memory") 1)
)

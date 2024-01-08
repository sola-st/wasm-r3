(module
  (import "env" "memory" (memory 1))
  (import "env" "changeMem" (func $changeMemHost))
  (func $main (export "entry")
    call $changeMemHost
    i32.const 1
    i32.load
    drop
  )
)

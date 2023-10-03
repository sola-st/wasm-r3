(module
  (import "env" "mem" (memory 1))
  (import "env" "changeMem" (func $changeMemHost))
  (func $main (export "main")
    call $changeMemHost
    i32.const 1
    i32.load
    drop
  )
)

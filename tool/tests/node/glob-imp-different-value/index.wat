(module
  (import "env" "global" (global $global (mut i32)))
  (func $main (export "main")
    global.get $global
    drop
  )
)

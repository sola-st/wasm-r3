(module
  (import "env" "global" (global $global i32))
  (func $main (export "main")
    global.get $global
    drop
  )
)

(module
  (import "env" "global" (global $global i32))
  (func $main (export "entry")
    global.get $global
    drop
  )
)

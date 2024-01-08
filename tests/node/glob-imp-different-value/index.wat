(module
  (import "env" "global" (global $global (mut i32)))
  (func $main (export "entry")
    global.get $global
    drop
  )
)

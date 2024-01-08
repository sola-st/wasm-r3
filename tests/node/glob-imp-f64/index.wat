(module
  (import "env" "global" (global $global (mut f64)))
  (func $main (export "entry")
    global.get $global
    drop
  )
)

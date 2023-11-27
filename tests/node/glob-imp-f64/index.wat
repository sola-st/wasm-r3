(module
  (import "env" "global" (global $global (mut f64)))
  (func $main (export "main")
    global.get $global
    drop
  )
)

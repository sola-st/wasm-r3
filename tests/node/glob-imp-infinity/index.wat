(module
  (import "env" "Infinity" (global $global f64))
  (func $main (export "entry")
    global.get $global
    drop
  )
)

(module
  (import "env" "Infinity" (global $global f64))
  (func $main (export "main")
    global.get $global
    drop
  )
)

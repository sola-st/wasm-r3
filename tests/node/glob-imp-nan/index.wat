(module
  (import "env" "NaN" (global $global f64))
  (func $main (export "main")
    global.get $global
    drop
  )
)

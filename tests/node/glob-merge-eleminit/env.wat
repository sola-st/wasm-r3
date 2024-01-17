(module
(import "index" "entry" (func $entry (param i32) (result )))
(elem declare func $entry)
(global (export "DYNAMICTOP_PTR") i32 (i32.const 0))
)

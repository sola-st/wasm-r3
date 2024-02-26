(module
(import "index" "table" (table $table 1 funcref))
(elem declare func )
(func (@name "r3 main")(export "_start") (export "main")
(i32.const 15)
(f32.const 15.5)(call_indirect (param i32 f32) (result ) (i32.const 0))(return)
))

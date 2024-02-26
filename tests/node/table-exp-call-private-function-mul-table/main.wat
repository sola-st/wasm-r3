(module
(import "index" "table1" (table $table1 1 funcref))
(import "index" "table2" (table $table2 1 funcref))
(elem declare func )
(func (@name "r3 main")(export "_start") (export "main")
(call_indirect (param ) (result ) (i32.const 0))(call_indirect (param ) (result ) (i32.const 0))(return)
))

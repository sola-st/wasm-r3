(module
(import "index" "entry" (func $entry (param ) (result )))
(elem declare func $entry)
(func (@name "r3 main")(export "_start") (export "main")
(call $entry)(return)
))

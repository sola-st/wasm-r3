(module
  (import "env" "host1" (func $host1 (param i32 i32)))
  (import "env" "host2" (func $host2 (param i32 i32)))
  (func $func2 (export "wasm1") (param i32 i32)
    return)
  (func $func1 (export "wasm0")
    (call $host2 (i32.const 5) (i32.const 1))
    (call $host1 (i32.const 5) (i32.const 1))
    (call $host1 (i32.const 5) (i32.const 1))
    return)
  (memory (export "memory") 1)
)

;; all memory are initialized to zero

;; naive: 2 loads
;; shadow mem: 1load

;; naive: 2 FuncEntry
;; callstack: 1 FuncEntry
(module
  (import "env" "changeMem" (func $changeMemHost (param i32 i32)))
  (func $changeMemWasm (param i32 i32)
    (i32.store8 (local.get 0) (local.get 1)))
  (func $main (export "entry")
    (call $changeMemWasm (i32.const 0) (i32.const 1))
    (call $changeMemHost (i32.const 5) (i32.const 1))
    (i32.load (i32.const 0))
    (i32.load (i32.const 5))
    return)
  (memory (export "memory") 1)
)

;; all memory are initialized to zero

;; naive: 2 loads
;; shadow mem: 1load

;; naive: 2 FuncEntry
;; callstack: 1 FuncEntry
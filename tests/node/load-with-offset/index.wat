(module
  (memory (import "env" "memory") 1 1)
  (func $main (export "entry")
    i32.const 42
    i32.const 0
    i32.load offset=4
    call_indirect (param i32)
  )
  (func $foo)
  (func $bar (param i32))
  (table $table 2 2 funcref)
  (elem $table (i32.const 0) $foo $bar)
)

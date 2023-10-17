(module
  (import "env1" "changeTable1" (func $changeTable1))
  (import "env2" "changeTable2" (func $changeTable2))
  (import "env1" "a" (func $a (result i32)))
  (import "env1" "b" (func $b (result i32)))
  (import "env2" "c" (func $c (result i32)))
  (import "env2" "d" (func $d (result i32)))
  (func $main1 (export "main") (result i32)
    i32.const 0
    (call_indirect 0 (result i32))
    drop
    call $changeTable1
    i32.const 0
    (call_indirect 0 (result i32))
  )
  (func $main2 (export "main") (result i32)
    i32.const 0
    (call_indirect 1 (result i32))
    drop
    call $changeTable2
    i32.const 0
    (call_indirect 1 (result i32))
  )
  (func $main2)
  (table (export "table1") 3 3 funcref)
  (elem (i32.const 0) 0 $a $b)
  (table (export "table2") 3 3 funcref)
  (elem (i32.const 0) 0 $c $d)
)

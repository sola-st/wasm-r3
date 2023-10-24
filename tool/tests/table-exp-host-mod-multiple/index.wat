(module
  (import "env1" "changeTable1" (func $changeTable1))
  (import "env2" "changeTable2" (func $changeTable2))
  (func $main1 (export "main1") (result i32)
    i32.const 0
    (call_indirect $table1 (result i32))
    drop
    call $changeTable1
    i32.const 0
    (call_indirect $table1 (result i32))
  )
  (func $main2 (export "main2") (result i32)
    i32.const 0
    (call_indirect $table2 (result i32))
    drop
    call $changeTable2
    i32.const 0
    (call_indirect $table2 (result i32))
  )
  (func $a (export "a") (result i32)
    i32.const 1
  )
  (func $b (export "b") (result i32)
    i32.const 2
  )
  (func $c (export "c") (result i32)
    i32.const 3
  )
  (func $d (export "d") (result i32)
    i32.const 4
  )
  (table $table1 (export "table1") 2 2 funcref)
  (elem $elem1 (table $table1) (i32.const 0) $a $b)
  (table $table2 (export "table2") 2 2 funcref)
  (elem $elem2 (table $table2) (i32.const 0) $c $d)
)

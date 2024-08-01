(module
  (table $table1 (export "table1") 1 1 funcref)
  (table $table2 (export "table2") 1 1 funcref)
  (elem (table $table1) (i32.const 0) $foo)
  (elem (table $table2) (i32.const 0) $bar)
  (func $foo)
  (func $bar)
)

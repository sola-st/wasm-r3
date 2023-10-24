(module
  (func $env1.changeTable1 (;0;) (import "env1" "changeTable1"))
  (func $env2.changeTable2 (;1;) (import "env2" "changeTable2"))
  (func $env1.a (;2;) (import "env1" "a") (result i32))
  (func $env1.b (;3;) (import "env1" "b") (result i32))
  (func $env2.c (;4;) (import "env2" "c") (result i32))
  (func $env2.d (;5;) (import "env2" "d") (result i32))
  (func $__wasabi_hooks.begin_function (;6;) (import "__wasabi_hooks" "begin_function") (param i32 i32))
  (func $__wasabi_hooks.i32_const (;7;) (import "__wasabi_hooks" "i32_const") (param i32 i32 i32))
  (func $__wasabi_hooks.call_indirect (;8;) (import "__wasabi_hooks" "call_indirect") (param i32 i32 i32 i32))
  (func $__wasabi_hooks.call_post_i (;9;) (import "__wasabi_hooks" "call_post_i") (param i32 i32 i32))
  (func $__wasabi_hooks.drop_i (;10;) (import "__wasabi_hooks" "drop_i") (param i32 i32 i32))
  (func $__wasabi_hooks.call (;11;) (import "__wasabi_hooks" "call") (param i32 i32 i32))
  (func $__wasabi_hooks.call_post (;12;) (import "__wasabi_hooks" "call_post") (param i32 i32))
  (func $__wasabi_hooks.return_i (;13;) (import "__wasabi_hooks" "return_i") (param i32 i32 i32))
  (func $__wasabi_hooks.end_function (;14;) (import "__wasabi_hooks" "end_function") (param i32 i32))
  (table $table1 (;0;) (export "table1") 3 3 funcref)
  (table $table2 (;1;) (export "table2") 3 3 funcref)
  (global $global0 (mut i32) (i32.const 1))
  (elem $elem0 (i32.const 0) funcref (ref.func $env1.changeTable1) (ref.func $env1.a) (ref.func $env1.b))
  (elem $elem1 (i32.const 0) funcref (ref.func $env1.changeTable1) (ref.func $env2.c) (ref.func $env2.d))
  (func $main1 (;15;) (export "main1") (result i32)
    (local $var0 i32)
    (local $var1 i32)
    (local $var2 i32)
    (local $var3 i32)
    (local $var4 i32)
    (local $var5 i32)
    i32.const 6
    i32.const -1
    call $__wasabi_hooks.begin_function
    i32.const 0
    i32.const 6
    i32.const 0
    i32.const 0
    call $__wasabi_hooks.i32_const
    local.set $var0
    local.get $var0
    i32.const 6
    i32.const 1
    i32.const 0
    local.get $var0
    call $__wasabi_hooks.call_indirect
    call_indirect (result i32)
    local.tee $var1
    i32.const 6
    i32.const 1
    local.get $var1
    call $__wasabi_hooks.call_post_i
    local.set $var2
    i32.const 6
    i32.const 2
    local.get $var2
    call $__wasabi_hooks.drop_i
    i32.const 6
    i32.const 3
    i32.const 0
    call $__wasabi_hooks.call
    call $env1.changeTable1
    i32.const 6
    i32.const 3
    call $__wasabi_hooks.call_post
    i32.const 0
    i32.const 6
    i32.const 4
    i32.const 0
    call $__wasabi_hooks.i32_const
    local.set $var3
    local.get $var3
    i32.const 6
    i32.const 5
    i32.const 0
    local.get $var3
    call $__wasabi_hooks.call_indirect
    call_indirect (result i32)
    local.tee $var4
    i32.const 6
    i32.const 5
    local.get $var4
    call $__wasabi_hooks.call_post_i
    local.tee $var5
    i32.const 6
    i32.const -1
    local.get $var5
    call $__wasabi_hooks.return_i
    i32.const 6
    i32.const 6
    call $__wasabi_hooks.end_function
  )
  (func $main2 (;16;) (export "main2") (result i32)
    (local $var0 i32)
    (local $var1 i32)
    (local $var2 i32)
    (local $var3 i32)
    (local $var4 i32)
    (local $var5 i32)
    i32.const 7
    i32.const -1
    call $__wasabi_hooks.begin_function
    i32.const 0
    i32.const 7
    i32.const 0
    i32.const 0
    call $__wasabi_hooks.i32_const
    local.set $var0
    local.get $var0
    i32.const 7
    i32.const 1
    i32.const 1
    local.get $var0
    call $__wasabi_hooks.call_indirect
    call_indirect (result i32) $table2
    local.tee $var1
    i32.const 7
    i32.const 1
    local.get $var1
    call $__wasabi_hooks.call_post_i
    local.set $var2
    i32.const 7
    i32.const 2
    local.get $var2
    call $__wasabi_hooks.drop_i
    i32.const 7
    i32.const 3
    i32.const 1
    call $__wasabi_hooks.call
    call $env2.changeTable2
    i32.const 7
    i32.const 3
    call $__wasabi_hooks.call_post
    i32.const 0
    i32.const 7
    i32.const 4
    i32.const 0
    call $__wasabi_hooks.i32_const
    local.set $var3
    local.get $var3
    i32.const 7
    i32.const 5
    i32.const 1
    local.get $var3
    call $__wasabi_hooks.call_indirect
    call_indirect (result i32) $table2
    local.tee $var4
    i32.const 7
    i32.const 5
    local.get $var4
    call $__wasabi_hooks.call_post_i
    local.tee $var5
    i32.const 7
    i32.const -1
    local.get $var5
    call $__wasabi_hooks.return_i
    i32.const 7
    i32.const 6
    call $__wasabi_hooks.end_function
  )
)
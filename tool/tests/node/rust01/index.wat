(module
  (type (;0;) (func (result i32)))
  (func $return_one (type 0) (result i32)
    (local i32 i32 i32)
    i32.const 1
    local.set 0
    i32.const 255
    local.set 1
    local.get 0
    local.get 1
    i32.and
    local.set 2
    local.get 2
    return)
  (table (;0;) 1 1 funcref)
  (memory (;0;) 16)
  (global $__stack_pointer (mut i32) (i32.const 1048576))
  (global (;1;) i32 (i32.const 1048576))
  (global (;2;) i32 (i32.const 1048576))
  (export "memory" (memory 0))
  (export "return_one" (func $return_one))
  (export "__data_end" (global 1))
  (export "__heap_base" (global 2)))

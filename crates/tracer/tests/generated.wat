(module
  (type (;0;) (func))
  (import "r3" "check_mem" (func $check_mem (;0;) (type 0)))
  (func (;1;) (type 0)
    (local $addr_local i32) (local $i32 i32) (local $i64 i64) (local $f32 f32) (local $f64 f64) (local $funcref funcref)
  )
  (func (;2;) (type 0)
    (local $addr_local i32) (local $i32 i32) (local $i64 i64) (local $f32 f32) (local $f64 f64) (local $funcref funcref)
    global.get $internal_call
    i32.eqz
    if ;; label = @1
      global.get $mem_pointer
      i32.const 2
      i32.store8
      global.get $mem_pointer
      i32.const 1
      i32.store offset=1
      global.get $mem_pointer
      i32.const 0
      i32.store offset=5
      global.get $mem_pointer
      i32.const 9
      i32.add
      global.set $mem_pointer
    else
    end
    i32.const 0
    global.get $mem_pointer
    i32.const 16
    i32.store8
    local.tee $i32
    global.get $mem_pointer
    local.get $i32
    i32.store offset=1
    global.get $mem_pointer
    i32.const 5
    i32.add
    global.set $mem_pointer
    call_indirect (type 0)
    global.get $mem_pointer
    i32.const 255
    i32.store8
    global.get $mem_pointer
    local.get $i32
    i32.store offset=1
    global.get $mem_pointer
    i32.const 0
    i32.store offset=5
    global.get $mem_pointer
    i32.const 9
    i32.add
    global.set $mem_pointer
    global.get $internal_call
    i32.eqz
    if ;; label = @1
      global.get $mem_pointer
      i32.const 15
      i32.store8
      global.get $mem_pointer
      i32.const 1
      i32.add
      global.set $mem_pointer
    else
      global.get $internal_call
      i32.const 1
      i32.sub
      global.set $internal_call
    end
    i32.const 448000000
    global.get $mem_pointer
    i32.le_u
    if ;; label = @1
      call $check_mem
    end
  )
  (table (;0;) 1 1 funcref)
  (memory $trace_mem (;0;) 10000)
  (global $mem_pointer (;0;) (mut i32) i32.const 0)
  (global $internal_call (;1;) (mut i32) i32.const 0)
  (export "entry" (func 2))
  (export "trace" (memory $trace_mem))
  (export "trace_byte_length" (global $mem_pointer))
  (elem (;0;) (i32.const 0) func 2)
)
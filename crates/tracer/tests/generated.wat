(module
  (type (;0;) (func))
  (import "r3" "check_mem" (func $check_mem (;0;) (type 0)))
  (func (;1;) (type 0)
    (local $addr_local i32) (local $i32 i32) (local $i64 i64) (local $f32 f32) (local $f64 f64) (local $funcref funcref)
    global.get $call_stack_addr
    i32.load8_u $call_stack
    global.get $call_stack_addr
    i32.const 1
    i32.add
    global.set $call_stack_addr
    global.get $call_stack_addr
    i32.const 1
    i32.store8 $call_stack
    i32.eqz
    if ;; label = @1
      global.get $mem_pointer
      i32.const 2
      i32.store8
      global.get $mem_pointer
      i32.const 0
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
    call 11
    global.get $call_stack_addr
    i32.const 1
    i32.sub
    global.set $call_stack_addr
    global.get $call_stack_addr
    i32.const 1
    i32.eq
    if ;; label = @1
      global.get $mem_pointer
      i32.const 15
      i32.store8
      global.get $mem_pointer
      i32.const 1
      i32.add
      global.set $mem_pointer
    else
    end
    i32.const 44800000
    global.get $mem_pointer
    i32.le_u
    if ;; label = @1
      call $check_mem
    end
  )
  (func (;2;) (type 0)
    (local $addr_local i32) (local $i32 i32) (local $i64 i64) (local $f32 f32) (local $f64 f64) (local $funcref funcref)
  )
  (func (;3;) (type 0)
    (local $addr_local i32) (local $i32 i32) (local $i64 i64) (local $f32 f32) (local $f64 f64) (local $funcref funcref)
  )
  (func (;4;) (type 0)
    (local $addr_local i32) (local $i32 i32) (local $i64 i64) (local $f32 f32) (local $f64 f64) (local $funcref funcref)
  )
  (func (;5;) (type 0)
    (local $addr_local i32) (local $i32 i32) (local $i64 i64) (local $f32 f32) (local $f64 f64) (local $funcref funcref)
  )
  (func (;6;) (type 0)
    (local $addr_local i32) (local $i32 i32) (local $i64 i64) (local $f32 f32) (local $f64 f64) (local $funcref funcref)
  )
  (func (;7;) (type 0)
    (local $addr_local i32) (local $i32 i32) (local $i64 i64) (local $f32 f32) (local $f64 f64) (local $funcref funcref)
  )
  (func (;8;) (type 0)
    (local $addr_local i32) (local $i32 i32) (local $i64 i64) (local $f32 f32) (local $f64 f64) (local $funcref funcref)
  )
  (func (;9;) (type 0)
    (local $addr_local i32) (local $i32 i32) (local $i64 i64) (local $f32 f32) (local $f64 f64) (local $funcref funcref)
  )
  (func (;10;) (type 0)
    (local $addr_local i32) (local $i32 i32) (local $i64 i64) (local $f32 f32) (local $f64 f64) (local $funcref funcref)
  )
  (func (;11;) (type 0)
    (local $addr_local i32) (local $i32 i32) (local $i64 i64) (local $f32 f32) (local $f64 f64) (local $funcref funcref)
  )
  (memory $trace_mem (;0;) 10000)
  (memory $call_stack (;1;) 1000)
  (global $mem_pointer (;0;) (mut i32) i32.const 0)
  (global $call_stack_addr (;1;) (mut i32) i32.const 1)
  (export "entry" (func 1))
  (export "trace" (memory $trace_mem))
  (export "trace_byte_length" (global $mem_pointer))
)
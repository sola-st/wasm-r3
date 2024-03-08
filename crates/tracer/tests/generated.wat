(module
(import "r3" "check_mem" (func $check_mem))
(type (;0;) (func))
(func (;0;) (type 0)
(local $addr_local i32)(local $i32 i32)(local $i64 i64)(local $f32 f32)(local $f64 f64)(local $funcref funcref)(local)
global.get $in_environment
(if (
global.get $call_stack_addr
i32.const 1
i32.add
global.set $call_stack_addr
global.get $call_stack_addr
i32.const 1
i32.store8 $call_stack
global.get $mem_pointer
i32.const 3
i32.store8 $trace_mem offset=0
global.get $mem_pointer
i32.const 0
i32.store $trace_mem offset=1
global.get $mem_pointer
i32.const 0
i32.store $trace_mem offset=5
global.get $mem_pointer
i32.const 9
i32.add
global.set $mem_pointer
i32.const 0
global.set $in_environment
) (else))
)
(table (;0;) 1 1 funcref)
(export "table" (table 0))
(elem (;0;) (i32.const 0) func 1 )

(memory $trace_mem (export "trace") 10000)
(memory $call_stack 1000)
(global $mem_pointer (export "trace_byte_length") (mut i32) (i32.const 0))
(global $call_stack_addr (mut i32) (i32.const 1))
(global $in_environment (mut i32) (i32.const 1))
)

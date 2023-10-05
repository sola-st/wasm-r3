(module
  (type (;0;) (func))
  (type (;1;) (func (param i32 i32)))
  (type (;2;) (func (param i32 i32 i32)))
  (import "env" "foo" (func (;0;) (type 0)))
  (import "env2" "bar" (func (;1;) (type 0)))
  (import "__wasabi_hooks" "begin_function" (func (;2;) (type 1)))
  (import "__wasabi_hooks" "call" (func (;3;) (type 2)))
  (import "__wasabi_hooks" "call_post" (func (;4;) (type 1)))
  (func (;5;) (type 0)
    i32.const 2
    i32.const -1
    call 2
    i32.const 2
    i32.const 0
    i32.const 0
    call 3
    call 0
    i32.const 2
    i32.const 0
    call 4
    i32.const 2
    i32.const 1
    i32.const 1
    call 3
    call 1
    i32.const 2
    i32.const 1
    call 4)
  (export "main" (func 5)))

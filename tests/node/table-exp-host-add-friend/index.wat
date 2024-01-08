(module
  (import "env" "foo" (func $foo))
  (import "env" "foo2" (func))
  (import "env" "foo3" (func))
  (import "env" "foo4" (func))
  (import "env" "foo5" (func))
  (import "env" "foo6" (func))
  (import "env" "foo7" (func))
  (import "env" "foo8" (func))
  (import "env" "foo9" (func))
  (import "env" "foo10" (func))
  (func $main (export "entry")
    i32.const 0
    call_indirect
  )
  (table (export "table") 1 1 funcref)
  (elem (i32.const 0) $foo)
  (func $bar (export "bar")
    call $foo
  )
)

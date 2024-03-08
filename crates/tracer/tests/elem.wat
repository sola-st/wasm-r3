(module
  (type (;0;) (func))
  (import "env" "foo" (func (;0;) (type 0)))
  (import "env" "bar" (func (;1;) (type 0)))
  (func (;2;) (type 0)
    call 0
  )
  (func (;3;) (type 0)
    call 1
  )
  (table (;0;) 1 1 funcref)
  (export "entry" (func 2))
  (export "table" (table 0))
  (elem (;0;) (i32.const 0) func 3)
)

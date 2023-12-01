(module
  (import "env" "tony" (func $tony))
  (import "env" "jannik" (func))
  (func (export "greet")
    call $tony
  )
)

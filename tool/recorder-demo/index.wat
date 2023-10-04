(module
  (func (export "i32store") (param i32 i32)
    local.get 0
    local.get 1
    i32.store
  )
  (func (export "i32store8") (param i32 i32)
    local.get 0
    local.get 1
    i32.store8
  )
  (func (export "i32store16") (param i32 i32)
    local.get 0
    local.get 1
    i32.store16
  )
  (func (export "i64store") (param i32 i64)
    local.get 0
    local.get 1
    i64.store
  )
  (func (export "i64store8") (param i32 i64)
    local.get 0
    local.get 1
    i64.store8
  )
  (func (export "i64store16") (param i32 i64)
    local.get 0
    local.get 1
    i64.store16
  )
  (func (export "i64store32") (param i32 i64)
    local.get 0
    local.get 1
    i64.store32
  )
  (func (export "f32store") (param i32 f32)
    local.get 0
    local.get 1
    f32.store
  )
  (func (export "f64store") (param i32 f64)
    local.get 0
    local.get 1
    f64.store
  )
  (func (export "i32load") (param i32)
    local.get 0
    i32.load
    drop
  )
  (func (export "i32load8_u") (param i32)
    local.get 0
    i32.load8_u
    drop
  )
  (func (export "i32load8_s") (param i32)
    local.get 0
    i32.load8_s
    drop
  )
  (func (export "i32load16_u") (param i32)
    local.get 0
    i32.load16_u
    drop
  )
  (func (export "i32load16_s") (param i32)
    local.get 0
    i32.load16_s
    drop
  )
  (func (export "i64load") (param i32)
    local.get 0
    i64.load
    drop
  )
  (func (export "i64load8_u") (param i32)
    local.get 0
    i64.load8_u
    drop
  )
  (func (export "i64load8_s") (param i32)
    local.get 0
    i64.load8_s
    drop
  )
  (func (export "i64load16_u") (param i32)
    local.get 0
    i64.load16_u
    drop
  )
  (func (export "i64load16_s") (param i32)
    local.get 0
    i64.load16_s
    drop
  )
  (func (export "i64load32_u") (param i32)
    local.get 0
    i64.load32_u
    drop
  )
  (func (export "i64load32_s") (param i32)
    local.get 0
    i64.load32_s
    drop
  )
  (func (export "f32load") (param i32)
    local.get 0
    f32.load
    drop
  )
  (func (export "f64load") (param i32)
    local.get 0
    f64.load
    drop
  )
  (memory (export "memory") 1)
)

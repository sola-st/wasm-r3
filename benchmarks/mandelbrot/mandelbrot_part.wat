(module
(type (;0;) (func (param i32 i32) (result i32)))
  (type (;1;) (func (param i32 i32 i32) (result i32)))
  (type (;2;) (func (param i32 i32)))
  (type (;3;) (func (param i32 i32 i32)))
  (type (;4;) (func (param i32)))
  (type (;5;) (func (param i32) (result i32)))
  (type (;6;) (func (param i32 i32 i32 i32 i32)))
  (type (;7;) (func))
  (type (;8;) (func (param i32 i32 i32 i32) (result i32)))
  (type (;9;) (func (param i32 i32 i32 i64 i32)))
  (type (;10;) (func (param i32 i32 i32 i32)))
  (type (;11;) (func (param i32 i32 i32 i32 i32 i32) (result i32)))
  (type (;12;) (func (param i32 i32 i32 i32 i32 i32)))
  (type (;13;) (func (param f64 f64) (result i32)))
  (type (;14;) (func (param i32 i32 i32 i32 i32) (result i32)))
  (type (;15;) (func (param i32) (result i64)))
  (type (;16;) (func (param i32 i32 i32 i32 i32 f64 f64 i32 i32 i32 i32)))
  (type (;17;) (func (param i32 f64 i32 i32) (result i32)))
  (type (;18;) (func (param i32 f64 i32) (result i32)))
  (type (;19;) (func (param i32 i32 i32 i64)))
  (type (;20;) (func (param i32 i32 i32 i32 i32 i32 i32)))
  (type (;21;) (func (param i64 i32 i32) (result i32)))
  (type (;22;) (func (param i32 i32 i32 f64 f64 f64 f64 i32 i32 i32)))
  (type (;23;) (func (param i32 i32 i32 f64 f64 f64 f64 f64 f64 i32 i32 i32)))
  (type (;24;) (func (param f64 f64 f64 f64) (result i32)))
  (type (;25;) (func (param i32 i32 f64 i32 i32)))
  (type (;26;) (func (param i32 f64 i32 i32)))
  (type (;27;) (func (param i32 i32 f32 i32 i32)))
  (type (;28;) (func (param i32 f32 i32 i32)))
  (type (;29;) (func (param i32 i32 f64 f64)))
(table (import "whole" "table_0") (;0;) 65 65 funcref)
(memory (import "whole" "memory_0") (;0;) 17)
(global (import "whole" "global_0") (mut i32))
(func $66 (export "66") (param i32 i32 i32) (local i32 i32 i32)
    global.get 0
    i32.const 32
    i32.sub
    local.tee 3
    global.set 0
    i32.const 1
    local.set 4
    i32.const 1061448
    i32.const 1061448
    i32.load
    i32.const 1
    i32.add
    i32.store
    block ;; label = @1
      block ;; label = @2
        block ;; label = @3
          i32.const 1061904
          i32.load
          i32.const 1
          i32.ne
          if ;; label = @4
            i32.const 1061904
            i64.const 4294967297
            i64.store
            br 1 (;@3;)
          end
          i32.const 1061908
          i32.const 1061908
          i32.load
          i32.const 1
          i32.add
          local.tee 4
          i32.store
          local.get 4
          i32.const 2
          i32.gt_u
          br_if 1 (;@2;)
        end
        local.get 3
        local.get 2
        i32.store offset=28
        local.get 3
        local.get 1
        i32.store offset=24
        local.get 3
        i32.const 1054132
        i32.store offset=20
        local.get 3
        i32.const 1054132
        i32.store offset=16
        i32.const 1061436
        i32.load
        local.tee 1
        i32.const -1
        i32.le_s
        br_if 0 (;@2;)
        i32.const 1061436
        local.get 1
        i32.const 1
        i32.add
        local.tee 1
        i32.store
        i32.const 1061436
        i32.const 1061444
        i32.load
        local.tee 2
        if (result i32) ;; label = @3
          i32.const 1061440
          i32.load
          local.set 5
          local.get 3
          i32.const 8
          i32.add
          local.get 0
          i32.const 1054608
          i32.load
          call_indirect (type 2)
          local.get 3
          local.get 3
          i64.load offset=8
          i64.store offset=16
          local.get 5
          local.get 3
          i32.const 16
          i32.add
          local.get 2
          i32.load offset=12
          call_indirect (type 2)
          i32.const 1061436
          i32.load
        else
          local.get 1
        end
        i32.const -1
        i32.add
        i32.store
        local.get 4
        i32.const 1
        i32.le_u
        br_if 1 (;@1;)
      end
      unreachable
    end
    global.get 0
    i32.const 16
    i32.sub
    local.tee 1
    global.set 0
    local.get 1
    i32.const 1054592
    i32.store offset=12
    local.get 1
    local.get 0
    i32.store offset=8
    unreachable
  )
)

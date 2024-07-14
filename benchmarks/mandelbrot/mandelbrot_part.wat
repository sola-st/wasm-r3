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
(func $44 (export "44") (;46;) (type 2) (param i32 i32)
    (local i32 i32 i32 i32)
    block ;; label = @1
      block ;; label = @2
        local.get 1
        i32.const 256
        i32.ge_u
        if ;; label = @3
          local.get 0
          i32.const 24
          i32.add
          i32.load
          local.set 4
          block ;; label = @4
            block ;; label = @5
              local.get 0
              local.get 0
              i32.load offset=12
              local.tee 2
              i32.eq
              if ;; label = @6
                local.get 0
                i32.const 20
                i32.const 16
                local.get 0
                i32.const 20
                i32.add
                local.tee 2
                i32.load
                local.tee 3
                select
                i32.add
                i32.load
                local.tee 1
                br_if 1 (;@5;)
                i32.const 0
                local.set 2
                br 2 (;@4;)
              end
              local.get 0
              i32.load offset=8
              local.tee 1
              local.get 2
              i32.store offset=12
              local.get 2
              local.get 1
              i32.store offset=8
              br 1 (;@4;)
            end
            local.get 2
            local.get 0
            i32.const 16
            i32.add
            local.get 3
            select
            local.set 3
            loop ;; label = @5
              local.get 3
              local.set 5
              local.get 1
              local.tee 2
              i32.const 20
              i32.add
              local.tee 3
              i32.load
              local.tee 1
              i32.eqz
              if ;; label = @6
                local.get 2
                i32.const 16
                i32.add
                local.set 3
                local.get 2
                i32.load offset=16
                local.set 1
              end
              local.get 1
              br_if 0 (;@5;)
            end
            local.get 5
            i32.const 0
            i32.store
          end
          local.get 4
          i32.eqz
          br_if 2 (;@1;)
          local.get 0
          local.get 0
          i32.const 28
          i32.add
          i32.load
          i32.const 2
          i32.shl
          i32.const 1061724
          i32.add
          local.tee 1
          i32.load
          i32.ne
          if ;; label = @4
            local.get 4
            i32.const 16
            i32.const 20
            local.get 4
            i32.load offset=16
            local.get 0
            i32.eq
            select
            i32.add
            local.get 2
            i32.store
            local.get 2
            i32.eqz
            br_if 3 (;@1;)
            br 2 (;@2;)
          end
          local.get 1
          local.get 2
          i32.store
          local.get 2
          br_if 1 (;@2;)
          i32.const 1061456
          i32.const 1061456
          i32.load
          i32.const -2
          local.get 0
          i32.load offset=28
          i32.rotl
          i32.and
          i32.store
          return
        end
        local.get 0
        i32.const 12
        i32.add
        i32.load
        local.tee 2
        local.get 0
        i32.const 8
        i32.add
        i32.load
        local.tee 0
        i32.ne
        if ;; label = @3
          local.get 0
          local.get 2
          i32.store offset=12
          local.get 2
          local.get 0
          i32.store offset=8
          return
        end
        i32.const 1061452
        i32.const 1061452
        i32.load
        i32.const -2
        local.get 1
        i32.const 3
        i32.shr_u
        i32.rotl
        i32.and
        i32.store
        br 1 (;@1;)
      end
      local.get 2
      local.get 4
      i32.store offset=24
      local.get 0
      i32.load offset=16
      local.tee 1
      if ;; label = @2
        local.get 2
        local.get 1
        i32.store offset=16
        local.get 1
        local.get 2
        i32.store offset=24
      end
      local.get 0
      i32.const 20
      i32.add
      i32.load
      local.tee 0
      i32.eqz
      br_if 0 (;@1;)
      local.get 2
      i32.const 20
      i32.add
      local.get 0
      i32.store
      local.get 0
      local.get 2
      i32.store offset=24
    end
)  
)

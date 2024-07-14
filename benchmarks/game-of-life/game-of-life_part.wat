(module 
  (type (;0;) (func))
  (type (;1;) (func (param i32 i32)))
  (type (;2;) (func (param i32 i32 i32) (result i32)))
  (memory (import "host" "memory") (;0;) 64 64)
  (func $0 (export "$0") (;1;) (type 1) (param i32 i32)
    (local i32 i32 i32)
    i32.const 1028
    i32.load
    local.set 2
    block ;; label = @1
      block ;; label = @2
        i32.const 1024
        i32.load
        local.tee 4
        i32.const 0
        i32.le_s
        br_if 0 (;@2;)
        loop ;; label = @3
          block ;; label = @4
            local.get 0
            local.get 3
            i32.const 12
            i32.mul
            local.get 2
            i32.add
            i32.load
            i32.eq
            if ;; label = @5
              local.get 1
              local.get 3
              i32.const 12
              i32.mul
              local.get 2
              i32.add
              i32.load offset=4
              i32.eq
              br_if 1 (;@4;)
            end
            local.get 3
            i32.const 1
            i32.add
            local.tee 3
            local.get 4
            i32.lt_s
            br_if 1 (;@3;)
            br 2 (;@2;)
          end
        end
        local.get 3
        i32.const 12
        i32.mul
        local.get 2
        i32.add
        i32.const 8
        i32.add
        local.tee 0
        local.set 1
        local.get 0
        i32.load
        local.set 0
        br 1 (;@1;)
      end
      local.get 4
      i32.const 12
      i32.mul
      local.get 2
      i32.add
      local.get 0
      i32.store
      i32.const 1024
      i32.load
      local.tee 0
      i32.const 12
      i32.mul
      local.get 2
      i32.add
      local.get 1
      i32.store offset=4
      local.get 0
      i32.const 12
      i32.mul
      local.get 2
      i32.add
      i32.const 1
      i32.store offset=8
      i32.const 1024
      local.set 1
    end
    local.get 1
    local.get 0
    i32.const 1
    i32.add
    i32.store
  )
)  
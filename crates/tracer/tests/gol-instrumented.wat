(module
  (type (;0;) (func (param i32 i32)))
  (type (;1;) (func (param i32 i32 i32) (result i32)))
  (import "env" "memory" (memory (;0;) 64 64))
  (func (;0;) (type 1) (param i32 i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32)
    i32.const 1024
    i32.const 0
    i32.store
    i32.const 1028
    local.get 1
    i32.store
    block (result i32)  ;; label = @1
      block  ;; label = @2
        local.get 2
        i32.const 0
        i32.gt_s
        local.tee 5
        i32.eqz
        br_if 0 (;@2;)
        i32.const 0
        local.set 1
        loop  ;; label = @3
          local.get 1
          i32.const 3
          i32.shl
          local.get 0
          i32.add
          local.tee 3
          i32.load
          i32.const -1
          i32.add
          local.get 1
          i32.const 3
          i32.shl
          local.get 0
          i32.add
          local.tee 4
          i32.load offset=4
          i32.const -1
          i32.add
          call 1
          local.get 3
          i32.load
          local.get 4
          i32.load offset=4
          i32.const -1
          i32.add
          call 1
          local.get 3
          i32.load
          i32.const 1
          i32.add
          local.get 4
          i32.load offset=4
          i32.const -1
          i32.add
          call 1
          local.get 3
          i32.load
          i32.const -1
          i32.add
          local.get 4
          i32.load offset=4
          call 1
          local.get 3
          i32.load
          i32.const 1
          i32.add
          local.get 4
          i32.load offset=4
          call 1
          local.get 3
          i32.load
          i32.const -1
          i32.add
          local.get 4
          i32.load offset=4
          i32.const 1
          i32.add
          call 1
          local.get 3
          i32.load
          local.get 4
          i32.load offset=4
          i32.const 1
          i32.add
          call 1
          local.get 3
          i32.load
          i32.const 1
          i32.add
          local.get 4
          i32.load offset=4
          i32.const 1
          i32.add
          call 1
          local.get 1
          i32.const 1
          i32.add
          local.tee 1
          local.get 2
          i32.ne
          br_if 0 (;@3;)
        end
        local.get 5
        i32.eqz
        br_if 0 (;@2;)
        i32.const 1024
        i32.load
        local.tee 4
        i32.const 0
        i32.gt_s
        local.set 6
        i32.const 1028
        i32.load
        local.set 5
        i32.const 0
        local.set 3
        loop (result i32)  ;; label = @3
          local.get 6
          if  ;; label = @4
            local.get 3
            i32.const 3
            i32.shl
            local.get 0
            i32.add
            i32.load
            local.set 7
            local.get 3
            i32.const 3
            i32.shl
            local.get 0
            i32.add
            local.set 8
            i32.const 0
            local.set 1
            loop  ;; label = @5
              local.get 7
              local.get 1
              i32.const 12
              i32.mul
              local.get 5
              i32.add
              i32.load
              i32.eq
              if  ;; label = @6
                local.get 1
                i32.const 12
                i32.mul
                local.get 5
                i32.add
                i32.load offset=4
                local.get 8
                i32.load offset=4
                i32.eq
                if  ;; label = @7
                  local.get 1
                  i32.const 12
                  i32.mul
                  local.get 5
                  i32.add
                  local.tee 9
                  i32.load offset=8
                  i32.const 2
                  i32.eq
                  if  ;; label = @8
                    local.get 9
                    i32.const 3
                    i32.store offset=8
                  end
                end
              end
              local.get 1
              i32.const 1
              i32.add
              local.tee 1
              local.get 4
              i32.ne
              br_if 0 (;@5;)
            end
          end
          local.get 3
          i32.const 1
          i32.add
          local.tee 3
          local.get 2
          i32.ne
          br_if 0 (;@3;)
          local.get 4
        end
        br 1 (;@1;)
      end
      i32.const 1024
      i32.load
    end
    local.tee 2
    i32.const 0
    i32.gt_s
    if  ;; label = @1
      i32.const 1028
      i32.load
      local.set 4
      i32.const 0
      local.set 1
      i32.const 0
      local.set 3
      loop  ;; label = @2
        local.get 3
        i32.const 12
        i32.mul
        local.get 4
        i32.add
        i32.load offset=8
        i32.const 3
        i32.eq
        if  ;; label = @3
          local.get 1
          i32.const 3
          i32.shl
          local.get 0
          i32.add
          local.get 3
          i32.const 12
          i32.mul
          local.get 4
          i32.add
          i32.load
          i32.store
          local.get 1
          i32.const 3
          i32.shl
          local.get 0
          i32.add
          local.get 3
          i32.const 12
          i32.mul
          local.get 4
          i32.add
          i32.load offset=4
          i32.store offset=4
          local.get 1
          i32.const 1
          i32.add
          local.set 1
          i32.const 1024
          i32.load
          local.set 2
        end
        local.get 3
        i32.const 1
        i32.add
        local.tee 3
        local.get 2
        i32.lt_s
        br_if 0 (;@2;)
      end
    else
      i32.const 0
      local.set 1
    end
    local.get 1)
  (func (;1;) (type 0) (param i32 i32)
    (local i32 i32 i32)
    i32.const 1028
    i32.load
    local.set 2
    block  ;; label = @1
      block  ;; label = @2
        i32.const 1024
        i32.load
        local.tee 4
        i32.const 0
        i32.le_s
        br_if 0 (;@2;)
        loop  ;; label = @3
          block  ;; label = @4
            local.get 0
            local.get 3
            i32.const 12
            i32.mul
            local.get 2
            i32.add
            i32.load
            i32.eq
            if  ;; label = @5
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
    i32.store)
  (memory (;1;) 100)
  (global (;0;) (mut i32) (i32.const 0))
  (export "_gol" (func 0)))

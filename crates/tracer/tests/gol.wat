(module
  (memory $env.memory (;0;) (import "env" "memory") 64 64)
  (func $func0 (param $var0 i32) (param $var1 i32)
    (local $var2 i32)
    (local $var3 i32)
    (local $var4 i32)
    i32.const 1028
    i32.load
    local.set $var2
    block $label3
      block $label0
        i32.const 1024
        i32.load
        local.tee $var4
        i32.const 0
        i32.le_s
        br_if $label0
        loop $label2
          block $label1
            local.get $var0
            local.get $var3
            i32.const 12
            i32.mul
            local.get $var2
            i32.add
            i32.load
            i32.eq
            if
              local.get $var1
              local.get $var3
              i32.const 12
              i32.mul
              local.get $var2
              i32.add
              i32.load offset=4
              i32.eq
              br_if $label1
            end
            local.get $var3
            i32.const 1
            i32.add
            local.tee $var3
            local.get $var4
            i32.lt_s
            br_if $label2
            br $label0
          end $label1
        end $label2
        local.get $var3
        i32.const 12
        i32.mul
        local.get $var2
        i32.add
        i32.const 8
        i32.add
        local.tee $var0
        local.set $var1
        local.get $var0
        i32.load
        local.set $var0
        br $label3
      end $label0
      local.get $var4
      i32.const 12
      i32.mul
      local.get $var2
      i32.add
      local.get $var0
      i32.store
      i32.const 1024
      i32.load
      local.tee $var0
      i32.const 12
      i32.mul
      local.get $var2
      i32.add
      local.get $var1
      i32.store offset=4
      local.get $var0
      i32.const 12
      i32.mul
      local.get $var2
      i32.add
      i32.const 1
      i32.store offset=8
      i32.const 1024
      local.set $var1
    end $label3
    local.get $var1
    local.get $var0
    i32.const 1
    i32.add
    i32.store
  )
  (func $_gol (;1;) (export "_gol") (param $var0 i32) (param $var1 i32) (param $var2 i32) (result i32)
    (local $var3 i32)
    (local $var4 i32)
    (local $var5 i32)
    (local $var6 i32)
    (local $var7 i32)
    (local $var8 i32)
    (local $var9 i32)
    i32.const 1024
    i32.const 0
    i32.store
    i32.const 1028
    local.get $var1
    i32.store
    block $label4 (result i32)
      block $label0
        local.get $var2
        i32.const 0
        i32.gt_s
        local.tee $var5
        i32.eqz
        br_if $label0
        i32.const 0
        local.set $var1
        loop $label1
          local.get $var1
          i32.const 3
          i32.shl
          local.get $var0
          i32.add
          local.tee $var3
          i32.load
          i32.const -1
          i32.add
          local.get $var1
          i32.const 3
          i32.shl
          local.get $var0
          i32.add
          local.tee $var4
          i32.load offset=4
          i32.const -1
          i32.add
          call $func0
          local.get $var3
          i32.load
          local.get $var4
          i32.load offset=4
          i32.const -1
          i32.add
          call $func0
          local.get $var3
          i32.load
          i32.const 1
          i32.add
          local.get $var4
          i32.load offset=4
          i32.const -1
          i32.add
          call $func0
          local.get $var3
          i32.load
          i32.const -1
          i32.add
          local.get $var4
          i32.load offset=4
          call $func0
          local.get $var3
          i32.load
          i32.const 1
          i32.add
          local.get $var4
          i32.load offset=4
          call $func0
          local.get $var3
          i32.load
          i32.const -1
          i32.add
          local.get $var4
          i32.load offset=4
          i32.const 1
          i32.add
          call $func0
          local.get $var3
          i32.load
          local.get $var4
          i32.load offset=4
          i32.const 1
          i32.add
          call $func0
          local.get $var3
          i32.load
          i32.const 1
          i32.add
          local.get $var4
          i32.load offset=4
          i32.const 1
          i32.add
          call $func0
          local.get $var1
          i32.const 1
          i32.add
          local.tee $var1
          local.get $var2
          i32.ne
          br_if $label1
        end $label1
        local.get $var5
        i32.eqz
        br_if $label0
        i32.const 1024
        i32.load
        local.tee $var4
        i32.const 0
        i32.gt_s
        local.set $var6
        i32.const 1028
        i32.load
        local.set $var5
        i32.const 0
        local.set $var3
        loop $label3 (result i32)
          local.get $var6
          if
            local.get $var3
            i32.const 3
            i32.shl
            local.get $var0
            i32.add
            i32.load
            local.set $var7
            local.get $var3
            i32.const 3
            i32.shl
            local.get $var0
            i32.add
            local.set $var8
            i32.const 0
            local.set $var1
            loop $label2
              local.get $var7
              local.get $var1
              i32.const 12
              i32.mul
              local.get $var5
              i32.add
              i32.load
              i32.eq
              if
                local.get $var1
                i32.const 12
                i32.mul
                local.get $var5
                i32.add
                i32.load offset=4
                local.get $var8
                i32.load offset=4
                i32.eq
                if
                  local.get $var1
                  i32.const 12
                  i32.mul
                  local.get $var5
                  i32.add
                  local.tee $var9
                  i32.load offset=8
                  i32.const 2
                  i32.eq
                  if
                    local.get $var9
                    i32.const 3
                    i32.store offset=8
                  end
                end
              end
              local.get $var1
              i32.const 1
              i32.add
              local.tee $var1
              local.get $var4
              i32.ne
              br_if $label2
            end $label2
          end
          local.get $var3
          i32.const 1
          i32.add
          local.tee $var3
          local.get $var2
          i32.ne
          br_if $label3
          local.get $var4
        end $label3
        br $label4
      end $label0
      i32.const 1024
      i32.load
    end $label4
    local.tee $var2
    i32.const 0
    i32.gt_s
    if
      i32.const 1028
      i32.load
      local.set $var4
      i32.const 0
      local.set $var1
      i32.const 0
      local.set $var3
      loop $label5
        local.get $var3
        i32.const 12
        i32.mul
        local.get $var4
        i32.add
        i32.load offset=8
        i32.const 3
        i32.eq
        if
          local.get $var1
          i32.const 3
          i32.shl
          local.get $var0
          i32.add
          local.get $var3
          i32.const 12
          i32.mul
          local.get $var4
          i32.add
          i32.load
          i32.store
          local.get $var1
          i32.const 3
          i32.shl
          local.get $var0
          i32.add
          local.get $var3
          i32.const 12
          i32.mul
          local.get $var4
          i32.add
          i32.load offset=4
          i32.store offset=4
          local.get $var1
          i32.const 1
          i32.add
          local.set $var1
          i32.const 1024
          i32.load
          local.set $var2
        end
        local.get $var3
        i32.const 1
        i32.add
        local.tee $var3
        local.get $var2
        i32.lt_s
        br_if $label5
      end $label5
    else
      i32.const 0
      local.set $var1
    end
    local.get $var1
  )
)
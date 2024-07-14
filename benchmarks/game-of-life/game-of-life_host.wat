(module
  (type (;0;) (func))
  (type (;1;) (func (param i32 i32)))
  (type (;2;) (func (param i32 i32 i32) (result i32)))
  (func $0 (import "part" "$0") (;1;) (type 1))
  (func $1 (;2;) (type 2) (param i32 i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32)
    i32.const 1024
    i32.const 0
    i32.store
    i32.const 1028
    local.get 1
    i32.store
    block (result i32) ;; label = @1
      block ;; label = @2
        local.get 2
        i32.const 0
        i32.gt_s
        local.tee 5
        i32.eqz
        br_if 0 (;@2;)
        i32.const 0
        local.set 1
        loop ;; label = @3
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
          call $0
          local.get 3
          i32.load
          local.get 4
          i32.load offset=4
          i32.const -1
          i32.add
          call $0
          local.get 3
          i32.load
          i32.const 1
          i32.add
          local.get 4
          i32.load offset=4
          i32.const -1
          i32.add
          call $0
          local.get 3
          i32.load
          i32.const -1
          i32.add
          local.get 4
          i32.load offset=4
          call $0
          local.get 3
          i32.load
          i32.const 1
          i32.add
          local.get 4
          i32.load offset=4
          call $0
          local.get 3
          i32.load
          i32.const -1
          i32.add
          local.get 4
          i32.load offset=4
          i32.const 1
          i32.add
          call $0
          local.get 3
          i32.load
          local.get 4
          i32.load offset=4
          i32.const 1
          i32.add
          call $0
          local.get 3
          i32.load
          i32.const 1
          i32.add
          local.get 4
          i32.load offset=4
          i32.const 1
          i32.add
          call $0
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
        loop (result i32) ;; label = @3
          local.get 6
          if ;; label = @4
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
            loop ;; label = @5
              local.get 7
              local.get 1
              i32.const 12
              i32.mul
              local.get 5
              i32.add
              i32.load
              i32.eq
              if ;; label = @6
                local.get 1
                i32.const 12
                i32.mul
                local.get 5
                i32.add
                i32.load offset=4
                local.get 8
                i32.load offset=4
                i32.eq
                if ;; label = @7
                  local.get 1
                  i32.const 12
                  i32.mul
                  local.get 5
                  i32.add
                  local.tee 9
                  i32.load offset=8
                  i32.const 2
                  i32.eq
                  if ;; label = @8
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
    if ;; label = @1
      i32.const 1028
      i32.load
      local.set 4
      i32.const 0
      local.set 1
      i32.const 0
      local.set 3
      loop ;; label = @2
        local.get 3
        i32.const 12
        i32.mul
        local.get 4
        i32.add
        i32.load offset=8
        i32.const 3
        i32.eq
        if ;; label = @3
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
    local.get 1
  )
   (func $#func0<r3_main> (@name "r3 main") (;0;) (type 0)
    i32.const 1048576
    i32.const 35
    i32.store8
    i32.const 1048577
    i32.const 0
    i32.store8
    i32.const 1048578
    i32.const 0
    i32.store8
    i32.const 1048579
    i32.const 0
    i32.store8
    i32.const 1048580
    i32.const 12
    i32.store8
    i32.const 1048581
    i32.const 0
    i32.store8
    i32.const 1048582
    i32.const 0
    i32.store8
    i32.const 1048583
    i32.const 0
    i32.store8
    i32.const 1048584
    i32.const 36
    i32.store8
    i32.const 1048585
    i32.const 0
    i32.store8
    i32.const 1048586
    i32.const 0
    i32.store8
    i32.const 1048587
    i32.const 0
    i32.store8
    i32.const 1048588
    i32.const 13
    i32.store8
    i32.const 1048589
    i32.const 0
    i32.store8
    i32.const 1048590
    i32.const 0
    i32.store8
    i32.const 1048591
    i32.const 0
    i32.store8
    i32.const 1048592
    i32.const 34
    i32.store8
    i32.const 1048593
    i32.const 0
    i32.store8
    i32.const 1048594
    i32.const 0
    i32.store8
    i32.const 1048595
    i32.const 0
    i32.store8
    i32.const 1048596
    i32.const 14
    i32.store8
    i32.const 1048597
    i32.const 0
    i32.store8
    i32.const 1048598
    i32.const 0
    i32.store8
    i32.const 1048599
    i32.const 0
    i32.store8
    i32.const 1048600
    i32.const 35
    i32.store8
    i32.const 1048601
    i32.const 0
    i32.store8
    i32.const 1048602
    i32.const 0
    i32.store8
    i32.const 1048603
    i32.const 0
    i32.store8
    i32.const 1048604
    i32.const 14
    i32.store8
    i32.const 1048605
    i32.const 0
    i32.store8
    i32.const 1048606
    i32.const 0
    i32.store8
    i32.const 1048607
    i32.const 0
    i32.store8
    i32.const 1048608
    i32.const 36
    i32.store8
    i32.const 1048609
    i32.const 0
    i32.store8
    i32.const 1048610
    i32.const 0
    i32.store8
    i32.const 1048611
    i32.const 0
    i32.store8
    i32.const 1048612
    i32.const 14
    i32.store8
    i32.const 1048613
    i32.const 0
    i32.store8
    i32.const 1048614
    i32.const 0
    i32.store8
    i32.const 1048615
    i32.const 0
    i32.store8
    i32.const 1048576
    i32.const 1258272
    i32.const 5
    call $1
    drop
    i32.const 1048576
    i32.const 1258272
    i32.const 5
    call $1
    drop
    return
  )
  (memory (;0;) 64 64)
  (export "_start" (func $#func0<r3_main>))
  (export "main" (func $#func0<r3_main>))
  (export "_gol" (func $1))
  (export "memory" (memory 0))
)
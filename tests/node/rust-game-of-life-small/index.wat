(module
  (type (;0;) (func (param i32 i32)))
  (type (;1;) (func (param i32 i32 i32) (result i32)))
  (type (;2;) (func (param i32 i32) (result i32)))
  (type (;3;) (func (param i32) (result i32)))
  (type (;4;) (func (param i32)))
  (type (;5;) (func (param i32 i32 i32 i32 i32)))
  (type (;6;) (func (param i32 i32 i32 i32)))
  (type (;7;) (func (param i32 i32 i32)))
  (type (;8;) (func (param i32 i32 i32 i32 i32 i32 i32 i32)))
  (type (;9;) (func (param i32 i32 i32 i32 i32 i32 i32)))
  (type (;10;) (func (param i32 i32 i32 i32) (result i32)))
  (type (;11;) (func (result i32)))
  (type (;12;) (func (param i32 i32 i32 i32 i32) (result i32)))
  (type (;13;) (func))
  (type (;14;) (func (param i32 i32 i32 i32 i32 i32) (result i32)))
  (type (;15;) (func (param i64 i32 i32) (result i32)))
  (func $_ZN103_$LT$alloc..vec..into_iter..IntoIter$LT$T$C$A$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$9size_hint17hc87a39d34c2afad0E (type 0) (param i32 i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    local.set 2
    i32.const 32
    local.set 3
    local.get 2
    local.get 3
    i32.sub
    local.set 4
    local.get 4
    global.set $__stack_pointer
    i32.const 0
    local.set 5
    i32.const 1
    local.set 6
    local.get 5
    local.get 6
    i32.and
    local.set 7
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              local.get 7
              br_if 0 (;@5;)
              local.get 1
              i32.load offset=12
              local.set 8
              local.get 1
              i32.load offset=8
              local.set 9
              i32.const 1
              local.set 10
              i32.const 1
              local.set 11
              local.get 10
              local.get 11
              i32.and
              local.set 12
              local.get 12
              br_if 2 (;@3;)
              br 1 (;@4;)
            end
            local.get 1
            i32.load offset=12
            local.set 13
            local.get 1
            i32.load offset=8
            local.set 14
            local.get 13
            local.get 14
            i32.sub
            local.set 15
            local.get 4
            local.get 15
            i32.store offset=12
            br 3 (;@1;)
          end
          i32.const 0
          local.set 16
          local.get 4
          local.get 16
          i32.store8 offset=31
          br 1 (;@2;)
        end
        i32.const 1
        local.set 17
        local.get 4
        local.get 17
        i32.store8 offset=31
      end
      local.get 4
      i32.load8_u offset=31
      local.set 18
      i32.const -1
      local.set 19
      local.get 18
      local.get 19
      i32.xor
      local.set 20
      i32.const 1
      local.set 21
      local.get 20
      local.get 21
      i32.and
      local.set 22
      block  ;; label = @2
        local.get 22
        br_if 0 (;@2;)
        local.get 8
        local.get 9
        i32.sub
        local.set 23
        i32.const 2
        local.set 24
        local.get 23
        local.get 24
        i32.shr_u
        local.set 25
        local.get 4
        local.get 25
        i32.store offset=12
        br 1 (;@1;)
      end
      i32.const 1048576
      local.set 26
      i32.const 73
      local.set 27
      i32.const 1048732
      local.set 28
      local.get 26
      local.get 27
      local.get 28
      call $_ZN4core9panicking5panic17hfd6e422134ee8ce5E
      unreachable
    end
    local.get 4
    i32.load offset=12
    local.set 29
    local.get 4
    i32.load offset=12
    local.set 30
    local.get 4
    local.get 30
    i32.store offset=20
    i32.const 1
    local.set 31
    local.get 4
    local.get 31
    i32.store offset=16
    local.get 0
    local.get 29
    i32.store
    local.get 4
    i32.load offset=16
    local.set 32
    local.get 4
    i32.load offset=20
    local.set 33
    local.get 0
    local.get 32
    i32.store offset=4
    local.get 0
    local.get 33
    i32.store offset=8
    i32.const 32
    local.set 34
    local.get 4
    local.get 34
    i32.add
    local.set 35
    local.get 35
    global.set $__stack_pointer
    return)
  (func $_ZN136_$LT$alloc..vec..Vec$LT$T$C$A$GT$$u20$as$u20$alloc..vec..spec_extend..SpecExtend$LT$T$C$alloc..vec..into_iter..IntoIter$LT$T$GT$$GT$$GT$11spec_extend17hbd39e72c4d7b47a9E (type 0) (param i32 i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    local.set 2
    i32.const 16
    local.set 3
    local.get 2
    local.get 3
    i32.sub
    local.set 4
    local.get 4
    global.set $__stack_pointer
    local.get 1
    i32.load offset=8
    local.set 5
    local.get 1
    call $_ZN4core4iter6traits10exact_size17ExactSizeIterator3len17h84b75e417f8dec48E
    local.set 6
    local.get 4
    local.get 5
    i32.store offset=8
    local.get 4
    local.get 6
    i32.store offset=12
    local.get 4
    i32.load offset=8
    local.set 7
    local.get 4
    i32.load offset=12
    local.set 8
    local.get 4
    local.get 7
    i32.store
    local.get 4
    local.get 8
    i32.store offset=4
    local.get 4
    i32.load
    local.set 9
    local.get 4
    i32.load offset=4
    local.set 10
    local.get 0
    local.get 10
    call $_ZN5alloc3vec16Vec$LT$T$C$A$GT$7reserve17h36d41c4f9b23f783E
    local.get 0
    i32.load offset=8
    local.set 11
    local.get 0
    i32.load
    local.set 12
    i32.const 2
    local.set 13
    local.get 11
    local.get 13
    i32.shl
    local.set 14
    local.get 12
    local.get 14
    i32.add
    local.set 15
    i32.const 2
    local.set 16
    local.get 10
    local.get 16
    i32.shl
    local.set 17
    local.get 15
    local.get 9
    local.get 17
    call $memcpy
    drop
    local.get 0
    i32.load offset=8
    local.set 18
    local.get 18
    local.get 10
    i32.add
    local.set 19
    local.get 0
    local.get 19
    i32.store offset=8
    local.get 1
    i32.load offset=8
    local.set 20
    local.get 1
    local.get 20
    i32.store offset=12
    local.get 1
    call $_ZN4core3ptr63drop_in_place$LT$alloc..vec..into_iter..IntoIter$LT$i32$GT$$GT$17h2eaeba7daae83c5cE
    i32.const 16
    local.set 21
    local.get 4
    local.get 21
    i32.add
    local.set 22
    local.get 22
    global.set $__stack_pointer
    return)
  (func $_ZN4core4iter6traits10exact_size17ExactSizeIterator3len17h84b75e417f8dec48E (type 3) (param i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    local.set 1
    i32.const 64
    local.set 2
    local.get 1
    local.get 2
    i32.sub
    local.set 3
    local.get 3
    global.set $__stack_pointer
    i32.const 8
    local.set 4
    local.get 3
    local.get 4
    i32.add
    local.set 5
    local.get 5
    local.set 6
    local.get 6
    local.get 0
    call $_ZN103_$LT$alloc..vec..into_iter..IntoIter$LT$T$C$A$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$9size_hint17hc87a39d34c2afad0E
    local.get 3
    i32.load offset=8
    local.set 7
    local.get 3
    i32.load offset=12
    local.set 8
    local.get 3
    i32.load offset=16
    local.set 9
    local.get 3
    local.get 8
    i32.store
    local.get 3
    local.get 9
    i32.store offset=4
    local.get 3
    local.get 7
    i32.store offset=36
    i32.const 1
    local.set 10
    local.get 3
    local.get 10
    i32.store offset=32
    local.get 3
    local.set 11
    local.get 3
    local.get 11
    i32.store offset=24
    i32.const 32
    local.set 12
    local.get 3
    local.get 12
    i32.add
    local.set 13
    local.get 13
    local.set 14
    local.get 3
    local.get 14
    i32.store offset=28
    local.get 3
    i32.load offset=24
    local.set 15
    local.get 3
    i32.load offset=28
    local.set 16
    local.get 15
    local.get 16
    call $_ZN55_$LT$T$u20$as$u20$core..option..SpecOptionPartialEq$GT$2eq17h7f8b4e8aecda0efdE
    local.set 17
    i32.const -1
    local.set 18
    local.get 17
    local.get 18
    i32.xor
    local.set 19
    i32.const 1
    local.set 20
    local.get 19
    local.get 20
    i32.and
    local.set 21
    block  ;; label = @1
      local.get 21
      br_if 0 (;@1;)
      i32.const 64
      local.set 22
      local.get 3
      local.get 22
      i32.add
      local.set 23
      local.get 23
      global.set $__stack_pointer
      local.get 7
      return
    end
    i32.const 0
    local.set 24
    local.get 3
    local.get 24
    i32.store offset=40
    i32.const 0
    local.set 25
    i32.const 40
    local.set 26
    local.get 3
    local.get 26
    i32.add
    local.set 27
    local.get 27
    local.set 28
    i32.const 1048840
    local.set 29
    local.get 25
    local.get 15
    local.get 16
    local.get 28
    local.get 29
    call $_ZN4core9panicking13assert_failed17h017c46df7e82c987E
    unreachable)
  (func $_ZN5alloc3vec16Vec$LT$T$C$A$GT$7reserve17h36d41c4f9b23f783E (type 0) (param i32 i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    local.set 2
    i32.const 16
    local.set 3
    local.get 2
    local.get 3
    i32.sub
    local.set 4
    local.get 4
    global.set $__stack_pointer
    local.get 0
    i32.load offset=8
    local.set 5
    i32.const 0
    local.set 6
    i32.const 1
    local.set 7
    local.get 6
    local.get 7
    i32.and
    local.set 8
    block  ;; label = @1
      block  ;; label = @2
        local.get 8
        br_if 0 (;@2;)
        local.get 0
        i32.load offset=4
        local.set 9
        local.get 4
        local.get 9
        i32.store offset=12
        br 1 (;@1;)
      end
      i32.const -1
      local.set 10
      local.get 4
      local.get 10
      i32.store offset=12
    end
    local.get 4
    i32.load offset=12
    local.set 11
    local.get 11
    local.get 5
    i32.sub
    local.set 12
    local.get 1
    local.set 13
    local.get 12
    local.set 14
    local.get 13
    local.get 14
    i32.gt_u
    local.set 15
    i32.const 1
    local.set 16
    local.get 15
    local.get 16
    i32.and
    local.set 17
    block  ;; label = @1
      local.get 17
      i32.eqz
      br_if 0 (;@1;)
      local.get 0
      local.get 5
      local.get 1
      call $_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$7reserve21do_reserve_and_handle17h66dec1479853b234E
    end
    i32.const 16
    local.set 18
    local.get 4
    local.get 18
    i32.add
    local.set 19
    local.get 19
    global.set $__stack_pointer
    return)
  (func $_ZN4core3ptr63drop_in_place$LT$alloc..vec..into_iter..IntoIter$LT$i32$GT$$GT$17h2eaeba7daae83c5cE (type 4) (param i32)
    local.get 0
    call $_ZN86_$LT$alloc..vec..into_iter..IntoIter$LT$T$C$A$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17h92e1064b238199ddE
    return)
  (func $_ZN137_$LT$alloc..vec..Vec$LT$T$GT$$u20$as$u20$alloc..vec..spec_from_iter..SpecFromIter$LT$T$C$alloc..vec..into_iter..IntoIter$LT$T$GT$$GT$$GT$9from_iter17ha5a2ceb06e6ace2dE (type 0) (param i32 i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i64 i32 i32 i32 i64 i32 i32 i32 i32 i32 i32 i64 i32 i32 i32 i32 i32 i32 i32 i32 i64 i32 i32 i32 i64 i32 i32 i32 i32 i32 i32 i32 i64 i64 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    local.set 2
    i32.const 96
    local.set 3
    local.get 2
    local.get 3
    i32.sub
    local.set 4
    local.get 4
    global.set $__stack_pointer
    local.get 1
    i32.load
    local.set 5
    local.get 1
    i32.load offset=8
    local.set 6
    local.get 5
    local.set 7
    local.get 6
    local.set 8
    local.get 7
    local.get 8
    i32.ne
    local.set 9
    i32.const -1
    local.set 10
    local.get 9
    local.get 10
    i32.xor
    local.set 11
    i32.const 1
    local.set 12
    local.get 11
    local.get 12
    i32.and
    local.set 13
    block  ;; label = @1
      block  ;; label = @2
        local.get 13
        br_if 0 (;@2;)
        local.get 1
        call $_ZN4core4iter6traits10exact_size17ExactSizeIterator3len17h84b75e417f8dec48E
        local.set 14
        local.get 1
        i32.load offset=4
        local.set 15
        i32.const 1
        local.set 16
        local.get 15
        local.get 16
        i32.shr_u
        local.set 17
        local.get 14
        local.set 18
        local.get 17
        local.set 19
        local.get 18
        local.get 19
        i32.ge_u
        local.set 20
        i32.const 1
        local.set 21
        local.get 20
        local.get 21
        i32.and
        local.set 22
        local.get 4
        local.get 22
        i32.store8 offset=15
        br 1 (;@1;)
      end
      i32.const 1
      local.set 23
      local.get 4
      local.get 23
      i32.store8 offset=15
    end
    local.get 4
    i32.load8_u offset=15
    local.set 24
    i32.const 1
    local.set 25
    local.get 24
    local.get 25
    i32.and
    local.set 26
    block  ;; label = @1
      block  ;; label = @2
        local.get 26
        br_if 0 (;@2;)
        i32.const 4
        local.set 27
        local.get 4
        local.get 27
        i32.store offset=48
        i32.const 0
        local.set 28
        local.get 4
        local.get 28
        i32.store offset=52
        i32.const 0
        local.set 29
        local.get 4
        local.get 29
        i32.store offset=56
        i32.const 8
        local.set 30
        local.get 1
        local.get 30
        i32.add
        local.set 31
        local.get 31
        i64.load align=4
        local.set 32
        i32.const 64
        local.set 33
        local.get 4
        local.get 33
        i32.add
        local.set 34
        local.get 34
        local.get 30
        i32.add
        local.set 35
        local.get 35
        local.get 32
        i64.store
        local.get 1
        i64.load align=4
        local.set 36
        local.get 4
        local.get 36
        i64.store offset=64
        i32.const 48
        local.set 37
        local.get 4
        local.get 37
        i32.add
        local.set 38
        local.get 38
        local.set 39
        i32.const 64
        local.set 40
        local.get 4
        local.get 40
        i32.add
        local.set 41
        local.get 41
        local.set 42
        local.get 39
        local.get 42
        call $_ZN136_$LT$alloc..vec..Vec$LT$T$C$A$GT$$u20$as$u20$alloc..vec..spec_extend..SpecExtend$LT$T$C$alloc..vec..into_iter..IntoIter$LT$T$GT$$GT$$GT$11spec_extend17hbd39e72c4d7b47a9E
        local.get 4
        i64.load offset=48
        local.set 43
        local.get 0
        local.get 43
        i64.store align=4
        i32.const 8
        local.set 44
        local.get 0
        local.get 44
        i32.add
        local.set 45
        i32.const 48
        local.set 46
        local.get 4
        local.get 46
        i32.add
        local.set 47
        local.get 47
        local.get 44
        i32.add
        local.set 48
        local.get 48
        i32.load
        local.set 49
        local.get 45
        local.get 49
        i32.store
        br 1 (;@1;)
      end
      i32.const 8
      local.set 50
      local.get 1
      local.get 50
      i32.add
      local.set 51
      local.get 51
      i64.load align=4
      local.set 52
      i32.const 32
      local.set 53
      local.get 4
      local.get 53
      i32.add
      local.set 54
      local.get 54
      local.get 50
      i32.add
      local.set 55
      local.get 55
      local.get 52
      i64.store
      local.get 1
      i64.load align=4
      local.set 56
      local.get 4
      local.get 56
      i64.store offset=32
      i32.const 8
      local.set 57
      i32.const 16
      local.set 58
      local.get 4
      local.get 58
      i32.add
      local.set 59
      local.get 59
      local.get 57
      i32.add
      local.set 60
      i32.const 32
      local.set 61
      local.get 4
      local.get 61
      i32.add
      local.set 62
      local.get 62
      local.get 57
      i32.add
      local.set 63
      local.get 63
      i64.load
      local.set 64
      local.get 60
      local.get 64
      i64.store
      local.get 4
      i64.load offset=32
      local.set 65
      local.get 4
      local.get 65
      i64.store offset=16
      i32.const 1
      local.set 66
      local.get 9
      local.get 66
      i32.and
      local.set 67
      block  ;; label = @2
        local.get 67
        i32.eqz
        br_if 0 (;@2;)
        local.get 4
        i32.load offset=24
        local.set 68
        local.get 4
        i32.load offset=16
        local.set 69
        i32.const 16
        local.set 70
        local.get 4
        local.get 70
        i32.add
        local.set 71
        local.get 71
        local.set 72
        local.get 72
        call $_ZN4core4iter6traits10exact_size17ExactSizeIterator3len17h84b75e417f8dec48E
        local.set 73
        i32.const 2
        local.set 74
        local.get 73
        local.get 74
        i32.shl
        local.set 75
        local.get 69
        local.get 68
        local.get 75
        call $memmove
        drop
      end
      local.get 4
      i32.load offset=16
      local.set 76
      i32.const 16
      local.set 77
      local.get 4
      local.get 77
      i32.add
      local.set 78
      local.get 78
      local.set 79
      local.get 79
      call $_ZN4core4iter6traits10exact_size17ExactSizeIterator3len17h84b75e417f8dec48E
      local.set 80
      local.get 4
      i32.load offset=20
      local.set 81
      local.get 4
      local.get 76
      i32.store offset=92
      local.get 4
      i32.load offset=92
      local.set 82
      local.get 4
      local.get 82
      i32.store offset=88
      local.get 4
      i32.load offset=88
      local.set 83
      local.get 4
      local.get 83
      i32.store offset=80
      local.get 4
      local.get 81
      i32.store offset=84
      local.get 4
      i32.load offset=80
      local.set 84
      local.get 4
      i32.load offset=84
      local.set 85
      local.get 0
      local.get 84
      i32.store
      local.get 0
      local.get 85
      i32.store offset=4
      local.get 0
      local.get 80
      i32.store offset=8
    end
    i32.const 96
    local.set 86
    local.get 4
    local.get 86
    i32.add
    local.set 87
    local.get 87
    global.set $__stack_pointer
    return)
  (func $_ZN157_$LT$$LT$alloc..vec..into_iter..IntoIter$LT$T$C$A$GT$$u20$as$u20$core..ops..drop..Drop$GT$..drop..DropGuard$LT$T$C$A$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17h7edcb5b6b57fc7a3E (type 4) (param i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    local.set 1
    i32.const 16
    local.set 2
    local.get 1
    local.get 2
    i32.sub
    local.set 3
    local.get 3
    global.set $__stack_pointer
    local.get 0
    i32.load
    local.set 4
    local.get 4
    i32.load
    local.set 5
    local.get 0
    i32.load
    local.set 6
    local.get 6
    i32.load offset=4
    local.set 7
    local.get 3
    local.get 5
    i32.store offset=12
    local.get 3
    i32.load offset=12
    local.set 8
    local.get 3
    local.get 8
    i32.store offset=8
    local.get 3
    i32.load offset=8
    local.set 9
    local.get 3
    local.get 9
    i32.store
    local.get 3
    local.get 7
    i32.store offset=4
    local.get 3
    local.set 10
    local.get 10
    call $_ZN4core3ptr54drop_in_place$LT$alloc..raw_vec..RawVec$LT$i32$GT$$GT$17ha34b821272ad03edE
    i32.const 16
    local.set 11
    local.get 3
    local.get 11
    i32.add
    local.set 12
    local.get 12
    global.set $__stack_pointer
    return)
  (func $_ZN4core3ptr54drop_in_place$LT$alloc..raw_vec..RawVec$LT$i32$GT$$GT$17ha34b821272ad03edE (type 4) (param i32)
    local.get 0
    call $_ZN77_$LT$alloc..raw_vec..RawVec$LT$T$C$A$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17h759d778245c9e6f0E
    return)
  (func $_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h13faa5d10322b428E (type 2) (param i32 i32) (result i32)
    (local i32 i32 i32 i32)
    local.get 0
    i32.load
    local.set 2
    local.get 2
    local.get 1
    call $_ZN66_$LT$core..option..Option$LT$T$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17h9aedc6a084bd3f23E
    local.set 3
    i32.const 1
    local.set 4
    local.get 3
    local.get 4
    i32.and
    local.set 5
    local.get 5
    return)
  (func $_ZN66_$LT$core..option..Option$LT$T$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17h9aedc6a084bd3f23E (type 2) (param i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    local.set 2
    i32.const 16
    local.set 3
    local.get 2
    local.get 3
    i32.sub
    local.set 4
    local.get 4
    global.set $__stack_pointer
    local.get 0
    i32.load
    local.set 5
    block  ;; label = @1
      block  ;; label = @2
        local.get 5
        br_if 0 (;@2;)
        i32.const 1049004
        local.set 6
        i32.const 4
        local.set 7
        local.get 1
        local.get 6
        local.get 7
        call $_ZN4core3fmt9Formatter9write_str17h913e84d04ade0affE
        local.set 8
        i32.const 1
        local.set 9
        local.get 8
        local.get 9
        i32.and
        local.set 10
        local.get 4
        local.get 10
        i32.store8 offset=11
        br 1 (;@1;)
      end
      i32.const 4
      local.set 11
      local.get 0
      local.get 11
      i32.add
      local.set 12
      local.get 4
      local.get 12
      i32.store offset=12
      i32.const 1049008
      local.set 13
      i32.const 4
      local.set 14
      i32.const 12
      local.set 15
      local.get 4
      local.get 15
      i32.add
      local.set 16
      local.get 16
      local.set 17
      i32.const 1049012
      local.set 18
      local.get 1
      local.get 13
      local.get 14
      local.get 17
      local.get 18
      call $_ZN4core3fmt9Formatter25debug_tuple_field1_finish17h698cdec2464637e7E
      local.set 19
      i32.const 1
      local.set 20
      local.get 19
      local.get 20
      i32.and
      local.set 21
      local.get 4
      local.get 21
      i32.store8 offset=11
    end
    local.get 4
    i32.load8_u offset=11
    local.set 22
    i32.const 1
    local.set 23
    local.get 22
    local.get 23
    i32.and
    local.set 24
    i32.const 16
    local.set 25
    local.get 4
    local.get 25
    i32.add
    local.set 26
    local.get 26
    global.set $__stack_pointer
    local.get 24
    return)
  (func $_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h9a61fbf71f30f14cE (type 2) (param i32 i32) (result i32)
    (local i32 i32 i32 i32)
    local.get 0
    i32.load
    local.set 2
    local.get 2
    local.get 1
    call $_ZN4core3fmt3num52_$LT$impl$u20$core..fmt..Debug$u20$for$u20$usize$GT$3fmt17hfd646b8ec5427dddE
    local.set 3
    i32.const 1
    local.set 4
    local.get 3
    local.get 4
    i32.and
    local.set 5
    local.get 5
    return)
  (func $_ZN4core3fmt3num52_$LT$impl$u20$core..fmt..Debug$u20$for$u20$usize$GT$3fmt17hfd646b8ec5427dddE (type 2) (param i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    local.set 2
    i32.const 16
    local.set 3
    local.get 2
    local.get 3
    i32.sub
    local.set 4
    local.get 4
    global.set $__stack_pointer
    local.get 1
    call $_ZN4core3fmt9Formatter15debug_lower_hex17hd51e792cf83d3430E
    local.set 5
    i32.const 1
    local.set 6
    local.get 5
    local.get 6
    i32.and
    local.set 7
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              local.get 7
              br_if 0 (;@5;)
              local.get 1
              call $_ZN4core3fmt9Formatter15debug_upper_hex17h5d875fa48567936bE
              local.set 8
              i32.const 1
              local.set 9
              local.get 8
              local.get 9
              i32.and
              local.set 10
              local.get 10
              br_if 2 (;@3;)
              br 1 (;@4;)
            end
            local.get 0
            local.get 1
            call $_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$i32$GT$3fmt17hb34825256926739cE
            local.set 11
            i32.const 1
            local.set 12
            local.get 11
            local.get 12
            i32.and
            local.set 13
            local.get 4
            local.get 13
            i32.store8 offset=15
            br 3 (;@1;)
          end
          local.get 0
          local.get 1
          call $_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$u32$GT$3fmt17hbaa66a6ca3ee12c8E
          local.set 14
          i32.const 1
          local.set 15
          local.get 14
          local.get 15
          i32.and
          local.set 16
          local.get 4
          local.get 16
          i32.store8 offset=15
          br 1 (;@2;)
        end
        local.get 0
        local.get 1
        call $_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..UpperHex$u20$for$u20$i32$GT$3fmt17h59090ba5de968a5dE
        local.set 17
        i32.const 1
        local.set 18
        local.get 17
        local.get 18
        i32.and
        local.set 19
        local.get 4
        local.get 19
        i32.store8 offset=15
      end
    end
    local.get 4
    i32.load8_u offset=15
    local.set 20
    i32.const 1
    local.set 21
    local.get 20
    local.get 21
    i32.and
    local.set 22
    i32.const 16
    local.set 23
    local.get 4
    local.get 23
    i32.add
    local.set 24
    local.get 24
    global.set $__stack_pointer
    local.get 22
    return)
  (func $_ZN4core3cmp5impls50_$LT$impl$u20$core..cmp..Ord$u20$for$u20$usize$GT$3cmp17hf378a3b27c6a4c02E (type 2) (param i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    local.set 2
    i32.const 16
    local.set 3
    local.get 2
    local.get 3
    i32.sub
    local.set 4
    local.get 0
    i32.load
    local.set 5
    local.get 1
    i32.load
    local.set 6
    local.get 5
    local.set 7
    local.get 6
    local.set 8
    local.get 7
    local.get 8
    i32.lt_u
    local.set 9
    i32.const 1
    local.set 10
    local.get 9
    local.get 10
    i32.and
    local.set 11
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              local.get 11
              br_if 0 (;@5;)
              local.get 0
              i32.load
              local.set 12
              local.get 1
              i32.load
              local.set 13
              local.get 12
              local.set 14
              local.get 13
              local.set 15
              local.get 14
              local.get 15
              i32.eq
              local.set 16
              i32.const 1
              local.set 17
              local.get 16
              local.get 17
              i32.and
              local.set 18
              local.get 18
              br_if 2 (;@3;)
              br 1 (;@4;)
            end
            i32.const 255
            local.set 19
            local.get 4
            local.get 19
            i32.store8 offset=15
            br 3 (;@1;)
          end
          i32.const 1
          local.set 20
          local.get 4
          local.get 20
          i32.store8 offset=15
          br 1 (;@2;)
        end
        i32.const 0
        local.set 21
        local.get 4
        local.get 21
        i32.store8 offset=15
      end
    end
    local.get 4
    i32.load8_u offset=15
    local.set 22
    local.get 22
    return)
  (func $_ZN4core3cmp5impls56_$LT$impl$u20$core..cmp..PartialEq$u20$for$u20$usize$GT$2eq17h40e449a5d6d99e91E (type 2) (param i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32)
    local.get 0
    i32.load
    local.set 2
    local.get 1
    i32.load
    local.set 3
    local.get 2
    local.set 4
    local.get 3
    local.set 5
    local.get 4
    local.get 5
    i32.eq
    local.set 6
    i32.const 1
    local.set 7
    local.get 6
    local.get 7
    i32.and
    local.set 8
    local.get 8
    return)
  (func $_ZN4core3cmp6max_by17h2f68f711d6289889E (type 2) (param i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    local.set 2
    i32.const 32
    local.set 3
    local.get 2
    local.get 3
    i32.sub
    local.set 4
    local.get 4
    global.set $__stack_pointer
    local.get 4
    local.get 0
    i32.store
    local.get 4
    local.get 1
    i32.store offset=4
    i32.const 1
    local.set 5
    local.get 4
    local.get 5
    i32.store8 offset=31
    local.get 4
    local.get 5
    i32.store8 offset=30
    local.get 4
    local.get 4
    i32.store offset=16
    i32.const 4
    local.set 6
    local.get 4
    local.get 6
    i32.add
    local.set 7
    local.get 4
    local.get 7
    i32.store offset=20
    local.get 4
    i32.load offset=16
    local.set 8
    local.get 4
    i32.load offset=20
    local.set 9
    local.get 8
    local.get 9
    call $_ZN4core3ops8function6FnOnce9call_once17h3ce8a9a00f530154E
    local.set 10
    local.get 4
    local.get 10
    i32.store8 offset=15
    local.get 4
    i32.load8_u offset=15
    local.set 11
    local.get 11
    local.get 5
    i32.add
    local.set 12
    i32.const 255
    local.set 13
    local.get 12
    local.get 13
    i32.and
    local.set 14
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          local.get 14
          br_table 0 (;@3;) 0 (;@3;) 1 (;@2;) 0 (;@3;)
        end
        i32.const 0
        local.set 15
        local.get 4
        local.get 15
        i32.store8 offset=30
        local.get 4
        i32.load offset=4
        local.set 16
        local.get 4
        local.get 16
        i32.store offset=8
        br 1 (;@1;)
      end
      i32.const 0
      local.set 17
      local.get 4
      local.get 17
      i32.store8 offset=31
      local.get 4
      i32.load
      local.set 18
      local.get 4
      local.get 18
      i32.store offset=8
    end
    local.get 4
    i32.load8_u offset=30
    local.set 19
    i32.const 1
    local.set 20
    local.get 19
    local.get 20
    i32.and
    local.set 21
    block  ;; label = @1
      local.get 21
      i32.eqz
      br_if 0 (;@1;)
    end
    local.get 4
    i32.load8_u offset=31
    local.set 22
    i32.const 1
    local.set 23
    local.get 22
    local.get 23
    i32.and
    local.set 24
    block  ;; label = @1
      local.get 24
      i32.eqz
      br_if 0 (;@1;)
    end
    local.get 4
    i32.load offset=8
    local.set 25
    i32.const 32
    local.set 26
    local.get 4
    local.get 26
    i32.add
    local.set 27
    local.get 27
    global.set $__stack_pointer
    local.get 25
    return
    unreachable)
  (func $_ZN4core3ops8function6FnOnce9call_once17h3ce8a9a00f530154E (type 2) (param i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    local.set 2
    i32.const 16
    local.set 3
    local.get 2
    local.get 3
    i32.sub
    local.set 4
    local.get 4
    global.set $__stack_pointer
    local.get 4
    local.get 0
    i32.store offset=8
    local.get 4
    local.get 1
    i32.store offset=12
    local.get 4
    i32.load offset=8
    local.set 5
    local.get 4
    i32.load offset=12
    local.set 6
    local.get 5
    local.get 6
    call $_ZN4core3cmp5impls50_$LT$impl$u20$core..cmp..Ord$u20$for$u20$usize$GT$3cmp17hf378a3b27c6a4c02E
    local.set 7
    i32.const 16
    local.set 8
    local.get 4
    local.get 8
    i32.add
    local.set 9
    local.get 9
    global.set $__stack_pointer
    local.get 7
    return)
  (func $_ZN4core3ptr157drop_in_place$LT$$LT$alloc..vec..into_iter..IntoIter$LT$T$C$A$GT$$u20$as$u20$core..ops..drop..Drop$GT$..drop..DropGuard$LT$i32$C$alloc..alloc..Global$GT$$GT$17hb9f760554938bde0E (type 4) (param i32)
    local.get 0
    call $_ZN157_$LT$$LT$alloc..vec..into_iter..IntoIter$LT$T$C$A$GT$$u20$as$u20$core..ops..drop..Drop$GT$..drop..DropGuard$LT$T$C$A$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17h7edcb5b6b57fc7a3E
    return)
  (func $_ZN4core3ptr30drop_in_place$LT$$RF$usize$GT$17h83c3e7ffb678b72fE (type 4) (param i32)
    return)
  (func $_ZN77_$LT$alloc..raw_vec..RawVec$LT$T$C$A$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17h759d778245c9e6f0E (type 4) (param i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    local.set 1
    i32.const 16
    local.set 2
    local.get 1
    local.get 2
    i32.sub
    local.set 3
    local.get 3
    global.set $__stack_pointer
    local.get 3
    local.set 4
    local.get 4
    local.get 0
    call $_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$14current_memory17h9e5ff513db5d2e36E
    local.get 3
    i32.load offset=4
    local.set 5
    i32.const 0
    local.set 6
    i32.const 1
    local.set 7
    local.get 7
    local.get 6
    local.get 5
    select
    local.set 8
    i32.const 1
    local.set 9
    local.get 8
    local.set 10
    local.get 9
    local.set 11
    local.get 10
    local.get 11
    i32.eq
    local.set 12
    i32.const 1
    local.set 13
    local.get 12
    local.get 13
    i32.and
    local.set 14
    block  ;; label = @1
      local.get 14
      i32.eqz
      br_if 0 (;@1;)
      local.get 3
      i32.load
      local.set 15
      local.get 3
      i32.load offset=4
      local.set 16
      local.get 3
      i32.load offset=8
      local.set 17
      local.get 0
      local.get 15
      local.get 16
      local.get 17
      call $_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17ha34b8860f87e0fefE
    end
    i32.const 16
    local.set 18
    local.get 3
    local.get 18
    i32.add
    local.set 19
    local.get 19
    global.set $__stack_pointer
    return)
  (func $_ZN4core3ptr58drop_in_place$LT$$RF$core..option..Option$LT$usize$GT$$GT$17h31251f026af8b027E (type 4) (param i32)
    return)
  (func $_ZN86_$LT$alloc..vec..into_iter..IntoIter$LT$T$C$A$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17h92e1064b238199ddE (type 4) (param i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    local.set 1
    i32.const 16
    local.set 2
    local.get 1
    local.get 2
    i32.sub
    local.set 3
    local.get 3
    global.set $__stack_pointer
    local.get 3
    local.get 0
    i32.store offset=12
    local.get 3
    i32.load offset=12
    local.set 4
    local.get 3
    local.get 4
    call $_ZN5alloc3vec9into_iter21IntoIter$LT$T$C$A$GT$16as_raw_mut_slice17h2898f5287e33546fE
    local.get 3
    i32.load offset=4
    drop
    local.get 3
    i32.load
    drop
    i32.const 12
    local.set 5
    local.get 3
    local.get 5
    i32.add
    local.set 6
    local.get 6
    local.set 7
    local.get 7
    call $_ZN4core3ptr157drop_in_place$LT$$LT$alloc..vec..into_iter..IntoIter$LT$T$C$A$GT$$u20$as$u20$core..ops..drop..Drop$GT$..drop..DropGuard$LT$i32$C$alloc..alloc..Global$GT$$GT$17hb9f760554938bde0E
    i32.const 16
    local.set 8
    local.get 3
    local.get 8
    i32.add
    local.set 9
    local.get 9
    global.set $__stack_pointer
    return)
  (func $_ZN55_$LT$T$u20$as$u20$core..option..SpecOptionPartialEq$GT$2eq17h7f8b4e8aecda0efdE (type 2) (param i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    local.set 2
    i32.const 16
    local.set 3
    local.get 2
    local.get 3
    i32.sub
    local.set 4
    local.get 4
    global.set $__stack_pointer
    local.get 4
    local.get 0
    i32.store offset=8
    local.get 4
    local.get 1
    i32.store offset=12
    local.get 4
    i32.load offset=8
    local.set 5
    local.get 5
    i32.load
    local.set 6
    i32.const 1
    local.set 7
    local.get 6
    local.get 7
    i32.gt_u
    drop
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            local.get 6
            br_table 0 (;@4;) 1 (;@3;) 2 (;@2;)
          end
          local.get 4
          i32.load offset=12
          local.set 8
          local.get 8
          i32.load
          local.set 9
          i32.const 0
          local.set 10
          local.get 9
          local.set 11
          local.get 10
          local.set 12
          local.get 11
          local.get 12
          i32.eq
          local.set 13
          i32.const 1
          local.set 14
          local.get 13
          local.get 14
          i32.and
          local.set 15
          local.get 4
          local.get 15
          i32.store8 offset=7
          br 2 (;@1;)
        end
        local.get 4
        i32.load offset=12
        local.set 16
        local.get 16
        i32.load
        local.set 17
        i32.const 1
        local.set 18
        local.get 17
        local.set 19
        local.get 18
        local.set 20
        local.get 19
        local.get 20
        i32.eq
        local.set 21
        i32.const 1
        local.set 22
        local.get 21
        local.get 22
        i32.and
        local.set 23
        local.get 23
        i32.eqz
        br_if 0 (;@2;)
        local.get 4
        i32.load offset=8
        local.set 24
        i32.const 4
        local.set 25
        local.get 24
        local.get 25
        i32.add
        local.set 26
        local.get 4
        i32.load offset=12
        local.set 27
        i32.const 4
        local.set 28
        local.get 27
        local.get 28
        i32.add
        local.set 29
        local.get 26
        local.get 29
        call $_ZN4core3cmp5impls56_$LT$impl$u20$core..cmp..PartialEq$u20$for$u20$usize$GT$2eq17h40e449a5d6d99e91E
        local.set 30
        i32.const 1
        local.set 31
        local.get 30
        local.get 31
        i32.and
        local.set 32
        local.get 4
        local.get 32
        i32.store8 offset=7
        br 1 (;@1;)
      end
      i32.const 0
      local.set 33
      local.get 4
      local.get 33
      i32.store8 offset=7
    end
    local.get 4
    i32.load8_u offset=7
    local.set 34
    i32.const 1
    local.set 35
    local.get 34
    local.get 35
    i32.and
    local.set 36
    i32.const 16
    local.set 37
    local.get 4
    local.get 37
    i32.add
    local.set 38
    local.get 38
    global.set $__stack_pointer
    local.get 36
    return)
  (func $_ZN4core9panicking13assert_failed17h017c46df7e82c987E (type 5) (param i32 i32 i32 i32 i32)
    (local i32 i32 i32 i32 i32 i64 i32 i32 i32 i32 i32 i64 i32 i32 i32 i64 i32 i32 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    local.set 5
    i32.const 32
    local.set 6
    local.get 5
    local.get 6
    i32.sub
    local.set 7
    local.get 7
    global.set $__stack_pointer
    local.get 7
    local.get 1
    i32.store
    local.get 7
    local.get 2
    i32.store offset=4
    i32.const 16
    local.set 8
    local.get 3
    local.get 8
    i32.add
    local.set 9
    local.get 9
    i64.load align=4
    local.set 10
    i32.const 8
    local.set 11
    local.get 7
    local.get 11
    i32.add
    local.set 12
    local.get 12
    local.get 8
    i32.add
    local.set 13
    local.get 13
    local.get 10
    i64.store
    i32.const 8
    local.set 14
    local.get 3
    local.get 14
    i32.add
    local.set 15
    local.get 15
    i64.load align=4
    local.set 16
    i32.const 8
    local.set 17
    local.get 7
    local.get 17
    i32.add
    local.set 18
    local.get 18
    local.get 14
    i32.add
    local.set 19
    local.get 19
    local.get 16
    i64.store
    local.get 3
    i64.load align=4
    local.set 20
    local.get 7
    local.get 20
    i64.store offset=8
    local.get 7
    local.set 21
    i32.const 1048988
    local.set 22
    i32.const 4
    local.set 23
    local.get 7
    local.get 23
    i32.add
    local.set 24
    local.get 24
    local.set 25
    i32.const 8
    local.set 26
    local.get 7
    local.get 26
    i32.add
    local.set 27
    local.get 27
    local.set 28
    local.get 0
    local.get 21
    local.get 22
    local.get 25
    local.get 22
    local.get 28
    local.get 4
    call $_ZN4core9panicking19assert_failed_inner17hb22561d3158be3eaE
    unreachable)
  (func $_ZN4core4iter6traits8iterator8Iterator7collect17h17e168441d961b83E (type 0) (param i32 i32)
    local.get 0
    local.get 1
    call $_ZN95_$LT$alloc..vec..Vec$LT$T$GT$$u20$as$u20$core..iter..traits..collect..FromIterator$LT$T$GT$$GT$9from_iter17hf3d6f19b896b4ff5E
    return)
  (func $_ZN95_$LT$alloc..vec..Vec$LT$T$GT$$u20$as$u20$core..iter..traits..collect..FromIterator$LT$T$GT$$GT$9from_iter17hf3d6f19b896b4ff5E (type 0) (param i32 i32)
    (local i32 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    local.set 2
    i32.const 16
    local.set 3
    local.get 2
    local.get 3
    i32.sub
    local.set 4
    local.get 4
    global.set $__stack_pointer
    local.get 4
    local.set 5
    local.get 5
    local.get 1
    call $_ZN63_$LT$I$u20$as$u20$core..iter..traits..collect..IntoIterator$GT$9into_iter17hc9ff7e0c46c769b9E
    local.get 4
    local.set 6
    local.get 0
    local.get 6
    call $_ZN137_$LT$alloc..vec..Vec$LT$T$GT$$u20$as$u20$alloc..vec..spec_from_iter..SpecFromIter$LT$T$C$alloc..vec..into_iter..IntoIter$LT$T$GT$$GT$$GT$9from_iter17ha5a2ceb06e6ace2dE
    i32.const 16
    local.set 7
    local.get 4
    local.get 7
    i32.add
    local.set 8
    local.get 8
    global.set $__stack_pointer
    return)
  (func $_ZN4core5alloc6layout6Layout5array5inner17hfbb2edc59de7921aE (type 6) (param i32 i32 i32 i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    local.set 4
    i32.const 32
    local.set 5
    local.get 4
    local.get 5
    i32.sub
    local.set 6
    local.get 6
    global.set $__stack_pointer
    block  ;; label = @1
      block  ;; label = @2
        local.get 1
        br_if 0 (;@2;)
        i32.const 0
        local.set 7
        local.get 6
        local.get 7
        i32.store8 offset=15
        br 1 (;@1;)
      end
      local.get 6
      local.get 2
      i32.store offset=24
      local.get 6
      i32.load offset=24
      local.set 8
      i32.const 1
      local.set 9
      local.get 8
      local.get 9
      i32.sub
      local.set 10
      i32.const 2147483647
      local.set 11
      local.get 11
      local.get 10
      i32.sub
      local.set 12
      i32.const 0
      local.set 13
      local.get 1
      local.set 14
      local.get 13
      local.set 15
      local.get 14
      local.get 15
      i32.eq
      local.set 16
      i32.const 1
      local.set 17
      local.get 16
      local.get 17
      i32.and
      local.set 18
      block  ;; label = @2
        local.get 18
        br_if 0 (;@2;)
        local.get 12
        local.get 1
        i32.div_u
        local.set 19
        local.get 3
        local.set 20
        local.get 19
        local.set 21
        local.get 20
        local.get 21
        i32.gt_u
        local.set 22
        i32.const 1
        local.set 23
        local.get 22
        local.get 23
        i32.and
        local.set 24
        local.get 6
        local.get 24
        i32.store8 offset=15
        br 1 (;@1;)
      end
      i32.const 1048960
      local.set 25
      i32.const 25
      local.set 26
      i32.const 1048936
      local.set 27
      local.get 25
      local.get 26
      local.get 27
      call $_ZN4core9panicking5panic17hfd6e422134ee8ce5E
      unreachable
    end
    local.get 6
    i32.load8_u offset=15
    local.set 28
    i32.const 1
    local.set 29
    local.get 28
    local.get 29
    i32.and
    local.set 30
    block  ;; label = @1
      block  ;; label = @2
        local.get 30
        br_if 0 (;@2;)
        local.get 1
        local.get 3
        i32.mul
        local.set 31
        local.get 6
        local.get 2
        i32.store offset=28
        local.get 6
        i32.load offset=28
        local.set 32
        local.get 6
        local.get 31
        i32.store offset=20
        local.get 6
        local.get 32
        i32.store offset=16
        local.get 6
        i32.load offset=16
        local.set 33
        local.get 6
        i32.load offset=20
        local.set 34
        local.get 6
        local.get 33
        i32.store
        local.get 6
        local.get 34
        i32.store offset=4
        br 1 (;@1;)
      end
      i32.const 0
      local.set 35
      local.get 6
      local.get 35
      i32.store
    end
    local.get 6
    i32.load
    local.set 36
    local.get 6
    i32.load offset=4
    local.set 37
    local.get 0
    local.get 37
    i32.store offset=4
    local.get 0
    local.get 36
    i32.store
    i32.const 32
    local.set 38
    local.get 6
    local.get 38
    i32.add
    local.set 39
    local.get 39
    global.set $__stack_pointer
    return)
  (func $_ZN4core6result19Result$LT$T$C$E$GT$7map_err17h39f39cc027ebcfa6E (type 7) (param i32 i32 i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    local.set 3
    i32.const 48
    local.set 4
    local.get 3
    local.get 4
    i32.sub
    local.set 5
    local.get 5
    global.set $__stack_pointer
    local.get 5
    local.get 1
    i32.store offset=16
    local.get 5
    local.get 2
    i32.store offset=20
    i32.const 1
    local.set 6
    local.get 5
    local.get 6
    i32.store8 offset=47
    local.get 5
    i32.load offset=16
    local.set 7
    i32.const -2147483647
    local.set 8
    local.get 7
    local.set 9
    local.get 8
    local.set 10
    local.get 9
    local.get 10
    i32.eq
    local.set 11
    i32.const 0
    local.set 12
    i32.const 1
    local.set 13
    i32.const 1
    local.set 14
    local.get 11
    local.get 14
    i32.and
    local.set 15
    local.get 12
    local.get 13
    local.get 15
    select
    local.set 16
    block  ;; label = @1
      block  ;; label = @2
        local.get 16
        br_if 0 (;@2;)
        i32.const -2147483647
        local.set 17
        local.get 5
        local.get 17
        i32.store offset=24
        br 1 (;@1;)
      end
      local.get 5
      i32.load offset=16
      local.set 18
      local.get 5
      i32.load offset=20
      local.set 19
      i32.const 0
      local.set 20
      local.get 5
      local.get 20
      i32.store8 offset=47
      local.get 5
      local.get 18
      i32.store offset=32
      local.get 5
      local.get 19
      i32.store offset=36
      local.get 5
      i32.load offset=32
      local.set 21
      local.get 5
      i32.load offset=36
      local.set 22
      i32.const 8
      local.set 23
      local.get 5
      local.get 23
      i32.add
      local.set 24
      local.get 24
      local.get 21
      local.get 22
      call $_ZN5alloc7raw_vec14handle_reserve28_$u7b$$u7b$closure$u7d$$u7d$17he83bbe062444042bE
      local.get 5
      i32.load offset=12
      local.set 25
      local.get 5
      i32.load offset=8
      local.set 26
      local.get 5
      local.get 26
      i32.store offset=24
      local.get 5
      local.get 25
      i32.store offset=28
    end
    local.get 5
    i32.load8_u offset=47
    local.set 27
    i32.const 1
    local.set 28
    local.get 27
    local.get 28
    i32.and
    local.set 29
    block  ;; label = @1
      local.get 29
      i32.eqz
      br_if 0 (;@1;)
    end
    local.get 5
    i32.load offset=24
    local.set 30
    local.get 5
    i32.load offset=28
    local.set 31
    local.get 0
    local.get 31
    i32.store offset=4
    local.get 0
    local.get 30
    i32.store
    i32.const 48
    local.set 32
    local.get 5
    local.get 32
    i32.add
    local.set 33
    local.get 33
    global.set $__stack_pointer
    return)
  (func $_ZN5alloc7raw_vec14handle_reserve28_$u7b$$u7b$closure$u7d$$u7d$17he83bbe062444042bE (type 7) (param i32 i32 i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    local.set 3
    i32.const 16
    local.set 4
    local.get 3
    local.get 4
    i32.sub
    local.set 5
    local.get 5
    local.get 1
    i32.store
    local.get 5
    local.get 2
    i32.store offset=4
    local.get 5
    i32.load
    local.set 6
    i32.const 0
    local.set 7
    i32.const 1
    local.set 8
    local.get 8
    local.get 7
    local.get 6
    select
    local.set 9
    block  ;; label = @1
      block  ;; label = @2
        local.get 9
        br_if 0 (;@2;)
        i32.const 0
        local.set 10
        local.get 5
        local.get 10
        i32.store offset=8
        br 1 (;@1;)
      end
      local.get 5
      i32.load
      local.set 11
      local.get 5
      i32.load offset=4
      local.set 12
      local.get 5
      local.get 11
      i32.store offset=8
      local.get 5
      local.get 12
      i32.store offset=12
    end
    local.get 5
    i32.load offset=8
    local.set 13
    local.get 5
    i32.load offset=12
    local.set 14
    local.get 0
    local.get 14
    i32.store offset=4
    local.get 0
    local.get 13
    i32.store
    return)
  (func $_ZN4core6result19Result$LT$T$C$E$GT$7map_err17h5982f674a89010aaE (type 7) (param i32 i32 i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    local.set 3
    i32.const 32
    local.set 4
    local.get 3
    local.get 4
    i32.sub
    local.set 5
    local.get 5
    global.set $__stack_pointer
    local.get 5
    local.get 1
    i32.store offset=16
    local.get 5
    local.get 2
    i32.store offset=20
    i32.const 1
    local.set 6
    local.get 5
    local.get 6
    i32.store8 offset=31
    local.get 5
    i32.load offset=16
    local.set 7
    i32.const 1
    local.set 8
    i32.const 0
    local.set 9
    local.get 9
    local.get 8
    local.get 7
    select
    local.set 10
    block  ;; label = @1
      block  ;; label = @2
        local.get 10
        br_if 0 (;@2;)
        local.get 5
        i32.load offset=16
        local.set 11
        local.get 5
        i32.load offset=20
        local.set 12
        local.get 0
        local.get 11
        i32.store offset=4
        local.get 0
        local.get 12
        i32.store offset=8
        i32.const 0
        local.set 13
        local.get 0
        local.get 13
        i32.store
        br 1 (;@1;)
      end
      i32.const 0
      local.set 14
      local.get 5
      local.get 14
      i32.store8 offset=31
      i32.const 8
      local.set 15
      local.get 5
      local.get 15
      i32.add
      local.set 16
      local.get 16
      call $_ZN5alloc7raw_vec11finish_grow28_$u7b$$u7b$closure$u7d$$u7d$17hb1beaa90ea6ae120E
      local.get 5
      i32.load offset=12
      local.set 17
      local.get 5
      i32.load offset=8
      local.set 18
      local.get 0
      local.get 18
      i32.store offset=4
      local.get 0
      local.get 17
      i32.store offset=8
      i32.const 1
      local.set 19
      local.get 0
      local.get 19
      i32.store
    end
    local.get 5
    i32.load8_u offset=31
    local.set 20
    i32.const 1
    local.set 21
    local.get 20
    local.get 21
    i32.and
    local.set 22
    block  ;; label = @1
      local.get 22
      i32.eqz
      br_if 0 (;@1;)
    end
    i32.const 32
    local.set 23
    local.get 5
    local.get 23
    i32.add
    local.set 24
    local.get 24
    global.set $__stack_pointer
    return)
  (func $_ZN5alloc7raw_vec11finish_grow28_$u7b$$u7b$closure$u7d$$u7d$17hb1beaa90ea6ae120E (type 4) (param i32)
    (local i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    local.set 1
    i32.const 16
    local.set 2
    local.get 1
    local.get 2
    i32.sub
    local.set 3
    i32.const 0
    local.set 4
    local.get 3
    local.get 4
    i32.store offset=8
    local.get 3
    i32.load offset=8
    local.set 5
    local.get 3
    i32.load offset=12
    local.set 6
    local.get 0
    local.get 6
    i32.store offset=4
    local.get 0
    local.get 5
    i32.store
    return)
  (func $_ZN4core6result19Result$LT$T$C$E$GT$7map_err17hd2deccd7c24a623aE (type 6) (param i32 i32 i32 i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    local.set 4
    i32.const 32
    local.set 5
    local.get 4
    local.get 5
    i32.sub
    local.set 6
    local.get 6
    global.set $__stack_pointer
    local.get 6
    local.get 1
    i32.store offset=16
    local.get 6
    local.get 2
    i32.store offset=20
    i32.const 1
    local.set 7
    local.get 6
    local.get 7
    i32.store8 offset=31
    local.get 6
    i32.load offset=16
    local.set 8
    i32.const 1
    local.set 9
    i32.const 0
    local.set 10
    local.get 10
    local.get 9
    local.get 8
    select
    local.set 11
    block  ;; label = @1
      block  ;; label = @2
        local.get 11
        br_if 0 (;@2;)
        local.get 6
        i32.load offset=16
        local.set 12
        local.get 6
        i32.load offset=20
        local.set 13
        local.get 0
        local.get 12
        i32.store offset=4
        local.get 0
        local.get 13
        i32.store offset=8
        i32.const 0
        local.set 14
        local.get 0
        local.get 14
        i32.store
        br 1 (;@1;)
      end
      i32.const 0
      local.set 15
      local.get 6
      local.get 15
      i32.store8 offset=31
      i32.const 8
      local.set 16
      local.get 6
      local.get 16
      i32.add
      local.set 17
      local.get 17
      local.get 3
      call $_ZN5alloc7raw_vec11finish_grow28_$u7b$$u7b$closure$u7d$$u7d$17h74d78b02557fe2f4E
      local.get 6
      i32.load offset=12
      local.set 18
      local.get 6
      i32.load offset=8
      local.set 19
      local.get 0
      local.get 19
      i32.store offset=4
      local.get 0
      local.get 18
      i32.store offset=8
      i32.const 1
      local.set 20
      local.get 0
      local.get 20
      i32.store
    end
    local.get 6
    i32.load8_u offset=31
    local.set 21
    i32.const 1
    local.set 22
    local.get 21
    local.get 22
    i32.and
    local.set 23
    block  ;; label = @1
      local.get 23
      i32.eqz
      br_if 0 (;@1;)
    end
    i32.const 32
    local.set 24
    local.get 6
    local.get 24
    i32.add
    local.set 25
    local.get 25
    global.set $__stack_pointer
    return)
  (func $_ZN5alloc7raw_vec11finish_grow28_$u7b$$u7b$closure$u7d$$u7d$17h74d78b02557fe2f4E (type 0) (param i32 i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    local.set 2
    i32.const 32
    local.set 3
    local.get 2
    local.get 3
    i32.sub
    local.set 4
    local.get 4
    local.get 1
    i32.store offset=12
    local.get 4
    i32.load offset=12
    local.set 5
    local.get 5
    i32.load
    local.set 6
    local.get 5
    i32.load offset=4
    local.set 7
    local.get 4
    local.get 6
    i32.store offset=24
    local.get 4
    local.get 7
    i32.store offset=28
    local.get 4
    i32.load offset=24
    local.set 8
    local.get 4
    i32.load offset=28
    local.set 9
    local.get 4
    local.get 8
    i32.store offset=16
    local.get 4
    local.get 9
    i32.store offset=20
    local.get 4
    i32.load offset=16
    local.set 10
    local.get 4
    i32.load offset=20
    local.set 11
    local.get 0
    local.get 11
    i32.store offset=4
    local.get 0
    local.get 10
    i32.store
    return)
  (func $_ZN5alloc3vec12Vec$LT$T$GT$3new17h03ff6f2a4d4edaf5E (type 4) (param i32)
    (local i32 i32 i32)
    i32.const 4
    local.set 1
    local.get 0
    local.get 1
    i32.store
    i32.const 0
    local.set 2
    local.get 0
    local.get 2
    i32.store offset=4
    i32.const 0
    local.set 3
    local.get 0
    local.get 3
    i32.store offset=8
    return)
  (func $_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$7reserve21do_reserve_and_handle17h66dec1479853b234E (type 7) (param i32 i32 i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    local.set 3
    i32.const 16
    local.set 4
    local.get 3
    local.get 4
    i32.sub
    local.set 5
    local.get 5
    global.set $__stack_pointer
    i32.const 8
    local.set 6
    local.get 5
    local.get 6
    i32.add
    local.set 7
    local.get 7
    local.get 0
    local.get 1
    local.get 2
    call $_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$14grow_amortized17hd512fe9f5b7074aaE
    local.get 5
    i32.load offset=12
    local.set 8
    local.get 5
    i32.load offset=8
    local.set 9
    local.get 9
    local.get 8
    call $_ZN5alloc7raw_vec14handle_reserve17h05fd33db22a196d0E
    i32.const 16
    local.set 10
    local.get 5
    local.get 10
    i32.add
    local.set 11
    local.get 11
    global.set $__stack_pointer
    return)
  (func $_ZN5alloc3vec9into_iter21IntoIter$LT$T$C$A$GT$16as_raw_mut_slice17h2898f5287e33546fE (type 0) (param i32 i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    local.set 2
    i32.const 32
    local.set 3
    local.get 2
    local.get 3
    i32.sub
    local.set 4
    local.get 4
    global.set $__stack_pointer
    local.get 4
    local.get 1
    i32.store offset=12
    local.get 4
    i32.load offset=12
    local.set 5
    local.get 5
    i32.load offset=8
    local.set 6
    local.get 5
    call $_ZN4core4iter6traits10exact_size17ExactSizeIterator3len17h84b75e417f8dec48E
    local.set 7
    local.get 4
    local.get 6
    i32.store offset=24
    local.get 4
    local.get 7
    i32.store offset=28
    local.get 4
    i32.load offset=24
    local.set 8
    local.get 4
    i32.load offset=28
    local.set 9
    local.get 4
    local.get 8
    i32.store offset=16
    local.get 4
    local.get 9
    i32.store offset=20
    local.get 4
    i32.load offset=16
    local.set 10
    local.get 4
    i32.load offset=20
    local.set 11
    local.get 0
    local.get 11
    i32.store offset=4
    local.get 0
    local.get 10
    i32.store
    i32.const 32
    local.set 12
    local.get 4
    local.get 12
    i32.add
    local.set 13
    local.get 13
    global.set $__stack_pointer
    return)
  (func $_ZN5alloc5alloc6Global10alloc_impl17hd3af88dafb6ddfb2E (type 5) (param i32 i32 i32 i32 i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    local.set 5
    i32.const 144
    local.set 6
    local.get 5
    local.get 6
    i32.sub
    local.set 7
    local.get 7
    global.set $__stack_pointer
    local.get 7
    local.get 2
    i32.store offset=8
    local.get 7
    local.get 3
    i32.store offset=12
    local.get 7
    i32.load offset=12
    local.set 8
    block  ;; label = @1
      block  ;; label = @2
        local.get 8
        br_if 0 (;@2;)
        local.get 7
        i32.load offset=8
        local.set 9
        local.get 7
        local.get 9
        i32.store offset=84
        local.get 7
        i32.load offset=84
        local.set 10
        local.get 7
        local.get 10
        i32.store offset=32
        local.get 7
        i32.load offset=32
        local.set 11
        local.get 7
        local.get 11
        i32.store offset=96
        i32.const 0
        local.set 12
        local.get 7
        local.get 12
        i32.store offset=100
        local.get 7
        i32.load offset=96
        local.set 13
        local.get 7
        i32.load offset=100
        local.set 14
        local.get 7
        local.get 13
        i32.store offset=88
        local.get 7
        local.get 14
        i32.store offset=92
        local.get 7
        i32.load offset=88
        local.set 15
        local.get 7
        i32.load offset=92
        local.set 16
        local.get 7
        local.get 15
        i32.store offset=24
        local.get 7
        local.get 16
        i32.store offset=28
        local.get 7
        i32.load offset=24
        local.set 17
        local.get 7
        i32.load offset=28
        local.set 18
        local.get 7
        local.get 17
        i32.store offset=16
        local.get 7
        local.get 18
        i32.store offset=20
        br 1 (;@1;)
      end
      local.get 4
      local.set 19
      block  ;; label = @2
        block  ;; label = @3
          local.get 19
          br_if 0 (;@3;)
          local.get 7
          i32.load offset=8
          local.set 20
          local.get 7
          i32.load offset=12
          local.set 21
          local.get 7
          local.get 20
          i32.store offset=48
          local.get 7
          local.get 21
          i32.store offset=52
          i32.const 0
          local.set 22
          local.get 22
          i32.load8_u offset=1049941
          local.set 23
          local.get 7
          local.get 23
          i32.store8 offset=143
          local.get 7
          i32.load offset=52
          local.set 24
          local.get 7
          i32.load offset=48
          local.set 25
          local.get 7
          local.get 25
          i32.store offset=108
          local.get 7
          i32.load offset=108
          local.set 26
          local.get 24
          local.get 26
          call $__rust_alloc
          local.set 27
          local.get 7
          local.get 27
          i32.store offset=36
          br 1 (;@2;)
        end
        local.get 7
        i32.load offset=8
        local.set 28
        local.get 7
        i32.load offset=12
        local.set 29
        local.get 7
        local.get 28
        i32.store offset=40
        local.get 7
        local.get 29
        i32.store offset=44
        local.get 7
        i32.load offset=44
        local.set 30
        local.get 7
        i32.load offset=40
        local.set 31
        local.get 7
        local.get 31
        i32.store offset=104
        local.get 7
        i32.load offset=104
        local.set 32
        local.get 30
        local.get 32
        call $__rust_alloc_zeroed
        local.set 33
        local.get 7
        local.get 33
        i32.store offset=36
      end
      local.get 7
      i32.load offset=36
      local.set 34
      local.get 7
      local.get 34
      i32.store offset=116
      local.get 7
      i32.load offset=116
      local.set 35
      i32.const 0
      local.set 36
      local.get 35
      local.set 37
      local.get 36
      local.set 38
      local.get 37
      local.get 38
      i32.eq
      local.set 39
      i32.const -1
      local.set 40
      local.get 39
      local.get 40
      i32.xor
      local.set 41
      i32.const 1
      local.set 42
      local.get 41
      local.get 42
      i32.and
      local.set 43
      block  ;; label = @2
        block  ;; label = @3
          local.get 43
          br_if 0 (;@3;)
          i32.const 0
          local.set 44
          local.get 7
          local.get 44
          i32.store offset=68
          br 1 (;@2;)
        end
        local.get 7
        local.get 34
        i32.store offset=112
        local.get 7
        i32.load offset=112
        local.set 45
        local.get 7
        local.get 45
        i32.store offset=68
      end
      local.get 7
      i32.load offset=68
      local.set 46
      i32.const 0
      local.set 47
      i32.const 1
      local.set 48
      local.get 48
      local.get 47
      local.get 46
      select
      local.set 49
      block  ;; label = @2
        block  ;; label = @3
          local.get 49
          br_if 0 (;@3;)
          i32.const 0
          local.set 50
          local.get 7
          local.get 50
          i32.store offset=64
          br 1 (;@2;)
        end
        local.get 7
        i32.load offset=68
        local.set 51
        local.get 7
        local.get 51
        i32.store offset=64
      end
      local.get 7
      i32.load offset=64
      local.set 52
      i32.const 1
      local.set 53
      i32.const 0
      local.set 54
      local.get 54
      local.get 53
      local.get 52
      select
      local.set 55
      block  ;; label = @2
        block  ;; label = @3
          local.get 55
          br_if 0 (;@3;)
          local.get 7
          i32.load offset=64
          local.set 56
          local.get 7
          local.get 56
          i32.store offset=60
          br 1 (;@2;)
        end
        i32.const 0
        local.set 57
        local.get 7
        local.get 57
        i32.store offset=60
      end
      local.get 7
      i32.load offset=60
      local.set 58
      i32.const 1
      local.set 59
      i32.const 0
      local.set 60
      local.get 60
      local.get 59
      local.get 58
      select
      local.set 61
      block  ;; label = @2
        local.get 61
        br_if 0 (;@2;)
        local.get 7
        i32.load offset=60
        local.set 62
        local.get 7
        local.get 62
        i32.store offset=128
        local.get 7
        local.get 8
        i32.store offset=132
        local.get 7
        i32.load offset=128
        local.set 63
        local.get 7
        i32.load offset=132
        local.set 64
        local.get 7
        local.get 63
        i32.store offset=120
        local.get 7
        local.get 64
        i32.store offset=124
        local.get 7
        i32.load offset=120
        local.set 65
        local.get 7
        i32.load offset=124
        local.set 66
        local.get 7
        local.get 65
        i32.store offset=72
        local.get 7
        local.get 66
        i32.store offset=76
        local.get 7
        i32.load offset=72
        local.set 67
        local.get 7
        i32.load offset=76
        local.set 68
        local.get 7
        local.get 67
        i32.store offset=16
        local.get 7
        local.get 68
        i32.store offset=20
        br 1 (;@1;)
      end
      i32.const 0
      local.set 69
      local.get 7
      local.get 69
      i32.store offset=16
    end
    local.get 7
    i32.load offset=16
    local.set 70
    local.get 7
    i32.load offset=20
    local.set 71
    local.get 0
    local.get 71
    i32.store offset=4
    local.get 0
    local.get 70
    i32.store
    i32.const 144
    local.set 72
    local.get 7
    local.get 72
    i32.add
    local.set 73
    local.get 73
    global.set $__stack_pointer
    return)
  (func $_ZN5alloc5alloc6Global9grow_impl17h909a4700248201a3E (type 8) (param i32 i32 i32 i32 i32 i32 i32 i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    local.set 8
    i32.const 144
    local.set 9
    local.get 8
    local.get 9
    i32.sub
    local.set 10
    local.get 10
    global.set $__stack_pointer
    local.get 10
    local.get 3
    i32.store offset=24
    local.get 10
    local.get 4
    i32.store offset=28
    local.get 10
    local.get 5
    i32.store offset=32
    local.get 10
    local.get 6
    i32.store offset=36
    local.get 10
    i32.load offset=28
    local.set 11
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          local.get 11
          br_if 0 (;@3;)
          local.get 10
          i32.load offset=32
          local.set 12
          local.get 10
          i32.load offset=36
          local.set 13
          i32.const 1
          local.set 14
          local.get 7
          local.get 14
          i32.and
          local.set 15
          i32.const 8
          local.set 16
          local.get 10
          local.get 16
          i32.add
          local.set 17
          local.get 17
          local.get 1
          local.get 12
          local.get 13
          local.get 15
          call $_ZN5alloc5alloc6Global10alloc_impl17hd3af88dafb6ddfb2E
          local.get 10
          i32.load offset=8
          local.set 18
          local.get 10
          i32.load offset=12
          local.set 19
          local.get 10
          local.get 19
          i32.store offset=44
          local.get 10
          local.get 18
          i32.store offset=40
          br 1 (;@2;)
        end
        local.get 10
        i32.load offset=24
        local.set 20
        local.get 10
        local.get 20
        i32.store offset=100
        local.get 10
        i32.load offset=100
        local.set 21
        local.get 10
        i32.load offset=32
        local.set 22
        local.get 10
        local.get 22
        i32.store offset=104
        local.get 10
        i32.load offset=104
        local.set 23
        local.get 21
        local.set 24
        local.get 23
        local.set 25
        local.get 24
        local.get 25
        i32.eq
        local.set 26
        i32.const 1
        local.set 27
        local.get 26
        local.get 27
        i32.and
        local.set 28
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              block  ;; label = @6
                block  ;; label = @7
                  block  ;; label = @8
                    block  ;; label = @9
                      block  ;; label = @10
                        local.get 28
                        br_if 0 (;@10;)
                        local.get 10
                        i32.load offset=32
                        local.set 29
                        local.get 10
                        i32.load offset=36
                        local.set 30
                        i32.const 1
                        local.set 31
                        local.get 7
                        local.get 31
                        i32.and
                        local.set 32
                        i32.const 16
                        local.set 33
                        local.get 10
                        local.get 33
                        i32.add
                        local.set 34
                        local.get 34
                        local.get 1
                        local.get 29
                        local.get 30
                        local.get 32
                        call $_ZN5alloc5alloc6Global10alloc_impl17hd3af88dafb6ddfb2E
                        local.get 10
                        i32.load offset=16
                        local.set 35
                        local.get 10
                        i32.load offset=20
                        local.set 36
                        local.get 10
                        local.get 36
                        i32.store offset=92
                        local.get 10
                        local.get 35
                        i32.store offset=88
                        local.get 10
                        i32.load offset=88
                        local.set 37
                        i32.const 1
                        local.set 38
                        i32.const 0
                        local.set 39
                        local.get 39
                        local.get 38
                        local.get 37
                        select
                        local.set 40
                        local.get 40
                        i32.eqz
                        br_if 1 (;@9;)
                        br 2 (;@8;)
                      end
                      local.get 10
                      i32.load offset=36
                      local.set 41
                      local.get 10
                      i32.load offset=24
                      local.set 42
                      local.get 10
                      i32.load offset=28
                      local.set 43
                      local.get 10
                      local.get 42
                      i32.store offset=48
                      local.get 10
                      local.get 43
                      i32.store offset=52
                      local.get 10
                      i32.load offset=52
                      local.set 44
                      local.get 10
                      i32.load offset=48
                      local.set 45
                      local.get 10
                      local.get 45
                      i32.store offset=108
                      local.get 10
                      i32.load offset=108
                      local.set 46
                      local.get 2
                      local.get 44
                      local.get 46
                      local.get 41
                      call $__rust_realloc
                      local.set 47
                      local.get 10
                      local.get 47
                      i32.store offset=116
                      local.get 10
                      i32.load offset=116
                      local.set 48
                      i32.const 0
                      local.set 49
                      local.get 48
                      local.set 50
                      local.get 49
                      local.set 51
                      local.get 50
                      local.get 51
                      i32.eq
                      local.set 52
                      i32.const -1
                      local.set 53
                      local.get 52
                      local.get 53
                      i32.xor
                      local.set 54
                      i32.const 1
                      local.set 55
                      local.get 54
                      local.get 55
                      i32.and
                      local.set 56
                      local.get 56
                      br_if 4 (;@5;)
                      br 3 (;@6;)
                    end
                    local.get 10
                    i32.load offset=88
                    local.set 57
                    local.get 10
                    i32.load offset=92
                    local.set 58
                    local.get 10
                    local.get 57
                    i32.store offset=80
                    local.get 10
                    local.get 58
                    i32.store offset=84
                    br 1 (;@7;)
                  end
                  i32.const 0
                  local.set 59
                  local.get 10
                  local.get 59
                  i32.store offset=80
                end
                local.get 10
                i32.load offset=80
                local.set 60
                i32.const 1
                local.set 61
                i32.const 0
                local.set 62
                local.get 62
                local.get 61
                local.get 60
                select
                local.set 63
                block  ;; label = @7
                  local.get 63
                  br_if 0 (;@7;)
                  local.get 10
                  i32.load offset=80
                  local.set 64
                  local.get 10
                  i32.load offset=84
                  local.set 65
                  local.get 10
                  local.get 64
                  i32.store offset=140
                  local.get 10
                  i32.load offset=140
                  local.set 66
                  i32.const 0
                  local.set 67
                  local.get 11
                  local.get 67
                  i32.shl
                  local.set 68
                  local.get 66
                  local.get 2
                  local.get 68
                  call $memcpy
                  drop
                  local.get 10
                  i32.load offset=24
                  local.set 69
                  local.get 10
                  i32.load offset=28
                  local.set 70
                  local.get 1
                  local.get 2
                  local.get 69
                  local.get 70
                  call $_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17ha34b8860f87e0fefE
                  local.get 10
                  local.get 64
                  i32.store offset=40
                  local.get 10
                  local.get 65
                  i32.store offset=44
                  br 5 (;@2;)
                end
                i32.const 0
                local.set 71
                local.get 10
                local.get 71
                i32.store offset=40
                br 3 (;@3;)
              end
              i32.const 0
              local.set 72
              local.get 10
              local.get 72
              i32.store offset=68
              br 1 (;@4;)
            end
            local.get 10
            local.get 47
            i32.store offset=112
            local.get 10
            i32.load offset=112
            local.set 73
            local.get 10
            local.get 73
            i32.store offset=68
          end
          local.get 10
          i32.load offset=68
          local.set 74
          i32.const 0
          local.set 75
          i32.const 1
          local.set 76
          local.get 76
          local.get 75
          local.get 74
          select
          local.set 77
          block  ;; label = @4
            block  ;; label = @5
              local.get 77
              br_if 0 (;@5;)
              i32.const 0
              local.set 78
              local.get 10
              local.get 78
              i32.store offset=64
              br 1 (;@4;)
            end
            local.get 10
            i32.load offset=68
            local.set 79
            local.get 10
            local.get 79
            i32.store offset=64
          end
          local.get 10
          i32.load offset=64
          local.set 80
          i32.const 1
          local.set 81
          i32.const 0
          local.set 82
          local.get 82
          local.get 81
          local.get 80
          select
          local.set 83
          block  ;; label = @4
            block  ;; label = @5
              local.get 83
              br_if 0 (;@5;)
              local.get 10
              i32.load offset=64
              local.set 84
              local.get 10
              local.get 84
              i32.store offset=60
              br 1 (;@4;)
            end
            i32.const 0
            local.set 85
            local.get 10
            local.get 85
            i32.store offset=60
          end
          local.get 10
          i32.load offset=60
          local.set 86
          i32.const 1
          local.set 87
          i32.const 0
          local.set 88
          local.get 88
          local.get 87
          local.get 86
          select
          local.set 89
          block  ;; label = @4
            block  ;; label = @5
              block  ;; label = @6
                local.get 89
                br_if 0 (;@6;)
                local.get 10
                i32.load offset=60
                local.set 90
                local.get 7
                local.set 91
                local.get 91
                br_if 1 (;@5;)
                br 2 (;@4;)
              end
              i32.const 0
              local.set 92
              local.get 10
              local.get 92
              i32.store offset=40
              br 2 (;@3;)
            end
            local.get 47
            local.get 11
            i32.add
            local.set 93
            local.get 41
            local.get 11
            i32.sub
            local.set 94
            i32.const 0
            local.set 95
            local.get 94
            local.get 95
            i32.shl
            local.set 96
            i32.const 0
            local.set 97
            local.get 93
            local.get 97
            local.get 96
            call $memset
            drop
          end
          local.get 10
          local.get 90
          i32.store offset=128
          local.get 10
          local.get 41
          i32.store offset=132
          local.get 10
          i32.load offset=128
          local.set 98
          local.get 10
          i32.load offset=132
          local.set 99
          local.get 10
          local.get 98
          i32.store offset=120
          local.get 10
          local.get 99
          i32.store offset=124
          local.get 10
          i32.load offset=120
          local.set 100
          local.get 10
          i32.load offset=124
          local.set 101
          local.get 10
          local.get 100
          i32.store offset=72
          local.get 10
          local.get 101
          i32.store offset=76
          local.get 10
          i32.load offset=72
          local.set 102
          local.get 10
          i32.load offset=76
          local.set 103
          local.get 10
          local.get 102
          i32.store offset=40
          local.get 10
          local.get 103
          i32.store offset=44
          br 1 (;@2;)
        end
        br 1 (;@1;)
      end
    end
    local.get 10
    i32.load offset=40
    local.set 104
    local.get 10
    i32.load offset=44
    local.set 105
    local.get 0
    local.get 105
    i32.store offset=4
    local.get 0
    local.get 104
    i32.store
    i32.const 144
    local.set 106
    local.get 10
    local.get 106
    i32.add
    local.set 107
    local.get 107
    global.set $__stack_pointer
    return)
  (func $_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17ha34b8860f87e0fefE (type 6) (param i32 i32 i32 i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    local.set 4
    i32.const 32
    local.set 5
    local.get 4
    local.get 5
    i32.sub
    local.set 6
    local.get 6
    global.set $__stack_pointer
    local.get 6
    local.get 2
    i32.store offset=8
    local.get 6
    local.get 3
    i32.store offset=12
    local.get 6
    i32.load offset=12
    local.set 7
    block  ;; label = @1
      block  ;; label = @2
        local.get 7
        br_if 0 (;@2;)
        br 1 (;@1;)
      end
      local.get 6
      i32.load offset=8
      local.set 8
      local.get 6
      i32.load offset=12
      local.set 9
      local.get 6
      local.get 8
      i32.store offset=16
      local.get 6
      local.get 9
      i32.store offset=20
      local.get 6
      i32.load offset=20
      local.set 10
      local.get 6
      i32.load offset=16
      local.set 11
      local.get 6
      local.get 11
      i32.store offset=28
      local.get 6
      i32.load offset=28
      local.set 12
      local.get 1
      local.get 10
      local.get 12
      call $__rust_dealloc
    end
    i32.const 32
    local.set 13
    local.get 6
    local.get 13
    i32.add
    local.set 14
    local.get 14
    global.set $__stack_pointer
    return)
  (func $_ZN5alloc7raw_vec11finish_grow17h92fc14403172c315E (type 5) (param i32 i32 i32 i32 i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    local.set 5
    i32.const 160
    local.set 6
    local.get 5
    local.get 6
    i32.sub
    local.set 7
    local.get 7
    global.set $__stack_pointer
    i32.const 40
    local.set 8
    local.get 7
    local.get 8
    i32.add
    local.set 9
    local.get 9
    local.set 10
    local.get 10
    local.get 1
    local.get 2
    call $_ZN4core6result19Result$LT$T$C$E$GT$7map_err17h5982f674a89010aaE
    local.get 7
    i32.load offset=40
    local.set 11
    block  ;; label = @1
      block  ;; label = @2
        local.get 11
        br_if 0 (;@2;)
        local.get 7
        i32.load offset=44
        local.set 12
        local.get 7
        i32.load offset=48
        local.set 13
        local.get 7
        local.get 12
        i32.store offset=28
        local.get 7
        local.get 13
        i32.store offset=32
        i32.const 0
        local.set 14
        local.get 7
        local.get 14
        i32.store offset=24
        br 1 (;@1;)
      end
      local.get 7
      i32.load offset=44
      local.set 15
      local.get 7
      i32.load offset=48
      local.set 16
      local.get 7
      local.get 15
      i32.store offset=112
      local.get 7
      local.get 16
      i32.store offset=116
      local.get 7
      i32.load offset=112
      local.set 17
      local.get 7
      i32.load offset=116
      local.set 18
      local.get 7
      local.get 17
      i32.store offset=28
      local.get 7
      local.get 18
      i32.store offset=32
      i32.const 1
      local.set 19
      local.get 7
      local.get 19
      i32.store offset=24
    end
    local.get 7
    i32.load offset=24
    local.set 20
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              block  ;; label = @6
                local.get 20
                br_if 0 (;@6;)
                local.get 7
                i32.load offset=28
                local.set 21
                local.get 7
                i32.load offset=32
                local.set 22
                local.get 7
                local.get 21
                i32.store offset=16
                local.get 7
                local.get 22
                i32.store offset=20
                local.get 7
                i32.load offset=20
                local.set 23
                i32.const 2147483647
                local.set 24
                local.get 23
                local.set 25
                local.get 24
                local.set 26
                local.get 25
                local.get 26
                i32.gt_u
                local.set 27
                i32.const 1
                local.set 28
                local.get 27
                local.get 28
                i32.and
                local.set 29
                local.get 29
                br_if 2 (;@4;)
                br 1 (;@5;)
              end
              local.get 7
              i32.load offset=28
              local.set 30
              local.get 7
              i32.load offset=32
              local.set 31
              local.get 7
              local.get 30
              i32.store offset=56
              local.get 7
              local.get 31
              i32.store offset=60
              local.get 7
              i32.load offset=56
              local.set 32
              local.get 7
              i32.load offset=60
              local.set 33
              local.get 7
              local.get 32
              i32.store offset=120
              local.get 7
              local.get 33
              i32.store offset=124
              local.get 7
              i32.load offset=120
              local.set 34
              local.get 7
              i32.load offset=124
              local.set 35
              local.get 0
              local.get 34
              i32.store offset=4
              local.get 0
              local.get 35
              i32.store offset=8
              i32.const 1
              local.set 36
              local.get 0
              local.get 36
              i32.store
              br 3 (;@2;)
            end
            i32.const -2147483647
            local.set 37
            local.get 7
            local.get 37
            i32.store offset=72
            br 1 (;@3;)
          end
          i32.const 0
          local.set 38
          local.get 7
          local.get 38
          i32.store offset=136
          local.get 7
          i32.load offset=136
          local.set 39
          local.get 7
          i32.load offset=140
          local.set 40
          local.get 7
          local.get 39
          i32.store offset=128
          local.get 7
          local.get 40
          i32.store offset=132
          local.get 7
          i32.load offset=128
          local.set 41
          local.get 7
          i32.load offset=132
          local.set 42
          local.get 7
          local.get 41
          i32.store offset=72
          local.get 7
          local.get 42
          i32.store offset=76
        end
        local.get 7
        i32.load offset=72
        local.set 43
        i32.const -2147483647
        local.set 44
        local.get 43
        local.set 45
        local.get 44
        local.set 46
        local.get 45
        local.get 46
        i32.eq
        local.set 47
        i32.const 0
        local.set 48
        i32.const 1
        local.set 49
        i32.const 1
        local.set 50
        local.get 47
        local.get 50
        i32.and
        local.set 51
        local.get 48
        local.get 49
        local.get 51
        select
        local.set 52
        block  ;; label = @3
          block  ;; label = @4
            local.get 52
            br_if 0 (;@4;)
            i32.const -2147483647
            local.set 53
            local.get 7
            local.get 53
            i32.store offset=64
            br 1 (;@3;)
          end
          local.get 7
          i32.load offset=72
          local.set 54
          local.get 7
          i32.load offset=76
          local.set 55
          local.get 7
          local.get 54
          i32.store offset=144
          local.get 7
          local.get 55
          i32.store offset=148
          local.get 7
          i32.load offset=144
          local.set 56
          local.get 7
          i32.load offset=148
          local.set 57
          local.get 7
          local.get 56
          i32.store offset=64
          local.get 7
          local.get 57
          i32.store offset=68
        end
        local.get 7
        i32.load offset=64
        local.set 58
        i32.const -2147483647
        local.set 59
        local.get 58
        local.set 60
        local.get 59
        local.set 61
        local.get 60
        local.get 61
        i32.eq
        local.set 62
        i32.const 0
        local.set 63
        i32.const 1
        local.set 64
        i32.const 1
        local.set 65
        local.get 62
        local.get 65
        i32.and
        local.set 66
        local.get 63
        local.get 64
        local.get 66
        select
        local.set 67
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              block  ;; label = @6
                local.get 67
                br_if 0 (;@6;)
                local.get 3
                i32.load offset=4
                local.set 68
                i32.const 0
                local.set 69
                i32.const 1
                local.set 70
                local.get 70
                local.get 69
                local.get 68
                select
                local.set 71
                i32.const 1
                local.set 72
                local.get 71
                local.set 73
                local.get 72
                local.set 74
                local.get 73
                local.get 74
                i32.eq
                local.set 75
                i32.const 1
                local.set 76
                local.get 75
                local.get 76
                i32.and
                local.set 77
                local.get 77
                br_if 1 (;@5;)
                br 2 (;@4;)
              end
              local.get 7
              i32.load offset=64
              local.set 78
              local.get 7
              i32.load offset=68
              local.set 79
              local.get 7
              local.get 78
              i32.store offset=80
              local.get 7
              local.get 79
              i32.store offset=84
              local.get 7
              i32.load offset=80
              local.set 80
              local.get 7
              i32.load offset=84
              local.set 81
              local.get 0
              local.get 80
              i32.store offset=4
              local.get 0
              local.get 81
              i32.store offset=8
              i32.const 1
              local.set 82
              local.get 0
              local.get 82
              i32.store
              br 3 (;@2;)
            end
            local.get 3
            i32.load
            local.set 83
            local.get 3
            i32.load offset=4
            local.set 84
            i32.const 8
            local.set 85
            local.get 3
            local.get 85
            i32.add
            local.set 86
            local.get 86
            i32.load
            local.set 87
            local.get 7
            local.get 84
            i32.store offset=96
            local.get 7
            local.get 87
            i32.store offset=100
            local.get 7
            i32.load offset=96
            local.set 88
            local.get 7
            local.get 88
            i32.store offset=152
            local.get 7
            i32.load offset=16
            local.set 89
            local.get 7
            local.get 89
            i32.store offset=156
            local.get 7
            i32.load offset=96
            local.set 90
            local.get 7
            i32.load offset=100
            local.set 91
            local.get 7
            i32.load offset=16
            local.set 92
            local.get 7
            i32.load offset=20
            local.set 93
            local.get 7
            local.get 4
            local.get 83
            local.get 90
            local.get 91
            local.get 92
            local.get 93
            call $_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$4grow17hb9f3c84a0ccba891E
            local.get 7
            i32.load
            local.set 94
            local.get 7
            i32.load offset=4
            local.set 95
            local.get 7
            local.get 95
            i32.store offset=92
            local.get 7
            local.get 94
            i32.store offset=88
            br 1 (;@3;)
          end
          local.get 7
          i32.load offset=16
          local.set 96
          local.get 7
          i32.load offset=20
          local.set 97
          i32.const 8
          local.set 98
          local.get 7
          local.get 98
          i32.add
          local.set 99
          local.get 99
          local.get 4
          local.get 96
          local.get 97
          call $_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$8allocate17h9dfc244b2f625c7dE
          local.get 7
          i32.load offset=8
          local.set 100
          local.get 7
          i32.load offset=12
          local.set 101
          local.get 7
          local.get 101
          i32.store offset=92
          local.get 7
          local.get 100
          i32.store offset=88
        end
        local.get 7
        i32.load offset=88
        local.set 102
        local.get 7
        i32.load offset=92
        local.set 103
        i32.const 16
        local.set 104
        local.get 7
        local.get 104
        i32.add
        local.set 105
        local.get 105
        local.set 106
        local.get 7
        local.get 106
        i32.store offset=108
        local.get 7
        i32.load offset=108
        local.set 107
        local.get 0
        local.get 102
        local.get 103
        local.get 107
        call $_ZN4core6result19Result$LT$T$C$E$GT$7map_err17hd2deccd7c24a623aE
        br 1 (;@1;)
      end
    end
    i32.const 160
    local.set 108
    local.get 7
    local.get 108
    i32.add
    local.set 109
    local.get 109
    global.set $__stack_pointer
    return)
  (func $_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$4grow17hb9f3c84a0ccba891E (type 9) (param i32 i32 i32 i32 i32 i32 i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    local.set 7
    i32.const 16
    local.set 8
    local.get 7
    local.get 8
    i32.sub
    local.set 9
    local.get 9
    global.set $__stack_pointer
    i32.const 0
    local.set 10
    i32.const 8
    local.set 11
    local.get 9
    local.get 11
    i32.add
    local.set 12
    local.get 12
    local.get 1
    local.get 2
    local.get 3
    local.get 4
    local.get 5
    local.get 6
    local.get 10
    call $_ZN5alloc5alloc6Global9grow_impl17h909a4700248201a3E
    local.get 9
    i32.load offset=8
    local.set 13
    local.get 9
    i32.load offset=12
    local.set 14
    local.get 0
    local.get 14
    i32.store offset=4
    local.get 0
    local.get 13
    i32.store
    i32.const 16
    local.set 15
    local.get 9
    local.get 15
    i32.add
    local.set 16
    local.get 16
    global.set $__stack_pointer
    return)
  (func $_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$8allocate17h9dfc244b2f625c7dE (type 6) (param i32 i32 i32 i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    local.set 4
    i32.const 16
    local.set 5
    local.get 4
    local.get 5
    i32.sub
    local.set 6
    local.get 6
    global.set $__stack_pointer
    i32.const 0
    local.set 7
    i32.const 8
    local.set 8
    local.get 6
    local.get 8
    i32.add
    local.set 9
    local.get 9
    local.get 1
    local.get 2
    local.get 3
    local.get 7
    call $_ZN5alloc5alloc6Global10alloc_impl17hd3af88dafb6ddfb2E
    local.get 6
    i32.load offset=8
    local.set 10
    local.get 6
    i32.load offset=12
    local.set 11
    local.get 0
    local.get 11
    i32.store offset=4
    local.get 0
    local.get 10
    i32.store
    i32.const 16
    local.set 12
    local.get 6
    local.get 12
    i32.add
    local.set 13
    local.get 13
    global.set $__stack_pointer
    return)
  (func $_ZN5alloc7raw_vec14handle_reserve17h05fd33db22a196d0E (type 0) (param i32 i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    local.set 2
    i32.const 16
    local.set 3
    local.get 2
    local.get 3
    i32.sub
    local.set 4
    local.get 4
    global.set $__stack_pointer
    local.get 4
    local.get 0
    local.get 1
    call $_ZN4core6result19Result$LT$T$C$E$GT$7map_err17h39f39cc027ebcfa6E
    local.get 4
    i32.load
    local.set 5
    local.get 4
    i32.load offset=4
    local.set 6
    local.get 4
    local.get 6
    i32.store offset=12
    local.get 4
    local.get 5
    i32.store offset=8
    local.get 4
    i32.load offset=8
    local.set 7
    i32.const -2147483647
    local.set 8
    local.get 7
    local.set 9
    local.get 8
    local.set 10
    local.get 9
    local.get 10
    i32.eq
    local.set 11
    i32.const 0
    local.set 12
    i32.const 1
    local.set 13
    i32.const 1
    local.set 14
    local.get 11
    local.get 14
    i32.and
    local.set 15
    local.get 12
    local.get 13
    local.get 15
    select
    local.set 16
    block  ;; label = @1
      local.get 16
      br_if 0 (;@1;)
      i32.const 16
      local.set 17
      local.get 4
      local.get 17
      i32.add
      local.set 18
      local.get 18
      global.set $__stack_pointer
      return
    end
    local.get 4
    i32.load offset=8
    local.set 19
    i32.const 0
    local.set 20
    i32.const 1
    local.set 21
    local.get 21
    local.get 20
    local.get 19
    select
    local.set 22
    block  ;; label = @1
      local.get 22
      br_if 0 (;@1;)
      call $_ZN5alloc7raw_vec17capacity_overflow17h69391d2b6a90e408E
      unreachable
    end
    local.get 4
    i32.load offset=8
    local.set 23
    local.get 4
    i32.load offset=12
    local.set 24
    local.get 23
    local.get 24
    call $_ZN5alloc5alloc18handle_alloc_error17hbbf685130f283420E
    unreachable)
  (func $_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$14current_memory17h9e5ff513db5d2e36E (type 0) (param i32 i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i64 i32 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    local.set 2
    i32.const 48
    local.set 3
    local.get 2
    local.get 3
    i32.sub
    local.set 4
    i32.const 0
    local.set 5
    i32.const 1
    local.set 6
    local.get 5
    local.get 6
    i32.and
    local.set 7
    block  ;; label = @1
      block  ;; label = @2
        local.get 7
        br_if 0 (;@2;)
        local.get 1
        i32.load offset=4
        local.set 8
        i32.const 0
        local.set 9
        local.get 8
        local.set 10
        local.get 9
        local.set 11
        local.get 10
        local.get 11
        i32.eq
        local.set 12
        i32.const 1
        local.set 13
        local.get 12
        local.get 13
        i32.and
        local.set 14
        local.get 4
        local.get 14
        i32.store8 offset=7
        br 1 (;@1;)
      end
      i32.const 1
      local.set 15
      local.get 4
      local.get 15
      i32.store8 offset=7
    end
    local.get 4
    i32.load8_u offset=7
    local.set 16
    i32.const 1
    local.set 17
    local.get 16
    local.get 17
    i32.and
    local.set 18
    block  ;; label = @1
      block  ;; label = @2
        local.get 18
        br_if 0 (;@2;)
        local.get 1
        i32.load offset=4
        local.set 19
        i32.const 2
        local.set 20
        local.get 19
        local.get 20
        i32.shl
        local.set 21
        local.get 4
        local.get 21
        i32.store offset=12
        i32.const 4
        local.set 22
        local.get 4
        local.get 22
        i32.store offset=8
        local.get 1
        i32.load
        local.set 23
        local.get 4
        local.get 23
        i32.store offset=40
        local.get 4
        i32.load offset=40
        local.set 24
        local.get 4
        local.get 24
        i32.store offset=44
        local.get 4
        i32.load offset=44
        local.set 25
        local.get 4
        local.get 25
        i32.store offset=36
        local.get 4
        i32.load offset=36
        local.set 26
        local.get 4
        local.get 26
        i32.store offset=32
        local.get 4
        i32.load offset=32
        local.set 27
        local.get 4
        local.get 27
        i32.store offset=16
        local.get 4
        i32.load offset=8
        local.set 28
        local.get 4
        i32.load offset=12
        local.set 29
        local.get 4
        local.get 28
        i32.store offset=20
        local.get 4
        local.get 29
        i32.store offset=24
        local.get 4
        i64.load offset=16
        local.set 30
        local.get 0
        local.get 30
        i64.store align=4
        i32.const 8
        local.set 31
        local.get 0
        local.get 31
        i32.add
        local.set 32
        i32.const 16
        local.set 33
        local.get 4
        local.get 33
        i32.add
        local.set 34
        local.get 34
        local.get 31
        i32.add
        local.set 35
        local.get 35
        i32.load
        local.set 36
        local.get 32
        local.get 36
        i32.store
        br 1 (;@1;)
      end
      i32.const 0
      local.set 37
      local.get 0
      local.get 37
      i32.store offset=4
    end
    return)
  (func $_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$14grow_amortized17hd512fe9f5b7074aaE (type 6) (param i32 i32 i32 i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    local.set 4
    i32.const 176
    local.set 5
    local.get 4
    local.get 5
    i32.sub
    local.set 6
    local.get 6
    global.set $__stack_pointer
    i32.const 0
    local.set 7
    i32.const 1
    local.set 8
    local.get 7
    local.get 8
    i32.and
    local.set 9
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              local.get 9
              br_if 0 (;@5;)
              local.get 2
              local.get 3
              i32.add
              local.set 10
              local.get 10
              local.get 2
              i32.lt_u
              local.set 11
              local.get 6
              local.get 10
              i32.store offset=136
              i32.const 1
              local.set 12
              local.get 11
              local.get 12
              i32.and
              local.set 13
              local.get 6
              local.get 13
              i32.store8 offset=140
              local.get 6
              i32.load offset=136
              local.set 14
              local.get 6
              i32.load8_u offset=140
              local.set 15
              i32.const 1
              local.set 16
              local.get 15
              local.get 16
              i32.and
              local.set 17
              local.get 6
              local.get 17
              i32.store8 offset=175
              local.get 6
              i32.load8_u offset=175
              local.set 18
              i32.const 1
              local.set 19
              local.get 18
              local.get 19
              i32.and
              local.set 20
              local.get 20
              br_if 2 (;@3;)
              br 1 (;@4;)
            end
            i32.const 0
            local.set 21
            local.get 6
            local.get 21
            i32.store offset=32
            local.get 6
            i32.load offset=32
            local.set 22
            local.get 6
            i32.load offset=36
            local.set 23
            local.get 6
            local.get 22
            i32.store offset=24
            local.get 6
            local.get 23
            i32.store offset=28
            local.get 6
            i32.load offset=24
            local.set 24
            local.get 6
            i32.load offset=28
            local.set 25
            local.get 6
            local.get 24
            i32.store offset=16
            local.get 6
            local.get 25
            i32.store offset=20
            br 3 (;@1;)
          end
          local.get 6
          local.get 14
          i32.store offset=60
          i32.const 1
          local.set 26
          local.get 6
          local.get 26
          i32.store offset=56
          br 1 (;@2;)
        end
        i32.const 0
        local.set 27
        local.get 6
        local.get 27
        i32.store offset=56
      end
      i32.const 0
      local.set 28
      local.get 6
      local.get 28
      i32.store offset=64
      local.get 6
      i32.load offset=56
      local.set 29
      block  ;; label = @2
        block  ;; label = @3
          local.get 29
          br_if 0 (;@3;)
          local.get 6
          i32.load offset=64
          local.set 30
          local.get 6
          i32.load offset=68
          local.set 31
          local.get 6
          local.get 30
          i32.store offset=48
          local.get 6
          local.get 31
          i32.store offset=52
          br 1 (;@2;)
        end
        local.get 6
        i32.load offset=60
        local.set 32
        local.get 6
        local.get 32
        i32.store offset=52
        i32.const -2147483647
        local.set 33
        local.get 6
        local.get 33
        i32.store offset=48
      end
      local.get 6
      i32.load offset=48
      local.set 34
      i32.const -2147483647
      local.set 35
      local.get 34
      local.set 36
      local.get 35
      local.set 37
      local.get 36
      local.get 37
      i32.eq
      local.set 38
      i32.const 0
      local.set 39
      i32.const 1
      local.set 40
      i32.const 1
      local.set 41
      local.get 38
      local.get 41
      i32.and
      local.set 42
      local.get 39
      local.get 40
      local.get 42
      select
      local.set 43
      block  ;; label = @2
        block  ;; label = @3
          local.get 43
          br_if 0 (;@3;)
          local.get 6
          i32.load offset=52
          local.set 44
          local.get 6
          local.get 44
          i32.store offset=44
          i32.const -2147483647
          local.set 45
          local.get 6
          local.get 45
          i32.store offset=40
          br 1 (;@2;)
        end
        local.get 6
        i32.load offset=48
        local.set 46
        local.get 6
        i32.load offset=52
        local.set 47
        local.get 6
        local.get 46
        i32.store offset=144
        local.get 6
        local.get 47
        i32.store offset=148
        local.get 6
        i32.load offset=144
        local.set 48
        local.get 6
        i32.load offset=148
        local.set 49
        local.get 6
        local.get 48
        i32.store offset=40
        local.get 6
        local.get 49
        i32.store offset=44
      end
      local.get 6
      i32.load offset=40
      local.set 50
      i32.const -2147483647
      local.set 51
      local.get 50
      local.set 52
      local.get 51
      local.set 53
      local.get 52
      local.get 53
      i32.eq
      local.set 54
      i32.const 0
      local.set 55
      i32.const 1
      local.set 56
      i32.const 1
      local.set 57
      local.get 54
      local.get 57
      i32.and
      local.set 58
      local.get 55
      local.get 56
      local.get 58
      select
      local.set 59
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              local.get 59
              br_if 0 (;@5;)
              local.get 6
              i32.load offset=44
              local.set 60
              local.get 1
              i32.load offset=4
              local.set 61
              i32.const 1
              local.set 62
              local.get 61
              local.get 62
              i32.shl
              local.set 63
              local.get 63
              local.get 60
              call $_ZN4core3cmp6max_by17h2f68f711d6289889E
              local.set 64
              i32.const 4
              local.set 65
              local.get 65
              local.get 64
              call $_ZN4core3cmp6max_by17h2f68f711d6289889E
              local.set 66
              i32.const 4
              local.set 67
              i32.const 8
              local.set 68
              local.get 6
              local.get 68
              i32.add
              local.set 69
              local.get 69
              local.get 67
              local.get 67
              local.get 66
              call $_ZN4core5alloc6layout6Layout5array5inner17hfbb2edc59de7921aE
              local.get 6
              i32.load offset=12
              local.set 70
              local.get 6
              i32.load offset=8
              local.set 71
              i32.const 112
              local.set 72
              local.get 6
              local.get 72
              i32.add
              local.set 73
              local.get 73
              local.set 74
              local.get 74
              local.get 1
              call $_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$14current_memory17h9e5ff513db5d2e36E
              i32.const 96
              local.set 75
              local.get 6
              local.get 75
              i32.add
              local.set 76
              local.get 76
              local.set 77
              i32.const 112
              local.set 78
              local.get 6
              local.get 78
              i32.add
              local.set 79
              local.get 79
              local.set 80
              local.get 77
              local.get 71
              local.get 70
              local.get 80
              local.get 1
              call $_ZN5alloc7raw_vec11finish_grow17h92fc14403172c315E
              local.get 6
              i32.load offset=96
              local.set 81
              local.get 81
              i32.eqz
              br_if 1 (;@4;)
              br 2 (;@3;)
            end
            local.get 6
            i32.load offset=40
            local.set 82
            local.get 6
            i32.load offset=44
            local.set 83
            local.get 6
            local.get 82
            i32.store offset=72
            local.get 6
            local.get 83
            i32.store offset=76
            local.get 6
            i32.load offset=72
            local.set 84
            local.get 6
            i32.load offset=76
            local.set 85
            local.get 6
            local.get 84
            i32.store offset=152
            local.get 6
            local.get 85
            i32.store offset=156
            local.get 6
            i32.load offset=152
            local.set 86
            local.get 6
            i32.load offset=156
            local.set 87
            local.get 6
            local.get 86
            i32.store offset=16
            local.get 6
            local.get 87
            i32.store offset=20
            br 3 (;@1;)
          end
          local.get 6
          i32.load offset=100
          local.set 88
          local.get 6
          i32.load offset=104
          local.set 89
          local.get 6
          local.get 88
          i32.store offset=84
          local.get 6
          local.get 89
          i32.store offset=88
          i32.const 0
          local.set 90
          local.get 6
          local.get 90
          i32.store offset=80
          br 1 (;@2;)
        end
        local.get 6
        i32.load offset=100
        local.set 91
        local.get 6
        i32.load offset=104
        local.set 92
        local.get 6
        local.get 91
        i32.store offset=160
        local.get 6
        local.get 92
        i32.store offset=164
        local.get 6
        i32.load offset=160
        local.set 93
        local.get 6
        i32.load offset=164
        local.set 94
        local.get 6
        local.get 93
        i32.store offset=84
        local.get 6
        local.get 94
        i32.store offset=88
        i32.const 1
        local.set 95
        local.get 6
        local.get 95
        i32.store offset=80
      end
      local.get 6
      i32.load offset=80
      local.set 96
      block  ;; label = @2
        local.get 96
        br_if 0 (;@2;)
        local.get 6
        i32.load offset=84
        local.set 97
        local.get 6
        i32.load offset=88
        local.set 98
        local.get 1
        local.get 97
        local.get 98
        local.get 66
        call $_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$15set_ptr_and_cap17h8b689811bcaca710E
        i32.const -2147483647
        local.set 99
        local.get 6
        local.get 99
        i32.store offset=16
        br 1 (;@1;)
      end
      local.get 6
      i32.load offset=84
      local.set 100
      local.get 6
      i32.load offset=88
      local.set 101
      local.get 6
      local.get 100
      i32.store offset=128
      local.get 6
      local.get 101
      i32.store offset=132
      local.get 6
      i32.load offset=128
      local.set 102
      local.get 6
      i32.load offset=132
      local.set 103
      local.get 6
      local.get 102
      i32.store offset=16
      local.get 6
      local.get 103
      i32.store offset=20
    end
    local.get 6
    i32.load offset=16
    local.set 104
    local.get 6
    i32.load offset=20
    local.set 105
    local.get 0
    local.get 105
    i32.store offset=4
    local.get 0
    local.get 104
    i32.store
    i32.const 176
    local.set 106
    local.get 6
    local.get 106
    i32.add
    local.set 107
    local.get 107
    global.set $__stack_pointer
    return)
  (func $_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$15set_ptr_and_cap17h8b689811bcaca710E (type 6) (param i32 i32 i32 i32)
    (local i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    local.set 4
    i32.const 16
    local.set 5
    local.get 4
    local.get 5
    i32.sub
    local.set 6
    local.get 6
    local.get 1
    i32.store offset=8
    local.get 6
    i32.load offset=8
    local.set 7
    local.get 6
    local.get 7
    i32.store offset=12
    local.get 6
    i32.load offset=12
    local.set 8
    local.get 6
    local.get 8
    i32.store offset=4
    local.get 6
    i32.load offset=4
    local.set 9
    local.get 0
    local.get 9
    i32.store
    local.get 0
    local.get 3
    i32.store offset=4
    return)
  (func $_ZN63_$LT$I$u20$as$u20$core..iter..traits..collect..IntoIterator$GT$9into_iter17hc9ff7e0c46c769b9E (type 0) (param i32 i32)
    (local i64 i32 i32 i32 i64)
    local.get 1
    i64.load align=4
    local.set 2
    local.get 0
    local.get 2
    i64.store align=4
    i32.const 8
    local.set 3
    local.get 0
    local.get 3
    i32.add
    local.set 4
    local.get 1
    local.get 3
    i32.add
    local.set 5
    local.get 5
    i64.load align=4
    local.set 6
    local.get 4
    local.get 6
    i64.store align=4
    return)
  (func $_ZN90_$LT$alloc..vec..Vec$LT$T$C$A$GT$$u20$as$u20$core..iter..traits..collect..IntoIterator$GT$9into_iter17h10fda26b5bae1437E (type 0) (param i32 i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i64 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    local.set 2
    i32.const 48
    local.set 3
    local.get 2
    local.get 3
    i32.sub
    local.set 4
    i32.const 8
    local.set 5
    local.get 1
    local.get 5
    i32.add
    local.set 6
    local.get 6
    i32.load
    local.set 7
    i32.const 8
    local.set 8
    local.get 4
    local.get 8
    i32.add
    local.set 9
    local.get 9
    local.get 5
    i32.add
    local.set 10
    local.get 10
    local.get 7
    i32.store
    local.get 1
    i64.load align=4
    local.set 11
    local.get 4
    local.get 11
    i64.store offset=8
    local.get 4
    i32.load offset=8
    local.set 12
    i32.const 0
    local.set 13
    i32.const 1
    local.set 14
    local.get 13
    local.get 14
    i32.and
    local.set 15
    block  ;; label = @1
      block  ;; label = @2
        local.get 15
        br_if 0 (;@2;)
        local.get 4
        i32.load offset=16
        local.set 16
        i32.const 2
        local.set 17
        local.get 16
        local.get 17
        i32.shl
        local.set 18
        local.get 12
        local.get 18
        i32.add
        local.set 19
        local.get 4
        local.get 19
        i32.store offset=20
        br 1 (;@1;)
      end
      local.get 4
      i32.load offset=16
      local.set 20
      local.get 12
      local.get 20
      i32.add
      local.set 21
      local.get 4
      local.get 21
      i32.store offset=44
      local.get 4
      i32.load offset=44
      local.set 22
      local.get 4
      local.get 22
      i32.store offset=40
      local.get 4
      i32.load offset=40
      local.set 23
      local.get 4
      local.get 23
      i32.store offset=32
      local.get 4
      i32.load offset=32
      local.set 24
      local.get 4
      local.get 24
      i32.store offset=20
    end
    i32.const 0
    local.set 25
    i32.const 1
    local.set 26
    local.get 25
    local.get 26
    i32.and
    local.set 27
    block  ;; label = @1
      block  ;; label = @2
        local.get 27
        br_if 0 (;@2;)
        local.get 4
        i32.load offset=12
        local.set 28
        local.get 4
        local.get 28
        i32.store offset=24
        br 1 (;@1;)
      end
      i32.const -1
      local.set 29
      local.get 4
      local.get 29
      i32.store offset=24
    end
    local.get 4
    local.get 12
    i32.store offset=28
    local.get 4
    i32.load offset=24
    local.set 30
    local.get 4
    i32.load offset=20
    local.set 31
    local.get 4
    i32.load offset=28
    local.set 32
    local.get 0
    local.get 32
    i32.store
    local.get 0
    local.get 30
    i32.store offset=4
    local.get 0
    local.get 12
    i32.store offset=8
    local.get 0
    local.get 31
    i32.store offset=12
    return)
  (func $new (type 4) (param i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    local.set 1
    i32.const 48
    local.set 2
    local.get 1
    local.get 2
    i32.sub
    local.set 3
    local.get 3
    global.set $__stack_pointer
    i32.const 32
    local.set 4
    local.get 3
    local.get 4
    i32.add
    local.set 5
    local.get 5
    call $_ZN5alloc3vec12Vec$LT$T$GT$3new17h03ff6f2a4d4edaf5E
    i32.const 16
    local.set 6
    local.get 3
    local.get 6
    i32.add
    local.set 7
    i32.const 32
    local.set 8
    local.get 3
    local.get 8
    i32.add
    local.set 9
    local.get 7
    local.get 9
    call $_ZN90_$LT$alloc..vec..Vec$LT$T$C$A$GT$$u20$as$u20$core..iter..traits..collect..IntoIterator$GT$9into_iter17h10fda26b5bae1437E
    i32.const 16
    local.set 10
    local.get 3
    local.get 10
    i32.add
    local.set 11
    local.get 3
    local.get 11
    call $_ZN4core4iter6traits8iterator8Iterator7collect17h17e168441d961b83E
    local.get 3
    i32.load
    local.set 12
    local.get 3
    i32.load offset=4
    local.set 13
    local.get 3
    i32.load offset=8
    local.set 14
    local.get 0
    local.get 14
    i32.store offset=8
    local.get 0
    local.get 13
    i32.store offset=4
    local.get 0
    local.get 12
    i32.store
    i32.const 48
    local.set 15
    local.get 3
    local.get 15
    i32.add
    local.set 16
    local.get 16
    global.set $__stack_pointer
    return)
  (func $__rust_alloc (type 2) (param i32 i32) (result i32)
    (local i32)
    local.get 0
    local.get 1
    call $__rdl_alloc
    local.set 2
    local.get 2
    return)
  (func $__rust_dealloc (type 7) (param i32 i32 i32)
    local.get 0
    local.get 1
    local.get 2
    call $__rdl_dealloc
    return)
  (func $__rust_realloc (type 10) (param i32 i32 i32 i32) (result i32)
    (local i32)
    local.get 0
    local.get 1
    local.get 2
    local.get 3
    call $__rdl_realloc
    local.set 4
    local.get 4
    return)
  (func $__rust_alloc_zeroed (type 2) (param i32 i32) (result i32)
    (local i32)
    local.get 0
    local.get 1
    call $__rdl_alloc_zeroed
    local.set 2
    local.get 2
    return)
  (func $__rust_alloc_error_handler (type 0) (param i32 i32)
    local.get 0
    local.get 1
    call $__rg_oom
    return)
  (func $_ZN36_$LT$T$u20$as$u20$core..any..Any$GT$7type_id17h2f9122058122ec53E (type 0) (param i32 i32)
    local.get 0
    i64.const 2604112250384438326
    i64.store offset=8
    local.get 0
    i64.const -5300603541150396866
    i64.store)
  (func $_ZN36_$LT$T$u20$as$u20$core..any..Any$GT$7type_id17h493a5d87ecb9888bE (type 0) (param i32 i32)
    local.get 0
    i64.const -163230743173927068
    i64.store offset=8
    local.get 0
    i64.const -4493808902380553279
    i64.store)
  (func $_ZN36_$LT$T$u20$as$u20$core..any..Any$GT$7type_id17hc16c025c0c717dd0E (type 0) (param i32 i32)
    local.get 0
    i64.const 6709583872402221221
    i64.store offset=8
    local.get 0
    i64.const -517914840449640987
    i64.store)
  (func $_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$7reserve21do_reserve_and_handle17h80fdd4a6338ee30dE (type 7) (param i32 i32 i32)
    (local i32 i32)
    global.get $__stack_pointer
    i32.const 32
    i32.sub
    local.tee 3
    global.set $__stack_pointer
    block  ;; label = @1
      block  ;; label = @2
        local.get 1
        local.get 2
        i32.add
        local.tee 2
        local.get 1
        i32.lt_u
        br_if 0 (;@2;)
        local.get 0
        i32.const 4
        i32.add
        i32.load
        local.tee 1
        i32.const 1
        i32.shl
        local.tee 4
        local.get 2
        local.get 4
        local.get 2
        i32.gt_u
        select
        local.tee 2
        i32.const 8
        local.get 2
        i32.const 8
        i32.gt_u
        select
        local.tee 2
        i32.const -1
        i32.xor
        i32.const 31
        i32.shr_u
        local.set 4
        block  ;; label = @3
          block  ;; label = @4
            local.get 1
            i32.eqz
            br_if 0 (;@4;)
            local.get 3
            local.get 1
            i32.store offset=24
            local.get 3
            i32.const 1
            i32.store offset=20
            local.get 3
            local.get 0
            i32.load
            i32.store offset=16
            br 1 (;@3;)
          end
          local.get 3
          i32.const 0
          i32.store offset=20
        end
        local.get 3
        local.get 4
        local.get 2
        local.get 3
        i32.const 16
        i32.add
        call $_ZN5alloc7raw_vec11finish_grow17hc21a3f541a74c2c7E
        local.get 3
        i32.load offset=4
        local.set 1
        block  ;; label = @3
          local.get 3
          i32.load
          br_if 0 (;@3;)
          local.get 0
          local.get 1
          i32.store
          local.get 0
          i32.const 4
          i32.add
          local.get 2
          i32.store
          br 2 (;@1;)
        end
        local.get 1
        i32.const -2147483647
        i32.eq
        br_if 1 (;@1;)
        local.get 1
        i32.eqz
        br_if 0 (;@2;)
        local.get 1
        local.get 3
        i32.const 8
        i32.add
        i32.load
        call $_ZN5alloc5alloc18handle_alloc_error17hbbf685130f283420E
        unreachable
      end
      call $_ZN5alloc7raw_vec17capacity_overflow17h69391d2b6a90e408E
      unreachable
    end
    local.get 3
    i32.const 32
    i32.add
    global.set $__stack_pointer)
  (func $_ZN4core3ptr100drop_in_place$LT$$RF$mut$u20$std..io..Write..write_fmt..Adapter$LT$alloc..vec..Vec$LT$u8$GT$$GT$$GT$17hd4e2b285c82bbfddE (type 4) (param i32))
  (func $_ZN4core3ptr29drop_in_place$LT$$LP$$RP$$GT$17h4601b2f1c809a5c8E (type 4) (param i32))
  (func $_ZN4core3ptr42drop_in_place$LT$alloc..string..String$GT$17h55fc1a049449355bE (type 4) (param i32)
    (local i32)
    block  ;; label = @1
      local.get 0
      i32.const 4
      i32.add
      i32.load
      local.tee 1
      i32.eqz
      br_if 0 (;@1;)
      local.get 0
      i32.load
      local.get 1
      i32.const 1
      call $__rust_dealloc
    end)
  (func $_ZN4core3ptr70drop_in_place$LT$std..panicking..begin_panic_handler..PanicPayload$GT$17h8c6df4fab5d2c7ebE (type 4) (param i32)
    (local i32)
    block  ;; label = @1
      local.get 0
      i32.load offset=4
      local.tee 1
      i32.eqz
      br_if 0 (;@1;)
      local.get 0
      i32.const 8
      i32.add
      i32.load
      local.tee 0
      i32.eqz
      br_if 0 (;@1;)
      local.get 1
      local.get 0
      i32.const 1
      call $__rust_dealloc
    end)
  (func $_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17h7cac422012c51d26E (type 2) (param i32 i32) (result i32)
    (local i32 i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    local.get 0
    i32.load
    local.set 0
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            local.get 1
            i32.const 128
            i32.lt_u
            br_if 0 (;@4;)
            local.get 2
            i32.const 0
            i32.store offset=12
            local.get 1
            i32.const 2048
            i32.lt_u
            br_if 1 (;@3;)
            block  ;; label = @5
              local.get 1
              i32.const 65536
              i32.ge_u
              br_if 0 (;@5;)
              local.get 2
              local.get 1
              i32.const 63
              i32.and
              i32.const 128
              i32.or
              i32.store8 offset=14
              local.get 2
              local.get 1
              i32.const 12
              i32.shr_u
              i32.const 224
              i32.or
              i32.store8 offset=12
              local.get 2
              local.get 1
              i32.const 6
              i32.shr_u
              i32.const 63
              i32.and
              i32.const 128
              i32.or
              i32.store8 offset=13
              i32.const 3
              local.set 1
              br 3 (;@2;)
            end
            local.get 2
            local.get 1
            i32.const 63
            i32.and
            i32.const 128
            i32.or
            i32.store8 offset=15
            local.get 2
            local.get 1
            i32.const 6
            i32.shr_u
            i32.const 63
            i32.and
            i32.const 128
            i32.or
            i32.store8 offset=14
            local.get 2
            local.get 1
            i32.const 12
            i32.shr_u
            i32.const 63
            i32.and
            i32.const 128
            i32.or
            i32.store8 offset=13
            local.get 2
            local.get 1
            i32.const 18
            i32.shr_u
            i32.const 7
            i32.and
            i32.const 240
            i32.or
            i32.store8 offset=12
            i32.const 4
            local.set 1
            br 2 (;@2;)
          end
          block  ;; label = @4
            local.get 0
            i32.load offset=8
            local.tee 3
            local.get 0
            i32.load offset=4
            i32.ne
            br_if 0 (;@4;)
            local.get 0
            local.get 3
            call $_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$16reserve_for_push17h665e9c8dc83233d8E
            local.get 0
            i32.load offset=8
            local.set 3
          end
          local.get 0
          local.get 3
          i32.const 1
          i32.add
          i32.store offset=8
          local.get 0
          i32.load
          local.get 3
          i32.add
          local.get 1
          i32.store8
          br 2 (;@1;)
        end
        local.get 2
        local.get 1
        i32.const 63
        i32.and
        i32.const 128
        i32.or
        i32.store8 offset=13
        local.get 2
        local.get 1
        i32.const 6
        i32.shr_u
        i32.const 192
        i32.or
        i32.store8 offset=12
        i32.const 2
        local.set 1
      end
      block  ;; label = @2
        local.get 0
        i32.load offset=4
        local.get 0
        i32.load offset=8
        local.tee 3
        i32.sub
        local.get 1
        i32.ge_u
        br_if 0 (;@2;)
        local.get 0
        local.get 3
        local.get 1
        call $_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$7reserve21do_reserve_and_handle17h80fdd4a6338ee30dE
        local.get 0
        i32.load offset=8
        local.set 3
      end
      local.get 0
      i32.load
      local.get 3
      i32.add
      local.get 2
      i32.const 12
      i32.add
      local.get 1
      call $memcpy
      drop
      local.get 0
      local.get 3
      local.get 1
      i32.add
      i32.store offset=8
    end
    local.get 2
    i32.const 16
    i32.add
    global.set $__stack_pointer
    i32.const 0)
  (func $_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$16reserve_for_push17h665e9c8dc83233d8E (type 0) (param i32 i32)
    (local i32 i32 i32)
    global.get $__stack_pointer
    i32.const 32
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    block  ;; label = @1
      block  ;; label = @2
        local.get 1
        i32.const 1
        i32.add
        local.tee 1
        i32.eqz
        br_if 0 (;@2;)
        local.get 0
        i32.const 4
        i32.add
        i32.load
        local.tee 3
        i32.const 1
        i32.shl
        local.tee 4
        local.get 1
        local.get 4
        local.get 1
        i32.gt_u
        select
        local.tee 1
        i32.const 8
        local.get 1
        i32.const 8
        i32.gt_u
        select
        local.tee 1
        i32.const -1
        i32.xor
        i32.const 31
        i32.shr_u
        local.set 4
        block  ;; label = @3
          block  ;; label = @4
            local.get 3
            i32.eqz
            br_if 0 (;@4;)
            local.get 2
            local.get 3
            i32.store offset=24
            local.get 2
            i32.const 1
            i32.store offset=20
            local.get 2
            local.get 0
            i32.load
            i32.store offset=16
            br 1 (;@3;)
          end
          local.get 2
          i32.const 0
          i32.store offset=20
        end
        local.get 2
        local.get 4
        local.get 1
        local.get 2
        i32.const 16
        i32.add
        call $_ZN5alloc7raw_vec11finish_grow17hc21a3f541a74c2c7E
        local.get 2
        i32.load offset=4
        local.set 3
        block  ;; label = @3
          local.get 2
          i32.load
          br_if 0 (;@3;)
          local.get 0
          local.get 3
          i32.store
          local.get 0
          i32.const 4
          i32.add
          local.get 1
          i32.store
          br 2 (;@1;)
        end
        local.get 3
        i32.const -2147483647
        i32.eq
        br_if 1 (;@1;)
        local.get 3
        i32.eqz
        br_if 0 (;@2;)
        local.get 3
        local.get 2
        i32.const 8
        i32.add
        i32.load
        call $_ZN5alloc5alloc18handle_alloc_error17hbbf685130f283420E
        unreachable
      end
      call $_ZN5alloc7raw_vec17capacity_overflow17h69391d2b6a90e408E
      unreachable
    end
    local.get 2
    i32.const 32
    i32.add
    global.set $__stack_pointer)
  (func $_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$9write_fmt17h8ae0b2b6f28f8ca0E (type 2) (param i32 i32) (result i32)
    (local i32)
    global.get $__stack_pointer
    i32.const 32
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    local.get 0
    i32.load
    local.set 0
    local.get 2
    i32.const 8
    i32.add
    i32.const 16
    i32.add
    local.get 1
    i32.const 16
    i32.add
    i64.load align=4
    i64.store
    local.get 2
    i32.const 8
    i32.add
    i32.const 8
    i32.add
    local.get 1
    i32.const 8
    i32.add
    i64.load align=4
    i64.store
    local.get 2
    local.get 1
    i64.load align=4
    i64.store offset=8
    local.get 2
    local.get 0
    i32.store offset=4
    local.get 2
    i32.const 4
    i32.add
    i32.const 1049072
    local.get 2
    i32.const 8
    i32.add
    call $_ZN4core3fmt5write17hce4d120ebbfb2b82E
    local.set 1
    local.get 2
    i32.const 32
    i32.add
    global.set $__stack_pointer
    local.get 1)
  (func $_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$9write_str17he71ac95e8290658dE (type 1) (param i32 i32 i32) (result i32)
    (local i32)
    block  ;; label = @1
      local.get 0
      i32.load
      local.tee 0
      i32.load offset=4
      local.get 0
      i32.load offset=8
      local.tee 3
      i32.sub
      local.get 2
      i32.ge_u
      br_if 0 (;@1;)
      local.get 0
      local.get 3
      local.get 2
      call $_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$7reserve21do_reserve_and_handle17h80fdd4a6338ee30dE
      local.get 0
      i32.load offset=8
      local.set 3
    end
    local.get 0
    i32.load
    local.get 3
    i32.add
    local.get 1
    local.get 2
    call $memcpy
    drop
    local.get 0
    local.get 3
    local.get 2
    i32.add
    i32.store offset=8
    i32.const 0)
  (func $_ZN5alloc7raw_vec11finish_grow17hc21a3f541a74c2c7E (type 6) (param i32 i32 i32 i32)
    (local i32)
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          local.get 1
          i32.eqz
          br_if 0 (;@3;)
          local.get 2
          i32.const -1
          i32.le_s
          br_if 1 (;@2;)
          block  ;; label = @4
            block  ;; label = @5
              block  ;; label = @6
                local.get 3
                i32.load offset=4
                i32.eqz
                br_if 0 (;@6;)
                block  ;; label = @7
                  local.get 3
                  i32.const 8
                  i32.add
                  i32.load
                  local.tee 4
                  br_if 0 (;@7;)
                  block  ;; label = @8
                    local.get 2
                    br_if 0 (;@8;)
                    local.get 1
                    local.set 3
                    br 4 (;@4;)
                  end
                  i32.const 0
                  i32.load8_u offset=1049941
                  drop
                  br 2 (;@5;)
                end
                local.get 3
                i32.load
                local.get 4
                local.get 1
                local.get 2
                call $__rust_realloc
                local.set 3
                br 2 (;@4;)
              end
              block  ;; label = @6
                local.get 2
                br_if 0 (;@6;)
                local.get 1
                local.set 3
                br 2 (;@4;)
              end
              i32.const 0
              i32.load8_u offset=1049941
              drop
            end
            local.get 2
            local.get 1
            call $__rust_alloc
            local.set 3
          end
          block  ;; label = @4
            local.get 3
            i32.eqz
            br_if 0 (;@4;)
            local.get 0
            local.get 3
            i32.store offset=4
            local.get 0
            i32.const 8
            i32.add
            local.get 2
            i32.store
            local.get 0
            i32.const 0
            i32.store
            return
          end
          local.get 0
          local.get 1
          i32.store offset=4
          local.get 0
          i32.const 8
          i32.add
          local.get 2
          i32.store
          br 2 (;@1;)
        end
        local.get 0
        i32.const 0
        i32.store offset=4
        local.get 0
        i32.const 8
        i32.add
        local.get 2
        i32.store
        br 1 (;@1;)
      end
      local.get 0
      i32.const 0
      i32.store offset=4
    end
    local.get 0
    i32.const 1
    i32.store)
  (func $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$13dispose_chunk17h814c7cfd84378e6aE (type 0) (param i32 i32)
    (local i32 i32 i32 i32)
    local.get 0
    local.get 1
    call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h9b67d52a46bbff2cE
    local.set 2
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          local.get 0
          call $_ZN8dlmalloc8dlmalloc5Chunk6pinuse17hc6c9f01d2e3fbf67E
          br_if 0 (;@3;)
          local.get 0
          i32.load
          local.set 3
          block  ;; label = @4
            local.get 0
            call $_ZN8dlmalloc8dlmalloc5Chunk7mmapped17h78a75c1ab0261090E
            br_if 0 (;@4;)
            local.get 3
            local.get 1
            i32.add
            local.set 1
            block  ;; label = @5
              local.get 0
              local.get 3
              call $_ZN8dlmalloc8dlmalloc5Chunk12minus_offset17h9670d4355605a879E
              local.tee 0
              i32.const 0
              i32.load offset=1050392
              i32.ne
              br_if 0 (;@5;)
              local.get 2
              i32.load offset=4
              i32.const 3
              i32.and
              i32.const 3
              i32.ne
              br_if 2 (;@3;)
              i32.const 0
              local.get 1
              i32.store offset=1050384
              local.get 0
              local.get 1
              local.get 2
              call $_ZN8dlmalloc8dlmalloc5Chunk20set_free_with_pinuse17h2b5f242508300075E
              return
            end
            block  ;; label = @5
              local.get 3
              i32.const 256
              i32.lt_u
              br_if 0 (;@5;)
              local.get 0
              call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$18unlink_large_chunk17hb47d8811580bf409E
              br 2 (;@3;)
            end
            block  ;; label = @5
              local.get 0
              i32.const 12
              i32.add
              i32.load
              local.tee 4
              local.get 0
              i32.const 8
              i32.add
              i32.load
              local.tee 5
              i32.eq
              br_if 0 (;@5;)
              local.get 5
              local.get 4
              i32.store offset=12
              local.get 4
              local.get 5
              i32.store offset=8
              br 2 (;@3;)
            end
            i32.const 0
            i32.const 0
            i32.load offset=1050376
            i32.const -2
            local.get 3
            i32.const 3
            i32.shr_u
            i32.rotl
            i32.and
            i32.store offset=1050376
            br 1 (;@3;)
          end
          i32.const 1049968
          local.get 0
          local.get 3
          i32.sub
          local.get 3
          local.get 1
          i32.add
          i32.const 16
          i32.add
          local.tee 0
          call $_ZN61_$LT$dlmalloc..sys..System$u20$as$u20$dlmalloc..Allocator$GT$4free17hd714605ffb598b3fE
          i32.eqz
          br_if 1 (;@2;)
          i32.const 0
          i32.const 0
          i32.load offset=1050400
          local.get 0
          i32.sub
          i32.store offset=1050400
          return
        end
        block  ;; label = @3
          local.get 2
          call $_ZN8dlmalloc8dlmalloc5Chunk6cinuse17h1ffe85bfa307cbe6E
          i32.eqz
          br_if 0 (;@3;)
          local.get 0
          local.get 1
          local.get 2
          call $_ZN8dlmalloc8dlmalloc5Chunk20set_free_with_pinuse17h2b5f242508300075E
          br 2 (;@1;)
        end
        block  ;; label = @3
          block  ;; label = @4
            local.get 2
            i32.const 0
            i32.load offset=1050396
            i32.eq
            br_if 0 (;@4;)
            local.get 2
            i32.const 0
            i32.load offset=1050392
            i32.eq
            br_if 1 (;@3;)
            local.get 2
            call $_ZN8dlmalloc8dlmalloc5Chunk4size17h7f97819e0e1a81b6E
            local.tee 3
            local.get 1
            i32.add
            local.set 1
            block  ;; label = @5
              block  ;; label = @6
                local.get 3
                i32.const 256
                i32.lt_u
                br_if 0 (;@6;)
                local.get 2
                call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$18unlink_large_chunk17hb47d8811580bf409E
                br 1 (;@5;)
              end
              block  ;; label = @6
                local.get 2
                i32.const 12
                i32.add
                i32.load
                local.tee 4
                local.get 2
                i32.const 8
                i32.add
                i32.load
                local.tee 2
                i32.eq
                br_if 0 (;@6;)
                local.get 2
                local.get 4
                i32.store offset=12
                local.get 4
                local.get 2
                i32.store offset=8
                br 1 (;@5;)
              end
              i32.const 0
              i32.const 0
              i32.load offset=1050376
              i32.const -2
              local.get 3
              i32.const 3
              i32.shr_u
              i32.rotl
              i32.and
              i32.store offset=1050376
            end
            local.get 0
            local.get 1
            call $_ZN8dlmalloc8dlmalloc5Chunk33set_size_and_pinuse_of_free_chunk17habe76bbe555b1e73E
            local.get 0
            i32.const 0
            i32.load offset=1050392
            i32.ne
            br_if 3 (;@1;)
            i32.const 0
            local.get 1
            i32.store offset=1050384
            br 2 (;@2;)
          end
          i32.const 0
          local.get 0
          i32.store offset=1050396
          i32.const 0
          i32.const 0
          i32.load offset=1050388
          local.get 1
          i32.add
          local.tee 1
          i32.store offset=1050388
          local.get 0
          local.get 1
          i32.const 1
          i32.or
          i32.store offset=4
          local.get 0
          i32.const 0
          i32.load offset=1050392
          i32.ne
          br_if 1 (;@2;)
          i32.const 0
          i32.const 0
          i32.store offset=1050384
          i32.const 0
          i32.const 0
          i32.store offset=1050392
          return
        end
        i32.const 0
        local.get 0
        i32.store offset=1050392
        i32.const 0
        i32.const 0
        i32.load offset=1050384
        local.get 1
        i32.add
        local.tee 1
        i32.store offset=1050384
        local.get 0
        local.get 1
        call $_ZN8dlmalloc8dlmalloc5Chunk33set_size_and_pinuse_of_free_chunk17habe76bbe555b1e73E
        return
      end
      return
    end
    block  ;; label = @1
      local.get 1
      i32.const 256
      i32.lt_u
      br_if 0 (;@1;)
      local.get 0
      local.get 1
      call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$18insert_large_chunk17h2634ef33b3af9a32E
      return
    end
    local.get 1
    i32.const -8
    i32.and
    i32.const 1050112
    i32.add
    local.set 2
    block  ;; label = @1
      block  ;; label = @2
        i32.const 0
        i32.load offset=1050376
        local.tee 3
        i32.const 1
        local.get 1
        i32.const 3
        i32.shr_u
        i32.shl
        local.tee 1
        i32.and
        i32.eqz
        br_if 0 (;@2;)
        local.get 2
        i32.load offset=8
        local.set 1
        br 1 (;@1;)
      end
      i32.const 0
      local.get 3
      local.get 1
      i32.or
      i32.store offset=1050376
      local.get 2
      local.set 1
    end
    local.get 2
    local.get 0
    i32.store offset=8
    local.get 1
    local.get 0
    i32.store offset=12
    local.get 0
    local.get 2
    i32.store offset=12
    local.get 0
    local.get 1
    i32.store offset=8)
  (func $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$18unlink_large_chunk17hb47d8811580bf409E (type 4) (param i32)
    (local i32 i32 i32 i32 i32)
    local.get 0
    i32.load offset=24
    local.set 1
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          local.get 0
          call $_ZN8dlmalloc8dlmalloc9TreeChunk4next17h1b01b32aed8bcb04E
          local.get 0
          i32.ne
          br_if 0 (;@3;)
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
          local.tee 4
          br_if 1 (;@2;)
          i32.const 0
          local.set 2
          br 2 (;@1;)
        end
        local.get 0
        call $_ZN8dlmalloc8dlmalloc9TreeChunk4prev17h2dd3935342ae5ab3E
        local.tee 4
        local.get 0
        call $_ZN8dlmalloc8dlmalloc9TreeChunk4next17h1b01b32aed8bcb04E
        local.tee 2
        call $_ZN8dlmalloc8dlmalloc9TreeChunk5chunk17h4562a4235ab5a16eE
        i32.store offset=12
        local.get 2
        local.get 4
        call $_ZN8dlmalloc8dlmalloc9TreeChunk5chunk17h4562a4235ab5a16eE
        i32.store offset=8
        br 1 (;@1;)
      end
      local.get 2
      local.get 0
      i32.const 16
      i32.add
      local.get 3
      select
      local.set 3
      loop  ;; label = @2
        local.get 3
        local.set 5
        local.get 4
        local.tee 2
        i32.const 20
        i32.add
        local.tee 4
        local.get 2
        i32.const 16
        i32.add
        local.get 4
        i32.load
        local.tee 4
        select
        local.set 3
        local.get 2
        i32.const 20
        i32.const 16
        local.get 4
        select
        i32.add
        i32.load
        local.tee 4
        br_if 0 (;@2;)
      end
      local.get 5
      i32.const 0
      i32.store
    end
    block  ;; label = @1
      local.get 1
      i32.eqz
      br_if 0 (;@1;)
      block  ;; label = @2
        block  ;; label = @3
          local.get 0
          i32.load offset=28
          i32.const 2
          i32.shl
          i32.const 1049968
          i32.add
          local.tee 4
          i32.load
          local.get 0
          i32.eq
          br_if 0 (;@3;)
          local.get 1
          i32.const 16
          i32.const 20
          local.get 1
          i32.load offset=16
          local.get 0
          i32.eq
          select
          i32.add
          local.get 2
          i32.store
          local.get 2
          br_if 1 (;@2;)
          br 2 (;@1;)
        end
        local.get 4
        local.get 2
        i32.store
        local.get 2
        br_if 0 (;@2;)
        i32.const 0
        i32.const 0
        i32.load offset=1050380
        i32.const -2
        local.get 0
        i32.load offset=28
        i32.rotl
        i32.and
        i32.store offset=1050380
        return
      end
      local.get 2
      local.get 1
      i32.store offset=24
      block  ;; label = @2
        local.get 0
        i32.load offset=16
        local.tee 4
        i32.eqz
        br_if 0 (;@2;)
        local.get 2
        local.get 4
        i32.store offset=16
        local.get 4
        local.get 2
        i32.store offset=24
      end
      local.get 0
      i32.const 20
      i32.add
      i32.load
      local.tee 4
      i32.eqz
      br_if 0 (;@1;)
      local.get 2
      i32.const 20
      i32.add
      local.get 4
      i32.store
      local.get 4
      local.get 2
      i32.store offset=24
      return
    end)
  (func $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$18insert_large_chunk17h2634ef33b3af9a32E (type 0) (param i32 i32)
    (local i32 i32 i32 i32 i32)
    i32.const 0
    local.set 2
    block  ;; label = @1
      local.get 1
      i32.const 256
      i32.lt_u
      br_if 0 (;@1;)
      i32.const 31
      local.set 2
      local.get 1
      i32.const 16777215
      i32.gt_u
      br_if 0 (;@1;)
      local.get 1
      i32.const 6
      local.get 1
      i32.const 8
      i32.shr_u
      i32.clz
      local.tee 2
      i32.sub
      i32.shr_u
      i32.const 1
      i32.and
      local.get 2
      i32.const 1
      i32.shl
      i32.sub
      i32.const 62
      i32.add
      local.set 2
    end
    local.get 0
    i64.const 0
    i64.store offset=16 align=4
    local.get 0
    local.get 2
    i32.store offset=28
    local.get 2
    i32.const 2
    i32.shl
    i32.const 1049968
    i32.add
    local.set 3
    local.get 0
    call $_ZN8dlmalloc8dlmalloc9TreeChunk5chunk17h4562a4235ab5a16eE
    local.set 4
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              i32.const 0
              i32.load offset=1050380
              local.tee 5
              i32.const 1
              local.get 2
              i32.shl
              local.tee 6
              i32.and
              i32.eqz
              br_if 0 (;@5;)
              local.get 3
              i32.load
              local.set 5
              local.get 2
              call $_ZN8dlmalloc8dlmalloc24leftshift_for_tree_index17hbd308eba79453696E
              local.set 2
              local.get 5
              call $_ZN8dlmalloc8dlmalloc9TreeChunk5chunk17h4562a4235ab5a16eE
              call $_ZN8dlmalloc8dlmalloc5Chunk4size17h7f97819e0e1a81b6E
              local.get 1
              i32.ne
              br_if 1 (;@4;)
              local.get 5
              local.set 2
              br 2 (;@3;)
            end
            i32.const 0
            local.get 5
            local.get 6
            i32.or
            i32.store offset=1050380
            local.get 3
            local.get 0
            i32.store
            local.get 0
            local.get 3
            i32.store offset=24
            br 3 (;@1;)
          end
          local.get 1
          local.get 2
          i32.shl
          local.set 3
          loop  ;; label = @4
            local.get 5
            local.get 3
            i32.const 29
            i32.shr_u
            i32.const 4
            i32.and
            i32.add
            i32.const 16
            i32.add
            local.tee 6
            i32.load
            local.tee 2
            i32.eqz
            br_if 2 (;@2;)
            local.get 3
            i32.const 1
            i32.shl
            local.set 3
            local.get 2
            local.set 5
            local.get 2
            call $_ZN8dlmalloc8dlmalloc9TreeChunk5chunk17h4562a4235ab5a16eE
            call $_ZN8dlmalloc8dlmalloc5Chunk4size17h7f97819e0e1a81b6E
            local.get 1
            i32.ne
            br_if 0 (;@4;)
          end
        end
        local.get 2
        call $_ZN8dlmalloc8dlmalloc9TreeChunk5chunk17h4562a4235ab5a16eE
        local.tee 2
        i32.load offset=8
        local.tee 3
        local.get 4
        i32.store offset=12
        local.get 2
        local.get 4
        i32.store offset=8
        local.get 4
        local.get 2
        i32.store offset=12
        local.get 4
        local.get 3
        i32.store offset=8
        local.get 0
        i32.const 0
        i32.store offset=24
        return
      end
      local.get 6
      local.get 0
      i32.store
      local.get 0
      local.get 5
      i32.store offset=24
    end
    local.get 4
    local.get 4
    i32.store offset=8
    local.get 4
    local.get 4
    i32.store offset=12)
  (func $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$23release_unused_segments17h3a36e1b255959a68E (type 11) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    i32.const 0
    local.set 0
    i32.const 0
    local.set 1
    block  ;; label = @1
      i32.const 0
      i32.load offset=1050104
      local.tee 2
      i32.eqz
      br_if 0 (;@1;)
      i32.const 1050096
      local.set 3
      i32.const 0
      local.set 1
      i32.const 0
      local.set 0
      loop  ;; label = @2
        local.get 2
        local.tee 4
        i32.load offset=8
        local.set 2
        local.get 4
        i32.load offset=4
        local.set 5
        local.get 4
        i32.load
        local.set 6
        block  ;; label = @3
          block  ;; label = @4
            i32.const 1049968
            local.get 4
            i32.load offset=12
            i32.const 1
            i32.shr_u
            call $_ZN61_$LT$dlmalloc..sys..System$u20$as$u20$dlmalloc..Allocator$GT$16can_release_part17h9678d24cb077bde0E
            i32.eqz
            br_if 0 (;@4;)
            local.get 4
            call $_ZN8dlmalloc8dlmalloc7Segment9is_extern17h3cbba93f4e5cfab1E
            br_if 0 (;@4;)
            local.get 6
            local.get 6
            call $_ZN8dlmalloc8dlmalloc5Chunk6to_mem17hc02bf0af126119c0E
            local.tee 7
            i32.const 8
            call $_ZN8dlmalloc8dlmalloc8align_up17h0e87fd8a6d5b4dd0E
            local.get 7
            i32.sub
            i32.add
            local.tee 7
            call $_ZN8dlmalloc8dlmalloc5Chunk4size17h7f97819e0e1a81b6E
            local.set 8
            call $_ZN8dlmalloc8dlmalloc5Chunk10mem_offset17h2818126ab4d4ccc1E
            local.tee 9
            i32.const 8
            call $_ZN8dlmalloc8dlmalloc8align_up17h0e87fd8a6d5b4dd0E
            local.set 10
            i32.const 20
            i32.const 8
            call $_ZN8dlmalloc8dlmalloc8align_up17h0e87fd8a6d5b4dd0E
            local.set 11
            i32.const 16
            i32.const 8
            call $_ZN8dlmalloc8dlmalloc8align_up17h0e87fd8a6d5b4dd0E
            local.set 12
            local.get 7
            call $_ZN8dlmalloc8dlmalloc5Chunk5inuse17h6a9390afcf3c4f59E
            br_if 0 (;@4;)
            local.get 7
            local.get 8
            i32.add
            local.get 6
            local.get 9
            local.get 5
            i32.add
            local.get 10
            local.get 11
            i32.add
            local.get 12
            i32.add
            i32.sub
            i32.add
            i32.lt_u
            br_if 0 (;@4;)
            block  ;; label = @5
              block  ;; label = @6
                local.get 7
                i32.const 0
                i32.load offset=1050392
                i32.eq
                br_if 0 (;@6;)
                local.get 7
                call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$18unlink_large_chunk17hb47d8811580bf409E
                br 1 (;@5;)
              end
              i32.const 0
              i32.const 0
              i32.store offset=1050384
              i32.const 0
              i32.const 0
              i32.store offset=1050392
            end
            block  ;; label = @5
              i32.const 1049968
              local.get 6
              local.get 5
              call $_ZN61_$LT$dlmalloc..sys..System$u20$as$u20$dlmalloc..Allocator$GT$4free17hd714605ffb598b3fE
              br_if 0 (;@5;)
              local.get 7
              local.get 8
              call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$18insert_large_chunk17h2634ef33b3af9a32E
              br 1 (;@4;)
            end
            i32.const 0
            i32.const 0
            i32.load offset=1050400
            local.get 5
            i32.sub
            i32.store offset=1050400
            local.get 3
            local.get 2
            i32.store offset=8
            local.get 5
            local.get 1
            i32.add
            local.set 1
            br 1 (;@3;)
          end
          local.get 4
          local.set 3
        end
        local.get 0
        i32.const 1
        i32.add
        local.set 0
        local.get 2
        br_if 0 (;@2;)
      end
    end
    i32.const 0
    local.get 0
    i32.const 4095
    local.get 0
    i32.const 4095
    i32.gt_u
    select
    i32.store offset=1050416
    local.get 1)
  (func $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$4free17h38a840ecb1c1c0fbE (type 4) (param i32)
    (local i32 i32 i32 i32 i32 i32)
    local.get 0
    call $_ZN8dlmalloc8dlmalloc5Chunk8from_mem17h580b9f140f06bda7E
    local.set 0
    local.get 0
    local.get 0
    call $_ZN8dlmalloc8dlmalloc5Chunk4size17h7f97819e0e1a81b6E
    local.tee 1
    call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h9b67d52a46bbff2cE
    local.set 2
    block  ;; label = @1
      block  ;; label = @2
        local.get 0
        call $_ZN8dlmalloc8dlmalloc5Chunk6pinuse17hc6c9f01d2e3fbf67E
        br_if 0 (;@2;)
        local.get 0
        i32.load
        local.set 3
        block  ;; label = @3
          local.get 0
          call $_ZN8dlmalloc8dlmalloc5Chunk7mmapped17h78a75c1ab0261090E
          br_if 0 (;@3;)
          local.get 3
          local.get 1
          i32.add
          local.set 1
          block  ;; label = @4
            local.get 0
            local.get 3
            call $_ZN8dlmalloc8dlmalloc5Chunk12minus_offset17h9670d4355605a879E
            local.tee 0
            i32.const 0
            i32.load offset=1050392
            i32.ne
            br_if 0 (;@4;)
            local.get 2
            i32.load offset=4
            i32.const 3
            i32.and
            i32.const 3
            i32.ne
            br_if 2 (;@2;)
            i32.const 0
            local.get 1
            i32.store offset=1050384
            local.get 0
            local.get 1
            local.get 2
            call $_ZN8dlmalloc8dlmalloc5Chunk20set_free_with_pinuse17h2b5f242508300075E
            return
          end
          block  ;; label = @4
            local.get 3
            i32.const 256
            i32.lt_u
            br_if 0 (;@4;)
            local.get 0
            call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$18unlink_large_chunk17hb47d8811580bf409E
            br 2 (;@2;)
          end
          block  ;; label = @4
            local.get 0
            i32.const 12
            i32.add
            i32.load
            local.tee 4
            local.get 0
            i32.const 8
            i32.add
            i32.load
            local.tee 5
            i32.eq
            br_if 0 (;@4;)
            local.get 5
            local.get 4
            i32.store offset=12
            local.get 4
            local.get 5
            i32.store offset=8
            br 2 (;@2;)
          end
          i32.const 0
          i32.const 0
          i32.load offset=1050376
          i32.const -2
          local.get 3
          i32.const 3
          i32.shr_u
          i32.rotl
          i32.and
          i32.store offset=1050376
          br 1 (;@2;)
        end
        i32.const 1049968
        local.get 0
        local.get 3
        i32.sub
        local.get 3
        local.get 1
        i32.add
        i32.const 16
        i32.add
        local.tee 0
        call $_ZN61_$LT$dlmalloc..sys..System$u20$as$u20$dlmalloc..Allocator$GT$4free17hd714605ffb598b3fE
        i32.eqz
        br_if 1 (;@1;)
        i32.const 0
        i32.const 0
        i32.load offset=1050400
        local.get 0
        i32.sub
        i32.store offset=1050400
        return
      end
      block  ;; label = @2
        block  ;; label = @3
          local.get 2
          call $_ZN8dlmalloc8dlmalloc5Chunk6cinuse17h1ffe85bfa307cbe6E
          i32.eqz
          br_if 0 (;@3;)
          local.get 0
          local.get 1
          local.get 2
          call $_ZN8dlmalloc8dlmalloc5Chunk20set_free_with_pinuse17h2b5f242508300075E
          br 1 (;@2;)
        end
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              block  ;; label = @6
                local.get 2
                i32.const 0
                i32.load offset=1050396
                i32.eq
                br_if 0 (;@6;)
                local.get 2
                i32.const 0
                i32.load offset=1050392
                i32.eq
                br_if 1 (;@5;)
                local.get 2
                call $_ZN8dlmalloc8dlmalloc5Chunk4size17h7f97819e0e1a81b6E
                local.tee 3
                local.get 1
                i32.add
                local.set 1
                block  ;; label = @7
                  block  ;; label = @8
                    local.get 3
                    i32.const 256
                    i32.lt_u
                    br_if 0 (;@8;)
                    local.get 2
                    call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$18unlink_large_chunk17hb47d8811580bf409E
                    br 1 (;@7;)
                  end
                  block  ;; label = @8
                    local.get 2
                    i32.const 12
                    i32.add
                    i32.load
                    local.tee 4
                    local.get 2
                    i32.const 8
                    i32.add
                    i32.load
                    local.tee 2
                    i32.eq
                    br_if 0 (;@8;)
                    local.get 2
                    local.get 4
                    i32.store offset=12
                    local.get 4
                    local.get 2
                    i32.store offset=8
                    br 1 (;@7;)
                  end
                  i32.const 0
                  i32.const 0
                  i32.load offset=1050376
                  i32.const -2
                  local.get 3
                  i32.const 3
                  i32.shr_u
                  i32.rotl
                  i32.and
                  i32.store offset=1050376
                end
                local.get 0
                local.get 1
                call $_ZN8dlmalloc8dlmalloc5Chunk33set_size_and_pinuse_of_free_chunk17habe76bbe555b1e73E
                local.get 0
                i32.const 0
                i32.load offset=1050392
                i32.ne
                br_if 4 (;@2;)
                i32.const 0
                local.get 1
                i32.store offset=1050384
                return
              end
              i32.const 0
              local.get 0
              i32.store offset=1050396
              i32.const 0
              i32.const 0
              i32.load offset=1050388
              local.get 1
              i32.add
              local.tee 1
              i32.store offset=1050388
              local.get 0
              local.get 1
              i32.const 1
              i32.or
              i32.store offset=4
              local.get 0
              i32.const 0
              i32.load offset=1050392
              i32.eq
              br_if 1 (;@4;)
              br 2 (;@3;)
            end
            i32.const 0
            local.get 0
            i32.store offset=1050392
            i32.const 0
            i32.const 0
            i32.load offset=1050384
            local.get 1
            i32.add
            local.tee 1
            i32.store offset=1050384
            local.get 0
            local.get 1
            call $_ZN8dlmalloc8dlmalloc5Chunk33set_size_and_pinuse_of_free_chunk17habe76bbe555b1e73E
            return
          end
          i32.const 0
          i32.const 0
          i32.store offset=1050384
          i32.const 0
          i32.const 0
          i32.store offset=1050392
        end
        local.get 1
        i32.const 0
        i32.load offset=1050408
        i32.le_u
        br_if 1 (;@1;)
        call $_ZN8dlmalloc8dlmalloc5Chunk10mem_offset17h2818126ab4d4ccc1E
        local.tee 0
        i32.const 8
        call $_ZN8dlmalloc8dlmalloc8align_up17h0e87fd8a6d5b4dd0E
        local.set 1
        i32.const 20
        i32.const 8
        call $_ZN8dlmalloc8dlmalloc8align_up17h0e87fd8a6d5b4dd0E
        local.set 2
        i32.const 16
        i32.const 8
        call $_ZN8dlmalloc8dlmalloc8align_up17h0e87fd8a6d5b4dd0E
        local.set 3
        i32.const 0
        i32.const 16
        i32.const 8
        call $_ZN8dlmalloc8dlmalloc8align_up17h0e87fd8a6d5b4dd0E
        i32.const 2
        i32.shl
        i32.sub
        local.tee 4
        local.get 0
        local.get 3
        local.get 1
        local.get 2
        i32.add
        i32.add
        i32.sub
        i32.const -65544
        i32.add
        i32.const -9
        i32.and
        i32.const -3
        i32.add
        local.tee 0
        local.get 4
        local.get 0
        i32.lt_u
        select
        i32.eqz
        br_if 1 (;@1;)
        i32.const 0
        i32.load offset=1050396
        i32.eqz
        br_if 1 (;@1;)
        call $_ZN8dlmalloc8dlmalloc5Chunk10mem_offset17h2818126ab4d4ccc1E
        local.tee 0
        i32.const 8
        call $_ZN8dlmalloc8dlmalloc8align_up17h0e87fd8a6d5b4dd0E
        local.set 1
        i32.const 20
        i32.const 8
        call $_ZN8dlmalloc8dlmalloc8align_up17h0e87fd8a6d5b4dd0E
        local.set 3
        i32.const 16
        i32.const 8
        call $_ZN8dlmalloc8dlmalloc8align_up17h0e87fd8a6d5b4dd0E
        local.set 4
        i32.const 0
        local.set 2
        block  ;; label = @3
          i32.const 0
          i32.load offset=1050388
          local.tee 5
          local.get 4
          local.get 3
          local.get 1
          local.get 0
          i32.sub
          i32.add
          i32.add
          local.tee 0
          i32.le_u
          br_if 0 (;@3;)
          local.get 5
          local.get 0
          i32.sub
          i32.const 65535
          i32.add
          i32.const -65536
          i32.and
          local.tee 4
          i32.const -65536
          i32.add
          local.set 3
          i32.const 0
          i32.load offset=1050396
          local.set 1
          i32.const 1050096
          local.set 0
          block  ;; label = @4
            loop  ;; label = @5
              block  ;; label = @6
                local.get 0
                i32.load
                local.get 1
                i32.gt_u
                br_if 0 (;@6;)
                local.get 0
                call $_ZN8dlmalloc8dlmalloc7Segment3top17h96cd19ac0fd36e05E
                local.get 1
                i32.gt_u
                br_if 2 (;@4;)
              end
              local.get 0
              i32.load offset=8
              local.tee 0
              br_if 0 (;@5;)
            end
            i32.const 0
            local.set 0
          end
          i32.const 0
          local.set 2
          local.get 0
          call $_ZN8dlmalloc8dlmalloc7Segment9is_extern17h3cbba93f4e5cfab1E
          br_if 0 (;@3;)
          i32.const 1049968
          local.get 0
          i32.load offset=12
          i32.const 1
          i32.shr_u
          call $_ZN61_$LT$dlmalloc..sys..System$u20$as$u20$dlmalloc..Allocator$GT$16can_release_part17h9678d24cb077bde0E
          i32.eqz
          br_if 0 (;@3;)
          local.get 0
          i32.load offset=4
          local.get 3
          i32.lt_u
          br_if 0 (;@3;)
          i32.const 1050096
          local.set 1
          loop  ;; label = @4
            local.get 0
            local.get 1
            call $_ZN8dlmalloc8dlmalloc7Segment5holds17he3b1db583c6e4172E
            br_if 1 (;@3;)
            local.get 1
            i32.load offset=8
            local.tee 1
            br_if 0 (;@4;)
          end
          i32.const 1049968
          local.get 0
          i32.load
          local.get 0
          i32.load offset=4
          local.tee 1
          local.get 1
          local.get 3
          i32.sub
          call $_ZN61_$LT$dlmalloc..sys..System$u20$as$u20$dlmalloc..Allocator$GT$9free_part17had77920da45d8a75E
          i32.eqz
          br_if 0 (;@3;)
          local.get 3
          i32.eqz
          br_if 0 (;@3;)
          local.get 0
          local.get 0
          i32.load offset=4
          local.get 3
          i32.sub
          i32.store offset=4
          i32.const 0
          i32.const 0
          i32.load offset=1050400
          local.get 3
          i32.sub
          i32.store offset=1050400
          i32.const 0
          i32.load offset=1050388
          local.set 1
          i32.const 0
          i32.load offset=1050396
          local.set 0
          i32.const 0
          local.get 0
          local.get 0
          call $_ZN8dlmalloc8dlmalloc5Chunk6to_mem17hc02bf0af126119c0E
          local.tee 2
          i32.const 8
          call $_ZN8dlmalloc8dlmalloc8align_up17h0e87fd8a6d5b4dd0E
          local.get 2
          i32.sub
          local.tee 2
          call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h9b67d52a46bbff2cE
          local.tee 0
          i32.store offset=1050396
          i32.const 0
          local.get 1
          local.get 4
          local.get 2
          i32.add
          i32.sub
          i32.const 65536
          i32.add
          local.tee 1
          i32.store offset=1050388
          local.get 0
          local.get 1
          i32.const 1
          i32.or
          i32.store offset=4
          call $_ZN8dlmalloc8dlmalloc5Chunk10mem_offset17h2818126ab4d4ccc1E
          local.tee 2
          i32.const 8
          call $_ZN8dlmalloc8dlmalloc8align_up17h0e87fd8a6d5b4dd0E
          local.set 4
          i32.const 20
          i32.const 8
          call $_ZN8dlmalloc8dlmalloc8align_up17h0e87fd8a6d5b4dd0E
          local.set 5
          i32.const 16
          i32.const 8
          call $_ZN8dlmalloc8dlmalloc8align_up17h0e87fd8a6d5b4dd0E
          local.set 6
          local.get 0
          local.get 1
          call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h9b67d52a46bbff2cE
          local.get 6
          local.get 5
          local.get 4
          local.get 2
          i32.sub
          i32.add
          i32.add
          i32.store offset=4
          i32.const 0
          i32.const 2097152
          i32.store offset=1050408
          local.get 3
          local.set 2
        end
        call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$23release_unused_segments17h3a36e1b255959a68E
        i32.const 0
        local.get 2
        i32.sub
        i32.ne
        br_if 1 (;@1;)
        i32.const 0
        i32.load offset=1050388
        i32.const 0
        i32.load offset=1050408
        i32.le_u
        br_if 1 (;@1;)
        i32.const 0
        i32.const -1
        i32.store offset=1050408
        return
      end
      block  ;; label = @2
        local.get 1
        i32.const 256
        i32.lt_u
        br_if 0 (;@2;)
        local.get 0
        local.get 1
        call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$18insert_large_chunk17h2634ef33b3af9a32E
        i32.const 0
        i32.const 0
        i32.load offset=1050416
        i32.const -1
        i32.add
        local.tee 0
        i32.store offset=1050416
        local.get 0
        br_if 1 (;@1;)
        call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$23release_unused_segments17h3a36e1b255959a68E
        drop
        return
      end
      local.get 1
      i32.const -8
      i32.and
      i32.const 1050112
      i32.add
      local.set 2
      block  ;; label = @2
        block  ;; label = @3
          i32.const 0
          i32.load offset=1050376
          local.tee 3
          i32.const 1
          local.get 1
          i32.const 3
          i32.shr_u
          i32.shl
          local.tee 1
          i32.and
          i32.eqz
          br_if 0 (;@3;)
          local.get 2
          i32.load offset=8
          local.set 1
          br 1 (;@2;)
        end
        i32.const 0
        local.get 3
        local.get 1
        i32.or
        i32.store offset=1050376
        local.get 2
        local.set 1
      end
      local.get 2
      local.get 0
      i32.store offset=8
      local.get 1
      local.get 0
      i32.store offset=12
      local.get 0
      local.get 2
      i32.store offset=12
      local.get 0
      local.get 1
      i32.store offset=8
    end)
  (func $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$6malloc17h77bc0faa7fd9e29bE (type 3) (param i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i64)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 1
    global.set $__stack_pointer
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              block  ;; label = @6
                local.get 0
                i32.const 245
                i32.lt_u
                br_if 0 (;@6;)
                call $_ZN8dlmalloc8dlmalloc5Chunk10mem_offset17h2818126ab4d4ccc1E
                local.tee 2
                i32.const 8
                call $_ZN8dlmalloc8dlmalloc8align_up17h0e87fd8a6d5b4dd0E
                local.set 3
                i32.const 20
                i32.const 8
                call $_ZN8dlmalloc8dlmalloc8align_up17h0e87fd8a6d5b4dd0E
                local.set 4
                i32.const 16
                i32.const 8
                call $_ZN8dlmalloc8dlmalloc8align_up17h0e87fd8a6d5b4dd0E
                local.set 5
                i32.const 0
                local.set 6
                i32.const 0
                i32.const 16
                i32.const 8
                call $_ZN8dlmalloc8dlmalloc8align_up17h0e87fd8a6d5b4dd0E
                i32.const 2
                i32.shl
                i32.sub
                local.tee 7
                local.get 2
                local.get 5
                local.get 3
                local.get 4
                i32.add
                i32.add
                i32.sub
                i32.const -65544
                i32.add
                i32.const -9
                i32.and
                i32.const -3
                i32.add
                local.tee 2
                local.get 7
                local.get 2
                i32.lt_u
                select
                local.get 0
                i32.le_u
                br_if 5 (;@1;)
                local.get 0
                i32.const 4
                i32.add
                i32.const 8
                call $_ZN8dlmalloc8dlmalloc8align_up17h0e87fd8a6d5b4dd0E
                local.set 2
                i32.const 0
                i32.load offset=1050380
                i32.eqz
                br_if 4 (;@2;)
                i32.const 0
                local.set 8
                block  ;; label = @7
                  local.get 2
                  i32.const 256
                  i32.lt_u
                  br_if 0 (;@7;)
                  i32.const 31
                  local.set 8
                  local.get 2
                  i32.const 16777215
                  i32.gt_u
                  br_if 0 (;@7;)
                  local.get 2
                  i32.const 6
                  local.get 2
                  i32.const 8
                  i32.shr_u
                  i32.clz
                  local.tee 0
                  i32.sub
                  i32.shr_u
                  i32.const 1
                  i32.and
                  local.get 0
                  i32.const 1
                  i32.shl
                  i32.sub
                  i32.const 62
                  i32.add
                  local.set 8
                end
                i32.const 0
                local.get 2
                i32.sub
                local.set 6
                block  ;; label = @7
                  local.get 8
                  i32.const 2
                  i32.shl
                  i32.const 1049968
                  i32.add
                  i32.load
                  local.tee 3
                  br_if 0 (;@7;)
                  i32.const 0
                  local.set 0
                  i32.const 0
                  local.set 4
                  br 2 (;@5;)
                end
                local.get 2
                local.get 8
                call $_ZN8dlmalloc8dlmalloc24leftshift_for_tree_index17hbd308eba79453696E
                i32.shl
                local.set 5
                i32.const 0
                local.set 0
                i32.const 0
                local.set 4
                loop  ;; label = @7
                  block  ;; label = @8
                    local.get 3
                    call $_ZN8dlmalloc8dlmalloc9TreeChunk5chunk17h4562a4235ab5a16eE
                    call $_ZN8dlmalloc8dlmalloc5Chunk4size17h7f97819e0e1a81b6E
                    local.tee 7
                    local.get 2
                    i32.lt_u
                    br_if 0 (;@8;)
                    local.get 7
                    local.get 2
                    i32.sub
                    local.tee 7
                    local.get 6
                    i32.ge_u
                    br_if 0 (;@8;)
                    local.get 7
                    local.set 6
                    local.get 3
                    local.set 4
                    local.get 7
                    br_if 0 (;@8;)
                    i32.const 0
                    local.set 6
                    local.get 3
                    local.set 4
                    local.get 3
                    local.set 0
                    br 4 (;@4;)
                  end
                  local.get 3
                  i32.const 20
                  i32.add
                  i32.load
                  local.tee 7
                  local.get 0
                  local.get 7
                  local.get 3
                  local.get 5
                  i32.const 29
                  i32.shr_u
                  i32.const 4
                  i32.and
                  i32.add
                  i32.const 16
                  i32.add
                  i32.load
                  local.tee 3
                  i32.ne
                  select
                  local.get 0
                  local.get 7
                  select
                  local.set 0
                  local.get 5
                  i32.const 1
                  i32.shl
                  local.set 5
                  local.get 3
                  i32.eqz
                  br_if 2 (;@5;)
                  br 0 (;@7;)
                end
              end
              i32.const 16
              local.get 0
              i32.const 4
              i32.add
              i32.const 16
              i32.const 8
              call $_ZN8dlmalloc8dlmalloc8align_up17h0e87fd8a6d5b4dd0E
              i32.const -5
              i32.add
              local.get 0
              i32.gt_u
              select
              i32.const 8
              call $_ZN8dlmalloc8dlmalloc8align_up17h0e87fd8a6d5b4dd0E
              local.set 2
              block  ;; label = @6
                i32.const 0
                i32.load offset=1050376
                local.tee 4
                local.get 2
                i32.const 3
                i32.shr_u
                local.tee 6
                i32.shr_u
                local.tee 0
                i32.const 3
                i32.and
                i32.eqz
                br_if 0 (;@6;)
                block  ;; label = @7
                  block  ;; label = @8
                    local.get 0
                    i32.const -1
                    i32.xor
                    i32.const 1
                    i32.and
                    local.get 6
                    i32.add
                    local.tee 2
                    i32.const 3
                    i32.shl
                    local.tee 3
                    i32.const 1050120
                    i32.add
                    i32.load
                    local.tee 0
                    i32.const 8
                    i32.add
                    i32.load
                    local.tee 6
                    local.get 3
                    i32.const 1050112
                    i32.add
                    local.tee 3
                    i32.eq
                    br_if 0 (;@8;)
                    local.get 6
                    local.get 3
                    i32.store offset=12
                    local.get 3
                    local.get 6
                    i32.store offset=8
                    br 1 (;@7;)
                  end
                  i32.const 0
                  local.get 4
                  i32.const -2
                  local.get 2
                  i32.rotl
                  i32.and
                  i32.store offset=1050376
                end
                local.get 0
                local.get 2
                i32.const 3
                i32.shl
                call $_ZN8dlmalloc8dlmalloc5Chunk20set_inuse_and_pinuse17hc87585256ab7e20fE
                local.get 0
                call $_ZN8dlmalloc8dlmalloc5Chunk6to_mem17hc02bf0af126119c0E
                local.set 6
                br 5 (;@1;)
              end
              local.get 2
              i32.const 0
              i32.load offset=1050384
              i32.le_u
              br_if 3 (;@2;)
              block  ;; label = @6
                block  ;; label = @7
                  block  ;; label = @8
                    block  ;; label = @9
                      block  ;; label = @10
                        block  ;; label = @11
                          block  ;; label = @12
                            local.get 0
                            br_if 0 (;@12;)
                            i32.const 0
                            i32.load offset=1050380
                            local.tee 0
                            i32.eqz
                            br_if 10 (;@2;)
                            local.get 0
                            call $_ZN8dlmalloc8dlmalloc9least_bit17hc206cf4e014f3c55E
                            i32.ctz
                            i32.const 2
                            i32.shl
                            i32.const 1049968
                            i32.add
                            i32.load
                            local.tee 3
                            call $_ZN8dlmalloc8dlmalloc9TreeChunk5chunk17h4562a4235ab5a16eE
                            call $_ZN8dlmalloc8dlmalloc5Chunk4size17h7f97819e0e1a81b6E
                            local.get 2
                            i32.sub
                            local.set 6
                            block  ;; label = @13
                              local.get 3
                              call $_ZN8dlmalloc8dlmalloc9TreeChunk14leftmost_child17h1ae27d38517e0e1cE
                              local.tee 0
                              i32.eqz
                              br_if 0 (;@13;)
                              loop  ;; label = @14
                                local.get 0
                                call $_ZN8dlmalloc8dlmalloc9TreeChunk5chunk17h4562a4235ab5a16eE
                                call $_ZN8dlmalloc8dlmalloc5Chunk4size17h7f97819e0e1a81b6E
                                local.get 2
                                i32.sub
                                local.tee 4
                                local.get 6
                                local.get 4
                                local.get 6
                                i32.lt_u
                                local.tee 4
                                select
                                local.set 6
                                local.get 0
                                local.get 3
                                local.get 4
                                select
                                local.set 3
                                local.get 0
                                call $_ZN8dlmalloc8dlmalloc9TreeChunk14leftmost_child17h1ae27d38517e0e1cE
                                local.tee 0
                                br_if 0 (;@14;)
                              end
                            end
                            local.get 3
                            call $_ZN8dlmalloc8dlmalloc9TreeChunk5chunk17h4562a4235ab5a16eE
                            local.tee 0
                            local.get 2
                            call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h9b67d52a46bbff2cE
                            local.set 4
                            local.get 3
                            call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$18unlink_large_chunk17hb47d8811580bf409E
                            local.get 6
                            i32.const 16
                            i32.const 8
                            call $_ZN8dlmalloc8dlmalloc8align_up17h0e87fd8a6d5b4dd0E
                            i32.lt_u
                            br_if 2 (;@10;)
                            local.get 4
                            call $_ZN8dlmalloc8dlmalloc9TreeChunk5chunk17h4562a4235ab5a16eE
                            local.set 4
                            local.get 0
                            local.get 2
                            call $_ZN8dlmalloc8dlmalloc5Chunk34set_size_and_pinuse_of_inuse_chunk17h4a3baeef63b4aae1E
                            local.get 4
                            local.get 6
                            call $_ZN8dlmalloc8dlmalloc5Chunk33set_size_and_pinuse_of_free_chunk17habe76bbe555b1e73E
                            i32.const 0
                            i32.load offset=1050384
                            local.tee 7
                            br_if 1 (;@11;)
                            br 5 (;@7;)
                          end
                          block  ;; label = @12
                            block  ;; label = @13
                              i32.const 1
                              local.get 6
                              i32.const 31
                              i32.and
                              local.tee 6
                              i32.shl
                              call $_ZN8dlmalloc8dlmalloc9left_bits17h4d52756c14d62f33E
                              local.get 0
                              local.get 6
                              i32.shl
                              i32.and
                              call $_ZN8dlmalloc8dlmalloc9least_bit17hc206cf4e014f3c55E
                              i32.ctz
                              local.tee 6
                              i32.const 3
                              i32.shl
                              local.tee 4
                              i32.const 1050120
                              i32.add
                              i32.load
                              local.tee 0
                              i32.const 8
                              i32.add
                              i32.load
                              local.tee 3
                              local.get 4
                              i32.const 1050112
                              i32.add
                              local.tee 4
                              i32.eq
                              br_if 0 (;@13;)
                              local.get 3
                              local.get 4
                              i32.store offset=12
                              local.get 4
                              local.get 3
                              i32.store offset=8
                              br 1 (;@12;)
                            end
                            i32.const 0
                            i32.const 0
                            i32.load offset=1050376
                            i32.const -2
                            local.get 6
                            i32.rotl
                            i32.and
                            i32.store offset=1050376
                          end
                          local.get 0
                          local.get 2
                          call $_ZN8dlmalloc8dlmalloc5Chunk34set_size_and_pinuse_of_inuse_chunk17h4a3baeef63b4aae1E
                          local.get 0
                          local.get 2
                          call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h9b67d52a46bbff2cE
                          local.tee 4
                          local.get 6
                          i32.const 3
                          i32.shl
                          local.get 2
                          i32.sub
                          local.tee 5
                          call $_ZN8dlmalloc8dlmalloc5Chunk33set_size_and_pinuse_of_free_chunk17habe76bbe555b1e73E
                          i32.const 0
                          i32.load offset=1050384
                          local.tee 3
                          br_if 2 (;@9;)
                          br 3 (;@8;)
                        end
                        local.get 7
                        i32.const -8
                        i32.and
                        i32.const 1050112
                        i32.add
                        local.set 5
                        i32.const 0
                        i32.load offset=1050392
                        local.set 3
                        block  ;; label = @11
                          block  ;; label = @12
                            i32.const 0
                            i32.load offset=1050376
                            local.tee 8
                            i32.const 1
                            local.get 7
                            i32.const 3
                            i32.shr_u
                            i32.shl
                            local.tee 7
                            i32.and
                            i32.eqz
                            br_if 0 (;@12;)
                            local.get 5
                            i32.load offset=8
                            local.set 7
                            br 1 (;@11;)
                          end
                          i32.const 0
                          local.get 8
                          local.get 7
                          i32.or
                          i32.store offset=1050376
                          local.get 5
                          local.set 7
                        end
                        local.get 5
                        local.get 3
                        i32.store offset=8
                        local.get 7
                        local.get 3
                        i32.store offset=12
                        local.get 3
                        local.get 5
                        i32.store offset=12
                        local.get 3
                        local.get 7
                        i32.store offset=8
                        br 3 (;@7;)
                      end
                      local.get 0
                      local.get 6
                      local.get 2
                      i32.add
                      call $_ZN8dlmalloc8dlmalloc5Chunk20set_inuse_and_pinuse17hc87585256ab7e20fE
                      br 3 (;@6;)
                    end
                    local.get 3
                    i32.const -8
                    i32.and
                    i32.const 1050112
                    i32.add
                    local.set 6
                    i32.const 0
                    i32.load offset=1050392
                    local.set 2
                    block  ;; label = @9
                      block  ;; label = @10
                        i32.const 0
                        i32.load offset=1050376
                        local.tee 7
                        i32.const 1
                        local.get 3
                        i32.const 3
                        i32.shr_u
                        i32.shl
                        local.tee 3
                        i32.and
                        i32.eqz
                        br_if 0 (;@10;)
                        local.get 6
                        i32.load offset=8
                        local.set 3
                        br 1 (;@9;)
                      end
                      i32.const 0
                      local.get 7
                      local.get 3
                      i32.or
                      i32.store offset=1050376
                      local.get 6
                      local.set 3
                    end
                    local.get 6
                    local.get 2
                    i32.store offset=8
                    local.get 3
                    local.get 2
                    i32.store offset=12
                    local.get 2
                    local.get 6
                    i32.store offset=12
                    local.get 2
                    local.get 3
                    i32.store offset=8
                  end
                  i32.const 0
                  local.get 4
                  i32.store offset=1050392
                  i32.const 0
                  local.get 5
                  i32.store offset=1050384
                  local.get 0
                  call $_ZN8dlmalloc8dlmalloc5Chunk6to_mem17hc02bf0af126119c0E
                  local.set 6
                  br 6 (;@1;)
                end
                i32.const 0
                local.get 4
                i32.store offset=1050392
                i32.const 0
                local.get 6
                i32.store offset=1050384
              end
              local.get 0
              call $_ZN8dlmalloc8dlmalloc5Chunk6to_mem17hc02bf0af126119c0E
              local.tee 6
              i32.eqz
              br_if 3 (;@2;)
              br 4 (;@1;)
            end
            block  ;; label = @5
              local.get 0
              local.get 4
              i32.or
              br_if 0 (;@5;)
              i32.const 0
              local.set 4
              i32.const 1
              local.get 8
              i32.shl
              call $_ZN8dlmalloc8dlmalloc9left_bits17h4d52756c14d62f33E
              i32.const 0
              i32.load offset=1050380
              i32.and
              local.tee 0
              i32.eqz
              br_if 3 (;@2;)
              local.get 0
              call $_ZN8dlmalloc8dlmalloc9least_bit17hc206cf4e014f3c55E
              i32.ctz
              i32.const 2
              i32.shl
              i32.const 1049968
              i32.add
              i32.load
              local.set 0
            end
            local.get 0
            i32.eqz
            br_if 1 (;@3;)
          end
          loop  ;; label = @4
            local.get 0
            local.get 4
            local.get 0
            call $_ZN8dlmalloc8dlmalloc9TreeChunk5chunk17h4562a4235ab5a16eE
            call $_ZN8dlmalloc8dlmalloc5Chunk4size17h7f97819e0e1a81b6E
            local.tee 3
            local.get 2
            i32.ge_u
            local.get 3
            local.get 2
            i32.sub
            local.tee 3
            local.get 6
            i32.lt_u
            i32.and
            local.tee 5
            select
            local.set 4
            local.get 3
            local.get 6
            local.get 5
            select
            local.set 6
            local.get 0
            call $_ZN8dlmalloc8dlmalloc9TreeChunk14leftmost_child17h1ae27d38517e0e1cE
            local.tee 0
            br_if 0 (;@4;)
          end
        end
        local.get 4
        i32.eqz
        br_if 0 (;@2;)
        block  ;; label = @3
          i32.const 0
          i32.load offset=1050384
          local.tee 0
          local.get 2
          i32.lt_u
          br_if 0 (;@3;)
          local.get 6
          local.get 0
          local.get 2
          i32.sub
          i32.ge_u
          br_if 1 (;@2;)
        end
        local.get 4
        call $_ZN8dlmalloc8dlmalloc9TreeChunk5chunk17h4562a4235ab5a16eE
        local.tee 0
        local.get 2
        call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h9b67d52a46bbff2cE
        local.set 3
        local.get 4
        call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$18unlink_large_chunk17hb47d8811580bf409E
        block  ;; label = @3
          block  ;; label = @4
            local.get 6
            i32.const 16
            i32.const 8
            call $_ZN8dlmalloc8dlmalloc8align_up17h0e87fd8a6d5b4dd0E
            i32.lt_u
            br_if 0 (;@4;)
            local.get 0
            local.get 2
            call $_ZN8dlmalloc8dlmalloc5Chunk34set_size_and_pinuse_of_inuse_chunk17h4a3baeef63b4aae1E
            local.get 3
            local.get 6
            call $_ZN8dlmalloc8dlmalloc5Chunk33set_size_and_pinuse_of_free_chunk17habe76bbe555b1e73E
            block  ;; label = @5
              local.get 6
              i32.const 256
              i32.lt_u
              br_if 0 (;@5;)
              local.get 3
              local.get 6
              call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$18insert_large_chunk17h2634ef33b3af9a32E
              br 2 (;@3;)
            end
            local.get 6
            i32.const -8
            i32.and
            i32.const 1050112
            i32.add
            local.set 4
            block  ;; label = @5
              block  ;; label = @6
                i32.const 0
                i32.load offset=1050376
                local.tee 5
                i32.const 1
                local.get 6
                i32.const 3
                i32.shr_u
                i32.shl
                local.tee 6
                i32.and
                i32.eqz
                br_if 0 (;@6;)
                local.get 4
                i32.load offset=8
                local.set 6
                br 1 (;@5;)
              end
              i32.const 0
              local.get 5
              local.get 6
              i32.or
              i32.store offset=1050376
              local.get 4
              local.set 6
            end
            local.get 4
            local.get 3
            i32.store offset=8
            local.get 6
            local.get 3
            i32.store offset=12
            local.get 3
            local.get 4
            i32.store offset=12
            local.get 3
            local.get 6
            i32.store offset=8
            br 1 (;@3;)
          end
          local.get 0
          local.get 6
          local.get 2
          i32.add
          call $_ZN8dlmalloc8dlmalloc5Chunk20set_inuse_and_pinuse17hc87585256ab7e20fE
        end
        local.get 0
        call $_ZN8dlmalloc8dlmalloc5Chunk6to_mem17hc02bf0af126119c0E
        local.tee 6
        br_if 1 (;@1;)
      end
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              block  ;; label = @6
                block  ;; label = @7
                  block  ;; label = @8
                    block  ;; label = @9
                      i32.const 0
                      i32.load offset=1050384
                      local.tee 6
                      local.get 2
                      i32.ge_u
                      br_if 0 (;@9;)
                      block  ;; label = @10
                        i32.const 0
                        i32.load offset=1050388
                        local.tee 0
                        local.get 2
                        i32.gt_u
                        br_if 0 (;@10;)
                        local.get 1
                        i32.const 1049968
                        local.get 2
                        call $_ZN8dlmalloc8dlmalloc5Chunk10mem_offset17h2818126ab4d4ccc1E
                        local.tee 0
                        i32.sub
                        local.get 0
                        i32.const 8
                        call $_ZN8dlmalloc8dlmalloc8align_up17h0e87fd8a6d5b4dd0E
                        i32.add
                        i32.const 20
                        i32.const 8
                        call $_ZN8dlmalloc8dlmalloc8align_up17h0e87fd8a6d5b4dd0E
                        i32.add
                        i32.const 16
                        i32.const 8
                        call $_ZN8dlmalloc8dlmalloc8align_up17h0e87fd8a6d5b4dd0E
                        i32.add
                        i32.const 8
                        i32.add
                        i32.const 65536
                        call $_ZN8dlmalloc8dlmalloc8align_up17h0e87fd8a6d5b4dd0E
                        call $_ZN61_$LT$dlmalloc..sys..System$u20$as$u20$dlmalloc..Allocator$GT$5alloc17h9bcb497e409528ddE
                        block  ;; label = @11
                          local.get 1
                          i32.load
                          local.tee 6
                          br_if 0 (;@11;)
                          i32.const 0
                          local.set 6
                          br 10 (;@1;)
                        end
                        local.get 1
                        i32.load offset=8
                        local.set 8
                        i32.const 0
                        i32.const 0
                        i32.load offset=1050400
                        local.get 1
                        i32.load offset=4
                        local.tee 5
                        i32.add
                        local.tee 0
                        i32.store offset=1050400
                        i32.const 0
                        i32.const 0
                        i32.load offset=1050404
                        local.tee 3
                        local.get 0
                        local.get 3
                        local.get 0
                        i32.gt_u
                        select
                        i32.store offset=1050404
                        block  ;; label = @11
                          block  ;; label = @12
                            block  ;; label = @13
                              i32.const 0
                              i32.load offset=1050396
                              i32.eqz
                              br_if 0 (;@13;)
                              i32.const 1050096
                              local.set 0
                              loop  ;; label = @14
                                local.get 6
                                local.get 0
                                call $_ZN8dlmalloc8dlmalloc7Segment3top17h96cd19ac0fd36e05E
                                i32.eq
                                br_if 2 (;@12;)
                                local.get 0
                                i32.load offset=8
                                local.tee 0
                                br_if 0 (;@14;)
                                br 3 (;@11;)
                              end
                            end
                            i32.const 0
                            i32.load offset=1050412
                            local.tee 0
                            i32.eqz
                            br_if 4 (;@8;)
                            local.get 6
                            local.get 0
                            i32.lt_u
                            br_if 4 (;@8;)
                            br 9 (;@3;)
                          end
                          local.get 0
                          call $_ZN8dlmalloc8dlmalloc7Segment9is_extern17h3cbba93f4e5cfab1E
                          br_if 0 (;@11;)
                          local.get 0
                          call $_ZN8dlmalloc8dlmalloc7Segment9sys_flags17hd7870bf529598941E
                          local.get 8
                          i32.ne
                          br_if 0 (;@11;)
                          local.get 0
                          i32.const 0
                          i32.load offset=1050396
                          call $_ZN8dlmalloc8dlmalloc7Segment5holds17he3b1db583c6e4172E
                          br_if 4 (;@7;)
                        end
                        i32.const 0
                        i32.const 0
                        i32.load offset=1050412
                        local.tee 0
                        local.get 6
                        local.get 6
                        local.get 0
                        i32.gt_u
                        select
                        i32.store offset=1050412
                        local.get 6
                        local.get 5
                        i32.add
                        local.set 3
                        i32.const 1050096
                        local.set 0
                        block  ;; label = @11
                          block  ;; label = @12
                            block  ;; label = @13
                              loop  ;; label = @14
                                local.get 0
                                i32.load
                                local.get 3
                                i32.eq
                                br_if 1 (;@13;)
                                local.get 0
                                i32.load offset=8
                                local.tee 0
                                br_if 0 (;@14;)
                                br 2 (;@12;)
                              end
                            end
                            local.get 0
                            call $_ZN8dlmalloc8dlmalloc7Segment9is_extern17h3cbba93f4e5cfab1E
                            br_if 0 (;@12;)
                            local.get 0
                            call $_ZN8dlmalloc8dlmalloc7Segment9sys_flags17hd7870bf529598941E
                            local.get 8
                            i32.eq
                            br_if 1 (;@11;)
                          end
                          i32.const 0
                          i32.load offset=1050396
                          local.set 3
                          i32.const 1050096
                          local.set 0
                          block  ;; label = @12
                            loop  ;; label = @13
                              block  ;; label = @14
                                local.get 0
                                i32.load
                                local.get 3
                                i32.gt_u
                                br_if 0 (;@14;)
                                local.get 0
                                call $_ZN8dlmalloc8dlmalloc7Segment3top17h96cd19ac0fd36e05E
                                local.get 3
                                i32.gt_u
                                br_if 2 (;@12;)
                              end
                              local.get 0
                              i32.load offset=8
                              local.tee 0
                              br_if 0 (;@13;)
                            end
                            i32.const 0
                            local.set 0
                          end
                          local.get 0
                          call $_ZN8dlmalloc8dlmalloc7Segment3top17h96cd19ac0fd36e05E
                          local.tee 4
                          i32.const 20
                          i32.const 8
                          call $_ZN8dlmalloc8dlmalloc8align_up17h0e87fd8a6d5b4dd0E
                          local.tee 9
                          i32.sub
                          i32.const -23
                          i32.add
                          local.set 0
                          local.get 3
                          local.get 0
                          local.get 0
                          call $_ZN8dlmalloc8dlmalloc5Chunk6to_mem17hc02bf0af126119c0E
                          local.tee 7
                          i32.const 8
                          call $_ZN8dlmalloc8dlmalloc8align_up17h0e87fd8a6d5b4dd0E
                          local.get 7
                          i32.sub
                          i32.add
                          local.tee 0
                          local.get 0
                          local.get 3
                          i32.const 16
                          i32.const 8
                          call $_ZN8dlmalloc8dlmalloc8align_up17h0e87fd8a6d5b4dd0E
                          i32.add
                          i32.lt_u
                          select
                          local.tee 7
                          call $_ZN8dlmalloc8dlmalloc5Chunk6to_mem17hc02bf0af126119c0E
                          local.set 10
                          local.get 7
                          local.get 9
                          call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h9b67d52a46bbff2cE
                          local.set 0
                          call $_ZN8dlmalloc8dlmalloc5Chunk10mem_offset17h2818126ab4d4ccc1E
                          local.tee 11
                          i32.const 8
                          call $_ZN8dlmalloc8dlmalloc8align_up17h0e87fd8a6d5b4dd0E
                          local.set 12
                          i32.const 20
                          i32.const 8
                          call $_ZN8dlmalloc8dlmalloc8align_up17h0e87fd8a6d5b4dd0E
                          local.set 13
                          i32.const 16
                          i32.const 8
                          call $_ZN8dlmalloc8dlmalloc8align_up17h0e87fd8a6d5b4dd0E
                          local.set 14
                          i32.const 0
                          local.get 6
                          local.get 6
                          call $_ZN8dlmalloc8dlmalloc5Chunk6to_mem17hc02bf0af126119c0E
                          local.tee 15
                          i32.const 8
                          call $_ZN8dlmalloc8dlmalloc8align_up17h0e87fd8a6d5b4dd0E
                          local.get 15
                          i32.sub
                          local.tee 16
                          call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h9b67d52a46bbff2cE
                          local.tee 15
                          i32.store offset=1050396
                          i32.const 0
                          local.get 11
                          local.get 5
                          i32.add
                          local.get 14
                          local.get 12
                          local.get 13
                          i32.add
                          i32.add
                          local.get 16
                          i32.add
                          i32.sub
                          local.tee 11
                          i32.store offset=1050388
                          local.get 15
                          local.get 11
                          i32.const 1
                          i32.or
                          i32.store offset=4
                          call $_ZN8dlmalloc8dlmalloc5Chunk10mem_offset17h2818126ab4d4ccc1E
                          local.tee 12
                          i32.const 8
                          call $_ZN8dlmalloc8dlmalloc8align_up17h0e87fd8a6d5b4dd0E
                          local.set 13
                          i32.const 20
                          i32.const 8
                          call $_ZN8dlmalloc8dlmalloc8align_up17h0e87fd8a6d5b4dd0E
                          local.set 14
                          i32.const 16
                          i32.const 8
                          call $_ZN8dlmalloc8dlmalloc8align_up17h0e87fd8a6d5b4dd0E
                          local.set 16
                          local.get 15
                          local.get 11
                          call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h9b67d52a46bbff2cE
                          local.get 16
                          local.get 14
                          local.get 13
                          local.get 12
                          i32.sub
                          i32.add
                          i32.add
                          i32.store offset=4
                          i32.const 0
                          i32.const 2097152
                          i32.store offset=1050408
                          local.get 7
                          local.get 9
                          call $_ZN8dlmalloc8dlmalloc5Chunk34set_size_and_pinuse_of_inuse_chunk17h4a3baeef63b4aae1E
                          i32.const 0
                          i64.load offset=1050096 align=4
                          local.set 17
                          local.get 10
                          i32.const 8
                          i32.add
                          i32.const 0
                          i64.load offset=1050104 align=4
                          i64.store align=4
                          local.get 10
                          local.get 17
                          i64.store align=4
                          i32.const 0
                          local.get 8
                          i32.store offset=1050108
                          i32.const 0
                          local.get 5
                          i32.store offset=1050100
                          i32.const 0
                          local.get 6
                          i32.store offset=1050096
                          i32.const 0
                          local.get 10
                          i32.store offset=1050104
                          loop  ;; label = @12
                            local.get 0
                            i32.const 4
                            call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h9b67d52a46bbff2cE
                            local.set 6
                            local.get 0
                            call $_ZN8dlmalloc8dlmalloc5Chunk14fencepost_head17h782694e16a323064E
                            i32.store offset=4
                            local.get 6
                            local.set 0
                            local.get 6
                            i32.const 4
                            i32.add
                            local.get 4
                            i32.lt_u
                            br_if 0 (;@12;)
                          end
                          local.get 7
                          local.get 3
                          i32.eq
                          br_if 9 (;@2;)
                          local.get 7
                          local.get 3
                          i32.sub
                          local.set 0
                          local.get 3
                          local.get 0
                          local.get 3
                          local.get 0
                          call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h9b67d52a46bbff2cE
                          call $_ZN8dlmalloc8dlmalloc5Chunk20set_free_with_pinuse17h2b5f242508300075E
                          block  ;; label = @12
                            local.get 0
                            i32.const 256
                            i32.lt_u
                            br_if 0 (;@12;)
                            local.get 3
                            local.get 0
                            call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$18insert_large_chunk17h2634ef33b3af9a32E
                            br 10 (;@2;)
                          end
                          local.get 0
                          i32.const -8
                          i32.and
                          i32.const 1050112
                          i32.add
                          local.set 6
                          block  ;; label = @12
                            block  ;; label = @13
                              i32.const 0
                              i32.load offset=1050376
                              local.tee 4
                              i32.const 1
                              local.get 0
                              i32.const 3
                              i32.shr_u
                              i32.shl
                              local.tee 0
                              i32.and
                              i32.eqz
                              br_if 0 (;@13;)
                              local.get 6
                              i32.load offset=8
                              local.set 0
                              br 1 (;@12;)
                            end
                            i32.const 0
                            local.get 4
                            local.get 0
                            i32.or
                            i32.store offset=1050376
                            local.get 6
                            local.set 0
                          end
                          local.get 6
                          local.get 3
                          i32.store offset=8
                          local.get 0
                          local.get 3
                          i32.store offset=12
                          local.get 3
                          local.get 6
                          i32.store offset=12
                          local.get 3
                          local.get 0
                          i32.store offset=8
                          br 9 (;@2;)
                        end
                        local.get 0
                        i32.load
                        local.set 4
                        local.get 0
                        local.get 6
                        i32.store
                        local.get 0
                        local.get 0
                        i32.load offset=4
                        local.get 5
                        i32.add
                        i32.store offset=4
                        local.get 6
                        call $_ZN8dlmalloc8dlmalloc5Chunk6to_mem17hc02bf0af126119c0E
                        local.tee 0
                        i32.const 8
                        call $_ZN8dlmalloc8dlmalloc8align_up17h0e87fd8a6d5b4dd0E
                        local.set 3
                        local.get 4
                        call $_ZN8dlmalloc8dlmalloc5Chunk6to_mem17hc02bf0af126119c0E
                        local.tee 5
                        i32.const 8
                        call $_ZN8dlmalloc8dlmalloc8align_up17h0e87fd8a6d5b4dd0E
                        local.set 7
                        local.get 6
                        local.get 3
                        local.get 0
                        i32.sub
                        i32.add
                        local.tee 6
                        local.get 2
                        call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h9b67d52a46bbff2cE
                        local.set 3
                        local.get 6
                        local.get 2
                        call $_ZN8dlmalloc8dlmalloc5Chunk34set_size_and_pinuse_of_inuse_chunk17h4a3baeef63b4aae1E
                        local.get 4
                        local.get 7
                        local.get 5
                        i32.sub
                        i32.add
                        local.tee 0
                        local.get 2
                        local.get 6
                        i32.add
                        i32.sub
                        local.set 2
                        block  ;; label = @11
                          local.get 0
                          i32.const 0
                          i32.load offset=1050396
                          i32.eq
                          br_if 0 (;@11;)
                          local.get 0
                          i32.const 0
                          i32.load offset=1050392
                          i32.eq
                          br_if 5 (;@6;)
                          local.get 0
                          call $_ZN8dlmalloc8dlmalloc5Chunk5inuse17h6a9390afcf3c4f59E
                          br_if 7 (;@4;)
                          block  ;; label = @12
                            block  ;; label = @13
                              local.get 0
                              call $_ZN8dlmalloc8dlmalloc5Chunk4size17h7f97819e0e1a81b6E
                              local.tee 4
                              i32.const 256
                              i32.lt_u
                              br_if 0 (;@13;)
                              local.get 0
                              call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$18unlink_large_chunk17hb47d8811580bf409E
                              br 1 (;@12;)
                            end
                            block  ;; label = @13
                              local.get 0
                              i32.const 12
                              i32.add
                              i32.load
                              local.tee 5
                              local.get 0
                              i32.const 8
                              i32.add
                              i32.load
                              local.tee 7
                              i32.eq
                              br_if 0 (;@13;)
                              local.get 7
                              local.get 5
                              i32.store offset=12
                              local.get 5
                              local.get 7
                              i32.store offset=8
                              br 1 (;@12;)
                            end
                            i32.const 0
                            i32.const 0
                            i32.load offset=1050376
                            i32.const -2
                            local.get 4
                            i32.const 3
                            i32.shr_u
                            i32.rotl
                            i32.and
                            i32.store offset=1050376
                          end
                          local.get 4
                          local.get 2
                          i32.add
                          local.set 2
                          local.get 0
                          local.get 4
                          call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h9b67d52a46bbff2cE
                          local.set 0
                          br 7 (;@4;)
                        end
                        i32.const 0
                        local.get 3
                        i32.store offset=1050396
                        i32.const 0
                        i32.const 0
                        i32.load offset=1050388
                        local.get 2
                        i32.add
                        local.tee 0
                        i32.store offset=1050388
                        local.get 3
                        local.get 0
                        i32.const 1
                        i32.or
                        i32.store offset=4
                        local.get 6
                        call $_ZN8dlmalloc8dlmalloc5Chunk6to_mem17hc02bf0af126119c0E
                        local.set 6
                        br 9 (;@1;)
                      end
                      i32.const 0
                      local.get 0
                      local.get 2
                      i32.sub
                      local.tee 6
                      i32.store offset=1050388
                      i32.const 0
                      i32.const 0
                      i32.load offset=1050396
                      local.tee 0
                      local.get 2
                      call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h9b67d52a46bbff2cE
                      local.tee 3
                      i32.store offset=1050396
                      local.get 3
                      local.get 6
                      i32.const 1
                      i32.or
                      i32.store offset=4
                      local.get 0
                      local.get 2
                      call $_ZN8dlmalloc8dlmalloc5Chunk34set_size_and_pinuse_of_inuse_chunk17h4a3baeef63b4aae1E
                      local.get 0
                      call $_ZN8dlmalloc8dlmalloc5Chunk6to_mem17hc02bf0af126119c0E
                      local.set 6
                      br 8 (;@1;)
                    end
                    i32.const 0
                    i32.load offset=1050392
                    local.set 0
                    local.get 6
                    local.get 2
                    i32.sub
                    local.tee 6
                    i32.const 16
                    i32.const 8
                    call $_ZN8dlmalloc8dlmalloc8align_up17h0e87fd8a6d5b4dd0E
                    i32.lt_u
                    br_if 3 (;@5;)
                    local.get 0
                    local.get 2
                    call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h9b67d52a46bbff2cE
                    local.set 3
                    i32.const 0
                    local.get 6
                    i32.store offset=1050384
                    i32.const 0
                    local.get 3
                    i32.store offset=1050392
                    local.get 3
                    local.get 6
                    call $_ZN8dlmalloc8dlmalloc5Chunk33set_size_and_pinuse_of_free_chunk17habe76bbe555b1e73E
                    local.get 0
                    local.get 2
                    call $_ZN8dlmalloc8dlmalloc5Chunk34set_size_and_pinuse_of_inuse_chunk17h4a3baeef63b4aae1E
                    local.get 0
                    call $_ZN8dlmalloc8dlmalloc5Chunk6to_mem17hc02bf0af126119c0E
                    local.set 6
                    br 7 (;@1;)
                  end
                  i32.const 0
                  local.get 6
                  i32.store offset=1050412
                  br 4 (;@3;)
                end
                local.get 0
                local.get 0
                i32.load offset=4
                local.get 5
                i32.add
                i32.store offset=4
                i32.const 0
                i32.load offset=1050396
                i32.const 0
                i32.load offset=1050388
                local.get 5
                i32.add
                call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$8init_top17h9f173f15516b6497E
                br 4 (;@2;)
              end
              i32.const 0
              local.get 3
              i32.store offset=1050392
              i32.const 0
              i32.const 0
              i32.load offset=1050384
              local.get 2
              i32.add
              local.tee 0
              i32.store offset=1050384
              local.get 3
              local.get 0
              call $_ZN8dlmalloc8dlmalloc5Chunk33set_size_and_pinuse_of_free_chunk17habe76bbe555b1e73E
              local.get 6
              call $_ZN8dlmalloc8dlmalloc5Chunk6to_mem17hc02bf0af126119c0E
              local.set 6
              br 4 (;@1;)
            end
            i32.const 0
            i32.const 0
            i32.store offset=1050392
            i32.const 0
            i32.load offset=1050384
            local.set 2
            i32.const 0
            i32.const 0
            i32.store offset=1050384
            local.get 0
            local.get 2
            call $_ZN8dlmalloc8dlmalloc5Chunk20set_inuse_and_pinuse17hc87585256ab7e20fE
            local.get 0
            call $_ZN8dlmalloc8dlmalloc5Chunk6to_mem17hc02bf0af126119c0E
            local.set 6
            br 3 (;@1;)
          end
          local.get 3
          local.get 2
          local.get 0
          call $_ZN8dlmalloc8dlmalloc5Chunk20set_free_with_pinuse17h2b5f242508300075E
          block  ;; label = @4
            local.get 2
            i32.const 256
            i32.lt_u
            br_if 0 (;@4;)
            local.get 3
            local.get 2
            call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$18insert_large_chunk17h2634ef33b3af9a32E
            local.get 6
            call $_ZN8dlmalloc8dlmalloc5Chunk6to_mem17hc02bf0af126119c0E
            local.set 6
            br 3 (;@1;)
          end
          local.get 2
          i32.const -8
          i32.and
          i32.const 1050112
          i32.add
          local.set 0
          block  ;; label = @4
            block  ;; label = @5
              i32.const 0
              i32.load offset=1050376
              local.tee 4
              i32.const 1
              local.get 2
              i32.const 3
              i32.shr_u
              i32.shl
              local.tee 2
              i32.and
              i32.eqz
              br_if 0 (;@5;)
              local.get 0
              i32.load offset=8
              local.set 2
              br 1 (;@4;)
            end
            i32.const 0
            local.get 4
            local.get 2
            i32.or
            i32.store offset=1050376
            local.get 0
            local.set 2
          end
          local.get 0
          local.get 3
          i32.store offset=8
          local.get 2
          local.get 3
          i32.store offset=12
          local.get 3
          local.get 0
          i32.store offset=12
          local.get 3
          local.get 2
          i32.store offset=8
          local.get 6
          call $_ZN8dlmalloc8dlmalloc5Chunk6to_mem17hc02bf0af126119c0E
          local.set 6
          br 2 (;@1;)
        end
        i32.const 0
        i32.const 4095
        i32.store offset=1050416
        i32.const 0
        local.get 8
        i32.store offset=1050108
        i32.const 0
        local.get 5
        i32.store offset=1050100
        i32.const 0
        local.get 6
        i32.store offset=1050096
        i32.const 0
        i32.const 1050112
        i32.store offset=1050124
        i32.const 0
        i32.const 1050120
        i32.store offset=1050132
        i32.const 0
        i32.const 1050112
        i32.store offset=1050120
        i32.const 0
        i32.const 1050128
        i32.store offset=1050140
        i32.const 0
        i32.const 1050120
        i32.store offset=1050128
        i32.const 0
        i32.const 1050136
        i32.store offset=1050148
        i32.const 0
        i32.const 1050128
        i32.store offset=1050136
        i32.const 0
        i32.const 1050144
        i32.store offset=1050156
        i32.const 0
        i32.const 1050136
        i32.store offset=1050144
        i32.const 0
        i32.const 1050152
        i32.store offset=1050164
        i32.const 0
        i32.const 1050144
        i32.store offset=1050152
        i32.const 0
        i32.const 1050160
        i32.store offset=1050172
        i32.const 0
        i32.const 1050152
        i32.store offset=1050160
        i32.const 0
        i32.const 1050168
        i32.store offset=1050180
        i32.const 0
        i32.const 1050160
        i32.store offset=1050168
        i32.const 0
        i32.const 1050176
        i32.store offset=1050188
        i32.const 0
        i32.const 1050168
        i32.store offset=1050176
        i32.const 0
        i32.const 1050176
        i32.store offset=1050184
        i32.const 0
        i32.const 1050184
        i32.store offset=1050196
        i32.const 0
        i32.const 1050184
        i32.store offset=1050192
        i32.const 0
        i32.const 1050192
        i32.store offset=1050204
        i32.const 0
        i32.const 1050192
        i32.store offset=1050200
        i32.const 0
        i32.const 1050200
        i32.store offset=1050212
        i32.const 0
        i32.const 1050200
        i32.store offset=1050208
        i32.const 0
        i32.const 1050208
        i32.store offset=1050220
        i32.const 0
        i32.const 1050208
        i32.store offset=1050216
        i32.const 0
        i32.const 1050216
        i32.store offset=1050228
        i32.const 0
        i32.const 1050216
        i32.store offset=1050224
        i32.const 0
        i32.const 1050224
        i32.store offset=1050236
        i32.const 0
        i32.const 1050224
        i32.store offset=1050232
        i32.const 0
        i32.const 1050232
        i32.store offset=1050244
        i32.const 0
        i32.const 1050232
        i32.store offset=1050240
        i32.const 0
        i32.const 1050240
        i32.store offset=1050252
        i32.const 0
        i32.const 1050248
        i32.store offset=1050260
        i32.const 0
        i32.const 1050240
        i32.store offset=1050248
        i32.const 0
        i32.const 1050256
        i32.store offset=1050268
        i32.const 0
        i32.const 1050248
        i32.store offset=1050256
        i32.const 0
        i32.const 1050264
        i32.store offset=1050276
        i32.const 0
        i32.const 1050256
        i32.store offset=1050264
        i32.const 0
        i32.const 1050272
        i32.store offset=1050284
        i32.const 0
        i32.const 1050264
        i32.store offset=1050272
        i32.const 0
        i32.const 1050280
        i32.store offset=1050292
        i32.const 0
        i32.const 1050272
        i32.store offset=1050280
        i32.const 0
        i32.const 1050288
        i32.store offset=1050300
        i32.const 0
        i32.const 1050280
        i32.store offset=1050288
        i32.const 0
        i32.const 1050296
        i32.store offset=1050308
        i32.const 0
        i32.const 1050288
        i32.store offset=1050296
        i32.const 0
        i32.const 1050304
        i32.store offset=1050316
        i32.const 0
        i32.const 1050296
        i32.store offset=1050304
        i32.const 0
        i32.const 1050312
        i32.store offset=1050324
        i32.const 0
        i32.const 1050304
        i32.store offset=1050312
        i32.const 0
        i32.const 1050320
        i32.store offset=1050332
        i32.const 0
        i32.const 1050312
        i32.store offset=1050320
        i32.const 0
        i32.const 1050328
        i32.store offset=1050340
        i32.const 0
        i32.const 1050320
        i32.store offset=1050328
        i32.const 0
        i32.const 1050336
        i32.store offset=1050348
        i32.const 0
        i32.const 1050328
        i32.store offset=1050336
        i32.const 0
        i32.const 1050344
        i32.store offset=1050356
        i32.const 0
        i32.const 1050336
        i32.store offset=1050344
        i32.const 0
        i32.const 1050352
        i32.store offset=1050364
        i32.const 0
        i32.const 1050344
        i32.store offset=1050352
        i32.const 0
        i32.const 1050360
        i32.store offset=1050372
        i32.const 0
        i32.const 1050352
        i32.store offset=1050360
        i32.const 0
        i32.const 1050360
        i32.store offset=1050368
        call $_ZN8dlmalloc8dlmalloc5Chunk10mem_offset17h2818126ab4d4ccc1E
        local.tee 3
        i32.const 8
        call $_ZN8dlmalloc8dlmalloc8align_up17h0e87fd8a6d5b4dd0E
        local.set 4
        i32.const 20
        i32.const 8
        call $_ZN8dlmalloc8dlmalloc8align_up17h0e87fd8a6d5b4dd0E
        local.set 7
        i32.const 16
        i32.const 8
        call $_ZN8dlmalloc8dlmalloc8align_up17h0e87fd8a6d5b4dd0E
        local.set 8
        i32.const 0
        local.get 6
        local.get 6
        call $_ZN8dlmalloc8dlmalloc5Chunk6to_mem17hc02bf0af126119c0E
        local.tee 0
        i32.const 8
        call $_ZN8dlmalloc8dlmalloc8align_up17h0e87fd8a6d5b4dd0E
        local.get 0
        i32.sub
        local.tee 10
        call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h9b67d52a46bbff2cE
        local.tee 0
        i32.store offset=1050396
        i32.const 0
        local.get 3
        local.get 5
        i32.add
        local.get 8
        local.get 4
        local.get 7
        i32.add
        i32.add
        local.get 10
        i32.add
        i32.sub
        local.tee 6
        i32.store offset=1050388
        local.get 0
        local.get 6
        i32.const 1
        i32.or
        i32.store offset=4
        call $_ZN8dlmalloc8dlmalloc5Chunk10mem_offset17h2818126ab4d4ccc1E
        local.tee 3
        i32.const 8
        call $_ZN8dlmalloc8dlmalloc8align_up17h0e87fd8a6d5b4dd0E
        local.set 4
        i32.const 20
        i32.const 8
        call $_ZN8dlmalloc8dlmalloc8align_up17h0e87fd8a6d5b4dd0E
        local.set 5
        i32.const 16
        i32.const 8
        call $_ZN8dlmalloc8dlmalloc8align_up17h0e87fd8a6d5b4dd0E
        local.set 7
        local.get 0
        local.get 6
        call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h9b67d52a46bbff2cE
        local.get 7
        local.get 5
        local.get 4
        local.get 3
        i32.sub
        i32.add
        i32.add
        i32.store offset=4
        i32.const 0
        i32.const 2097152
        i32.store offset=1050408
      end
      i32.const 0
      local.set 6
      i32.const 0
      i32.load offset=1050388
      local.tee 0
      local.get 2
      i32.le_u
      br_if 0 (;@1;)
      i32.const 0
      local.get 0
      local.get 2
      i32.sub
      local.tee 6
      i32.store offset=1050388
      i32.const 0
      i32.const 0
      i32.load offset=1050396
      local.tee 0
      local.get 2
      call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h9b67d52a46bbff2cE
      local.tee 3
      i32.store offset=1050396
      local.get 3
      local.get 6
      i32.const 1
      i32.or
      i32.store offset=4
      local.get 0
      local.get 2
      call $_ZN8dlmalloc8dlmalloc5Chunk34set_size_and_pinuse_of_inuse_chunk17h4a3baeef63b4aae1E
      local.get 0
      call $_ZN8dlmalloc8dlmalloc5Chunk6to_mem17hc02bf0af126119c0E
      local.set 6
    end
    local.get 1
    i32.const 16
    i32.add
    global.set $__stack_pointer
    local.get 6)
  (func $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$8init_top17h9f173f15516b6497E (type 0) (param i32 i32)
    (local i32 i32 i32 i32)
    local.get 0
    local.get 0
    call $_ZN8dlmalloc8dlmalloc5Chunk6to_mem17hc02bf0af126119c0E
    local.tee 2
    i32.const 8
    call $_ZN8dlmalloc8dlmalloc8align_up17h0e87fd8a6d5b4dd0E
    local.get 2
    i32.sub
    local.tee 2
    call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h9b67d52a46bbff2cE
    local.set 0
    i32.const 0
    local.get 1
    local.get 2
    i32.sub
    local.tee 1
    i32.store offset=1050388
    i32.const 0
    local.get 0
    i32.store offset=1050396
    local.get 0
    local.get 1
    i32.const 1
    i32.or
    i32.store offset=4
    call $_ZN8dlmalloc8dlmalloc5Chunk10mem_offset17h2818126ab4d4ccc1E
    local.tee 2
    i32.const 8
    call $_ZN8dlmalloc8dlmalloc8align_up17h0e87fd8a6d5b4dd0E
    local.set 3
    i32.const 20
    i32.const 8
    call $_ZN8dlmalloc8dlmalloc8align_up17h0e87fd8a6d5b4dd0E
    local.set 4
    i32.const 16
    i32.const 8
    call $_ZN8dlmalloc8dlmalloc8align_up17h0e87fd8a6d5b4dd0E
    local.set 5
    local.get 0
    local.get 1
    call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h9b67d52a46bbff2cE
    local.get 5
    local.get 4
    local.get 3
    local.get 2
    i32.sub
    i32.add
    i32.add
    i32.store offset=4
    i32.const 0
    i32.const 2097152
    i32.store offset=1050408)
  (func $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$8memalign17h4975f1e1d24aff71E (type 2) (param i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32)
    block  ;; label = @1
      i32.const 16
      i32.const 8
      call $_ZN8dlmalloc8dlmalloc8align_up17h0e87fd8a6d5b4dd0E
      local.get 0
      i32.le_u
      br_if 0 (;@1;)
      i32.const 16
      i32.const 8
      call $_ZN8dlmalloc8dlmalloc8align_up17h0e87fd8a6d5b4dd0E
      local.set 0
    end
    call $_ZN8dlmalloc8dlmalloc5Chunk10mem_offset17h2818126ab4d4ccc1E
    local.tee 2
    i32.const 8
    call $_ZN8dlmalloc8dlmalloc8align_up17h0e87fd8a6d5b4dd0E
    local.set 3
    i32.const 20
    i32.const 8
    call $_ZN8dlmalloc8dlmalloc8align_up17h0e87fd8a6d5b4dd0E
    local.set 4
    i32.const 16
    i32.const 8
    call $_ZN8dlmalloc8dlmalloc8align_up17h0e87fd8a6d5b4dd0E
    local.set 5
    i32.const 0
    local.set 6
    block  ;; label = @1
      i32.const 0
      i32.const 16
      i32.const 8
      call $_ZN8dlmalloc8dlmalloc8align_up17h0e87fd8a6d5b4dd0E
      i32.const 2
      i32.shl
      i32.sub
      local.tee 7
      local.get 2
      local.get 5
      local.get 3
      local.get 4
      i32.add
      i32.add
      i32.sub
      i32.const -65544
      i32.add
      i32.const -9
      i32.and
      i32.const -3
      i32.add
      local.tee 2
      local.get 7
      local.get 2
      i32.lt_u
      select
      local.get 0
      i32.sub
      local.get 1
      i32.le_u
      br_if 0 (;@1;)
      local.get 0
      i32.const 16
      local.get 1
      i32.const 4
      i32.add
      i32.const 16
      i32.const 8
      call $_ZN8dlmalloc8dlmalloc8align_up17h0e87fd8a6d5b4dd0E
      i32.const -5
      i32.add
      local.get 1
      i32.gt_u
      select
      i32.const 8
      call $_ZN8dlmalloc8dlmalloc8align_up17h0e87fd8a6d5b4dd0E
      local.tee 3
      i32.add
      i32.const 16
      i32.const 8
      call $_ZN8dlmalloc8dlmalloc8align_up17h0e87fd8a6d5b4dd0E
      i32.add
      i32.const -4
      i32.add
      call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$6malloc17h77bc0faa7fd9e29bE
      local.tee 2
      i32.eqz
      br_if 0 (;@1;)
      local.get 2
      call $_ZN8dlmalloc8dlmalloc5Chunk8from_mem17h580b9f140f06bda7E
      local.set 1
      block  ;; label = @2
        block  ;; label = @3
          local.get 0
          i32.const -1
          i32.add
          local.tee 6
          local.get 2
          i32.and
          br_if 0 (;@3;)
          local.get 1
          local.set 0
          br 1 (;@2;)
        end
        local.get 6
        local.get 2
        i32.add
        i32.const 0
        local.get 0
        i32.sub
        i32.and
        call $_ZN8dlmalloc8dlmalloc5Chunk8from_mem17h580b9f140f06bda7E
        local.set 6
        i32.const 16
        i32.const 8
        call $_ZN8dlmalloc8dlmalloc8align_up17h0e87fd8a6d5b4dd0E
        local.set 2
        local.get 1
        call $_ZN8dlmalloc8dlmalloc5Chunk4size17h7f97819e0e1a81b6E
        local.get 6
        i32.const 0
        local.get 0
        local.get 6
        local.get 1
        i32.sub
        local.get 2
        i32.gt_u
        select
        i32.add
        local.tee 0
        local.get 1
        i32.sub
        local.tee 6
        i32.sub
        local.set 2
        block  ;; label = @3
          local.get 1
          call $_ZN8dlmalloc8dlmalloc5Chunk7mmapped17h78a75c1ab0261090E
          br_if 0 (;@3;)
          local.get 0
          local.get 2
          call $_ZN8dlmalloc8dlmalloc5Chunk9set_inuse17h11955a4ac5122936E
          local.get 1
          local.get 6
          call $_ZN8dlmalloc8dlmalloc5Chunk9set_inuse17h11955a4ac5122936E
          local.get 1
          local.get 6
          call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$13dispose_chunk17h814c7cfd84378e6aE
          br 1 (;@2;)
        end
        local.get 1
        i32.load
        local.set 1
        local.get 0
        local.get 2
        i32.store offset=4
        local.get 0
        local.get 1
        local.get 6
        i32.add
        i32.store
      end
      block  ;; label = @2
        local.get 0
        call $_ZN8dlmalloc8dlmalloc5Chunk7mmapped17h78a75c1ab0261090E
        br_if 0 (;@2;)
        local.get 0
        call $_ZN8dlmalloc8dlmalloc5Chunk4size17h7f97819e0e1a81b6E
        local.tee 1
        i32.const 16
        i32.const 8
        call $_ZN8dlmalloc8dlmalloc8align_up17h0e87fd8a6d5b4dd0E
        local.get 3
        i32.add
        i32.le_u
        br_if 0 (;@2;)
        local.get 0
        local.get 3
        call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h9b67d52a46bbff2cE
        local.set 6
        local.get 0
        local.get 3
        call $_ZN8dlmalloc8dlmalloc5Chunk9set_inuse17h11955a4ac5122936E
        local.get 6
        local.get 1
        local.get 3
        i32.sub
        local.tee 1
        call $_ZN8dlmalloc8dlmalloc5Chunk9set_inuse17h11955a4ac5122936E
        local.get 6
        local.get 1
        call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$13dispose_chunk17h814c7cfd84378e6aE
      end
      local.get 0
      call $_ZN8dlmalloc8dlmalloc5Chunk6to_mem17hc02bf0af126119c0E
      local.set 6
      local.get 0
      call $_ZN8dlmalloc8dlmalloc5Chunk7mmapped17h78a75c1ab0261090E
      drop
    end
    local.get 6)
  (func $_ZN3std10sys_common9backtrace26__rust_end_short_backtrace17h04fac26f88d230dfE (type 4) (param i32)
    local.get 0
    call $_ZN3std9panicking19begin_panic_handler28_$u7b$$u7b$closure$u7d$$u7d$17he405aaeb801d5772E
    unreachable)
  (func $_ZN3std9panicking19begin_panic_handler28_$u7b$$u7b$closure$u7d$$u7d$17he405aaeb801d5772E (type 4) (param i32)
    (local i32 i32 i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 1
    global.set $__stack_pointer
    local.get 0
    i32.load
    local.tee 2
    i32.const 12
    i32.add
    i32.load
    local.set 3
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            local.get 2
            i32.load offset=4
            br_table 0 (;@4;) 1 (;@3;) 3 (;@1;)
          end
          local.get 3
          br_if 2 (;@1;)
          i32.const 1049096
          local.set 2
          i32.const 0
          local.set 3
          br 1 (;@2;)
        end
        local.get 3
        br_if 1 (;@1;)
        local.get 2
        i32.load
        local.tee 2
        i32.load offset=4
        local.set 3
        local.get 2
        i32.load
        local.set 2
      end
      local.get 1
      local.get 3
      i32.store offset=4
      local.get 1
      local.get 2
      i32.store
      local.get 1
      i32.const 1049280
      local.get 0
      i32.load offset=4
      local.tee 2
      call $_ZN4core5panic10panic_info9PanicInfo7message17ha3c0b951fa489593E
      local.get 0
      i32.load offset=8
      local.get 2
      call $_ZN4core5panic10panic_info9PanicInfo10can_unwind17h75205550bb42d21cE
      call $_ZN3std9panicking20rust_panic_with_hook17h7601402c0a383194E
      unreachable
    end
    local.get 1
    i32.const 0
    i32.store offset=4
    local.get 1
    local.get 2
    i32.store
    local.get 1
    i32.const 1049300
    local.get 0
    i32.load offset=4
    local.tee 2
    call $_ZN4core5panic10panic_info9PanicInfo7message17ha3c0b951fa489593E
    local.get 0
    i32.load offset=8
    local.get 2
    call $_ZN4core5panic10panic_info9PanicInfo10can_unwind17h75205550bb42d21cE
    call $_ZN3std9panicking20rust_panic_with_hook17h7601402c0a383194E
    unreachable)
  (func $_ZN3std5alloc24default_alloc_error_hook17hab840010b11b64ffE (type 0) (param i32 i32)
    (local i32)
    global.get $__stack_pointer
    i32.const 48
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    block  ;; label = @1
      i32.const 0
      i32.load8_u offset=1049940
      i32.eqz
      br_if 0 (;@1;)
      local.get 2
      i32.const 20
      i32.add
      i64.const 1
      i64.store align=4
      local.get 2
      i32.const 2
      i32.store offset=12
      local.get 2
      i32.const 1049132
      i32.store offset=8
      local.get 2
      i32.const 5
      i32.store offset=36
      local.get 2
      local.get 1
      i32.store offset=44
      local.get 2
      local.get 2
      i32.const 32
      i32.add
      i32.store offset=16
      local.get 2
      local.get 2
      i32.const 44
      i32.add
      i32.store offset=32
      local.get 2
      i32.const 8
      i32.add
      i32.const 1049172
      call $_ZN4core9panicking9panic_fmt17h6dad0405f48e39e2E
      unreachable
    end
    local.get 2
    i32.const 48
    i32.add
    global.set $__stack_pointer)
  (func $__rdl_alloc (type 2) (param i32 i32) (result i32)
    block  ;; label = @1
      local.get 1
      i32.const 9
      i32.lt_u
      br_if 0 (;@1;)
      local.get 1
      local.get 0
      call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$8memalign17h4975f1e1d24aff71E
      return
    end
    local.get 0
    call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$6malloc17h77bc0faa7fd9e29bE)
  (func $__rdl_dealloc (type 7) (param i32 i32 i32)
    local.get 0
    call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$4free17h38a840ecb1c1c0fbE)
  (func $__rdl_realloc (type 10) (param i32 i32 i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32)
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              block  ;; label = @6
                local.get 2
                i32.const 9
                i32.lt_u
                br_if 0 (;@6;)
                local.get 2
                local.get 3
                call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$8memalign17h4975f1e1d24aff71E
                local.tee 2
                br_if 1 (;@5;)
                i32.const 0
                return
              end
              call $_ZN8dlmalloc8dlmalloc5Chunk10mem_offset17h2818126ab4d4ccc1E
              local.tee 1
              i32.const 8
              call $_ZN8dlmalloc8dlmalloc8align_up17h0e87fd8a6d5b4dd0E
              local.set 4
              i32.const 20
              i32.const 8
              call $_ZN8dlmalloc8dlmalloc8align_up17h0e87fd8a6d5b4dd0E
              local.set 5
              i32.const 16
              i32.const 8
              call $_ZN8dlmalloc8dlmalloc8align_up17h0e87fd8a6d5b4dd0E
              local.set 6
              i32.const 0
              local.set 2
              i32.const 0
              i32.const 16
              i32.const 8
              call $_ZN8dlmalloc8dlmalloc8align_up17h0e87fd8a6d5b4dd0E
              i32.const 2
              i32.shl
              i32.sub
              local.tee 7
              local.get 1
              local.get 6
              local.get 4
              local.get 5
              i32.add
              i32.add
              i32.sub
              i32.const -65544
              i32.add
              i32.const -9
              i32.and
              i32.const -3
              i32.add
              local.tee 1
              local.get 7
              local.get 1
              i32.lt_u
              select
              local.get 3
              i32.le_u
              br_if 3 (;@2;)
              i32.const 16
              local.get 3
              i32.const 4
              i32.add
              i32.const 16
              i32.const 8
              call $_ZN8dlmalloc8dlmalloc8align_up17h0e87fd8a6d5b4dd0E
              i32.const -5
              i32.add
              local.get 3
              i32.gt_u
              select
              i32.const 8
              call $_ZN8dlmalloc8dlmalloc8align_up17h0e87fd8a6d5b4dd0E
              local.set 4
              local.get 0
              call $_ZN8dlmalloc8dlmalloc5Chunk8from_mem17h580b9f140f06bda7E
              local.set 1
              local.get 1
              local.get 1
              call $_ZN8dlmalloc8dlmalloc5Chunk4size17h7f97819e0e1a81b6E
              local.tee 5
              call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h9b67d52a46bbff2cE
              local.set 6
              block  ;; label = @6
                block  ;; label = @7
                  block  ;; label = @8
                    block  ;; label = @9
                      block  ;; label = @10
                        block  ;; label = @11
                          block  ;; label = @12
                            local.get 1
                            call $_ZN8dlmalloc8dlmalloc5Chunk7mmapped17h78a75c1ab0261090E
                            br_if 0 (;@12;)
                            local.get 5
                            local.get 4
                            i32.ge_u
                            br_if 4 (;@8;)
                            local.get 6
                            i32.const 0
                            i32.load offset=1050396
                            i32.eq
                            br_if 6 (;@6;)
                            local.get 6
                            i32.const 0
                            i32.load offset=1050392
                            i32.eq
                            br_if 3 (;@9;)
                            local.get 6
                            call $_ZN8dlmalloc8dlmalloc5Chunk6cinuse17h1ffe85bfa307cbe6E
                            br_if 9 (;@3;)
                            local.get 6
                            call $_ZN8dlmalloc8dlmalloc5Chunk4size17h7f97819e0e1a81b6E
                            local.tee 7
                            local.get 5
                            i32.add
                            local.tee 5
                            local.get 4
                            i32.lt_u
                            br_if 9 (;@3;)
                            local.get 5
                            local.get 4
                            i32.sub
                            local.set 8
                            local.get 7
                            i32.const 256
                            i32.lt_u
                            br_if 1 (;@11;)
                            local.get 6
                            call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$18unlink_large_chunk17hb47d8811580bf409E
                            br 2 (;@10;)
                          end
                          local.get 1
                          call $_ZN8dlmalloc8dlmalloc5Chunk4size17h7f97819e0e1a81b6E
                          local.set 5
                          local.get 4
                          i32.const 256
                          i32.lt_u
                          br_if 8 (;@3;)
                          block  ;; label = @12
                            local.get 5
                            local.get 4
                            i32.const 4
                            i32.add
                            i32.lt_u
                            br_if 0 (;@12;)
                            local.get 5
                            local.get 4
                            i32.sub
                            i32.const 131073
                            i32.lt_u
                            br_if 5 (;@7;)
                          end
                          i32.const 1049968
                          local.get 1
                          local.get 1
                          i32.load
                          local.tee 6
                          i32.sub
                          local.get 5
                          local.get 6
                          i32.add
                          i32.const 16
                          i32.add
                          local.tee 7
                          local.get 4
                          i32.const 31
                          i32.add
                          i32.const 1049968
                          call $_ZN61_$LT$dlmalloc..sys..System$u20$as$u20$dlmalloc..Allocator$GT$9page_size17hb3843d9dc082c5b9E
                          call $_ZN8dlmalloc8dlmalloc8align_up17h0e87fd8a6d5b4dd0E
                          local.tee 5
                          i32.const 1
                          call $_ZN61_$LT$dlmalloc..sys..System$u20$as$u20$dlmalloc..Allocator$GT$5remap17hdb996963ff5d078cE
                          local.tee 4
                          i32.eqz
                          br_if 8 (;@3;)
                          local.get 4
                          local.get 6
                          i32.add
                          local.tee 1
                          local.get 5
                          local.get 6
                          i32.sub
                          local.tee 3
                          i32.const -16
                          i32.add
                          local.tee 2
                          i32.store offset=4
                          call $_ZN8dlmalloc8dlmalloc5Chunk14fencepost_head17h782694e16a323064E
                          local.set 0
                          local.get 1
                          local.get 2
                          call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h9b67d52a46bbff2cE
                          local.get 0
                          i32.store offset=4
                          local.get 1
                          local.get 3
                          i32.const -12
                          i32.add
                          call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h9b67d52a46bbff2cE
                          i32.const 0
                          i32.store offset=4
                          i32.const 0
                          i32.const 0
                          i32.load offset=1050400
                          local.get 5
                          local.get 7
                          i32.sub
                          i32.add
                          local.tee 3
                          i32.store offset=1050400
                          i32.const 0
                          i32.const 0
                          i32.load offset=1050412
                          local.tee 2
                          local.get 4
                          local.get 4
                          local.get 2
                          i32.gt_u
                          select
                          i32.store offset=1050412
                          i32.const 0
                          i32.const 0
                          i32.load offset=1050404
                          local.tee 2
                          local.get 3
                          local.get 2
                          local.get 3
                          i32.gt_u
                          select
                          i32.store offset=1050404
                          br 10 (;@1;)
                        end
                        block  ;; label = @11
                          local.get 6
                          i32.const 12
                          i32.add
                          i32.load
                          local.tee 9
                          local.get 6
                          i32.const 8
                          i32.add
                          i32.load
                          local.tee 6
                          i32.eq
                          br_if 0 (;@11;)
                          local.get 6
                          local.get 9
                          i32.store offset=12
                          local.get 9
                          local.get 6
                          i32.store offset=8
                          br 1 (;@10;)
                        end
                        i32.const 0
                        i32.const 0
                        i32.load offset=1050376
                        i32.const -2
                        local.get 7
                        i32.const 3
                        i32.shr_u
                        i32.rotl
                        i32.and
                        i32.store offset=1050376
                      end
                      block  ;; label = @10
                        local.get 8
                        i32.const 16
                        i32.const 8
                        call $_ZN8dlmalloc8dlmalloc8align_up17h0e87fd8a6d5b4dd0E
                        i32.lt_u
                        br_if 0 (;@10;)
                        local.get 1
                        local.get 4
                        call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h9b67d52a46bbff2cE
                        local.set 5
                        local.get 1
                        local.get 4
                        call $_ZN8dlmalloc8dlmalloc5Chunk9set_inuse17h11955a4ac5122936E
                        local.get 5
                        local.get 8
                        call $_ZN8dlmalloc8dlmalloc5Chunk9set_inuse17h11955a4ac5122936E
                        local.get 5
                        local.get 8
                        call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$13dispose_chunk17h814c7cfd84378e6aE
                        local.get 1
                        br_if 9 (;@1;)
                        br 7 (;@3;)
                      end
                      local.get 1
                      local.get 5
                      call $_ZN8dlmalloc8dlmalloc5Chunk9set_inuse17h11955a4ac5122936E
                      local.get 1
                      br_if 8 (;@1;)
                      br 6 (;@3;)
                    end
                    i32.const 0
                    i32.load offset=1050384
                    local.get 5
                    i32.add
                    local.tee 5
                    local.get 4
                    i32.lt_u
                    br_if 5 (;@3;)
                    block  ;; label = @9
                      block  ;; label = @10
                        local.get 5
                        local.get 4
                        i32.sub
                        local.tee 6
                        i32.const 16
                        i32.const 8
                        call $_ZN8dlmalloc8dlmalloc8align_up17h0e87fd8a6d5b4dd0E
                        i32.ge_u
                        br_if 0 (;@10;)
                        local.get 1
                        local.get 5
                        call $_ZN8dlmalloc8dlmalloc5Chunk9set_inuse17h11955a4ac5122936E
                        i32.const 0
                        local.set 6
                        i32.const 0
                        local.set 5
                        br 1 (;@9;)
                      end
                      local.get 1
                      local.get 4
                      call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h9b67d52a46bbff2cE
                      local.tee 5
                      local.get 6
                      call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h9b67d52a46bbff2cE
                      local.set 7
                      local.get 1
                      local.get 4
                      call $_ZN8dlmalloc8dlmalloc5Chunk9set_inuse17h11955a4ac5122936E
                      local.get 5
                      local.get 6
                      call $_ZN8dlmalloc8dlmalloc5Chunk33set_size_and_pinuse_of_free_chunk17habe76bbe555b1e73E
                      local.get 7
                      call $_ZN8dlmalloc8dlmalloc5Chunk12clear_pinuse17h0b911081ee46f5e4E
                    end
                    i32.const 0
                    local.get 5
                    i32.store offset=1050392
                    i32.const 0
                    local.get 6
                    i32.store offset=1050384
                    local.get 1
                    br_if 7 (;@1;)
                    br 5 (;@3;)
                  end
                  local.get 5
                  local.get 4
                  i32.sub
                  local.tee 5
                  i32.const 16
                  i32.const 8
                  call $_ZN8dlmalloc8dlmalloc8align_up17h0e87fd8a6d5b4dd0E
                  i32.lt_u
                  br_if 0 (;@7;)
                  local.get 1
                  local.get 4
                  call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h9b67d52a46bbff2cE
                  local.set 6
                  local.get 1
                  local.get 4
                  call $_ZN8dlmalloc8dlmalloc5Chunk9set_inuse17h11955a4ac5122936E
                  local.get 6
                  local.get 5
                  call $_ZN8dlmalloc8dlmalloc5Chunk9set_inuse17h11955a4ac5122936E
                  local.get 6
                  local.get 5
                  call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$13dispose_chunk17h814c7cfd84378e6aE
                end
                local.get 1
                br_if 5 (;@1;)
                br 3 (;@3;)
              end
              i32.const 0
              i32.load offset=1050388
              local.get 5
              i32.add
              local.tee 5
              local.get 4
              i32.gt_u
              br_if 1 (;@4;)
              br 2 (;@3;)
            end
            local.get 2
            local.get 0
            local.get 1
            local.get 3
            local.get 1
            local.get 3
            i32.lt_u
            select
            call $memcpy
            drop
            local.get 0
            call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$4free17h38a840ecb1c1c0fbE
            br 2 (;@2;)
          end
          local.get 1
          local.get 4
          call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h9b67d52a46bbff2cE
          local.set 6
          local.get 1
          local.get 4
          call $_ZN8dlmalloc8dlmalloc5Chunk9set_inuse17h11955a4ac5122936E
          local.get 6
          local.get 5
          local.get 4
          i32.sub
          local.tee 4
          i32.const 1
          i32.or
          i32.store offset=4
          i32.const 0
          local.get 4
          i32.store offset=1050388
          i32.const 0
          local.get 6
          i32.store offset=1050396
          local.get 1
          br_if 2 (;@1;)
        end
        local.get 3
        call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$6malloc17h77bc0faa7fd9e29bE
        local.tee 4
        i32.eqz
        br_if 0 (;@2;)
        local.get 4
        local.get 0
        local.get 1
        call $_ZN8dlmalloc8dlmalloc5Chunk4size17h7f97819e0e1a81b6E
        i32.const -8
        i32.const -4
        local.get 1
        call $_ZN8dlmalloc8dlmalloc5Chunk7mmapped17h78a75c1ab0261090E
        select
        i32.add
        local.tee 2
        local.get 3
        local.get 2
        local.get 3
        i32.lt_u
        select
        call $memcpy
        local.set 3
        local.get 0
        call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$4free17h38a840ecb1c1c0fbE
        local.get 3
        return
      end
      local.get 2
      return
    end
    local.get 1
    call $_ZN8dlmalloc8dlmalloc5Chunk7mmapped17h78a75c1ab0261090E
    drop
    local.get 1
    call $_ZN8dlmalloc8dlmalloc5Chunk6to_mem17hc02bf0af126119c0E)
  (func $__rdl_alloc_zeroed (type 2) (param i32 i32) (result i32)
    block  ;; label = @1
      block  ;; label = @2
        local.get 1
        i32.const 9
        i32.lt_u
        br_if 0 (;@2;)
        local.get 1
        local.get 0
        call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$8memalign17h4975f1e1d24aff71E
        local.set 1
        br 1 (;@1;)
      end
      local.get 0
      call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$6malloc17h77bc0faa7fd9e29bE
      local.set 1
    end
    block  ;; label = @1
      local.get 1
      i32.eqz
      br_if 0 (;@1;)
      block  ;; label = @2
        i32.const 1049968
        call $_ZN61_$LT$dlmalloc..sys..System$u20$as$u20$dlmalloc..Allocator$GT$15allocates_zeros17h598c0d26e9d865e2E
        i32.eqz
        br_if 0 (;@2;)
        local.get 1
        call $_ZN8dlmalloc8dlmalloc5Chunk8from_mem17h580b9f140f06bda7E
        call $_ZN8dlmalloc8dlmalloc5Chunk7mmapped17h78a75c1ab0261090E
        br_if 1 (;@1;)
      end
      local.get 1
      i32.const 0
      local.get 0
      call $memset
      drop
    end
    local.get 1)
  (func $rust_begin_unwind (type 4) (param i32)
    (local i32 i32 i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 1
    global.set $__stack_pointer
    block  ;; label = @1
      block  ;; label = @2
        local.get 0
        call $_ZN4core5panic10panic_info9PanicInfo8location17h1ccdb1bf0bb693f4E
        local.tee 2
        i32.eqz
        br_if 0 (;@2;)
        local.get 0
        call $_ZN4core5panic10panic_info9PanicInfo7message17ha3c0b951fa489593E
        local.tee 3
        i32.eqz
        br_if 1 (;@1;)
        local.get 1
        local.get 2
        i32.store offset=8
        local.get 1
        local.get 0
        i32.store offset=4
        local.get 1
        local.get 3
        i32.store
        local.get 1
        call $_ZN3std10sys_common9backtrace26__rust_end_short_backtrace17h04fac26f88d230dfE
        unreachable
      end
      i32.const 1049028
      i32.const 43
      i32.const 1049216
      call $_ZN4core9panicking5panic17hfd6e422134ee8ce5E
      unreachable
    end
    i32.const 1049028
    i32.const 43
    i32.const 1049232
    call $_ZN4core9panicking5panic17hfd6e422134ee8ce5E
    unreachable)
  (func $_ZN90_$LT$std..panicking..begin_panic_handler..PanicPayload$u20$as$u20$core..panic..BoxMeUp$GT$8take_box17h910c38d4f578a2b7E (type 0) (param i32 i32)
    (local i32 i32 i32 i32 i64)
    global.get $__stack_pointer
    i32.const 48
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    local.get 1
    i32.const 4
    i32.add
    local.set 3
    block  ;; label = @1
      local.get 1
      i32.load offset=4
      br_if 0 (;@1;)
      local.get 1
      i32.load
      local.set 4
      local.get 2
      i32.const 32
      i32.add
      i32.const 8
      i32.add
      local.tee 5
      i32.const 0
      i32.store
      local.get 2
      i64.const 1
      i64.store offset=32
      local.get 2
      local.get 2
      i32.const 32
      i32.add
      i32.store offset=44
      local.get 2
      i32.const 44
      i32.add
      i32.const 1049072
      local.get 4
      call $_ZN4core3fmt5write17hce4d120ebbfb2b82E
      drop
      local.get 2
      i32.const 16
      i32.add
      i32.const 8
      i32.add
      local.get 5
      i32.load
      local.tee 4
      i32.store
      local.get 2
      local.get 2
      i64.load offset=32
      local.tee 6
      i64.store offset=16
      local.get 3
      i32.const 8
      i32.add
      local.get 4
      i32.store
      local.get 3
      local.get 6
      i64.store align=4
    end
    local.get 2
    i32.const 8
    i32.add
    local.tee 4
    local.get 3
    i32.const 8
    i32.add
    i32.load
    i32.store
    local.get 1
    i32.const 12
    i32.add
    i32.const 0
    i32.store
    local.get 3
    i64.load align=4
    local.set 6
    local.get 1
    i64.const 1
    i64.store offset=4 align=4
    i32.const 0
    i32.load8_u offset=1049941
    drop
    local.get 2
    local.get 6
    i64.store
    block  ;; label = @1
      i32.const 12
      i32.const 4
      call $__rust_alloc
      local.tee 1
      br_if 0 (;@1;)
      i32.const 4
      i32.const 12
      call $_ZN5alloc5alloc18handle_alloc_error17hbbf685130f283420E
      unreachable
    end
    local.get 1
    local.get 2
    i64.load
    i64.store align=4
    local.get 1
    i32.const 8
    i32.add
    local.get 4
    i32.load
    i32.store
    local.get 0
    i32.const 1049248
    i32.store offset=4
    local.get 0
    local.get 1
    i32.store
    local.get 2
    i32.const 48
    i32.add
    global.set $__stack_pointer)
  (func $_ZN90_$LT$std..panicking..begin_panic_handler..PanicPayload$u20$as$u20$core..panic..BoxMeUp$GT$3get17hdf52e0f41fcdce1bE (type 0) (param i32 i32)
    (local i32 i32 i32 i64)
    global.get $__stack_pointer
    i32.const 32
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    local.get 1
    i32.const 4
    i32.add
    local.set 3
    block  ;; label = @1
      local.get 1
      i32.load offset=4
      br_if 0 (;@1;)
      local.get 1
      i32.load
      local.set 1
      local.get 2
      i32.const 16
      i32.add
      i32.const 8
      i32.add
      local.tee 4
      i32.const 0
      i32.store
      local.get 2
      i64.const 1
      i64.store offset=16
      local.get 2
      local.get 2
      i32.const 16
      i32.add
      i32.store offset=28
      local.get 2
      i32.const 28
      i32.add
      i32.const 1049072
      local.get 1
      call $_ZN4core3fmt5write17hce4d120ebbfb2b82E
      drop
      local.get 2
      i32.const 8
      i32.add
      local.get 4
      i32.load
      local.tee 1
      i32.store
      local.get 2
      local.get 2
      i64.load offset=16
      local.tee 5
      i64.store
      local.get 3
      i32.const 8
      i32.add
      local.get 1
      i32.store
      local.get 3
      local.get 5
      i64.store align=4
    end
    local.get 0
    i32.const 1049248
    i32.store offset=4
    local.get 0
    local.get 3
    i32.store
    local.get 2
    i32.const 32
    i32.add
    global.set $__stack_pointer)
  (func $_ZN93_$LT$std..panicking..begin_panic_handler..StrPanicPayload$u20$as$u20$core..panic..BoxMeUp$GT$8take_box17hb935537982794978E (type 0) (param i32 i32)
    (local i32 i32)
    i32.const 0
    i32.load8_u offset=1049941
    drop
    local.get 1
    i32.load offset=4
    local.set 2
    local.get 1
    i32.load
    local.set 3
    block  ;; label = @1
      i32.const 8
      i32.const 4
      call $__rust_alloc
      local.tee 1
      br_if 0 (;@1;)
      i32.const 4
      i32.const 8
      call $_ZN5alloc5alloc18handle_alloc_error17hbbf685130f283420E
      unreachable
    end
    local.get 1
    local.get 2
    i32.store offset=4
    local.get 1
    local.get 3
    i32.store
    local.get 0
    i32.const 1049264
    i32.store offset=4
    local.get 0
    local.get 1
    i32.store)
  (func $_ZN93_$LT$std..panicking..begin_panic_handler..StrPanicPayload$u20$as$u20$core..panic..BoxMeUp$GT$3get17h5a47fb41c3bdfcd5E (type 0) (param i32 i32)
    local.get 0
    i32.const 1049264
    i32.store offset=4
    local.get 0
    local.get 1
    i32.store)
  (func $_ZN3std9panicking20rust_panic_with_hook17h7601402c0a383194E (type 5) (param i32 i32 i32 i32 i32)
    (local i32 i32)
    global.get $__stack_pointer
    i32.const 32
    i32.sub
    local.tee 5
    global.set $__stack_pointer
    i32.const 0
    i32.const 0
    i32.load offset=1049964
    local.tee 6
    i32.const 1
    i32.add
    i32.store offset=1049964
    block  ;; label = @1
      block  ;; label = @2
        local.get 6
        i32.const 0
        i32.lt_s
        br_if 0 (;@2;)
        i32.const 0
        i32.load8_u offset=1050424
        i32.const 255
        i32.and
        br_if 0 (;@2;)
        i32.const 0
        i32.const 1
        i32.store8 offset=1050424
        i32.const 0
        i32.const 0
        i32.load offset=1050420
        i32.const 1
        i32.add
        i32.store offset=1050420
        local.get 5
        local.get 2
        i32.store offset=20
        local.get 5
        i32.const 1049320
        i32.store offset=12
        local.get 5
        i32.const 1049096
        i32.store offset=8
        local.get 5
        local.get 4
        i32.store8 offset=24
        local.get 5
        local.get 3
        i32.store offset=16
        i32.const 0
        i32.load offset=1049948
        local.tee 6
        i32.const -1
        i32.le_s
        br_if 0 (;@2;)
        i32.const 0
        local.get 6
        i32.const 1
        i32.add
        i32.store offset=1049948
        block  ;; label = @3
          i32.const 0
          i32.load offset=1049956
          i32.eqz
          br_if 0 (;@3;)
          local.get 5
          local.get 0
          local.get 1
          i32.load offset=16
          call_indirect (type 0)
          local.get 5
          local.get 5
          i64.load
          i64.store offset=8
          i32.const 0
          i32.load offset=1049956
          local.get 5
          i32.const 8
          i32.add
          i32.const 0
          i32.load offset=1049960
          i32.load offset=20
          call_indirect (type 0)
          i32.const 0
          i32.load offset=1049948
          i32.const -1
          i32.add
          local.set 6
        end
        i32.const 0
        local.get 6
        i32.store offset=1049948
        i32.const 0
        i32.const 0
        i32.store8 offset=1050424
        local.get 4
        br_if 1 (;@1;)
      end
      unreachable
      unreachable
    end
    local.get 0
    local.get 1
    call $rust_panic
    unreachable)
  (func $rust_panic (type 0) (param i32 i32)
    local.get 0
    local.get 1
    call $__rust_start_panic
    drop
    unreachable
    unreachable)
  (func $__rg_oom (type 0) (param i32 i32)
    (local i32)
    local.get 1
    local.get 0
    i32.const 0
    i32.load offset=1049944
    local.tee 2
    i32.const 6
    local.get 2
    select
    call_indirect (type 0)
    unreachable
    unreachable)
  (func $__rust_start_panic (type 2) (param i32 i32) (result i32)
    unreachable
    unreachable)
  (func $_ZN8dlmalloc8dlmalloc8align_up17h0e87fd8a6d5b4dd0E (type 2) (param i32 i32) (result i32)
    local.get 0
    local.get 1
    i32.add
    i32.const -1
    i32.add
    i32.const 0
    local.get 1
    i32.sub
    i32.and)
  (func $_ZN8dlmalloc8dlmalloc9left_bits17h4d52756c14d62f33E (type 3) (param i32) (result i32)
    local.get 0
    i32.const 1
    i32.shl
    local.tee 0
    i32.const 0
    local.get 0
    i32.sub
    i32.or)
  (func $_ZN8dlmalloc8dlmalloc9least_bit17hc206cf4e014f3c55E (type 3) (param i32) (result i32)
    i32.const 0
    local.get 0
    i32.sub
    local.get 0
    i32.and)
  (func $_ZN8dlmalloc8dlmalloc24leftshift_for_tree_index17hbd308eba79453696E (type 3) (param i32) (result i32)
    i32.const 0
    i32.const 25
    local.get 0
    i32.const 1
    i32.shr_u
    i32.sub
    local.get 0
    i32.const 31
    i32.eq
    select)
  (func $_ZN8dlmalloc8dlmalloc5Chunk14fencepost_head17h782694e16a323064E (type 11) (result i32)
    i32.const 7)
  (func $_ZN8dlmalloc8dlmalloc5Chunk4size17h7f97819e0e1a81b6E (type 3) (param i32) (result i32)
    local.get 0
    i32.load offset=4
    i32.const -8
    i32.and)
  (func $_ZN8dlmalloc8dlmalloc5Chunk6cinuse17h1ffe85bfa307cbe6E (type 3) (param i32) (result i32)
    local.get 0
    i32.load8_u offset=4
    i32.const 2
    i32.and
    i32.const 1
    i32.shr_u)
  (func $_ZN8dlmalloc8dlmalloc5Chunk6pinuse17hc6c9f01d2e3fbf67E (type 3) (param i32) (result i32)
    local.get 0
    i32.load offset=4
    i32.const 1
    i32.and)
  (func $_ZN8dlmalloc8dlmalloc5Chunk12clear_pinuse17h0b911081ee46f5e4E (type 4) (param i32)
    local.get 0
    local.get 0
    i32.load offset=4
    i32.const -2
    i32.and
    i32.store offset=4)
  (func $_ZN8dlmalloc8dlmalloc5Chunk5inuse17h6a9390afcf3c4f59E (type 3) (param i32) (result i32)
    local.get 0
    i32.load offset=4
    i32.const 3
    i32.and
    i32.const 1
    i32.ne)
  (func $_ZN8dlmalloc8dlmalloc5Chunk7mmapped17h78a75c1ab0261090E (type 3) (param i32) (result i32)
    local.get 0
    i32.load8_u offset=4
    i32.const 3
    i32.and
    i32.eqz)
  (func $_ZN8dlmalloc8dlmalloc5Chunk9set_inuse17h11955a4ac5122936E (type 0) (param i32 i32)
    local.get 0
    local.get 0
    i32.load offset=4
    i32.const 1
    i32.and
    local.get 1
    i32.or
    i32.const 2
    i32.or
    i32.store offset=4
    local.get 0
    local.get 1
    i32.add
    local.tee 0
    local.get 0
    i32.load offset=4
    i32.const 1
    i32.or
    i32.store offset=4)
  (func $_ZN8dlmalloc8dlmalloc5Chunk20set_inuse_and_pinuse17hc87585256ab7e20fE (type 0) (param i32 i32)
    local.get 0
    local.get 1
    i32.const 3
    i32.or
    i32.store offset=4
    local.get 0
    local.get 1
    i32.add
    local.tee 1
    local.get 1
    i32.load offset=4
    i32.const 1
    i32.or
    i32.store offset=4)
  (func $_ZN8dlmalloc8dlmalloc5Chunk34set_size_and_pinuse_of_inuse_chunk17h4a3baeef63b4aae1E (type 0) (param i32 i32)
    local.get 0
    local.get 1
    i32.const 3
    i32.or
    i32.store offset=4)
  (func $_ZN8dlmalloc8dlmalloc5Chunk33set_size_and_pinuse_of_free_chunk17habe76bbe555b1e73E (type 0) (param i32 i32)
    local.get 0
    local.get 1
    i32.const 1
    i32.or
    i32.store offset=4
    local.get 0
    local.get 1
    i32.add
    local.get 1
    i32.store)
  (func $_ZN8dlmalloc8dlmalloc5Chunk20set_free_with_pinuse17h2b5f242508300075E (type 7) (param i32 i32 i32)
    local.get 2
    local.get 2
    i32.load offset=4
    i32.const -2
    i32.and
    i32.store offset=4
    local.get 0
    local.get 1
    i32.const 1
    i32.or
    i32.store offset=4
    local.get 0
    local.get 1
    i32.add
    local.get 1
    i32.store)
  (func $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h9b67d52a46bbff2cE (type 2) (param i32 i32) (result i32)
    local.get 0
    local.get 1
    i32.add)
  (func $_ZN8dlmalloc8dlmalloc5Chunk12minus_offset17h9670d4355605a879E (type 2) (param i32 i32) (result i32)
    local.get 0
    local.get 1
    i32.sub)
  (func $_ZN8dlmalloc8dlmalloc5Chunk6to_mem17hc02bf0af126119c0E (type 3) (param i32) (result i32)
    local.get 0
    i32.const 8
    i32.add)
  (func $_ZN8dlmalloc8dlmalloc5Chunk10mem_offset17h2818126ab4d4ccc1E (type 11) (result i32)
    i32.const 8)
  (func $_ZN8dlmalloc8dlmalloc5Chunk8from_mem17h580b9f140f06bda7E (type 3) (param i32) (result i32)
    local.get 0
    i32.const -8
    i32.add)
  (func $_ZN8dlmalloc8dlmalloc9TreeChunk14leftmost_child17h1ae27d38517e0e1cE (type 3) (param i32) (result i32)
    (local i32)
    block  ;; label = @1
      local.get 0
      i32.load offset=16
      local.tee 1
      br_if 0 (;@1;)
      local.get 0
      i32.const 20
      i32.add
      i32.load
      local.set 1
    end
    local.get 1)
  (func $_ZN8dlmalloc8dlmalloc9TreeChunk5chunk17h4562a4235ab5a16eE (type 3) (param i32) (result i32)
    local.get 0)
  (func $_ZN8dlmalloc8dlmalloc9TreeChunk4next17h1b01b32aed8bcb04E (type 3) (param i32) (result i32)
    local.get 0
    i32.load offset=12)
  (func $_ZN8dlmalloc8dlmalloc9TreeChunk4prev17h2dd3935342ae5ab3E (type 3) (param i32) (result i32)
    local.get 0
    i32.load offset=8)
  (func $_ZN8dlmalloc8dlmalloc7Segment9is_extern17h3cbba93f4e5cfab1E (type 3) (param i32) (result i32)
    local.get 0
    i32.load offset=12
    i32.const 1
    i32.and)
  (func $_ZN8dlmalloc8dlmalloc7Segment9sys_flags17hd7870bf529598941E (type 3) (param i32) (result i32)
    local.get 0
    i32.load offset=12
    i32.const 1
    i32.shr_u)
  (func $_ZN8dlmalloc8dlmalloc7Segment5holds17he3b1db583c6e4172E (type 2) (param i32 i32) (result i32)
    (local i32 i32)
    i32.const 0
    local.set 2
    block  ;; label = @1
      local.get 0
      i32.load
      local.tee 3
      local.get 1
      i32.gt_u
      br_if 0 (;@1;)
      local.get 3
      local.get 0
      i32.load offset=4
      i32.add
      local.get 1
      i32.gt_u
      local.set 2
    end
    local.get 2)
  (func $_ZN8dlmalloc8dlmalloc7Segment3top17h96cd19ac0fd36e05E (type 3) (param i32) (result i32)
    local.get 0
    i32.load
    local.get 0
    i32.load offset=4
    i32.add)
  (func $_ZN61_$LT$dlmalloc..sys..System$u20$as$u20$dlmalloc..Allocator$GT$5alloc17h9bcb497e409528ddE (type 7) (param i32 i32 i32)
    (local i32)
    local.get 2
    i32.const 16
    i32.shr_u
    memory.grow
    local.set 3
    local.get 0
    i32.const 0
    i32.store offset=8
    local.get 0
    i32.const 0
    local.get 2
    i32.const -65536
    i32.and
    local.get 3
    i32.const -1
    i32.eq
    local.tee 2
    select
    i32.store offset=4
    local.get 0
    i32.const 0
    local.get 3
    i32.const 16
    i32.shl
    local.get 2
    select
    i32.store)
  (func $_ZN61_$LT$dlmalloc..sys..System$u20$as$u20$dlmalloc..Allocator$GT$5remap17hdb996963ff5d078cE (type 12) (param i32 i32 i32 i32 i32) (result i32)
    i32.const 0)
  (func $_ZN61_$LT$dlmalloc..sys..System$u20$as$u20$dlmalloc..Allocator$GT$9free_part17had77920da45d8a75E (type 10) (param i32 i32 i32 i32) (result i32)
    i32.const 0)
  (func $_ZN61_$LT$dlmalloc..sys..System$u20$as$u20$dlmalloc..Allocator$GT$4free17hd714605ffb598b3fE (type 1) (param i32 i32 i32) (result i32)
    i32.const 0)
  (func $_ZN61_$LT$dlmalloc..sys..System$u20$as$u20$dlmalloc..Allocator$GT$16can_release_part17h9678d24cb077bde0E (type 2) (param i32 i32) (result i32)
    i32.const 0)
  (func $_ZN61_$LT$dlmalloc..sys..System$u20$as$u20$dlmalloc..Allocator$GT$15allocates_zeros17h598c0d26e9d865e2E (type 3) (param i32) (result i32)
    i32.const 1)
  (func $_ZN61_$LT$dlmalloc..sys..System$u20$as$u20$dlmalloc..Allocator$GT$9page_size17hb3843d9dc082c5b9E (type 3) (param i32) (result i32)
    i32.const 65536)
  (func $_ZN5alloc5alloc18handle_alloc_error17hbbf685130f283420E (type 0) (param i32 i32)
    local.get 0
    local.get 1
    call $_ZN5alloc5alloc18handle_alloc_error8rt_error17ha06fd10b3c267ebeE
    unreachable)
  (func $_ZN5alloc7raw_vec17capacity_overflow17h69391d2b6a90e408E (type 13)
    (local i32)
    global.get $__stack_pointer
    i32.const 32
    i32.sub
    local.tee 0
    global.set $__stack_pointer
    local.get 0
    i32.const 20
    i32.add
    i64.const 0
    i64.store align=4
    local.get 0
    i32.const 1
    i32.store offset=12
    local.get 0
    i32.const 1049384
    i32.store offset=8
    local.get 0
    i32.const 1049336
    i32.store offset=16
    local.get 0
    i32.const 8
    i32.add
    i32.const 1049392
    call $_ZN4core9panicking9panic_fmt17h6dad0405f48e39e2E
    unreachable)
  (func $_ZN5alloc5alloc18handle_alloc_error8rt_error17ha06fd10b3c267ebeE (type 0) (param i32 i32)
    local.get 1
    local.get 0
    call $__rust_alloc_error_handler
    unreachable)
  (func $_ZN4core3ops8function6FnOnce9call_once17h76067c467ab7d853E (type 2) (param i32 i32) (result i32)
    local.get 0
    i32.load
    drop
    loop (result i32)  ;; label = @1
      br 0 (;@1;)
    end)
  (func $_ZN4core3ptr102drop_in_place$LT$$RF$core..iter..adapters..copied..Copied$LT$core..slice..iter..Iter$LT$u8$GT$$GT$$GT$17hfa8c64d5360f8a2aE (type 4) (param i32))
  (func $_ZN4core3ptr37drop_in_place$LT$core..fmt..Error$GT$17h20c52a201febd195E (type 4) (param i32))
  (func $_ZN4core9panicking9panic_fmt17h6dad0405f48e39e2E (type 0) (param i32 i32)
    (local i32)
    global.get $__stack_pointer
    i32.const 32
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    local.get 2
    local.get 0
    i32.store offset=20
    local.get 2
    i32.const 1049412
    i32.store offset=12
    local.get 2
    i32.const 1049408
    i32.store offset=8
    local.get 2
    i32.const 1
    i32.store8 offset=24
    local.get 2
    local.get 1
    i32.store offset=16
    local.get 2
    i32.const 8
    i32.add
    call $rust_begin_unwind
    unreachable)
  (func $_ZN4core5slice5index26slice_start_index_len_fail17h851b41322c5eadc1E (type 7) (param i32 i32 i32)
    (local i32)
    global.get $__stack_pointer
    i32.const 48
    i32.sub
    local.tee 3
    global.set $__stack_pointer
    local.get 3
    local.get 0
    i32.store
    local.get 3
    local.get 1
    i32.store offset=4
    local.get 3
    i32.const 8
    i32.add
    i32.const 12
    i32.add
    i64.const 2
    i64.store align=4
    local.get 3
    i32.const 32
    i32.add
    i32.const 12
    i32.add
    i32.const 5
    i32.store
    local.get 3
    i32.const 2
    i32.store offset=12
    local.get 3
    i32.const 1049924
    i32.store offset=8
    local.get 3
    i32.const 5
    i32.store offset=36
    local.get 3
    local.get 3
    i32.const 32
    i32.add
    i32.store offset=16
    local.get 3
    local.get 3
    i32.const 4
    i32.add
    i32.store offset=40
    local.get 3
    local.get 3
    i32.store offset=32
    local.get 3
    i32.const 8
    i32.add
    local.get 2
    call $_ZN4core9panicking9panic_fmt17h6dad0405f48e39e2E
    unreachable)
  (func $_ZN4core3fmt9Formatter3pad17h0b6da8b5646917dcE (type 1) (param i32 i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32)
    block  ;; label = @1
      block  ;; label = @2
        local.get 0
        i32.load
        local.tee 3
        local.get 0
        i32.load offset=8
        local.tee 4
        i32.or
        i32.eqz
        br_if 0 (;@2;)
        block  ;; label = @3
          local.get 4
          i32.eqz
          br_if 0 (;@3;)
          local.get 1
          local.get 2
          i32.add
          local.set 5
          local.get 0
          i32.const 12
          i32.add
          i32.load
          i32.const 1
          i32.add
          local.set 6
          i32.const 0
          local.set 7
          local.get 1
          local.set 8
          block  ;; label = @4
            loop  ;; label = @5
              local.get 8
              local.set 4
              local.get 6
              i32.const -1
              i32.add
              local.tee 6
              i32.eqz
              br_if 1 (;@4;)
              local.get 4
              local.get 5
              i32.eq
              br_if 2 (;@3;)
              block  ;; label = @6
                block  ;; label = @7
                  local.get 4
                  i32.load8_s
                  local.tee 9
                  i32.const -1
                  i32.le_s
                  br_if 0 (;@7;)
                  local.get 4
                  i32.const 1
                  i32.add
                  local.set 8
                  local.get 9
                  i32.const 255
                  i32.and
                  local.set 9
                  br 1 (;@6;)
                end
                local.get 4
                i32.load8_u offset=1
                i32.const 63
                i32.and
                local.set 10
                local.get 9
                i32.const 31
                i32.and
                local.set 8
                block  ;; label = @7
                  local.get 9
                  i32.const -33
                  i32.gt_u
                  br_if 0 (;@7;)
                  local.get 8
                  i32.const 6
                  i32.shl
                  local.get 10
                  i32.or
                  local.set 9
                  local.get 4
                  i32.const 2
                  i32.add
                  local.set 8
                  br 1 (;@6;)
                end
                local.get 10
                i32.const 6
                i32.shl
                local.get 4
                i32.load8_u offset=2
                i32.const 63
                i32.and
                i32.or
                local.set 10
                block  ;; label = @7
                  local.get 9
                  i32.const -16
                  i32.ge_u
                  br_if 0 (;@7;)
                  local.get 10
                  local.get 8
                  i32.const 12
                  i32.shl
                  i32.or
                  local.set 9
                  local.get 4
                  i32.const 3
                  i32.add
                  local.set 8
                  br 1 (;@6;)
                end
                local.get 10
                i32.const 6
                i32.shl
                local.get 4
                i32.load8_u offset=3
                i32.const 63
                i32.and
                i32.or
                local.get 8
                i32.const 18
                i32.shl
                i32.const 1835008
                i32.and
                i32.or
                local.tee 9
                i32.const 1114112
                i32.eq
                br_if 3 (;@3;)
                local.get 4
                i32.const 4
                i32.add
                local.set 8
              end
              local.get 7
              local.get 4
              i32.sub
              local.get 8
              i32.add
              local.set 7
              local.get 9
              i32.const 1114112
              i32.ne
              br_if 0 (;@5;)
              br 2 (;@3;)
            end
          end
          local.get 4
          local.get 5
          i32.eq
          br_if 0 (;@3;)
          block  ;; label = @4
            local.get 4
            i32.load8_s
            local.tee 8
            i32.const -1
            i32.gt_s
            br_if 0 (;@4;)
            local.get 8
            i32.const -32
            i32.lt_u
            br_if 0 (;@4;)
            local.get 8
            i32.const -16
            i32.lt_u
            br_if 0 (;@4;)
            local.get 4
            i32.load8_u offset=2
            i32.const 63
            i32.and
            i32.const 6
            i32.shl
            local.get 4
            i32.load8_u offset=1
            i32.const 63
            i32.and
            i32.const 12
            i32.shl
            i32.or
            local.get 4
            i32.load8_u offset=3
            i32.const 63
            i32.and
            i32.or
            local.get 8
            i32.const 255
            i32.and
            i32.const 18
            i32.shl
            i32.const 1835008
            i32.and
            i32.or
            i32.const 1114112
            i32.eq
            br_if 1 (;@3;)
          end
          block  ;; label = @4
            block  ;; label = @5
              local.get 7
              i32.eqz
              br_if 0 (;@5;)
              block  ;; label = @6
                local.get 7
                local.get 2
                i32.lt_u
                br_if 0 (;@6;)
                i32.const 0
                local.set 4
                local.get 7
                local.get 2
                i32.eq
                br_if 1 (;@5;)
                br 2 (;@4;)
              end
              i32.const 0
              local.set 4
              local.get 1
              local.get 7
              i32.add
              i32.load8_s
              i32.const -64
              i32.lt_s
              br_if 1 (;@4;)
            end
            local.get 1
            local.set 4
          end
          local.get 7
          local.get 2
          local.get 4
          select
          local.set 2
          local.get 4
          local.get 1
          local.get 4
          select
          local.set 1
        end
        block  ;; label = @3
          local.get 3
          br_if 0 (;@3;)
          local.get 0
          i32.load offset=20
          local.get 1
          local.get 2
          local.get 0
          i32.const 24
          i32.add
          i32.load
          i32.load offset=12
          call_indirect (type 1)
          return
        end
        local.get 0
        i32.load offset=4
        local.set 5
        block  ;; label = @3
          block  ;; label = @4
            local.get 2
            i32.const 16
            i32.lt_u
            br_if 0 (;@4;)
            local.get 1
            local.get 2
            call $_ZN4core3str5count14do_count_chars17h3b059f1cb1060412E
            local.set 4
            br 1 (;@3;)
          end
          block  ;; label = @4
            local.get 2
            br_if 0 (;@4;)
            i32.const 0
            local.set 4
            br 1 (;@3;)
          end
          local.get 2
          i32.const 3
          i32.and
          local.set 6
          block  ;; label = @4
            block  ;; label = @5
              local.get 2
              i32.const 4
              i32.ge_u
              br_if 0 (;@5;)
              i32.const 0
              local.set 4
              i32.const 0
              local.set 9
              br 1 (;@4;)
            end
            local.get 2
            i32.const -4
            i32.and
            local.set 7
            i32.const 0
            local.set 4
            i32.const 0
            local.set 9
            loop  ;; label = @5
              local.get 4
              local.get 1
              local.get 9
              i32.add
              local.tee 8
              i32.load8_s
              i32.const -65
              i32.gt_s
              i32.add
              local.get 8
              i32.const 1
              i32.add
              i32.load8_s
              i32.const -65
              i32.gt_s
              i32.add
              local.get 8
              i32.const 2
              i32.add
              i32.load8_s
              i32.const -65
              i32.gt_s
              i32.add
              local.get 8
              i32.const 3
              i32.add
              i32.load8_s
              i32.const -65
              i32.gt_s
              i32.add
              local.set 4
              local.get 7
              local.get 9
              i32.const 4
              i32.add
              local.tee 9
              i32.ne
              br_if 0 (;@5;)
            end
          end
          local.get 6
          i32.eqz
          br_if 0 (;@3;)
          local.get 1
          local.get 9
          i32.add
          local.set 8
          loop  ;; label = @4
            local.get 4
            local.get 8
            i32.load8_s
            i32.const -65
            i32.gt_s
            i32.add
            local.set 4
            local.get 8
            i32.const 1
            i32.add
            local.set 8
            local.get 6
            i32.const -1
            i32.add
            local.tee 6
            br_if 0 (;@4;)
          end
        end
        local.get 5
        local.get 4
        i32.le_u
        br_if 1 (;@1;)
        i32.const 0
        local.set 8
        local.get 5
        local.get 4
        i32.sub
        local.tee 4
        local.set 7
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              local.get 0
              i32.load8_u offset=32
              br_table 2 (;@3;) 0 (;@5;) 1 (;@4;) 2 (;@3;) 2 (;@3;)
            end
            i32.const 0
            local.set 7
            local.get 4
            local.set 8
            br 1 (;@3;)
          end
          local.get 4
          i32.const 1
          i32.shr_u
          local.set 8
          local.get 4
          i32.const 1
          i32.add
          i32.const 1
          i32.shr_u
          local.set 7
        end
        local.get 8
        i32.const 1
        i32.add
        local.set 4
        local.get 0
        i32.const 24
        i32.add
        i32.load
        local.set 9
        local.get 0
        i32.const 20
        i32.add
        i32.load
        local.set 6
        local.get 0
        i32.load offset=16
        local.set 8
        block  ;; label = @3
          loop  ;; label = @4
            local.get 4
            i32.const -1
            i32.add
            local.tee 4
            i32.eqz
            br_if 1 (;@3;)
            local.get 6
            local.get 8
            local.get 9
            i32.load offset=16
            call_indirect (type 2)
            i32.eqz
            br_if 0 (;@4;)
          end
          i32.const 1
          return
        end
        i32.const 1
        local.set 4
        block  ;; label = @3
          local.get 8
          i32.const 1114112
          i32.eq
          br_if 0 (;@3;)
          local.get 6
          local.get 1
          local.get 2
          local.get 9
          i32.load offset=12
          call_indirect (type 1)
          br_if 0 (;@3;)
          i32.const 0
          local.set 4
          block  ;; label = @4
            loop  ;; label = @5
              block  ;; label = @6
                local.get 7
                local.get 4
                i32.ne
                br_if 0 (;@6;)
                local.get 7
                local.set 4
                br 2 (;@4;)
              end
              local.get 4
              i32.const 1
              i32.add
              local.set 4
              local.get 6
              local.get 8
              local.get 9
              i32.load offset=16
              call_indirect (type 2)
              i32.eqz
              br_if 0 (;@5;)
            end
            local.get 4
            i32.const -1
            i32.add
            local.set 4
          end
          local.get 4
          local.get 7
          i32.lt_u
          local.set 4
        end
        local.get 4
        return
      end
      local.get 0
      i32.load offset=20
      local.get 1
      local.get 2
      local.get 0
      i32.const 24
      i32.add
      i32.load
      i32.load offset=12
      call_indirect (type 1)
      return
    end
    local.get 0
    i32.load offset=20
    local.get 1
    local.get 2
    local.get 0
    i32.const 24
    i32.add
    i32.load
    i32.load offset=12
    call_indirect (type 1))
  (func $_ZN4core9panicking5panic17hfd6e422134ee8ce5E (type 7) (param i32 i32 i32)
    (local i32)
    global.get $__stack_pointer
    i32.const 32
    i32.sub
    local.tee 3
    global.set $__stack_pointer
    local.get 3
    i32.const 12
    i32.add
    i64.const 0
    i64.store align=4
    local.get 3
    i32.const 1
    i32.store offset=4
    local.get 3
    i32.const 1049408
    i32.store offset=8
    local.get 3
    local.get 1
    i32.store offset=28
    local.get 3
    local.get 0
    i32.store offset=24
    local.get 3
    local.get 3
    i32.const 24
    i32.add
    i32.store
    local.get 3
    local.get 2
    call $_ZN4core9panicking9panic_fmt17h6dad0405f48e39e2E
    unreachable)
  (func $_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$u32$GT$3fmt17hbaa66a6ca3ee12c8E (type 2) (param i32 i32) (result i32)
    local.get 0
    i64.load32_u
    i32.const 1
    local.get 1
    call $_ZN4core3fmt3num3imp7fmt_u6417h7a228af73e4122cdE)
  (func $_ZN4core3fmt5write17hce4d120ebbfb2b82E (type 1) (param i32 i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    i32.const 48
    i32.sub
    local.tee 3
    global.set $__stack_pointer
    local.get 3
    i32.const 32
    i32.add
    local.get 1
    i32.store
    local.get 3
    i32.const 3
    i32.store8 offset=40
    local.get 3
    i32.const 32
    i32.store offset=24
    i32.const 0
    local.set 4
    local.get 3
    i32.const 0
    i32.store offset=36
    local.get 3
    local.get 0
    i32.store offset=28
    local.get 3
    i32.const 0
    i32.store offset=16
    local.get 3
    i32.const 0
    i32.store offset=8
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            local.get 2
            i32.load offset=16
            local.tee 5
            br_if 0 (;@4;)
            local.get 2
            i32.const 12
            i32.add
            i32.load
            local.tee 0
            i32.eqz
            br_if 1 (;@3;)
            local.get 2
            i32.load offset=8
            local.set 1
            local.get 0
            i32.const 3
            i32.shl
            local.set 6
            local.get 0
            i32.const -1
            i32.add
            i32.const 536870911
            i32.and
            i32.const 1
            i32.add
            local.set 4
            local.get 2
            i32.load
            local.set 0
            loop  ;; label = @5
              block  ;; label = @6
                local.get 0
                i32.const 4
                i32.add
                i32.load
                local.tee 7
                i32.eqz
                br_if 0 (;@6;)
                local.get 3
                i32.load offset=28
                local.get 0
                i32.load
                local.get 7
                local.get 3
                i32.load offset=32
                i32.load offset=12
                call_indirect (type 1)
                br_if 4 (;@2;)
              end
              local.get 1
              i32.load
              local.get 3
              i32.const 8
              i32.add
              local.get 1
              i32.const 4
              i32.add
              i32.load
              call_indirect (type 2)
              br_if 3 (;@2;)
              local.get 1
              i32.const 8
              i32.add
              local.set 1
              local.get 0
              i32.const 8
              i32.add
              local.set 0
              local.get 6
              i32.const -8
              i32.add
              local.tee 6
              br_if 0 (;@5;)
              br 2 (;@3;)
            end
          end
          local.get 2
          i32.const 20
          i32.add
          i32.load
          local.tee 1
          i32.eqz
          br_if 0 (;@3;)
          local.get 1
          i32.const 5
          i32.shl
          local.set 8
          local.get 1
          i32.const -1
          i32.add
          i32.const 134217727
          i32.and
          i32.const 1
          i32.add
          local.set 4
          local.get 2
          i32.load
          local.set 0
          i32.const 0
          local.set 6
          loop  ;; label = @4
            block  ;; label = @5
              local.get 0
              i32.const 4
              i32.add
              i32.load
              local.tee 1
              i32.eqz
              br_if 0 (;@5;)
              local.get 3
              i32.load offset=28
              local.get 0
              i32.load
              local.get 1
              local.get 3
              i32.load offset=32
              i32.load offset=12
              call_indirect (type 1)
              br_if 3 (;@2;)
            end
            local.get 3
            local.get 5
            local.get 6
            i32.add
            local.tee 1
            i32.const 16
            i32.add
            i32.load
            i32.store offset=24
            local.get 3
            local.get 1
            i32.const 28
            i32.add
            i32.load8_u
            i32.store8 offset=40
            local.get 3
            local.get 1
            i32.const 24
            i32.add
            i32.load
            i32.store offset=36
            local.get 1
            i32.const 12
            i32.add
            i32.load
            local.set 9
            local.get 2
            i32.load offset=8
            local.set 10
            i32.const 0
            local.set 11
            i32.const 0
            local.set 7
            block  ;; label = @5
              block  ;; label = @6
                block  ;; label = @7
                  local.get 1
                  i32.const 8
                  i32.add
                  i32.load
                  br_table 1 (;@6;) 0 (;@7;) 2 (;@5;) 1 (;@6;)
                end
                local.get 9
                i32.const 3
                i32.shl
                local.set 12
                i32.const 0
                local.set 7
                local.get 10
                local.get 12
                i32.add
                local.tee 12
                i32.load offset=4
                i32.const 21
                i32.ne
                br_if 1 (;@5;)
                local.get 12
                i32.load
                i32.load
                local.set 9
              end
              i32.const 1
              local.set 7
            end
            local.get 3
            local.get 9
            i32.store offset=12
            local.get 3
            local.get 7
            i32.store offset=8
            local.get 1
            i32.const 4
            i32.add
            i32.load
            local.set 7
            block  ;; label = @5
              block  ;; label = @6
                block  ;; label = @7
                  local.get 1
                  i32.load
                  br_table 1 (;@6;) 0 (;@7;) 2 (;@5;) 1 (;@6;)
                end
                local.get 7
                i32.const 3
                i32.shl
                local.set 9
                local.get 10
                local.get 9
                i32.add
                local.tee 9
                i32.load offset=4
                i32.const 21
                i32.ne
                br_if 1 (;@5;)
                local.get 9
                i32.load
                i32.load
                local.set 7
              end
              i32.const 1
              local.set 11
            end
            local.get 3
            local.get 7
            i32.store offset=20
            local.get 3
            local.get 11
            i32.store offset=16
            local.get 10
            local.get 1
            i32.const 20
            i32.add
            i32.load
            i32.const 3
            i32.shl
            i32.add
            local.tee 1
            i32.load
            local.get 3
            i32.const 8
            i32.add
            local.get 1
            i32.load offset=4
            call_indirect (type 2)
            br_if 2 (;@2;)
            local.get 0
            i32.const 8
            i32.add
            local.set 0
            local.get 8
            local.get 6
            i32.const 32
            i32.add
            local.tee 6
            i32.ne
            br_if 0 (;@4;)
          end
        end
        block  ;; label = @3
          local.get 4
          local.get 2
          i32.load offset=4
          i32.ge_u
          br_if 0 (;@3;)
          local.get 3
          i32.load offset=28
          local.get 2
          i32.load
          local.get 4
          i32.const 3
          i32.shl
          i32.add
          local.tee 1
          i32.load
          local.get 1
          i32.load offset=4
          local.get 3
          i32.load offset=32
          i32.load offset=12
          call_indirect (type 1)
          br_if 1 (;@2;)
        end
        i32.const 0
        local.set 1
        br 1 (;@1;)
      end
      i32.const 1
      local.set 1
    end
    local.get 3
    i32.const 48
    i32.add
    global.set $__stack_pointer
    local.get 1)
  (func $_ZN4core3fmt9Formatter12pad_integral17h1311a70c35efb64aE (type 14) (param i32 i32 i32 i32 i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32)
    block  ;; label = @1
      block  ;; label = @2
        local.get 1
        i32.eqz
        br_if 0 (;@2;)
        i32.const 43
        i32.const 1114112
        local.get 0
        i32.load offset=28
        local.tee 6
        i32.const 1
        i32.and
        local.tee 1
        select
        local.set 7
        local.get 1
        local.get 5
        i32.add
        local.set 8
        br 1 (;@1;)
      end
      local.get 5
      i32.const 1
      i32.add
      local.set 8
      local.get 0
      i32.load offset=28
      local.set 6
      i32.const 45
      local.set 7
    end
    block  ;; label = @1
      block  ;; label = @2
        local.get 6
        i32.const 4
        i32.and
        br_if 0 (;@2;)
        i32.const 0
        local.set 2
        br 1 (;@1;)
      end
      block  ;; label = @2
        block  ;; label = @3
          local.get 3
          i32.const 16
          i32.lt_u
          br_if 0 (;@3;)
          local.get 2
          local.get 3
          call $_ZN4core3str5count14do_count_chars17h3b059f1cb1060412E
          local.set 1
          br 1 (;@2;)
        end
        block  ;; label = @3
          local.get 3
          br_if 0 (;@3;)
          i32.const 0
          local.set 1
          br 1 (;@2;)
        end
        local.get 3
        i32.const 3
        i32.and
        local.set 9
        block  ;; label = @3
          block  ;; label = @4
            local.get 3
            i32.const 4
            i32.ge_u
            br_if 0 (;@4;)
            i32.const 0
            local.set 1
            i32.const 0
            local.set 10
            br 1 (;@3;)
          end
          local.get 3
          i32.const -4
          i32.and
          local.set 11
          i32.const 0
          local.set 1
          i32.const 0
          local.set 10
          loop  ;; label = @4
            local.get 1
            local.get 2
            local.get 10
            i32.add
            local.tee 12
            i32.load8_s
            i32.const -65
            i32.gt_s
            i32.add
            local.get 12
            i32.const 1
            i32.add
            i32.load8_s
            i32.const -65
            i32.gt_s
            i32.add
            local.get 12
            i32.const 2
            i32.add
            i32.load8_s
            i32.const -65
            i32.gt_s
            i32.add
            local.get 12
            i32.const 3
            i32.add
            i32.load8_s
            i32.const -65
            i32.gt_s
            i32.add
            local.set 1
            local.get 11
            local.get 10
            i32.const 4
            i32.add
            local.tee 10
            i32.ne
            br_if 0 (;@4;)
          end
        end
        local.get 9
        i32.eqz
        br_if 0 (;@2;)
        local.get 2
        local.get 10
        i32.add
        local.set 12
        loop  ;; label = @3
          local.get 1
          local.get 12
          i32.load8_s
          i32.const -65
          i32.gt_s
          i32.add
          local.set 1
          local.get 12
          i32.const 1
          i32.add
          local.set 12
          local.get 9
          i32.const -1
          i32.add
          local.tee 9
          br_if 0 (;@3;)
        end
      end
      local.get 1
      local.get 8
      i32.add
      local.set 8
    end
    block  ;; label = @1
      block  ;; label = @2
        local.get 0
        i32.load
        br_if 0 (;@2;)
        i32.const 1
        local.set 1
        local.get 0
        i32.const 20
        i32.add
        i32.load
        local.tee 12
        local.get 0
        i32.const 24
        i32.add
        i32.load
        local.tee 10
        local.get 7
        local.get 2
        local.get 3
        call $_ZN4core3fmt9Formatter12pad_integral12write_prefix17h7186e489b53c8fefE
        br_if 1 (;@1;)
        local.get 12
        local.get 4
        local.get 5
        local.get 10
        i32.load offset=12
        call_indirect (type 1)
        return
      end
      block  ;; label = @2
        local.get 0
        i32.load offset=4
        local.tee 9
        local.get 8
        i32.gt_u
        br_if 0 (;@2;)
        i32.const 1
        local.set 1
        local.get 0
        i32.const 20
        i32.add
        i32.load
        local.tee 12
        local.get 0
        i32.const 24
        i32.add
        i32.load
        local.tee 10
        local.get 7
        local.get 2
        local.get 3
        call $_ZN4core3fmt9Formatter12pad_integral12write_prefix17h7186e489b53c8fefE
        br_if 1 (;@1;)
        local.get 12
        local.get 4
        local.get 5
        local.get 10
        i32.load offset=12
        call_indirect (type 1)
        return
      end
      block  ;; label = @2
        local.get 6
        i32.const 8
        i32.and
        i32.eqz
        br_if 0 (;@2;)
        local.get 0
        i32.load offset=16
        local.set 11
        local.get 0
        i32.const 48
        i32.store offset=16
        local.get 0
        i32.load8_u offset=32
        local.set 6
        i32.const 1
        local.set 1
        local.get 0
        i32.const 1
        i32.store8 offset=32
        local.get 0
        i32.const 20
        i32.add
        i32.load
        local.tee 12
        local.get 0
        i32.const 24
        i32.add
        i32.load
        local.tee 10
        local.get 7
        local.get 2
        local.get 3
        call $_ZN4core3fmt9Formatter12pad_integral12write_prefix17h7186e489b53c8fefE
        br_if 1 (;@1;)
        local.get 9
        local.get 8
        i32.sub
        i32.const 1
        i32.add
        local.set 1
        block  ;; label = @3
          loop  ;; label = @4
            local.get 1
            i32.const -1
            i32.add
            local.tee 1
            i32.eqz
            br_if 1 (;@3;)
            local.get 12
            i32.const 48
            local.get 10
            i32.load offset=16
            call_indirect (type 2)
            i32.eqz
            br_if 0 (;@4;)
          end
          i32.const 1
          return
        end
        i32.const 1
        local.set 1
        local.get 12
        local.get 4
        local.get 5
        local.get 10
        i32.load offset=12
        call_indirect (type 1)
        br_if 1 (;@1;)
        local.get 0
        local.get 6
        i32.store8 offset=32
        local.get 0
        local.get 11
        i32.store offset=16
        i32.const 0
        local.set 1
        br 1 (;@1;)
      end
      local.get 9
      local.get 8
      i32.sub
      local.tee 12
      local.set 8
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            local.get 0
            i32.load8_u offset=32
            local.tee 1
            br_table 2 (;@2;) 0 (;@4;) 1 (;@3;) 0 (;@4;) 2 (;@2;)
          end
          i32.const 0
          local.set 8
          local.get 12
          local.set 1
          br 1 (;@2;)
        end
        local.get 12
        i32.const 1
        i32.shr_u
        local.set 1
        local.get 12
        i32.const 1
        i32.add
        i32.const 1
        i32.shr_u
        local.set 8
      end
      local.get 1
      i32.const 1
      i32.add
      local.set 1
      local.get 0
      i32.const 24
      i32.add
      i32.load
      local.set 10
      local.get 0
      i32.const 20
      i32.add
      i32.load
      local.set 9
      local.get 0
      i32.load offset=16
      local.set 12
      block  ;; label = @2
        loop  ;; label = @3
          local.get 1
          i32.const -1
          i32.add
          local.tee 1
          i32.eqz
          br_if 1 (;@2;)
          local.get 9
          local.get 12
          local.get 10
          i32.load offset=16
          call_indirect (type 2)
          i32.eqz
          br_if 0 (;@3;)
        end
        i32.const 1
        return
      end
      i32.const 1
      local.set 1
      local.get 12
      i32.const 1114112
      i32.eq
      br_if 0 (;@1;)
      local.get 9
      local.get 10
      local.get 7
      local.get 2
      local.get 3
      call $_ZN4core3fmt9Formatter12pad_integral12write_prefix17h7186e489b53c8fefE
      br_if 0 (;@1;)
      local.get 9
      local.get 4
      local.get 5
      local.get 10
      i32.load offset=12
      call_indirect (type 1)
      br_if 0 (;@1;)
      i32.const 0
      local.set 1
      loop  ;; label = @2
        block  ;; label = @3
          local.get 8
          local.get 1
          i32.ne
          br_if 0 (;@3;)
          local.get 8
          local.get 8
          i32.lt_u
          return
        end
        local.get 1
        i32.const 1
        i32.add
        local.set 1
        local.get 9
        local.get 12
        local.get 10
        i32.load offset=16
        call_indirect (type 2)
        i32.eqz
        br_if 0 (;@2;)
      end
      local.get 1
      i32.const -1
      i32.add
      local.get 8
      i32.lt_u
      return
    end
    local.get 1)
  (func $_ZN36_$LT$T$u20$as$u20$core..any..Any$GT$7type_id17hfb753db928a637b4E (type 0) (param i32 i32)
    local.get 0
    i64.const 6709583872402221221
    i64.store offset=8
    local.get 0
    i64.const -517914840449640987
    i64.store)
  (func $_ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17hb73b6a73788677afE (type 2) (param i32 i32) (result i32)
    local.get 1
    local.get 0
    i32.load
    local.get 0
    i32.load offset=4
    call $_ZN4core3fmt9Formatter3pad17h0b6da8b5646917dcE)
  (func $_ZN4core5panic10panic_info9PanicInfo7message17ha3c0b951fa489593E (type 3) (param i32) (result i32)
    local.get 0
    i32.load offset=12)
  (func $_ZN4core5panic10panic_info9PanicInfo8location17h1ccdb1bf0bb693f4E (type 3) (param i32) (result i32)
    local.get 0
    i32.load offset=8)
  (func $_ZN4core5panic10panic_info9PanicInfo10can_unwind17h75205550bb42d21cE (type 3) (param i32) (result i32)
    local.get 0
    i32.load8_u offset=16)
  (func $_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$i32$GT$3fmt17hb34825256926739cE (type 2) (param i32 i32) (result i32)
    (local i32 i32 i32)
    global.get $__stack_pointer
    i32.const 128
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    local.get 0
    i32.load
    local.set 0
    i32.const 0
    local.set 3
    loop  ;; label = @1
      local.get 2
      local.get 3
      i32.add
      i32.const 127
      i32.add
      i32.const 48
      i32.const 87
      local.get 0
      i32.const 15
      i32.and
      local.tee 4
      i32.const 10
      i32.lt_u
      select
      local.get 4
      i32.add
      i32.store8
      local.get 3
      i32.const -1
      i32.add
      local.set 3
      local.get 0
      i32.const 16
      i32.lt_u
      local.set 4
      local.get 0
      i32.const 4
      i32.shr_u
      local.set 0
      local.get 4
      i32.eqz
      br_if 0 (;@1;)
    end
    block  ;; label = @1
      local.get 3
      i32.const 128
      i32.add
      local.tee 0
      i32.const 129
      i32.lt_u
      br_if 0 (;@1;)
      local.get 0
      i32.const 128
      i32.const 1049628
      call $_ZN4core5slice5index26slice_start_index_len_fail17h851b41322c5eadc1E
      unreachable
    end
    local.get 1
    i32.const 1
    i32.const 1049644
    i32.const 2
    local.get 2
    local.get 3
    i32.add
    i32.const 128
    i32.add
    i32.const 0
    local.get 3
    i32.sub
    call $_ZN4core3fmt9Formatter12pad_integral17h1311a70c35efb64aE
    local.set 0
    local.get 2
    i32.const 128
    i32.add
    global.set $__stack_pointer
    local.get 0)
  (func $_ZN4core9panicking19assert_failed_inner17hb22561d3158be3eaE (type 9) (param i32 i32 i32 i32 i32 i32 i32)
    (local i32)
    global.get $__stack_pointer
    i32.const 112
    i32.sub
    local.tee 7
    global.set $__stack_pointer
    local.get 7
    local.get 2
    i32.store offset=12
    local.get 7
    local.get 1
    i32.store offset=8
    local.get 7
    local.get 4
    i32.store offset=20
    local.get 7
    local.get 3
    i32.store offset=16
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            local.get 0
            i32.const 255
            i32.and
            br_table 0 (;@4;) 1 (;@3;) 2 (;@2;) 0 (;@4;)
          end
          local.get 7
          i32.const 1049428
          i32.store offset=24
          i32.const 2
          local.set 2
          br 2 (;@1;)
        end
        local.get 7
        i32.const 1049430
        i32.store offset=24
        i32.const 2
        local.set 2
        br 1 (;@1;)
      end
      local.get 7
      i32.const 1049432
      i32.store offset=24
      i32.const 7
      local.set 2
    end
    local.get 7
    local.get 2
    i32.store offset=28
    block  ;; label = @1
      local.get 5
      i32.load
      br_if 0 (;@1;)
      local.get 7
      i32.const 76
      i32.add
      i32.const 22
      i32.store
      local.get 7
      i32.const 56
      i32.add
      i32.const 12
      i32.add
      i32.const 22
      i32.store
      local.get 7
      i32.const 88
      i32.add
      i32.const 12
      i32.add
      i64.const 3
      i64.store align=4
      local.get 7
      i32.const 4
      i32.store offset=92
      local.get 7
      i32.const 1049496
      i32.store offset=88
      local.get 7
      i32.const 23
      i32.store offset=60
      local.get 7
      local.get 7
      i32.const 56
      i32.add
      i32.store offset=96
      local.get 7
      local.get 7
      i32.const 16
      i32.add
      i32.store offset=72
      local.get 7
      local.get 7
      i32.const 8
      i32.add
      i32.store offset=64
      local.get 7
      local.get 7
      i32.const 24
      i32.add
      i32.store offset=56
      local.get 7
      i32.const 88
      i32.add
      local.get 6
      call $_ZN4core9panicking9panic_fmt17h6dad0405f48e39e2E
      unreachable
    end
    local.get 7
    i32.const 32
    i32.add
    i32.const 16
    i32.add
    local.get 5
    i32.const 16
    i32.add
    i64.load align=4
    i64.store
    local.get 7
    i32.const 32
    i32.add
    i32.const 8
    i32.add
    local.get 5
    i32.const 8
    i32.add
    i64.load align=4
    i64.store
    local.get 7
    local.get 5
    i64.load align=4
    i64.store offset=32
    local.get 7
    i32.const 88
    i32.add
    i32.const 12
    i32.add
    i64.const 4
    i64.store align=4
    local.get 7
    i32.const 84
    i32.add
    i32.const 24
    i32.store
    local.get 7
    i32.const 76
    i32.add
    i32.const 22
    i32.store
    local.get 7
    i32.const 56
    i32.add
    i32.const 12
    i32.add
    i32.const 22
    i32.store
    local.get 7
    i32.const 4
    i32.store offset=92
    local.get 7
    i32.const 1049532
    i32.store offset=88
    local.get 7
    i32.const 23
    i32.store offset=60
    local.get 7
    local.get 7
    i32.const 56
    i32.add
    i32.store offset=96
    local.get 7
    local.get 7
    i32.const 32
    i32.add
    i32.store offset=80
    local.get 7
    local.get 7
    i32.const 16
    i32.add
    i32.store offset=72
    local.get 7
    local.get 7
    i32.const 8
    i32.add
    i32.store offset=64
    local.get 7
    local.get 7
    i32.const 24
    i32.add
    i32.store offset=56
    local.get 7
    i32.const 88
    i32.add
    local.get 6
    call $_ZN4core9panicking9panic_fmt17h6dad0405f48e39e2E
    unreachable)
  (func $_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h492aa3edaecea1b7E (type 2) (param i32 i32) (result i32)
    local.get 0
    i32.load
    local.get 1
    local.get 0
    i32.load offset=4
    i32.load offset=12
    call_indirect (type 2))
  (func $_ZN59_$LT$core..fmt..Arguments$u20$as$u20$core..fmt..Display$GT$3fmt17h10a377a6759b4243E (type 2) (param i32 i32) (result i32)
    local.get 1
    i32.load offset=20
    local.get 1
    i32.const 24
    i32.add
    i32.load
    local.get 0
    call $_ZN4core3fmt5write17hce4d120ebbfb2b82E)
  (func $_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17hdafde26fcff4b2d8E (type 1) (param i32 i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    local.get 0
    i32.load offset=4
    local.set 3
    local.get 0
    i32.load
    local.set 4
    local.get 0
    i32.load offset=8
    local.set 5
    i32.const 0
    local.set 6
    i32.const 0
    local.set 7
    i32.const 0
    local.set 8
    i32.const 0
    local.set 9
    block  ;; label = @1
      loop  ;; label = @2
        local.get 9
        i32.const 255
        i32.and
        br_if 1 (;@1;)
        block  ;; label = @3
          block  ;; label = @4
            local.get 8
            local.get 2
            i32.gt_u
            br_if 0 (;@4;)
            loop  ;; label = @5
              local.get 1
              local.get 8
              i32.add
              local.set 10
              block  ;; label = @6
                block  ;; label = @7
                  local.get 2
                  local.get 8
                  i32.sub
                  local.tee 11
                  i32.const 8
                  i32.lt_u
                  br_if 0 (;@7;)
                  block  ;; label = @8
                    block  ;; label = @9
                      block  ;; label = @10
                        local.get 10
                        i32.const 3
                        i32.add
                        i32.const -4
                        i32.and
                        local.tee 0
                        local.get 10
                        i32.eq
                        br_if 0 (;@10;)
                        local.get 0
                        local.get 10
                        i32.sub
                        local.tee 12
                        i32.eqz
                        br_if 0 (;@10;)
                        i32.const 0
                        local.set 0
                        loop  ;; label = @11
                          local.get 10
                          local.get 0
                          i32.add
                          i32.load8_u
                          i32.const 10
                          i32.eq
                          br_if 5 (;@6;)
                          local.get 12
                          local.get 0
                          i32.const 1
                          i32.add
                          local.tee 0
                          i32.ne
                          br_if 0 (;@11;)
                        end
                        local.get 12
                        local.get 11
                        i32.const -8
                        i32.add
                        local.tee 13
                        i32.le_u
                        br_if 1 (;@9;)
                        br 2 (;@8;)
                      end
                      local.get 11
                      i32.const -8
                      i32.add
                      local.set 13
                      i32.const 0
                      local.set 12
                    end
                    loop  ;; label = @9
                      local.get 10
                      local.get 12
                      i32.add
                      local.tee 9
                      i32.load
                      local.tee 0
                      i32.const -1
                      i32.xor
                      local.get 0
                      i32.const 168430090
                      i32.xor
                      i32.const -16843009
                      i32.add
                      i32.and
                      i32.const -2139062144
                      i32.and
                      br_if 1 (;@8;)
                      local.get 9
                      i32.const 4
                      i32.add
                      i32.load
                      local.tee 0
                      i32.const -1
                      i32.xor
                      local.get 0
                      i32.const 168430090
                      i32.xor
                      i32.const -16843009
                      i32.add
                      i32.and
                      i32.const -2139062144
                      i32.and
                      br_if 1 (;@8;)
                      local.get 12
                      i32.const 8
                      i32.add
                      local.tee 12
                      local.get 13
                      i32.le_u
                      br_if 0 (;@9;)
                    end
                  end
                  block  ;; label = @8
                    local.get 11
                    local.get 12
                    i32.ne
                    br_if 0 (;@8;)
                    local.get 2
                    local.set 8
                    br 4 (;@4;)
                  end
                  loop  ;; label = @8
                    block  ;; label = @9
                      local.get 10
                      local.get 12
                      i32.add
                      i32.load8_u
                      i32.const 10
                      i32.ne
                      br_if 0 (;@9;)
                      local.get 12
                      local.set 0
                      br 3 (;@6;)
                    end
                    local.get 11
                    local.get 12
                    i32.const 1
                    i32.add
                    local.tee 12
                    i32.ne
                    br_if 0 (;@8;)
                  end
                  local.get 2
                  local.set 8
                  br 3 (;@4;)
                end
                block  ;; label = @7
                  local.get 8
                  local.get 2
                  i32.ne
                  br_if 0 (;@7;)
                  local.get 2
                  local.set 8
                  br 3 (;@4;)
                end
                i32.const 0
                local.set 0
                loop  ;; label = @7
                  local.get 10
                  local.get 0
                  i32.add
                  i32.load8_u
                  i32.const 10
                  i32.eq
                  br_if 1 (;@6;)
                  local.get 11
                  local.get 0
                  i32.const 1
                  i32.add
                  local.tee 0
                  i32.ne
                  br_if 0 (;@7;)
                end
                local.get 2
                local.set 8
                br 2 (;@4;)
              end
              local.get 8
              local.get 0
              i32.add
              local.tee 0
              i32.const 1
              i32.add
              local.set 8
              block  ;; label = @6
                local.get 0
                local.get 2
                i32.ge_u
                br_if 0 (;@6;)
                local.get 1
                local.get 0
                i32.add
                i32.load8_u
                i32.const 10
                i32.ne
                br_if 0 (;@6;)
                i32.const 0
                local.set 9
                local.get 8
                local.set 13
                local.get 8
                local.set 0
                br 3 (;@3;)
              end
              local.get 8
              local.get 2
              i32.le_u
              br_if 0 (;@5;)
            end
          end
          i32.const 1
          local.set 9
          local.get 7
          local.set 13
          local.get 2
          local.set 0
          local.get 7
          local.get 2
          i32.eq
          br_if 2 (;@1;)
        end
        block  ;; label = @3
          block  ;; label = @4
            local.get 5
            i32.load8_u
            i32.eqz
            br_if 0 (;@4;)
            local.get 4
            i32.const 1049588
            i32.const 4
            local.get 3
            i32.load offset=12
            call_indirect (type 1)
            br_if 1 (;@3;)
          end
          local.get 1
          local.get 7
          i32.add
          local.set 12
          local.get 0
          local.get 7
          i32.sub
          local.set 10
          i32.const 0
          local.set 11
          block  ;; label = @4
            local.get 0
            local.get 7
            i32.eq
            br_if 0 (;@4;)
            local.get 10
            local.get 12
            i32.add
            i32.const -1
            i32.add
            i32.load8_u
            i32.const 10
            i32.eq
            local.set 11
          end
          local.get 5
          local.get 11
          i32.store8
          local.get 13
          local.set 7
          local.get 4
          local.get 12
          local.get 10
          local.get 3
          i32.load offset=12
          call_indirect (type 1)
          i32.eqz
          br_if 1 (;@2;)
        end
      end
      i32.const 1
      local.set 6
    end
    local.get 6)
  (func $_ZN4core3fmt8builders10DebugTuple5field17h32130795d920081aE (type 1) (param i32 i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i64)
    global.get $__stack_pointer
    i32.const 64
    i32.sub
    local.tee 3
    global.set $__stack_pointer
    block  ;; label = @1
      block  ;; label = @2
        local.get 0
        i32.load8_u offset=8
        i32.eqz
        br_if 0 (;@2;)
        local.get 0
        i32.load
        local.set 4
        i32.const 1
        local.set 5
        br 1 (;@1;)
      end
      local.get 0
      i32.load
      local.set 4
      block  ;; label = @2
        local.get 0
        i32.const 4
        i32.add
        i32.load
        local.tee 6
        i32.load offset=28
        local.tee 7
        i32.const 4
        i32.and
        br_if 0 (;@2;)
        i32.const 1
        local.set 5
        local.get 6
        i32.load offset=20
        i32.const 1049592
        i32.const 1049596
        local.get 4
        select
        i32.const 2
        i32.const 1
        local.get 4
        select
        local.get 6
        i32.const 24
        i32.add
        i32.load
        i32.load offset=12
        call_indirect (type 1)
        br_if 1 (;@1;)
        local.get 1
        local.get 6
        local.get 2
        i32.load offset=12
        call_indirect (type 2)
        local.set 5
        br 1 (;@1;)
      end
      block  ;; label = @2
        local.get 4
        br_if 0 (;@2;)
        block  ;; label = @3
          local.get 6
          i32.load offset=20
          i32.const 1049597
          i32.const 2
          local.get 6
          i32.const 24
          i32.add
          i32.load
          i32.load offset=12
          call_indirect (type 1)
          i32.eqz
          br_if 0 (;@3;)
          i32.const 1
          local.set 5
          i32.const 0
          local.set 4
          br 2 (;@1;)
        end
        local.get 6
        i32.load offset=28
        local.set 7
      end
      i32.const 1
      local.set 5
      local.get 3
      i32.const 1
      i32.store8 offset=23
      local.get 3
      i32.const 48
      i32.add
      i32.const 1049564
      i32.store
      local.get 3
      local.get 6
      i64.load offset=20 align=4
      i64.store offset=8
      local.get 3
      local.get 3
      i32.const 23
      i32.add
      i32.store offset=16
      local.get 3
      local.get 6
      i64.load offset=8 align=4
      i64.store offset=32
      local.get 6
      i64.load align=4
      local.set 8
      local.get 3
      local.get 7
      i32.store offset=52
      local.get 3
      local.get 6
      i32.load offset=16
      i32.store offset=40
      local.get 3
      local.get 6
      i32.load8_u offset=32
      i32.store8 offset=56
      local.get 3
      local.get 8
      i64.store offset=24
      local.get 3
      local.get 3
      i32.const 8
      i32.add
      i32.store offset=44
      local.get 1
      local.get 3
      i32.const 24
      i32.add
      local.get 2
      i32.load offset=12
      call_indirect (type 2)
      br_if 0 (;@1;)
      local.get 3
      i32.load offset=44
      i32.const 1049594
      i32.const 2
      local.get 3
      i32.load offset=48
      i32.load offset=12
      call_indirect (type 1)
      local.set 5
    end
    local.get 0
    local.get 5
    i32.store8 offset=8
    local.get 0
    local.get 4
    i32.const 1
    i32.add
    i32.store
    local.get 3
    i32.const 64
    i32.add
    global.set $__stack_pointer
    local.get 0)
  (func $_ZN4core3fmt5Write10write_char17h3f59a8cf545d4fe7E (type 2) (param i32 i32) (result i32)
    (local i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    local.get 2
    i32.const 0
    i32.store offset=12
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            local.get 1
            i32.const 128
            i32.lt_u
            br_if 0 (;@4;)
            local.get 1
            i32.const 2048
            i32.lt_u
            br_if 1 (;@3;)
            local.get 1
            i32.const 65536
            i32.ge_u
            br_if 2 (;@2;)
            local.get 2
            local.get 1
            i32.const 63
            i32.and
            i32.const 128
            i32.or
            i32.store8 offset=14
            local.get 2
            local.get 1
            i32.const 12
            i32.shr_u
            i32.const 224
            i32.or
            i32.store8 offset=12
            local.get 2
            local.get 1
            i32.const 6
            i32.shr_u
            i32.const 63
            i32.and
            i32.const 128
            i32.or
            i32.store8 offset=13
            i32.const 3
            local.set 1
            br 3 (;@1;)
          end
          local.get 2
          local.get 1
          i32.store8 offset=12
          i32.const 1
          local.set 1
          br 2 (;@1;)
        end
        local.get 2
        local.get 1
        i32.const 63
        i32.and
        i32.const 128
        i32.or
        i32.store8 offset=13
        local.get 2
        local.get 1
        i32.const 6
        i32.shr_u
        i32.const 192
        i32.or
        i32.store8 offset=12
        i32.const 2
        local.set 1
        br 1 (;@1;)
      end
      local.get 2
      local.get 1
      i32.const 63
      i32.and
      i32.const 128
      i32.or
      i32.store8 offset=15
      local.get 2
      local.get 1
      i32.const 6
      i32.shr_u
      i32.const 63
      i32.and
      i32.const 128
      i32.or
      i32.store8 offset=14
      local.get 2
      local.get 1
      i32.const 12
      i32.shr_u
      i32.const 63
      i32.and
      i32.const 128
      i32.or
      i32.store8 offset=13
      local.get 2
      local.get 1
      i32.const 18
      i32.shr_u
      i32.const 7
      i32.and
      i32.const 240
      i32.or
      i32.store8 offset=12
      i32.const 4
      local.set 1
    end
    local.get 0
    local.get 2
    i32.const 12
    i32.add
    local.get 1
    call $_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17hdafde26fcff4b2d8E
    local.set 1
    local.get 2
    i32.const 16
    i32.add
    global.set $__stack_pointer
    local.get 1)
  (func $_ZN4core3fmt5Write9write_fmt17h2e6bceee10c37b66E (type 2) (param i32 i32) (result i32)
    (local i32)
    global.get $__stack_pointer
    i32.const 32
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    local.get 2
    local.get 0
    i32.store offset=4
    local.get 2
    i32.const 8
    i32.add
    i32.const 16
    i32.add
    local.get 1
    i32.const 16
    i32.add
    i64.load align=4
    i64.store
    local.get 2
    i32.const 8
    i32.add
    i32.const 8
    i32.add
    local.get 1
    i32.const 8
    i32.add
    i64.load align=4
    i64.store
    local.get 2
    local.get 1
    i64.load align=4
    i64.store offset=8
    local.get 2
    i32.const 4
    i32.add
    i32.const 1049848
    local.get 2
    i32.const 8
    i32.add
    call $_ZN4core3fmt5write17hce4d120ebbfb2b82E
    local.set 1
    local.get 2
    i32.const 32
    i32.add
    global.set $__stack_pointer
    local.get 1)
  (func $_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$9write_str17hcaa6cd3ac839b2faE (type 1) (param i32 i32 i32) (result i32)
    local.get 0
    i32.load
    local.get 1
    local.get 2
    call $_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17hdafde26fcff4b2d8E)
  (func $_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17h080db87b87f4d73cE (type 2) (param i32 i32) (result i32)
    (local i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    local.get 0
    i32.load
    local.set 0
    local.get 2
    i32.const 0
    i32.store offset=12
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            local.get 1
            i32.const 128
            i32.lt_u
            br_if 0 (;@4;)
            local.get 1
            i32.const 2048
            i32.lt_u
            br_if 1 (;@3;)
            local.get 1
            i32.const 65536
            i32.ge_u
            br_if 2 (;@2;)
            local.get 2
            local.get 1
            i32.const 63
            i32.and
            i32.const 128
            i32.or
            i32.store8 offset=14
            local.get 2
            local.get 1
            i32.const 12
            i32.shr_u
            i32.const 224
            i32.or
            i32.store8 offset=12
            local.get 2
            local.get 1
            i32.const 6
            i32.shr_u
            i32.const 63
            i32.and
            i32.const 128
            i32.or
            i32.store8 offset=13
            i32.const 3
            local.set 1
            br 3 (;@1;)
          end
          local.get 2
          local.get 1
          i32.store8 offset=12
          i32.const 1
          local.set 1
          br 2 (;@1;)
        end
        local.get 2
        local.get 1
        i32.const 63
        i32.and
        i32.const 128
        i32.or
        i32.store8 offset=13
        local.get 2
        local.get 1
        i32.const 6
        i32.shr_u
        i32.const 192
        i32.or
        i32.store8 offset=12
        i32.const 2
        local.set 1
        br 1 (;@1;)
      end
      local.get 2
      local.get 1
      i32.const 63
      i32.and
      i32.const 128
      i32.or
      i32.store8 offset=15
      local.get 2
      local.get 1
      i32.const 6
      i32.shr_u
      i32.const 63
      i32.and
      i32.const 128
      i32.or
      i32.store8 offset=14
      local.get 2
      local.get 1
      i32.const 12
      i32.shr_u
      i32.const 63
      i32.and
      i32.const 128
      i32.or
      i32.store8 offset=13
      local.get 2
      local.get 1
      i32.const 18
      i32.shr_u
      i32.const 7
      i32.and
      i32.const 240
      i32.or
      i32.store8 offset=12
      i32.const 4
      local.set 1
    end
    local.get 0
    local.get 2
    i32.const 12
    i32.add
    local.get 1
    call $_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17hdafde26fcff4b2d8E
    local.set 1
    local.get 2
    i32.const 16
    i32.add
    global.set $__stack_pointer
    local.get 1)
  (func $_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$9write_fmt17hf9a0ca43263b8ba6E (type 2) (param i32 i32) (result i32)
    (local i32)
    global.get $__stack_pointer
    i32.const 32
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    local.get 0
    i32.load
    local.set 0
    local.get 2
    i32.const 8
    i32.add
    i32.const 16
    i32.add
    local.get 1
    i32.const 16
    i32.add
    i64.load align=4
    i64.store
    local.get 2
    i32.const 8
    i32.add
    i32.const 8
    i32.add
    local.get 1
    i32.const 8
    i32.add
    i64.load align=4
    i64.store
    local.get 2
    local.get 1
    i64.load align=4
    i64.store offset=8
    local.get 2
    local.get 0
    i32.store offset=4
    local.get 2
    i32.const 4
    i32.add
    i32.const 1049848
    local.get 2
    i32.const 8
    i32.add
    call $_ZN4core3fmt5write17hce4d120ebbfb2b82E
    local.set 1
    local.get 2
    i32.const 32
    i32.add
    global.set $__stack_pointer
    local.get 1)
  (func $_ZN4core3str5count14do_count_chars17h3b059f1cb1060412E (type 2) (param i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32)
    block  ;; label = @1
      block  ;; label = @2
        local.get 0
        i32.const 3
        i32.add
        i32.const -4
        i32.and
        local.tee 2
        local.get 0
        i32.sub
        local.tee 3
        local.get 1
        i32.gt_u
        br_if 0 (;@2;)
        local.get 1
        local.get 3
        i32.sub
        local.tee 4
        i32.const 4
        i32.lt_u
        br_if 0 (;@2;)
        local.get 4
        i32.const 3
        i32.and
        local.set 5
        i32.const 0
        local.set 6
        i32.const 0
        local.set 1
        block  ;; label = @3
          local.get 2
          local.get 0
          i32.eq
          br_if 0 (;@3;)
          local.get 3
          i32.const 3
          i32.and
          local.set 7
          block  ;; label = @4
            block  ;; label = @5
              local.get 2
              local.get 0
              i32.const -1
              i32.xor
              i32.add
              i32.const 3
              i32.ge_u
              br_if 0 (;@5;)
              i32.const 0
              local.set 1
              i32.const 0
              local.set 8
              br 1 (;@4;)
            end
            local.get 3
            i32.const -4
            i32.and
            local.set 9
            i32.const 0
            local.set 1
            i32.const 0
            local.set 8
            loop  ;; label = @5
              local.get 1
              local.get 0
              local.get 8
              i32.add
              local.tee 2
              i32.load8_s
              i32.const -65
              i32.gt_s
              i32.add
              local.get 2
              i32.const 1
              i32.add
              i32.load8_s
              i32.const -65
              i32.gt_s
              i32.add
              local.get 2
              i32.const 2
              i32.add
              i32.load8_s
              i32.const -65
              i32.gt_s
              i32.add
              local.get 2
              i32.const 3
              i32.add
              i32.load8_s
              i32.const -65
              i32.gt_s
              i32.add
              local.set 1
              local.get 9
              local.get 8
              i32.const 4
              i32.add
              local.tee 8
              i32.ne
              br_if 0 (;@5;)
            end
          end
          local.get 7
          i32.eqz
          br_if 0 (;@3;)
          local.get 0
          local.get 8
          i32.add
          local.set 2
          loop  ;; label = @4
            local.get 1
            local.get 2
            i32.load8_s
            i32.const -65
            i32.gt_s
            i32.add
            local.set 1
            local.get 2
            i32.const 1
            i32.add
            local.set 2
            local.get 7
            i32.const -1
            i32.add
            local.tee 7
            br_if 0 (;@4;)
          end
        end
        local.get 0
        local.get 3
        i32.add
        local.set 8
        block  ;; label = @3
          local.get 5
          i32.eqz
          br_if 0 (;@3;)
          local.get 8
          local.get 4
          i32.const -4
          i32.and
          i32.add
          local.tee 2
          i32.load8_s
          i32.const -65
          i32.gt_s
          local.set 6
          local.get 5
          i32.const 1
          i32.eq
          br_if 0 (;@3;)
          local.get 6
          local.get 2
          i32.load8_s offset=1
          i32.const -65
          i32.gt_s
          i32.add
          local.set 6
          local.get 5
          i32.const 2
          i32.eq
          br_if 0 (;@3;)
          local.get 6
          local.get 2
          i32.load8_s offset=2
          i32.const -65
          i32.gt_s
          i32.add
          local.set 6
        end
        local.get 4
        i32.const 2
        i32.shr_u
        local.set 9
        local.get 6
        local.get 1
        i32.add
        local.set 7
        loop  ;; label = @3
          local.get 8
          local.set 4
          local.get 9
          i32.eqz
          br_if 2 (;@1;)
          local.get 9
          i32.const 192
          local.get 9
          i32.const 192
          i32.lt_u
          select
          local.tee 3
          i32.const 3
          i32.and
          local.set 6
          local.get 3
          i32.const 2
          i32.shl
          local.set 5
          block  ;; label = @4
            block  ;; label = @5
              local.get 3
              i32.const 252
              i32.and
              local.tee 10
              br_if 0 (;@5;)
              i32.const 0
              local.set 2
              br 1 (;@4;)
            end
            local.get 4
            local.get 10
            i32.const 2
            i32.shl
            i32.add
            local.set 0
            i32.const 0
            local.set 2
            local.get 4
            local.set 1
            loop  ;; label = @5
              local.get 1
              i32.eqz
              br_if 1 (;@4;)
              local.get 1
              i32.const 12
              i32.add
              i32.load
              local.tee 8
              i32.const -1
              i32.xor
              i32.const 7
              i32.shr_u
              local.get 8
              i32.const 6
              i32.shr_u
              i32.or
              i32.const 16843009
              i32.and
              local.get 1
              i32.const 8
              i32.add
              i32.load
              local.tee 8
              i32.const -1
              i32.xor
              i32.const 7
              i32.shr_u
              local.get 8
              i32.const 6
              i32.shr_u
              i32.or
              i32.const 16843009
              i32.and
              local.get 1
              i32.const 4
              i32.add
              i32.load
              local.tee 8
              i32.const -1
              i32.xor
              i32.const 7
              i32.shr_u
              local.get 8
              i32.const 6
              i32.shr_u
              i32.or
              i32.const 16843009
              i32.and
              local.get 1
              i32.load
              local.tee 8
              i32.const -1
              i32.xor
              i32.const 7
              i32.shr_u
              local.get 8
              i32.const 6
              i32.shr_u
              i32.or
              i32.const 16843009
              i32.and
              local.get 2
              i32.add
              i32.add
              i32.add
              i32.add
              local.set 2
              local.get 1
              i32.const 16
              i32.add
              local.tee 1
              local.get 0
              i32.ne
              br_if 0 (;@5;)
            end
          end
          local.get 9
          local.get 3
          i32.sub
          local.set 9
          local.get 4
          local.get 5
          i32.add
          local.set 8
          local.get 2
          i32.const 8
          i32.shr_u
          i32.const 16711935
          i32.and
          local.get 2
          i32.const 16711935
          i32.and
          i32.add
          i32.const 65537
          i32.mul
          i32.const 16
          i32.shr_u
          local.get 7
          i32.add
          local.set 7
          local.get 6
          i32.eqz
          br_if 0 (;@3;)
        end
        block  ;; label = @3
          block  ;; label = @4
            local.get 4
            br_if 0 (;@4;)
            i32.const 0
            local.set 1
            br 1 (;@3;)
          end
          local.get 4
          local.get 10
          i32.const 2
          i32.shl
          i32.add
          local.tee 2
          i32.load
          local.tee 1
          i32.const -1
          i32.xor
          i32.const 7
          i32.shr_u
          local.get 1
          i32.const 6
          i32.shr_u
          i32.or
          i32.const 16843009
          i32.and
          local.set 1
          local.get 6
          i32.const 1
          i32.eq
          br_if 0 (;@3;)
          local.get 2
          i32.load offset=4
          local.tee 8
          i32.const -1
          i32.xor
          i32.const 7
          i32.shr_u
          local.get 8
          i32.const 6
          i32.shr_u
          i32.or
          i32.const 16843009
          i32.and
          local.get 1
          i32.add
          local.set 1
          local.get 6
          i32.const 2
          i32.eq
          br_if 0 (;@3;)
          local.get 2
          i32.load offset=8
          local.tee 2
          i32.const -1
          i32.xor
          i32.const 7
          i32.shr_u
          local.get 2
          i32.const 6
          i32.shr_u
          i32.or
          i32.const 16843009
          i32.and
          local.get 1
          i32.add
          local.set 1
        end
        local.get 1
        i32.const 8
        i32.shr_u
        i32.const 459007
        i32.and
        local.get 1
        i32.const 16711935
        i32.and
        i32.add
        i32.const 65537
        i32.mul
        i32.const 16
        i32.shr_u
        local.get 7
        i32.add
        local.set 7
        br 1 (;@1;)
      end
      block  ;; label = @2
        local.get 1
        br_if 0 (;@2;)
        i32.const 0
        return
      end
      local.get 1
      i32.const 3
      i32.and
      local.set 8
      block  ;; label = @2
        block  ;; label = @3
          local.get 1
          i32.const 4
          i32.ge_u
          br_if 0 (;@3;)
          i32.const 0
          local.set 7
          i32.const 0
          local.set 2
          br 1 (;@2;)
        end
        local.get 1
        i32.const -4
        i32.and
        local.set 9
        i32.const 0
        local.set 7
        i32.const 0
        local.set 2
        loop  ;; label = @3
          local.get 7
          local.get 0
          local.get 2
          i32.add
          local.tee 1
          i32.load8_s
          i32.const -65
          i32.gt_s
          i32.add
          local.get 1
          i32.const 1
          i32.add
          i32.load8_s
          i32.const -65
          i32.gt_s
          i32.add
          local.get 1
          i32.const 2
          i32.add
          i32.load8_s
          i32.const -65
          i32.gt_s
          i32.add
          local.get 1
          i32.const 3
          i32.add
          i32.load8_s
          i32.const -65
          i32.gt_s
          i32.add
          local.set 7
          local.get 9
          local.get 2
          i32.const 4
          i32.add
          local.tee 2
          i32.ne
          br_if 0 (;@3;)
        end
      end
      local.get 8
      i32.eqz
      br_if 0 (;@1;)
      local.get 0
      local.get 2
      i32.add
      local.set 1
      loop  ;; label = @2
        local.get 7
        local.get 1
        i32.load8_s
        i32.const -65
        i32.gt_s
        i32.add
        local.set 7
        local.get 1
        i32.const 1
        i32.add
        local.set 1
        local.get 8
        i32.const -1
        i32.add
        local.tee 8
        br_if 0 (;@2;)
      end
    end
    local.get 7)
  (func $_ZN4core3fmt9Formatter12pad_integral12write_prefix17h7186e489b53c8fefE (type 12) (param i32 i32 i32 i32 i32) (result i32)
    (local i32)
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          local.get 2
          i32.const 1114112
          i32.eq
          br_if 0 (;@3;)
          i32.const 1
          local.set 5
          local.get 0
          local.get 2
          local.get 1
          i32.load offset=16
          call_indirect (type 2)
          br_if 1 (;@2;)
        end
        local.get 3
        br_if 1 (;@1;)
        i32.const 0
        local.set 5
      end
      local.get 5
      return
    end
    local.get 0
    local.get 3
    local.get 4
    local.get 1
    i32.load offset=12
    call_indirect (type 1))
  (func $_ZN4core3fmt9Formatter9write_str17h913e84d04ade0affE (type 1) (param i32 i32 i32) (result i32)
    local.get 0
    i32.load offset=20
    local.get 1
    local.get 2
    local.get 0
    i32.const 24
    i32.add
    i32.load
    i32.load offset=12
    call_indirect (type 1))
  (func $_ZN4core3fmt9Formatter15debug_lower_hex17hd51e792cf83d3430E (type 3) (param i32) (result i32)
    local.get 0
    i32.load8_u offset=28
    i32.const 16
    i32.and
    i32.const 4
    i32.shr_u)
  (func $_ZN4core3fmt9Formatter15debug_upper_hex17h5d875fa48567936bE (type 3) (param i32) (result i32)
    local.get 0
    i32.load8_u offset=28
    i32.const 32
    i32.and
    i32.const 5
    i32.shr_u)
  (func $_ZN4core3fmt9Formatter25debug_tuple_field1_finish17h698cdec2464637e7E (type 12) (param i32 i32 i32 i32 i32) (result i32)
    (local i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 5
    global.set $__stack_pointer
    local.get 5
    local.get 0
    i32.load offset=20
    local.get 1
    local.get 2
    local.get 0
    i32.const 24
    i32.add
    i32.load
    i32.load offset=12
    call_indirect (type 1)
    i32.store8 offset=8
    local.get 5
    local.get 0
    i32.store offset=4
    local.get 5
    local.get 2
    i32.eqz
    i32.store8 offset=9
    local.get 5
    i32.const 0
    i32.store
    local.get 5
    local.get 3
    local.get 4
    call $_ZN4core3fmt8builders10DebugTuple5field17h32130795d920081aE
    local.set 0
    local.get 5
    i32.load8_u offset=8
    local.set 2
    block  ;; label = @1
      block  ;; label = @2
        local.get 0
        i32.load
        local.tee 1
        br_if 0 (;@2;)
        local.get 2
        i32.const 255
        i32.and
        i32.const 0
        i32.ne
        local.set 0
        br 1 (;@1;)
      end
      i32.const 1
      local.set 0
      local.get 2
      i32.const 255
      i32.and
      br_if 0 (;@1;)
      local.get 5
      i32.load offset=4
      local.set 2
      block  ;; label = @2
        local.get 1
        i32.const 1
        i32.ne
        br_if 0 (;@2;)
        local.get 5
        i32.load8_u offset=9
        i32.const 255
        i32.and
        i32.eqz
        br_if 0 (;@2;)
        local.get 2
        i32.load8_u offset=28
        i32.const 4
        i32.and
        br_if 0 (;@2;)
        i32.const 1
        local.set 0
        local.get 2
        i32.load offset=20
        i32.const 1049599
        i32.const 1
        local.get 2
        i32.const 24
        i32.add
        i32.load
        i32.load offset=12
        call_indirect (type 1)
        br_if 1 (;@1;)
      end
      local.get 2
      i32.load offset=20
      i32.const 1049408
      i32.const 1
      local.get 2
      i32.const 24
      i32.add
      i32.load
      i32.load offset=12
      call_indirect (type 1)
      local.set 0
    end
    local.get 5
    i32.const 16
    i32.add
    global.set $__stack_pointer
    local.get 0)
  (func $_ZN4core3fmt3num3imp7fmt_u6417h7a228af73e4122cdE (type 15) (param i64 i32 i32) (result i32)
    (local i32 i32 i64 i32 i32 i32)
    global.get $__stack_pointer
    i32.const 48
    i32.sub
    local.tee 3
    global.set $__stack_pointer
    i32.const 39
    local.set 4
    block  ;; label = @1
      block  ;; label = @2
        local.get 0
        i64.const 10000
        i64.ge_u
        br_if 0 (;@2;)
        local.get 0
        local.set 5
        br 1 (;@1;)
      end
      i32.const 39
      local.set 4
      loop  ;; label = @2
        local.get 3
        i32.const 9
        i32.add
        local.get 4
        i32.add
        local.tee 6
        i32.const -4
        i32.add
        local.get 0
        local.get 0
        i64.const 10000
        i64.div_u
        local.tee 5
        i64.const 10000
        i64.mul
        i64.sub
        i32.wrap_i64
        local.tee 7
        i32.const 65535
        i32.and
        i32.const 100
        i32.div_u
        local.tee 8
        i32.const 1
        i32.shl
        i32.const 1049646
        i32.add
        i32.load16_u align=1
        i32.store16 align=1
        local.get 6
        i32.const -2
        i32.add
        local.get 7
        local.get 8
        i32.const 100
        i32.mul
        i32.sub
        i32.const 65535
        i32.and
        i32.const 1
        i32.shl
        i32.const 1049646
        i32.add
        i32.load16_u align=1
        i32.store16 align=1
        local.get 4
        i32.const -4
        i32.add
        local.set 4
        local.get 0
        i64.const 99999999
        i64.gt_u
        local.set 6
        local.get 5
        local.set 0
        local.get 6
        br_if 0 (;@2;)
      end
    end
    block  ;; label = @1
      local.get 5
      i32.wrap_i64
      local.tee 6
      i32.const 99
      i32.le_u
      br_if 0 (;@1;)
      local.get 3
      i32.const 9
      i32.add
      local.get 4
      i32.const -2
      i32.add
      local.tee 4
      i32.add
      local.get 5
      i32.wrap_i64
      local.tee 6
      local.get 6
      i32.const 65535
      i32.and
      i32.const 100
      i32.div_u
      local.tee 6
      i32.const 100
      i32.mul
      i32.sub
      i32.const 65535
      i32.and
      i32.const 1
      i32.shl
      i32.const 1049646
      i32.add
      i32.load16_u align=1
      i32.store16 align=1
    end
    block  ;; label = @1
      block  ;; label = @2
        local.get 6
        i32.const 10
        i32.lt_u
        br_if 0 (;@2;)
        local.get 3
        i32.const 9
        i32.add
        local.get 4
        i32.const -2
        i32.add
        local.tee 4
        i32.add
        local.get 6
        i32.const 1
        i32.shl
        i32.const 1049646
        i32.add
        i32.load16_u align=1
        i32.store16 align=1
        br 1 (;@1;)
      end
      local.get 3
      i32.const 9
      i32.add
      local.get 4
      i32.const -1
      i32.add
      local.tee 4
      i32.add
      local.get 6
      i32.const 48
      i32.add
      i32.store8
    end
    local.get 2
    local.get 1
    i32.const 1049408
    i32.const 0
    local.get 3
    i32.const 9
    i32.add
    local.get 4
    i32.add
    i32.const 39
    local.get 4
    i32.sub
    call $_ZN4core3fmt9Formatter12pad_integral17h1311a70c35efb64aE
    local.set 4
    local.get 3
    i32.const 48
    i32.add
    global.set $__stack_pointer
    local.get 4)
  (func $_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..UpperHex$u20$for$u20$i32$GT$3fmt17h59090ba5de968a5dE (type 2) (param i32 i32) (result i32)
    (local i32 i32 i32)
    global.get $__stack_pointer
    i32.const 128
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    local.get 0
    i32.load
    local.set 0
    i32.const 0
    local.set 3
    loop  ;; label = @1
      local.get 2
      local.get 3
      i32.add
      i32.const 127
      i32.add
      i32.const 48
      i32.const 55
      local.get 0
      i32.const 15
      i32.and
      local.tee 4
      i32.const 10
      i32.lt_u
      select
      local.get 4
      i32.add
      i32.store8
      local.get 3
      i32.const -1
      i32.add
      local.set 3
      local.get 0
      i32.const 16
      i32.lt_u
      local.set 4
      local.get 0
      i32.const 4
      i32.shr_u
      local.set 0
      local.get 4
      i32.eqz
      br_if 0 (;@1;)
    end
    block  ;; label = @1
      local.get 3
      i32.const 128
      i32.add
      local.tee 0
      i32.const 129
      i32.lt_u
      br_if 0 (;@1;)
      local.get 0
      i32.const 128
      i32.const 1049628
      call $_ZN4core5slice5index26slice_start_index_len_fail17h851b41322c5eadc1E
      unreachable
    end
    local.get 1
    i32.const 1
    i32.const 1049644
    i32.const 2
    local.get 2
    local.get 3
    i32.add
    i32.const 128
    i32.add
    i32.const 0
    local.get 3
    i32.sub
    call $_ZN4core3fmt9Formatter12pad_integral17h1311a70c35efb64aE
    local.set 0
    local.get 2
    i32.const 128
    i32.add
    global.set $__stack_pointer
    local.get 0)
  (func $_ZN17compiler_builtins3mem6memcpy17ha02d5535b4a2d57fE (type 1) (param i32 i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32)
    block  ;; label = @1
      block  ;; label = @2
        local.get 2
        i32.const 15
        i32.gt_u
        br_if 0 (;@2;)
        local.get 0
        local.set 3
        br 1 (;@1;)
      end
      local.get 0
      i32.const 0
      local.get 0
      i32.sub
      i32.const 3
      i32.and
      local.tee 4
      i32.add
      local.set 5
      block  ;; label = @2
        local.get 4
        i32.eqz
        br_if 0 (;@2;)
        local.get 0
        local.set 3
        local.get 1
        local.set 6
        loop  ;; label = @3
          local.get 3
          local.get 6
          i32.load8_u
          i32.store8
          local.get 6
          i32.const 1
          i32.add
          local.set 6
          local.get 3
          i32.const 1
          i32.add
          local.tee 3
          local.get 5
          i32.lt_u
          br_if 0 (;@3;)
        end
      end
      local.get 5
      local.get 2
      local.get 4
      i32.sub
      local.tee 7
      i32.const -4
      i32.and
      local.tee 8
      i32.add
      local.set 3
      block  ;; label = @2
        block  ;; label = @3
          local.get 1
          local.get 4
          i32.add
          local.tee 9
          i32.const 3
          i32.and
          i32.eqz
          br_if 0 (;@3;)
          local.get 8
          i32.const 1
          i32.lt_s
          br_if 1 (;@2;)
          local.get 9
          i32.const 3
          i32.shl
          local.tee 6
          i32.const 24
          i32.and
          local.set 2
          local.get 9
          i32.const -4
          i32.and
          local.tee 10
          i32.const 4
          i32.add
          local.set 1
          i32.const 0
          local.get 6
          i32.sub
          i32.const 24
          i32.and
          local.set 4
          local.get 10
          i32.load
          local.set 6
          loop  ;; label = @4
            local.get 5
            local.get 6
            local.get 2
            i32.shr_u
            local.get 1
            i32.load
            local.tee 6
            local.get 4
            i32.shl
            i32.or
            i32.store
            local.get 1
            i32.const 4
            i32.add
            local.set 1
            local.get 5
            i32.const 4
            i32.add
            local.tee 5
            local.get 3
            i32.lt_u
            br_if 0 (;@4;)
            br 2 (;@2;)
          end
        end
        local.get 8
        i32.const 1
        i32.lt_s
        br_if 0 (;@2;)
        local.get 9
        local.set 1
        loop  ;; label = @3
          local.get 5
          local.get 1
          i32.load
          i32.store
          local.get 1
          i32.const 4
          i32.add
          local.set 1
          local.get 5
          i32.const 4
          i32.add
          local.tee 5
          local.get 3
          i32.lt_u
          br_if 0 (;@3;)
        end
      end
      local.get 7
      i32.const 3
      i32.and
      local.set 2
      local.get 9
      local.get 8
      i32.add
      local.set 1
    end
    block  ;; label = @1
      local.get 2
      i32.eqz
      br_if 0 (;@1;)
      local.get 3
      local.get 2
      i32.add
      local.set 5
      loop  ;; label = @2
        local.get 3
        local.get 1
        i32.load8_u
        i32.store8
        local.get 1
        i32.const 1
        i32.add
        local.set 1
        local.get 3
        i32.const 1
        i32.add
        local.tee 3
        local.get 5
        i32.lt_u
        br_if 0 (;@2;)
      end
    end
    local.get 0)
  (func $_ZN17compiler_builtins3mem7memmove17h649a1cf8470f8a89E (type 1) (param i32 i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32)
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            local.get 0
            local.get 1
            i32.sub
            local.get 2
            i32.ge_u
            br_if 0 (;@4;)
            local.get 1
            local.get 2
            i32.add
            local.set 3
            local.get 0
            local.get 2
            i32.add
            local.set 4
            block  ;; label = @5
              local.get 2
              i32.const 15
              i32.gt_u
              br_if 0 (;@5;)
              local.get 0
              local.set 5
              br 3 (;@2;)
            end
            local.get 4
            i32.const -4
            i32.and
            local.set 6
            i32.const 0
            local.get 4
            i32.const 3
            i32.and
            local.tee 7
            i32.sub
            local.set 8
            block  ;; label = @5
              local.get 7
              i32.eqz
              br_if 0 (;@5;)
              local.get 1
              local.get 2
              i32.add
              i32.const -1
              i32.add
              local.set 5
              loop  ;; label = @6
                local.get 4
                i32.const -1
                i32.add
                local.tee 4
                local.get 5
                i32.load8_u
                i32.store8
                local.get 5
                i32.const -1
                i32.add
                local.set 5
                local.get 6
                local.get 4
                i32.lt_u
                br_if 0 (;@6;)
              end
            end
            local.get 6
            local.get 2
            local.get 7
            i32.sub
            local.tee 9
            i32.const -4
            i32.and
            local.tee 5
            i32.sub
            local.set 4
            i32.const 0
            local.get 5
            i32.sub
            local.set 7
            block  ;; label = @5
              local.get 3
              local.get 8
              i32.add
              local.tee 8
              i32.const 3
              i32.and
              i32.eqz
              br_if 0 (;@5;)
              local.get 7
              i32.const -1
              i32.gt_s
              br_if 2 (;@3;)
              local.get 8
              i32.const 3
              i32.shl
              local.tee 5
              i32.const 24
              i32.and
              local.set 2
              local.get 8
              i32.const -4
              i32.and
              local.tee 10
              i32.const -4
              i32.add
              local.set 1
              i32.const 0
              local.get 5
              i32.sub
              i32.const 24
              i32.and
              local.set 3
              local.get 10
              i32.load
              local.set 5
              loop  ;; label = @6
                local.get 6
                i32.const -4
                i32.add
                local.tee 6
                local.get 5
                local.get 3
                i32.shl
                local.get 1
                i32.load
                local.tee 5
                local.get 2
                i32.shr_u
                i32.or
                i32.store
                local.get 1
                i32.const -4
                i32.add
                local.set 1
                local.get 4
                local.get 6
                i32.lt_u
                br_if 0 (;@6;)
                br 3 (;@3;)
              end
            end
            local.get 7
            i32.const -1
            i32.gt_s
            br_if 1 (;@3;)
            local.get 9
            local.get 1
            i32.add
            i32.const -4
            i32.add
            local.set 1
            loop  ;; label = @5
              local.get 6
              i32.const -4
              i32.add
              local.tee 6
              local.get 1
              i32.load
              i32.store
              local.get 1
              i32.const -4
              i32.add
              local.set 1
              local.get 4
              local.get 6
              i32.lt_u
              br_if 0 (;@5;)
              br 2 (;@3;)
            end
          end
          block  ;; label = @4
            block  ;; label = @5
              local.get 2
              i32.const 15
              i32.gt_u
              br_if 0 (;@5;)
              local.get 0
              local.set 4
              br 1 (;@4;)
            end
            local.get 0
            i32.const 0
            local.get 0
            i32.sub
            i32.const 3
            i32.and
            local.tee 3
            i32.add
            local.set 5
            block  ;; label = @5
              local.get 3
              i32.eqz
              br_if 0 (;@5;)
              local.get 0
              local.set 4
              local.get 1
              local.set 6
              loop  ;; label = @6
                local.get 4
                local.get 6
                i32.load8_u
                i32.store8
                local.get 6
                i32.const 1
                i32.add
                local.set 6
                local.get 4
                i32.const 1
                i32.add
                local.tee 4
                local.get 5
                i32.lt_u
                br_if 0 (;@6;)
              end
            end
            local.get 5
            local.get 2
            local.get 3
            i32.sub
            local.tee 8
            i32.const -4
            i32.and
            local.tee 9
            i32.add
            local.set 4
            block  ;; label = @5
              block  ;; label = @6
                local.get 1
                local.get 3
                i32.add
                local.tee 7
                i32.const 3
                i32.and
                i32.eqz
                br_if 0 (;@6;)
                local.get 9
                i32.const 1
                i32.lt_s
                br_if 1 (;@5;)
                local.get 7
                i32.const 3
                i32.shl
                local.tee 6
                i32.const 24
                i32.and
                local.set 2
                local.get 7
                i32.const -4
                i32.and
                local.tee 10
                i32.const 4
                i32.add
                local.set 1
                i32.const 0
                local.get 6
                i32.sub
                i32.const 24
                i32.and
                local.set 3
                local.get 10
                i32.load
                local.set 6
                loop  ;; label = @7
                  local.get 5
                  local.get 6
                  local.get 2
                  i32.shr_u
                  local.get 1
                  i32.load
                  local.tee 6
                  local.get 3
                  i32.shl
                  i32.or
                  i32.store
                  local.get 1
                  i32.const 4
                  i32.add
                  local.set 1
                  local.get 5
                  i32.const 4
                  i32.add
                  local.tee 5
                  local.get 4
                  i32.lt_u
                  br_if 0 (;@7;)
                  br 2 (;@5;)
                end
              end
              local.get 9
              i32.const 1
              i32.lt_s
              br_if 0 (;@5;)
              local.get 7
              local.set 1
              loop  ;; label = @6
                local.get 5
                local.get 1
                i32.load
                i32.store
                local.get 1
                i32.const 4
                i32.add
                local.set 1
                local.get 5
                i32.const 4
                i32.add
                local.tee 5
                local.get 4
                i32.lt_u
                br_if 0 (;@6;)
              end
            end
            local.get 8
            i32.const 3
            i32.and
            local.set 2
            local.get 7
            local.get 9
            i32.add
            local.set 1
          end
          local.get 2
          i32.eqz
          br_if 2 (;@1;)
          local.get 4
          local.get 2
          i32.add
          local.set 5
          loop  ;; label = @4
            local.get 4
            local.get 1
            i32.load8_u
            i32.store8
            local.get 1
            i32.const 1
            i32.add
            local.set 1
            local.get 4
            i32.const 1
            i32.add
            local.tee 4
            local.get 5
            i32.lt_u
            br_if 0 (;@4;)
            br 3 (;@1;)
          end
        end
        local.get 9
        i32.const 3
        i32.and
        local.tee 1
        i32.eqz
        br_if 1 (;@1;)
        local.get 8
        local.get 7
        i32.add
        local.set 3
        local.get 4
        local.get 1
        i32.sub
        local.set 5
      end
      local.get 3
      i32.const -1
      i32.add
      local.set 1
      loop  ;; label = @2
        local.get 4
        i32.const -1
        i32.add
        local.tee 4
        local.get 1
        i32.load8_u
        i32.store8
        local.get 1
        i32.const -1
        i32.add
        local.set 1
        local.get 5
        local.get 4
        i32.lt_u
        br_if 0 (;@2;)
      end
    end
    local.get 0)
  (func $_ZN17compiler_builtins3mem6memset17h4307a527d1d13eb9E (type 1) (param i32 i32 i32) (result i32)
    (local i32 i32 i32)
    block  ;; label = @1
      block  ;; label = @2
        local.get 2
        i32.const 15
        i32.gt_u
        br_if 0 (;@2;)
        local.get 0
        local.set 3
        br 1 (;@1;)
      end
      local.get 0
      i32.const 0
      local.get 0
      i32.sub
      i32.const 3
      i32.and
      local.tee 4
      i32.add
      local.set 5
      block  ;; label = @2
        local.get 4
        i32.eqz
        br_if 0 (;@2;)
        local.get 0
        local.set 3
        loop  ;; label = @3
          local.get 3
          local.get 1
          i32.store8
          local.get 3
          i32.const 1
          i32.add
          local.tee 3
          local.get 5
          i32.lt_u
          br_if 0 (;@3;)
        end
      end
      local.get 5
      local.get 2
      local.get 4
      i32.sub
      local.tee 4
      i32.const -4
      i32.and
      local.tee 2
      i32.add
      local.set 3
      block  ;; label = @2
        local.get 2
        i32.const 1
        i32.lt_s
        br_if 0 (;@2;)
        local.get 1
        i32.const 255
        i32.and
        i32.const 16843009
        i32.mul
        local.set 2
        loop  ;; label = @3
          local.get 5
          local.get 2
          i32.store
          local.get 5
          i32.const 4
          i32.add
          local.tee 5
          local.get 3
          i32.lt_u
          br_if 0 (;@3;)
        end
      end
      local.get 4
      i32.const 3
      i32.and
      local.set 2
    end
    block  ;; label = @1
      local.get 2
      i32.eqz
      br_if 0 (;@1;)
      local.get 3
      local.get 2
      i32.add
      local.set 5
      loop  ;; label = @2
        local.get 3
        local.get 1
        i32.store8
        local.get 3
        i32.const 1
        i32.add
        local.tee 3
        local.get 5
        i32.lt_u
        br_if 0 (;@2;)
      end
    end
    local.get 0)
  (func $memcpy (type 1) (param i32 i32 i32) (result i32)
    local.get 0
    local.get 1
    local.get 2
    call $_ZN17compiler_builtins3mem6memcpy17ha02d5535b4a2d57fE)
  (func $memmove (type 1) (param i32 i32 i32) (result i32)
    local.get 0
    local.get 1
    local.get 2
    call $_ZN17compiler_builtins3mem7memmove17h649a1cf8470f8a89E)
  (func $memset (type 1) (param i32 i32 i32) (result i32)
    local.get 0
    local.get 1
    local.get 2
    call $_ZN17compiler_builtins3mem6memset17h4307a527d1d13eb9E)
  (table (;0;) 34 34 funcref)
  (memory (;0;) 17)
  (global $__stack_pointer (mut i32) (i32.const 1048576))
  (global (;1;) i32 (i32.const 1050425))
  (global (;2;) i32 (i32.const 1050432))
  (export "memory" (memory 0))
  (export "new" (func $new))
  (export "__data_end" (global 1))
  (export "__heap_base" (global 2))
  (elem (;0;) (i32.const 1) func $_ZN4core3ptr58drop_in_place$LT$$RF$core..option..Option$LT$usize$GT$$GT$17h31251f026af8b027E $_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h13faa5d10322b428E $_ZN4core3ptr30drop_in_place$LT$$RF$usize$GT$17h83c3e7ffb678b72fE $_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h9a61fbf71f30f14cE $_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$u32$GT$3fmt17hbaa66a6ca3ee12c8E $_ZN3std5alloc24default_alloc_error_hook17hab840010b11b64ffE $_ZN4core3ptr100drop_in_place$LT$$RF$mut$u20$std..io..Write..write_fmt..Adapter$LT$alloc..vec..Vec$LT$u8$GT$$GT$$GT$17hd4e2b285c82bbfddE $_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$9write_str17he71ac95e8290658dE $_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17h7cac422012c51d26E $_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$9write_fmt17h8ae0b2b6f28f8ca0E $_ZN4core3ptr42drop_in_place$LT$alloc..string..String$GT$17h55fc1a049449355bE $_ZN36_$LT$T$u20$as$u20$core..any..Any$GT$7type_id17h2f9122058122ec53E $_ZN36_$LT$T$u20$as$u20$core..any..Any$GT$7type_id17h493a5d87ecb9888bE $_ZN93_$LT$std..panicking..begin_panic_handler..StrPanicPayload$u20$as$u20$core..panic..BoxMeUp$GT$8take_box17hb935537982794978E $_ZN93_$LT$std..panicking..begin_panic_handler..StrPanicPayload$u20$as$u20$core..panic..BoxMeUp$GT$3get17h5a47fb41c3bdfcd5E $_ZN4core3ptr70drop_in_place$LT$std..panicking..begin_panic_handler..PanicPayload$GT$17h8c6df4fab5d2c7ebE $_ZN90_$LT$std..panicking..begin_panic_handler..PanicPayload$u20$as$u20$core..panic..BoxMeUp$GT$8take_box17h910c38d4f578a2b7E $_ZN90_$LT$std..panicking..begin_panic_handler..PanicPayload$u20$as$u20$core..panic..BoxMeUp$GT$3get17hdf52e0f41fcdce1bE $_ZN4core3ptr29drop_in_place$LT$$LP$$RP$$GT$17h4601b2f1c809a5c8E $_ZN36_$LT$T$u20$as$u20$core..any..Any$GT$7type_id17hc16c025c0c717dd0E $_ZN4core3ops8function6FnOnce9call_once17h76067c467ab7d853E $_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h492aa3edaecea1b7E $_ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17hb73b6a73788677afE $_ZN59_$LT$core..fmt..Arguments$u20$as$u20$core..fmt..Display$GT$3fmt17h10a377a6759b4243E $_ZN4core3ptr37drop_in_place$LT$core..fmt..Error$GT$17h20c52a201febd195E $_ZN36_$LT$T$u20$as$u20$core..any..Any$GT$7type_id17hfb753db928a637b4E $_ZN4core3ptr102drop_in_place$LT$$RF$core..iter..adapters..copied..Copied$LT$core..slice..iter..Iter$LT$u8$GT$$GT$$GT$17hfa8c64d5360f8a2aE $_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17hdafde26fcff4b2d8E $_ZN4core3fmt5Write10write_char17h3f59a8cf545d4fe7E $_ZN4core3fmt5Write9write_fmt17h2e6bceee10c37b66E $_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$9write_str17hcaa6cd3ac839b2faE $_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17h080db87b87f4d73cE $_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$9write_fmt17hf9a0ca43263b8ba6E)
  (data $.rodata (i32.const 1048576) "assertion failed: 0 < pointee_size && pointee_size <= isize::MAX as usize/rustc/5680fa18feaa87f3ff04063800aec256c3d4b4be/library/core/src/ptr/const_ptr.rs\00\00I\00\10\00Q\00\00\00\1d\03\00\00\09\00\00\00/rustc/5680fa18feaa87f3ff04063800aec256c3d4b4be/library/core/src/iter/traits/exact_size.rs\00\00\ac\00\10\00Z\00\00\00z\00\00\00\09\00\00\00/rustc/5680fa18feaa87f3ff04063800aec256c3d4b4be/library/core/src/alloc/layout.rs\18\01\10\00P\00\00\00\bf\01\00\00)\00\00\00\00\00\00\00\00\00\00\00attempt to divide by zero\00\00\00\01\00\00\00\04\00\00\00\04\00\00\00\02\00\00\00NoneSome\03\00\00\00\04\00\00\00\04\00\00\00\04\00\00\00called `Option::unwrap()` on a `None` value\00\07\00\00\00\04\00\00\00\04\00\00\00\08\00\00\00\09\00\00\00\0a\00\00\00memory allocation of  bytes failed\00\00\08\02\10\00\15\00\00\00\1d\02\10\00\0d\00\00\00library/std/src/alloc.rs<\02\10\00\18\00\00\00U\01\00\00\09\00\00\00library/std/src/panicking.rsd\02\10\00\1c\00\00\00O\02\00\00\1f\00\00\00d\02\10\00\1c\00\00\00P\02\00\00\1e\00\00\00\0b\00\00\00\0c\00\00\00\04\00\00\00\0c\00\00\00\07\00\00\00\08\00\00\00\04\00\00\00\0d\00\00\00\07\00\00\00\08\00\00\00\04\00\00\00\0e\00\00\00\0f\00\00\00\10\00\00\00\10\00\00\00\04\00\00\00\11\00\00\00\12\00\00\00\13\00\00\00\00\00\00\00\01\00\00\00\14\00\00\00library/alloc/src/raw_vec.rscapacity overflow\00\00\00\14\03\10\00\11\00\00\00\f8\02\10\00\1c\00\00\00\0c\02\00\00\05\00\00\00)\00\00\00\19\00\00\00\00\00\00\00\01\00\00\00\1a\00\00\00==!=matchesassertion failed: `(left  right)`\0a  left: ``,\0a right: ``\00_\03\10\00\19\00\00\00x\03\10\00\12\00\00\00\8a\03\10\00\0c\00\00\00\96\03\10\00\01\00\00\00`: \00_\03\10\00\19\00\00\00x\03\10\00\12\00\00\00\8a\03\10\00\0c\00\00\00\b8\03\10\00\03\00\00\00\1b\00\00\00\0c\00\00\00\04\00\00\00\1c\00\00\00\1d\00\00\00\1e\00\00\00    , ,\0a((\0a,library/core/src/fmt/num.rs\00\00\04\10\00\1b\00\00\00i\00\00\00\14\00\00\000x00010203040506070809101112131415161718192021222324252627282930313233343536373839404142434445464748495051525354555657585960616263646566676869707172737475767778798081828384858687888990919293949596979899\00\00\1b\00\00\00\04\00\00\00\04\00\00\00\1f\00\00\00 \00\00\00!\00\00\00range start index  out of range for slice of length \10\05\10\00\12\00\00\00\22\05\10\00\22\00\00\00"))

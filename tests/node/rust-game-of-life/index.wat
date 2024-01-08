(module
  (type (;0;) (func (param i32 i32)))
  (type (;1;) (func (param i32 i32 i32) (result i32)))
  (type (;2;) (func (param i32 i32) (result i32)))
  (type (;3;) (func (param i32 i32 i32)))
  (type (;4;) (func (param i32) (result i32)))
  (type (;5;) (func (param i32 i32 i32 i32 i32 i32)))
  (type (;6;) (func (param i32 i32 i32 i32 i32)))
  (type (;7;) (func (param i32)))
  (type (;8;) (func (param i32 i32 i32 i32)))
  (type (;9;) (func (param i32 i32 i32 i32 i32 i32 i32 i32)))
  (type (;10;) (func (param i32 i32 i32 i32 i32 i32 i32)))
  (type (;11;) (func (param i32 i32 i32 i32) (result i32)))
  (type (;12;) (func (result i32)))
  (type (;13;) (func (param i32 i32 i32 i32 i32) (result i32)))
  (type (;14;) (func))
  (type (;15;) (func (param i32 i32 i32 i32 i32 i32) (result i32)))
  (type (;16;) (func (param i64 i32 i32) (result i32)))
  (func $_ZN102_$LT$core..iter..adapters..map..Map$LT$I$C$F$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4fold17h07ca9642c4fa0a53E (type 3) (param i32 i32 i32)
    (local i32 i32 i32 i32 i32 i32 i32 i64 i32 i32 i32)
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
    local.get 2
    local.get 6
    i32.add
    local.set 7
    local.get 7
    i32.load
    local.set 8
    local.get 5
    local.get 6
    i32.add
    local.set 9
    local.get 9
    local.get 8
    i32.store
    local.get 2
    i64.load align=4
    local.set 10
    local.get 5
    local.get 10
    i64.store
    local.get 5
    local.set 11
    local.get 0
    local.get 1
    local.get 11
    call $_ZN4core4iter6traits8iterator8Iterator4fold17h152a5dee337df8b7E
    i32.const 16
    local.set 12
    local.get 5
    local.get 12
    i32.add
    local.set 13
    local.get 13
    global.set $__stack_pointer
    return)
  (func $_ZN4core4iter6traits8iterator8Iterator4fold17h152a5dee337df8b7E (type 3) (param i32 i32 i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
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
    local.get 0
    i32.store offset=12
    local.get 5
    local.get 1
    i32.store offset=16
    block  ;; label = @1
      loop  ;; label = @2
        i32.const 12
        local.set 6
        local.get 5
        local.get 6
        i32.add
        local.set 7
        local.get 5
        local.get 7
        call $_ZN4core4iter5range101_$LT$impl$u20$core..iter..traits..iterator..Iterator$u20$for$u20$core..ops..range..Range$LT$A$GT$$GT$4next17hb8a5ddf94a022688E
        local.get 5
        i32.load
        local.set 8
        local.get 5
        i32.load offset=4
        local.set 9
        local.get 5
        local.get 9
        i32.store offset=24
        local.get 5
        local.get 8
        i32.store offset=20
        local.get 5
        i32.load offset=20
        local.set 10
        i32.const 1
        local.set 11
        local.get 10
        local.set 12
        local.get 11
        local.set 13
        local.get 12
        local.get 13
        i32.eq
        local.set 14
        i32.const 1
        local.set 15
        local.get 14
        local.get 15
        i32.and
        local.set 16
        local.get 16
        i32.eqz
        br_if 1 (;@1;)
        local.get 5
        i32.load offset=24
        local.set 17
        local.get 5
        local.get 17
        i32.store offset=28
        local.get 5
        i32.load offset=28
        local.set 18
        local.get 2
        local.get 18
        call $_ZN4core4iter8adapters3map8map_fold28_$u7b$$u7b$closure$u7d$$u7d$17ha4a8b9f5d96ed1ddE
        br 0 (;@2;)
      end
    end
    local.get 2
    call $_ZN4core3ptr492drop_in_place$LT$core..iter..adapters..map..map_fold$LT$u32$C$index..Cell$C$$LP$$RP$$C$index..Universe..new..$u7b$$u7b$closure$u7d$$u7d$$C$core..iter..traits..iterator..Iterator..for_each..call$LT$index..Cell$C$alloc..vec..Vec$LT$index..Cell$GT$..extend_trusted$LT$core..iter..adapters..map..Map$LT$core..ops..range..Range$LT$u32$GT$$C$index..Universe..new..$u7b$$u7b$closure$u7d$$u7d$$GT$$GT$..$u7b$$u7b$closure$u7d$$u7d$$GT$..$u7b$$u7b$closure$u7d$$u7d$$GT$..$u7b$$u7b$closure$u7d$$u7d$$GT$17hcbe4b66420d1e594E
    i32.const 32
    local.set 19
    local.get 5
    local.get 19
    i32.add
    local.set 20
    local.get 20
    global.set $__stack_pointer
    return)
  (func $_ZN102_$LT$core..iter..adapters..map..Map$LT$I$C$F$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$9size_hint17h02dbb3e914644c64E (type 0) (param i32 i32)
    local.get 0
    local.get 1
    call $_ZN4core4iter5range101_$LT$impl$u20$core..iter..traits..iterator..Iterator$u20$for$u20$core..ops..range..Range$LT$A$GT$$GT$9size_hint17h3ba3b69a8b9df1c9E
    return)
  (func $_ZN4core4iter5range101_$LT$impl$u20$core..iter..traits..iterator..Iterator$u20$for$u20$core..ops..range..Range$LT$A$GT$$GT$9size_hint17h3ba3b69a8b9df1c9E (type 0) (param i32 i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
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
    local.get 1
    i32.load
    local.set 5
    local.get 1
    i32.load offset=4
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
        local.get 11
        br_if 0 (;@2;)
        i32.const 0
        local.set 12
        local.get 4
        local.get 12
        i32.store offset=28
        i32.const 1
        local.set 13
        local.get 4
        local.get 13
        i32.store offset=24
        i32.const 0
        local.set 14
        local.get 0
        local.get 14
        i32.store
        local.get 4
        i32.load offset=24
        local.set 15
        local.get 4
        i32.load offset=28
        local.set 16
        local.get 0
        local.get 15
        i32.store offset=4
        local.get 0
        local.get 16
        i32.store offset=8
        br 1 (;@1;)
      end
      i32.const 4
      local.set 17
      local.get 1
      local.get 17
      i32.add
      local.set 18
      local.get 4
      local.get 1
      local.get 18
      call $_ZN47_$LT$u32$u20$as$u20$core..iter..range..Step$GT$13steps_between17h50fba028dc6caa02E
      local.get 4
      i32.load offset=4
      local.set 19
      local.get 4
      i32.load
      local.set 20
      local.get 4
      local.get 20
      i32.store offset=16
      local.get 4
      local.get 19
      i32.store offset=20
      local.get 4
      i32.load offset=16
      local.set 21
      block  ;; label = @2
        block  ;; label = @3
          local.get 21
          br_if 0 (;@3;)
          i32.const -1
          local.set 22
          local.get 4
          local.get 22
          i32.store offset=12
          br 1 (;@2;)
        end
        local.get 4
        i32.load offset=20
        local.set 23
        local.get 4
        local.get 23
        i32.store offset=12
      end
      local.get 4
      i32.load offset=12
      local.set 24
      local.get 0
      local.get 24
      i32.store
      local.get 0
      local.get 20
      i32.store offset=4
      local.get 0
      local.get 19
      i32.store offset=8
    end
    i32.const 32
    local.set 25
    local.get 4
    local.get 25
    i32.add
    local.set 26
    local.get 26
    global.set $__stack_pointer
    return)
  (func $_ZN104_$LT$core..iter..adapters..cloned..Cloned$LT$I$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17haaa1e9c7b03f1d44E (type 0) (param i32 i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
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
    call $_ZN91_$LT$core..slice..iter..Iter$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17h1c178e3976512d25E
    local.set 5
    i32.const 8
    local.set 6
    local.get 4
    local.get 6
    i32.add
    local.set 7
    local.get 7
    local.get 5
    call $_ZN4core6option19Option$LT$$RF$T$GT$6cloned17h6f5be186997ec6e2E
    local.get 4
    i32.load offset=8
    local.set 8
    local.get 4
    i32.load offset=12
    local.set 9
    local.get 0
    local.get 9
    i32.store offset=4
    local.get 0
    local.get 8
    i32.store
    i32.const 16
    local.set 10
    local.get 4
    local.get 10
    i32.add
    local.set 11
    local.get 11
    global.set $__stack_pointer
    return)
  (func $_ZN91_$LT$core..slice..iter..Iter$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17h1c178e3976512d25E (type 4) (param i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
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
    i32.const 1
    local.set 5
    local.get 4
    local.get 5
    i32.and
    local.set 6
    block  ;; label = @1
      block  ;; label = @2
        local.get 6
        br_if 0 (;@2;)
        local.get 0
        i32.load offset=4
        local.set 7
        local.get 0
        i32.load
        local.set 8
        local.get 8
        local.set 9
        local.get 7
        local.set 10
        local.get 9
        local.get 10
        i32.eq
        local.set 11
        i32.const 1
        local.set 12
        local.get 11
        local.get 12
        i32.and
        local.set 13
        local.get 3
        local.get 13
        i32.store8 offset=11
        br 1 (;@1;)
      end
      local.get 0
      i32.load offset=4
      local.set 14
      i32.const 0
      local.set 15
      local.get 14
      local.set 16
      local.get 15
      local.set 17
      local.get 16
      local.get 17
      i32.eq
      local.set 18
      i32.const 1
      local.set 19
      local.get 18
      local.get 19
      i32.and
      local.set 20
      local.get 3
      local.get 20
      i32.store8 offset=11
    end
    local.get 3
    i32.load8_u offset=11
    local.set 21
    i32.const 1
    local.set 22
    local.get 21
    local.get 22
    i32.and
    local.set 23
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              local.get 23
              br_if 0 (;@5;)
              local.get 0
              i32.load
              local.set 24
              i32.const 0
              local.set 25
              i32.const 1
              local.set 26
              local.get 25
              local.get 26
              i32.and
              local.set 27
              local.get 27
              br_if 2 (;@3;)
              br 1 (;@4;)
            end
            i32.const 0
            local.set 28
            local.get 3
            local.get 28
            i32.store offset=4
            br 3 (;@1;)
          end
          local.get 0
          i32.load
          local.set 29
          i32.const 4
          local.set 30
          local.get 29
          local.get 30
          i32.add
          local.set 31
          local.get 3
          local.get 31
          i32.store offset=12
          local.get 3
          i32.load offset=12
          local.set 32
          local.get 0
          local.get 32
          i32.store
          br 1 (;@2;)
        end
        local.get 0
        i32.load offset=4
        local.set 33
        i32.const 1
        local.set 34
        local.get 33
        local.get 34
        i32.sub
        local.set 35
        local.get 0
        local.get 35
        i32.store offset=4
      end
      local.get 3
      local.get 24
      i32.store offset=4
    end
    local.get 3
    i32.load offset=4
    local.set 36
    local.get 36
    return)
  (func $_ZN4core6option19Option$LT$$RF$T$GT$6cloned17h6f5be186997ec6e2E (type 0) (param i32 i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    local.set 2
    i32.const 16
    local.set 3
    local.get 2
    local.get 3
    i32.sub
    local.set 4
    local.get 4
    local.get 1
    i32.store offset=4
    local.get 4
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
    block  ;; label = @1
      block  ;; label = @2
        local.get 8
        br_if 0 (;@2;)
        i32.const 0
        local.set 9
        local.get 4
        local.get 9
        i32.store offset=8
        br 1 (;@1;)
      end
      local.get 4
      i32.load offset=4
      local.set 10
      local.get 10
      i32.load
      local.set 11
      local.get 4
      local.get 11
      i32.store offset=12
      i32.const 1
      local.set 12
      local.get 4
      local.get 12
      i32.store offset=8
    end
    local.get 4
    i32.load offset=8
    local.set 13
    local.get 4
    i32.load offset=12
    local.set 14
    local.get 0
    local.get 14
    i32.store offset=4
    local.get 0
    local.get 13
    i32.store
    return)
  (func $_ZN106_$LT$core..ops..range..Range$LT$usize$GT$$u20$as$u20$core..slice..index..SliceIndex$LT$$u5b$T$u5d$$GT$$GT$9index_mut17h81ed307bba01b2a8E (type 5) (param i32 i32 i32 i32 i32 i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    local.set 6
    i32.const 16
    local.set 7
    local.get 6
    local.get 7
    i32.sub
    local.set 8
    local.get 8
    global.set $__stack_pointer
    local.get 1
    local.set 9
    local.get 2
    local.set 10
    local.get 9
    local.get 10
    i32.gt_u
    local.set 11
    i32.const 1
    local.set 12
    local.get 11
    local.get 12
    i32.and
    local.set 13
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          local.get 13
          br_if 0 (;@3;)
          local.get 2
          local.set 14
          local.get 4
          local.set 15
          local.get 14
          local.get 15
          i32.gt_u
          local.set 16
          i32.const 1
          local.set 17
          local.get 16
          local.get 17
          i32.and
          local.set 18
          local.get 18
          br_if 2 (;@1;)
          br 1 (;@2;)
        end
        local.get 1
        local.get 2
        local.get 5
        call $_ZN4core5slice5index22slice_index_order_fail17h511e34aef03a49cbE
        unreachable
      end
      local.get 2
      local.get 1
      i32.sub
      local.set 19
      local.get 3
      local.get 1
      i32.add
      local.set 20
      local.get 8
      local.get 20
      i32.store offset=8
      local.get 8
      local.get 19
      i32.store offset=12
      local.get 8
      i32.load offset=8
      local.set 21
      local.get 8
      i32.load offset=12
      local.set 22
      local.get 8
      local.get 21
      i32.store
      local.get 8
      local.get 22
      i32.store offset=4
      local.get 8
      i32.load
      local.set 23
      local.get 8
      i32.load offset=4
      local.set 24
      local.get 0
      local.get 24
      i32.store offset=4
      local.get 0
      local.get 23
      i32.store
      i32.const 16
      local.set 25
      local.get 8
      local.get 25
      i32.add
      local.set 26
      local.get 26
      global.set $__stack_pointer
      return
    end
    local.get 2
    local.get 4
    local.get 5
    call $_ZN4core5slice5index24slice_end_index_len_fail17h6448231a3cf176e8E
    unreachable)
  (func $_ZN111_$LT$alloc..vec..Vec$LT$T$GT$$u20$as$u20$alloc..vec..spec_from_iter_nested..SpecFromIterNested$LT$T$C$I$GT$$GT$9from_iter17h6f338b4443ee7d7bE (type 3) (param i32 i32 i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i64 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    local.set 3
    i32.const 96
    local.set 4
    local.get 3
    local.get 4
    i32.sub
    local.set 5
    local.get 5
    global.set $__stack_pointer
    local.get 5
    local.get 1
    i32.store offset=8
    local.get 5
    local.get 2
    i32.store offset=12
    i32.const 28
    local.set 6
    local.get 5
    local.get 6
    i32.add
    local.set 7
    local.get 7
    local.set 8
    i32.const 8
    local.set 9
    local.get 5
    local.get 9
    i32.add
    local.set 10
    local.get 10
    local.set 11
    local.get 8
    local.get 11
    call $_ZN102_$LT$core..iter..adapters..map..Map$LT$I$C$F$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$9size_hint17h02dbb3e914644c64E
    local.get 5
    i32.load offset=32
    local.set 12
    i32.const 1
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
    block  ;; label = @1
      local.get 18
      i32.eqz
      br_if 0 (;@1;)
      local.get 5
      i32.load offset=36
      local.set 19
      i32.const 0
      local.set 20
      local.get 5
      local.get 19
      local.get 20
      call $_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$11allocate_in17h72fc51a304adc19aE
      local.get 5
      i32.load offset=4
      local.set 21
      local.get 5
      i32.load
      local.set 22
      local.get 5
      local.get 22
      i32.store offset=16
      local.get 5
      local.get 21
      i32.store offset=20
      i32.const 0
      local.set 23
      local.get 5
      local.get 23
      i32.store offset=24
      local.get 5
      i32.load offset=8
      local.set 24
      local.get 5
      i32.load offset=12
      local.set 25
      i32.const 16
      local.set 26
      local.get 5
      local.get 26
      i32.add
      local.set 27
      local.get 27
      local.set 28
      local.get 28
      local.get 24
      local.get 25
      call $_ZN97_$LT$alloc..vec..Vec$LT$T$C$A$GT$$u20$as$u20$alloc..vec..spec_extend..SpecExtend$LT$T$C$I$GT$$GT$11spec_extend17h341a5e54dda36425E
      local.get 5
      i64.load offset=16 align=4
      local.set 29
      local.get 0
      local.get 29
      i64.store align=4
      i32.const 8
      local.set 30
      local.get 0
      local.get 30
      i32.add
      local.set 31
      i32.const 16
      local.set 32
      local.get 5
      local.get 32
      i32.add
      local.set 33
      local.get 33
      local.get 30
      i32.add
      local.set 34
      local.get 34
      i32.load
      local.set 35
      local.get 31
      local.get 35
      i32.store
      i32.const 96
      local.set 36
      local.get 5
      local.get 36
      i32.add
      local.set 37
      local.get 37
      global.set $__stack_pointer
      return
    end
    i32.const 0
    local.set 38
    i32.const 1
    local.set 39
    local.get 38
    local.get 39
    i32.and
    local.set 40
    block  ;; label = @1
      local.get 40
      br_if 0 (;@1;)
      i32.const 0
      local.set 41
      local.get 5
      local.get 41
      i32.store offset=88
      i32.const 1048596
      local.set 42
      local.get 5
      local.get 42
      i32.store offset=40
      i32.const 1
      local.set 43
      local.get 5
      local.get 43
      i32.store offset=44
      local.get 5
      i32.load offset=88
      local.set 44
      local.get 5
      i32.load offset=92
      local.set 45
      local.get 5
      local.get 44
      i32.store offset=56
      local.get 5
      local.get 45
      i32.store offset=60
      i32.const 1048604
      local.set 46
      local.get 5
      local.get 46
      i32.store offset=48
      i32.const 0
      local.set 47
      local.get 5
      local.get 47
      i32.store offset=52
      i32.const 40
      local.set 48
      local.get 5
      local.get 48
      i32.add
      local.set 49
      local.get 49
      local.set 50
      i32.const 1048700
      local.set 51
      local.get 50
      local.get 51
      call $_ZN4core9panicking9panic_fmt17h14c85a61aa3d538eE
      unreachable
    end
    i32.const 64
    local.set 52
    local.get 5
    local.get 52
    i32.add
    local.set 53
    local.get 53
    local.set 54
    i32.const 1048728
    local.set 55
    i32.const 1
    local.set 56
    local.get 54
    local.get 55
    local.get 56
    call $_ZN4core3fmt9Arguments9new_const17hc20d6a4705f59fffE
    i32.const 64
    local.set 57
    local.get 5
    local.get 57
    i32.add
    local.set 58
    local.get 58
    local.set 59
    i32.const 1048812
    local.set 60
    local.get 59
    local.get 60
    call $_ZN4core9panicking9panic_fmt17h14c85a61aa3d538eE
    unreachable)
  (func $_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$11allocate_in17h72fc51a304adc19aE (type 3) (param i32 i32 i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    local.set 3
    i32.const 96
    local.set 4
    local.get 3
    local.get 4
    i32.sub
    local.set 5
    local.get 5
    global.set $__stack_pointer
    local.get 2
    local.set 6
    local.get 5
    local.get 6
    i32.store8 offset=26
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
          local.get 9
          br_if 0 (;@3;)
          local.get 1
          br_if 1 (;@2;)
        end
        i32.const 1
        local.set 10
        local.get 5
        local.get 10
        i32.store offset=72
        local.get 5
        i32.load offset=72
        local.set 11
        local.get 5
        local.get 11
        i32.store offset=68
        local.get 5
        i32.load offset=68
        local.set 12
        local.get 5
        local.get 12
        i32.store offset=28
        i32.const 0
        local.set 13
        local.get 5
        local.get 13
        i32.store offset=32
        br 1 (;@1;)
      end
      i32.const 1
      local.set 14
      i32.const 16
      local.set 15
      local.get 5
      local.get 15
      i32.add
      local.set 16
      local.get 16
      local.get 14
      local.get 14
      local.get 1
      call $_ZN4core5alloc6layout6Layout5array5inner17hde74f827f47f01deE
      local.get 5
      i32.load offset=16
      local.set 17
      local.get 5
      i32.load offset=20
      local.set 18
      local.get 5
      local.get 18
      i32.store offset=40
      local.get 5
      local.get 17
      i32.store offset=36
      local.get 5
      i32.load offset=36
      local.set 19
      i32.const 1
      local.set 20
      i32.const 0
      local.set 21
      local.get 21
      local.get 20
      local.get 19
      select
      local.set 22
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              local.get 22
              br_if 0 (;@5;)
              local.get 5
              i32.load offset=36
              local.set 23
              local.get 5
              i32.load offset=40
              local.set 24
              i32.const 2147483647
              local.set 25
              local.get 24
              local.set 26
              local.get 25
              local.set 27
              local.get 26
              local.get 27
              i32.gt_u
              local.set 28
              i32.const 1
              local.set 29
              local.get 28
              local.get 29
              i32.and
              local.set 30
              local.get 30
              br_if 2 (;@3;)
              br 1 (;@4;)
            end
            call $_ZN5alloc7raw_vec17capacity_overflow17h6742d6b707f6ebe7E
            unreachable
          end
          i32.const -2147483647
          local.set 31
          local.get 5
          local.get 31
          i32.store offset=44
          br 1 (;@2;)
        end
        i32.const 0
        local.set 32
        local.get 5
        local.get 32
        i32.store offset=84
        local.get 5
        i32.load offset=84
        local.set 33
        local.get 5
        i32.load offset=88
        local.set 34
        local.get 5
        local.get 33
        i32.store offset=76
        local.get 5
        local.get 34
        i32.store offset=80
        local.get 5
        i32.load offset=76
        local.set 35
        local.get 5
        i32.load offset=80
        local.set 36
        local.get 5
        local.get 35
        i32.store offset=44
        local.get 5
        local.get 36
        i32.store offset=48
      end
      local.get 5
      i32.load offset=44
      local.set 37
      i32.const -2147483647
      local.set 38
      local.get 37
      local.set 39
      local.get 38
      local.set 40
      local.get 39
      local.get 40
      i32.eq
      local.set 41
      i32.const 0
      local.set 42
      i32.const 1
      local.set 43
      i32.const 1
      local.set 44
      local.get 41
      local.get 44
      i32.and
      local.set 45
      local.get 42
      local.get 43
      local.get 45
      select
      local.set 46
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              local.get 46
              br_if 0 (;@5;)
              local.get 5
              i32.load8_u offset=26
              local.set 47
              i32.const 1
              local.set 48
              local.get 47
              local.get 48
              i32.and
              local.set 49
              local.get 49
              i32.eqz
              br_if 1 (;@4;)
              br 2 (;@3;)
            end
            call $_ZN5alloc7raw_vec17capacity_overflow17h6742d6b707f6ebe7E
            unreachable
          end
          i32.const 27
          local.set 50
          local.get 5
          local.get 50
          i32.add
          local.set 51
          local.get 5
          local.get 51
          local.get 23
          local.get 24
          call $_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$8allocate17h3e69157076b4a21bE
          local.get 5
          i32.load
          local.set 52
          local.get 5
          i32.load offset=4
          local.set 53
          local.get 5
          local.get 53
          i32.store offset=56
          local.get 5
          local.get 52
          i32.store offset=52
          br 1 (;@2;)
        end
        i32.const 8
        local.set 54
        local.get 5
        local.get 54
        i32.add
        local.set 55
        i32.const 27
        local.set 56
        local.get 5
        local.get 56
        i32.add
        local.set 57
        local.get 55
        local.get 57
        local.get 23
        local.get 24
        call $_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$15allocate_zeroed17hfe62bc75efbfd71cE
        local.get 5
        i32.load offset=8
        local.set 58
        local.get 5
        i32.load offset=12
        local.set 59
        local.get 5
        local.get 59
        i32.store offset=56
        local.get 5
        local.get 58
        i32.store offset=52
      end
      local.get 5
      i32.load offset=52
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
      block  ;; label = @2
        local.get 63
        br_if 0 (;@2;)
        local.get 5
        i32.load offset=52
        local.set 64
        local.get 5
        local.get 64
        i32.store offset=64
        local.get 5
        i32.load offset=64
        local.set 65
        local.get 5
        local.get 65
        i32.store offset=92
        local.get 5
        i32.load offset=92
        local.set 66
        local.get 5
        local.get 66
        i32.store offset=60
        local.get 5
        i32.load offset=60
        local.set 67
        local.get 5
        local.get 67
        i32.store offset=28
        local.get 5
        local.get 1
        i32.store offset=32
        br 1 (;@1;)
      end
      local.get 23
      local.get 24
      call $_ZN5alloc5alloc18handle_alloc_error17h0853c609cdf121f4E
      unreachable
    end
    local.get 5
    i32.load offset=28
    local.set 68
    local.get 5
    i32.load offset=32
    local.set 69
    local.get 0
    local.get 69
    i32.store offset=4
    local.get 0
    local.get 68
    i32.store
    i32.const 96
    local.set 70
    local.get 5
    local.get 70
    i32.add
    local.set 71
    local.get 71
    global.set $__stack_pointer
    return)
  (func $_ZN97_$LT$alloc..vec..Vec$LT$T$C$A$GT$$u20$as$u20$alloc..vec..spec_extend..SpecExtend$LT$T$C$I$GT$$GT$11spec_extend17h341a5e54dda36425E (type 3) (param i32 i32 i32)
    local.get 0
    local.get 1
    local.get 2
    call $_ZN5alloc3vec16Vec$LT$T$C$A$GT$14extend_trusted17h84834286af8af33cE
    return)
  (func $_ZN4core3fmt9Arguments9new_const17hc20d6a4705f59fffE (type 3) (param i32 i32 i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
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
    i32.const 1
    local.set 6
    local.get 2
    local.set 7
    local.get 6
    local.set 8
    local.get 7
    local.get 8
    i32.gt_u
    local.set 9
    i32.const 1
    local.set 10
    local.get 9
    local.get 10
    i32.and
    local.set 11
    block  ;; label = @1
      local.get 11
      br_if 0 (;@1;)
      i32.const 0
      local.set 12
      local.get 5
      local.get 12
      i32.store offset=24
      local.get 0
      local.get 1
      i32.store
      local.get 0
      local.get 2
      i32.store offset=4
      local.get 5
      i32.load offset=24
      local.set 13
      local.get 5
      i32.load offset=28
      local.set 14
      local.get 0
      local.get 13
      i32.store offset=16
      local.get 0
      local.get 14
      i32.store offset=20
      i32.const 1048604
      local.set 15
      local.get 0
      local.get 15
      i32.store offset=8
      i32.const 0
      local.set 16
      local.get 0
      local.get 16
      i32.store offset=12
      i32.const 32
      local.set 17
      local.get 5
      local.get 17
      i32.add
      local.set 18
      local.get 18
      global.set $__stack_pointer
      return
    end
    local.get 5
    local.set 19
    i32.const 1048728
    local.set 20
    i32.const 1
    local.set 21
    local.get 19
    local.get 20
    local.get 21
    call $_ZN4core3fmt9Arguments9new_const17hc20d6a4705f59fffE
    local.get 5
    local.set 22
    i32.const 1048812
    local.set 23
    local.get 22
    local.get 23
    call $_ZN4core9panicking9panic_fmt17h14c85a61aa3d538eE
    unreachable)
  (func $_ZN132_$LT$alloc..vec..Vec$LT$T$C$A$GT$$u20$as$u20$alloc..vec..spec_extend..SpecExtend$LT$$RF$T$C$core..slice..iter..Iter$LT$T$GT$$GT$$GT$11spec_extend17he8259e5e06c7688cE (type 3) (param i32 i32 i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
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
    i32.store offset=4
    local.get 5
    local.get 2
    i32.store offset=8
    local.get 5
    i32.load offset=4
    local.set 6
    local.get 5
    i32.load offset=8
    local.set 7
    local.get 7
    local.get 6
    i32.sub
    local.set 8
    local.get 5
    local.get 8
    i32.store offset=12
    local.get 5
    local.get 6
    i32.store offset=24
    local.get 5
    i32.load offset=12
    local.set 9
    local.get 5
    local.get 9
    i32.store offset=28
    local.get 5
    i32.load offset=24
    local.set 10
    local.get 5
    i32.load offset=28
    local.set 11
    local.get 5
    local.get 10
    i32.store offset=16
    local.get 5
    local.get 11
    i32.store offset=20
    local.get 5
    i32.load offset=16
    local.set 12
    local.get 5
    i32.load offset=20
    local.set 13
    local.get 0
    local.get 13
    call $_ZN5alloc3vec16Vec$LT$T$C$A$GT$7reserve17hb801ab09a80cef1bE
    local.get 0
    i32.load offset=8
    local.set 14
    local.get 0
    i32.load
    local.set 15
    local.get 15
    local.get 14
    i32.add
    local.set 16
    i32.const 0
    local.set 17
    local.get 13
    local.get 17
    i32.shl
    local.set 18
    local.get 16
    local.get 12
    local.get 18
    call $memcpy
    drop
    local.get 0
    i32.load offset=8
    local.set 19
    local.get 19
    local.get 13
    i32.add
    local.set 20
    local.get 0
    local.get 20
    i32.store offset=8
    i32.const 32
    local.set 21
    local.get 5
    local.get 21
    i32.add
    local.set 22
    local.get 22
    global.set $__stack_pointer
    return)
  (func $_ZN5alloc3vec16Vec$LT$T$C$A$GT$7reserve17hb801ab09a80cef1bE (type 0) (param i32 i32)
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
      call $_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$7reserve21do_reserve_and_handle17h50013dd7585d6be0E
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
  (func $_ZN153_$LT$core..result..Result$LT$T$C$F$GT$$u20$as$u20$core..ops..try_trait..FromResidual$LT$core..result..Result$LT$core..convert..Infallible$C$E$GT$$GT$$GT$13from_residual17h0768ec548bd9d79fE (type 4) (param i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    local.set 1
    i32.const 16
    local.set 2
    local.get 1
    local.get 2
    i32.sub
    local.set 3
    i32.const 1
    local.set 4
    local.get 3
    local.get 4
    i32.store8 offset=15
    local.get 3
    i32.load8_u offset=15
    local.set 5
    i32.const 1
    local.set 6
    local.get 5
    local.get 6
    i32.and
    local.set 7
    local.get 7
    return)
  (func $_ZN45_$LT$T$u20$as$u20$alloc..string..ToString$GT$9to_string17hb6bda17ee49bda31E (type 0) (param i32 i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i64 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i64 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    local.set 2
    i32.const 80
    local.set 3
    local.get 2
    local.get 3
    i32.sub
    local.set 4
    local.get 4
    global.set $__stack_pointer
    i32.const 1
    local.set 5
    local.get 4
    local.get 5
    i32.store offset=64
    i32.const 0
    local.set 6
    local.get 4
    local.get 6
    i32.store offset=68
    i32.const 0
    local.set 7
    local.get 4
    local.get 7
    i32.store offset=72
    i32.const 8
    local.set 8
    i32.const 8
    local.set 9
    local.get 4
    local.get 9
    i32.add
    local.set 10
    local.get 10
    local.get 8
    i32.add
    local.set 11
    i32.const 64
    local.set 12
    local.get 4
    local.get 12
    i32.add
    local.set 13
    local.get 13
    local.get 8
    i32.add
    local.set 14
    local.get 14
    i32.load
    local.set 15
    local.get 11
    local.get 15
    i32.store
    local.get 4
    i64.load offset=64 align=4
    local.set 16
    local.get 4
    local.get 16
    i64.store offset=8
    i32.const 24
    local.set 17
    local.get 4
    local.get 17
    i32.add
    local.set 18
    local.get 18
    local.set 19
    i32.const 8
    local.set 20
    local.get 4
    local.get 20
    i32.add
    local.set 21
    local.get 21
    local.set 22
    i32.const 1048828
    local.set 23
    local.get 19
    local.get 22
    local.get 23
    call $_ZN4core3fmt9Formatter3new17h6af65e07b3260355E
    i32.const 24
    local.set 24
    local.get 4
    local.get 24
    i32.add
    local.set 25
    local.get 25
    local.set 26
    local.get 1
    local.get 26
    call $_ZN54_$LT$index..Universe$u20$as$u20$core..fmt..Display$GT$3fmt17h7676d7227ee3d747E
    local.set 27
    i32.const 1
    local.set 28
    local.get 27
    local.get 28
    i32.and
    local.set 29
    local.get 4
    local.get 29
    i32.store8 offset=63
    local.get 4
    i32.load8_u offset=63
    local.set 30
    i32.const 1
    local.set 31
    local.get 30
    local.get 31
    i32.and
    local.set 32
    block  ;; label = @1
      local.get 32
      br_if 0 (;@1;)
      local.get 4
      i64.load offset=8
      local.set 33
      local.get 0
      local.get 33
      i64.store align=4
      i32.const 8
      local.set 34
      local.get 0
      local.get 34
      i32.add
      local.set 35
      i32.const 8
      local.set 36
      local.get 4
      local.get 36
      i32.add
      local.set 37
      local.get 37
      local.get 34
      i32.add
      local.set 38
      local.get 38
      i32.load
      local.set 39
      local.get 35
      local.get 39
      i32.store
      i32.const 80
      local.set 40
      local.get 4
      local.get 40
      i32.add
      local.set 41
      local.get 41
      global.set $__stack_pointer
      return
    end
    i32.const 1048852
    local.set 42
    i32.const 55
    local.set 43
    i32.const 79
    local.set 44
    local.get 4
    local.get 44
    i32.add
    local.set 45
    local.get 45
    local.set 46
    i32.const 1048908
    local.set 47
    i32.const 1049000
    local.set 48
    local.get 42
    local.get 43
    local.get 46
    local.get 47
    local.get 48
    call $_ZN4core6result13unwrap_failed17hc368cb5845aa399dE
    unreachable)
  (func $_ZN54_$LT$index..Universe$u20$as$u20$core..fmt..Display$GT$3fmt17h7676d7227ee3d747E (type 2) (param i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i64 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    local.set 2
    i32.const 176
    local.set 3
    local.get 2
    local.get 3
    i32.sub
    local.set 4
    local.get 4
    global.set $__stack_pointer
    i32.const 24
    local.set 5
    local.get 4
    local.get 5
    i32.add
    local.set 6
    local.get 6
    local.get 0
    call $_ZN5alloc3vec16Vec$LT$T$C$A$GT$8as_slice17hf58bef610c257386E
    local.get 4
    i32.load offset=28
    local.set 7
    local.get 4
    i32.load offset=24
    local.set 8
    local.get 0
    i32.load offset=12
    local.set 9
    i32.const 52
    local.set 10
    local.get 4
    local.get 10
    i32.add
    local.set 11
    local.get 11
    local.set 12
    i32.const 1050044
    local.set 13
    local.get 12
    local.get 8
    local.get 7
    local.get 9
    local.get 13
    call $_ZN4core5slice29_$LT$impl$u20$$u5b$T$u5d$$GT$6chunks17h3d5b5c43ca89da6dE
    i32.const 40
    local.set 14
    local.get 4
    local.get 14
    i32.add
    local.set 15
    local.get 15
    local.set 16
    i32.const 52
    local.set 17
    local.get 4
    local.get 17
    i32.add
    local.set 18
    local.get 18
    local.set 19
    local.get 16
    local.get 19
    call $_ZN63_$LT$I$u20$as$u20$core..iter..traits..collect..IntoIterator$GT$9into_iter17hf1002aae9a2c2681E
    i32.const 8
    local.set 20
    i32.const 64
    local.set 21
    local.get 4
    local.get 21
    i32.add
    local.set 22
    local.get 22
    local.get 20
    i32.add
    local.set 23
    i32.const 40
    local.set 24
    local.get 4
    local.get 24
    i32.add
    local.set 25
    local.get 25
    local.get 20
    i32.add
    local.set 26
    local.get 26
    i32.load
    local.set 27
    local.get 23
    local.get 27
    i32.store
    local.get 4
    i64.load offset=40 align=4
    local.set 28
    local.get 4
    local.get 28
    i64.store offset=64
    block  ;; label = @1
      loop  ;; label = @2
        i32.const 16
        local.set 29
        local.get 4
        local.get 29
        i32.add
        local.set 30
        i32.const 64
        local.set 31
        local.get 4
        local.get 31
        i32.add
        local.set 32
        local.get 30
        local.get 32
        call $_ZN93_$LT$core..slice..iter..Chunks$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17h51255239889b08a6E
        local.get 4
        i32.load offset=16
        local.set 33
        local.get 4
        i32.load offset=20
        local.set 34
        local.get 4
        local.get 34
        i32.store offset=80
        local.get 4
        local.get 33
        i32.store offset=76
        local.get 4
        i32.load offset=76
        local.set 35
        i32.const 0
        local.set 36
        i32.const 1
        local.set 37
        local.get 37
        local.get 36
        local.get 35
        select
        local.set 38
        block  ;; label = @3
          local.get 38
          br_if 0 (;@3;)
          i32.const 0
          local.set 39
          local.get 4
          local.get 39
          i32.store8 offset=39
          br 2 (;@1;)
        end
        local.get 4
        i32.load offset=76
        local.set 40
        local.get 4
        i32.load offset=80
        local.set 41
        i32.const 8
        local.set 42
        local.get 4
        local.get 42
        i32.add
        local.set 43
        local.get 43
        local.get 40
        local.get 41
        call $_ZN4core5slice4iter87_$LT$impl$u20$core..iter..traits..collect..IntoIterator$u20$for$u20$$RF$$u5b$T$u5d$$GT$9into_iter17h2b52094caae78498E
        local.get 4
        i32.load offset=12
        local.set 44
        local.get 4
        i32.load offset=8
        local.set 45
        local.get 4
        local.get 45
        i32.store offset=84
        local.get 4
        local.get 44
        i32.store offset=88
        loop  ;; label = @3
          i32.const 84
          local.set 46
          local.get 4
          local.get 46
          i32.add
          local.set 47
          local.get 47
          local.set 48
          local.get 48
          call $_ZN91_$LT$core..slice..iter..Iter$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17h7476dad7275f695fE
          local.set 49
          local.get 4
          local.get 49
          i32.store offset=92
          local.get 4
          i32.load offset=92
          local.set 50
          i32.const 0
          local.set 51
          i32.const 1
          local.set 52
          local.get 52
          local.get 51
          local.get 50
          select
          local.set 53
          block  ;; label = @4
            block  ;; label = @5
              block  ;; label = @6
                block  ;; label = @7
                  block  ;; label = @8
                    local.get 53
                    br_if 0 (;@8;)
                    i32.const 144
                    local.set 54
                    local.get 4
                    local.get 54
                    i32.add
                    local.set 55
                    local.get 55
                    local.set 56
                    i32.const 1050064
                    local.set 57
                    i32.const 1
                    local.set 58
                    local.get 56
                    local.get 57
                    local.get 58
                    call $_ZN4core3fmt9Arguments9new_const17hc20d6a4705f59fffE
                    i32.const 144
                    local.set 59
                    local.get 4
                    local.get 59
                    i32.add
                    local.set 60
                    local.get 60
                    local.set 61
                    local.get 1
                    local.get 61
                    call $_ZN4core3fmt9Formatter9write_fmt17h9753a560d984b64cE
                    local.set 62
                    i32.const 1
                    local.set 63
                    local.get 62
                    local.get 63
                    i32.and
                    local.set 64
                    local.get 64
                    call $_ZN79_$LT$core..result..Result$LT$T$C$E$GT$$u20$as$u20$core..ops..try_trait..Try$GT$6branch17h8a3a2ca631598309E
                    local.set 65
                    i32.const 1
                    local.set 66
                    local.get 65
                    local.get 66
                    i32.and
                    local.set 67
                    local.get 4
                    local.get 67
                    i32.store8 offset=143
                    local.get 4
                    i32.load8_u offset=143
                    local.set 68
                    i32.const 1
                    local.set 69
                    local.get 68
                    local.get 69
                    i32.and
                    local.set 70
                    local.get 70
                    i32.eqz
                    br_if 6 (;@2;)
                    br 1 (;@7;)
                  end
                  local.get 4
                  i32.load offset=92
                  local.set 71
                  local.get 71
                  i32.load8_u
                  local.set 72
                  i32.const 1
                  local.set 73
                  local.get 72
                  local.get 73
                  i32.and
                  local.set 74
                  local.get 4
                  local.get 74
                  i32.store8 offset=99
                  i32.const 99
                  local.set 75
                  local.get 4
                  local.get 75
                  i32.add
                  local.set 76
                  local.get 76
                  local.set 77
                  i32.const 1050088
                  local.set 78
                  local.get 77
                  local.get 78
                  call $_ZN52_$LT$index..Cell$u20$as$u20$core..cmp..PartialEq$GT$2eq17h986f028f9909c227E
                  local.set 79
                  i32.const 1
                  local.set 80
                  local.get 79
                  local.get 80
                  i32.and
                  local.set 81
                  local.get 81
                  br_if 2 (;@5;)
                  br 1 (;@6;)
                end
                i32.const 1050072
                local.set 82
                local.get 82
                call $_ZN153_$LT$core..result..Result$LT$T$C$F$GT$$u20$as$u20$core..ops..try_trait..FromResidual$LT$core..result..Result$LT$core..convert..Infallible$C$E$GT$$GT$$GT$13from_residual17h0768ec548bd9d79fE
                local.set 83
                i32.const 1
                local.set 84
                local.get 83
                local.get 84
                i32.and
                local.set 85
                local.get 4
                local.get 85
                i32.store8 offset=39
                br 5 (;@1;)
              end
              i32.const 9724
              local.set 86
              local.get 4
              local.get 86
              i32.store offset=100
              br 1 (;@4;)
            end
            i32.const 9723
            local.set 87
            local.get 4
            local.get 87
            i32.store offset=100
          end
          i32.const 100
          local.set 88
          local.get 4
          local.get 88
          i32.add
          local.set 89
          local.get 4
          local.get 89
          i32.store offset=168
          i32.const 1
          local.set 90
          local.get 4
          local.get 90
          i32.store offset=172
          local.get 4
          i32.load offset=168
          local.set 91
          local.get 4
          i32.load offset=172
          local.set 92
          local.get 4
          local.get 91
          i32.store offset=132
          local.get 4
          local.get 92
          i32.store offset=136
          i32.const 108
          local.set 93
          local.get 4
          local.get 93
          i32.add
          local.set 94
          local.get 94
          local.set 95
          i32.const 1050092
          local.set 96
          i32.const 1
          local.set 97
          i32.const 132
          local.set 98
          local.get 4
          local.get 98
          i32.add
          local.set 99
          local.get 99
          local.set 100
          local.get 95
          local.get 96
          local.get 97
          local.get 100
          local.get 97
          call $_ZN4core3fmt9Arguments6new_v117h428008ca3fafacb9E
          i32.const 108
          local.set 101
          local.get 4
          local.get 101
          i32.add
          local.set 102
          local.get 102
          local.set 103
          local.get 1
          local.get 103
          call $_ZN4core3fmt9Formatter9write_fmt17h9753a560d984b64cE
          local.set 104
          i32.const 1
          local.set 105
          local.get 104
          local.get 105
          i32.and
          local.set 106
          local.get 106
          call $_ZN79_$LT$core..result..Result$LT$T$C$E$GT$$u20$as$u20$core..ops..try_trait..Try$GT$6branch17h8a3a2ca631598309E
          local.set 107
          i32.const 1
          local.set 108
          local.get 107
          local.get 108
          i32.and
          local.set 109
          local.get 4
          local.get 109
          i32.store8 offset=107
          local.get 4
          i32.load8_u offset=107
          local.set 110
          i32.const 1
          local.set 111
          local.get 110
          local.get 111
          i32.and
          local.set 112
          local.get 112
          i32.eqz
          br_if 0 (;@3;)
        end
      end
      i32.const 1050100
      local.set 113
      local.get 113
      call $_ZN153_$LT$core..result..Result$LT$T$C$F$GT$$u20$as$u20$core..ops..try_trait..FromResidual$LT$core..result..Result$LT$core..convert..Infallible$C$E$GT$$GT$$GT$13from_residual17h0768ec548bd9d79fE
      local.set 114
      i32.const 1
      local.set 115
      local.get 114
      local.get 115
      i32.and
      local.set 116
      local.get 4
      local.get 116
      i32.store8 offset=39
    end
    local.get 4
    i32.load8_u offset=39
    local.set 117
    i32.const 1
    local.set 118
    local.get 117
    local.get 118
    i32.and
    local.set 119
    i32.const 176
    local.set 120
    local.get 4
    local.get 120
    i32.add
    local.set 121
    local.get 121
    global.set $__stack_pointer
    local.get 119
    return)
  (func $_ZN47_$LT$u32$u20$as$u20$core..iter..range..Step$GT$13steps_between17h50fba028dc6caa02E (type 3) (param i32 i32 i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    local.set 3
    i32.const 16
    local.set 4
    local.get 3
    local.get 4
    i32.sub
    local.set 5
    local.get 1
    i32.load
    local.set 6
    local.get 2
    i32.load
    local.set 7
    local.get 6
    local.set 8
    local.get 7
    local.set 9
    local.get 8
    local.get 9
    i32.le_u
    local.set 10
    i32.const 1
    local.set 11
    local.get 10
    local.get 11
    i32.and
    local.set 12
    block  ;; label = @1
      block  ;; label = @2
        local.get 12
        br_if 0 (;@2;)
        i32.const 0
        local.set 13
        local.get 5
        local.get 13
        i32.store offset=8
        br 1 (;@1;)
      end
      local.get 2
      i32.load
      local.set 14
      local.get 1
      i32.load
      local.set 15
      local.get 14
      local.get 15
      i32.sub
      local.set 16
      local.get 5
      local.get 16
      i32.store offset=12
      i32.const 1
      local.set 17
      local.get 5
      local.get 17
      i32.store offset=8
    end
    local.get 5
    i32.load offset=8
    local.set 18
    local.get 5
    i32.load offset=12
    local.set 19
    local.get 0
    local.get 19
    i32.store offset=4
    local.get 0
    local.get 18
    i32.store
    return)
  (func $_ZN47_$LT$u32$u20$as$u20$core..iter..range..Step$GT$17forward_unchecked17h5c549402a7911c6aE (type 2) (param i32 i32) (result i32)
    (local i32)
    local.get 0
    local.get 1
    i32.add
    local.set 2
    local.get 2
    return)
  (func $_ZN4core3cmp5impls50_$LT$impl$u20$core..cmp..Ord$u20$for$u20$usize$GT$3cmp17h58aee2a32d7d5fa8E (type 2) (param i32 i32) (result i32)
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
  (func $_ZN4core3cmp6max_by17hcb9c71ffbd8edb51E (type 2) (param i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
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
    i32.store offset=4
    local.get 4
    local.get 1
    i32.store offset=8
    i32.const 1
    local.set 5
    local.get 4
    local.get 5
    i32.store8 offset=31
    local.get 4
    local.get 5
    i32.store8 offset=30
    i32.const 4
    local.set 6
    local.get 4
    local.get 6
    i32.add
    local.set 7
    local.get 4
    local.get 7
    i32.store offset=20
    i32.const 8
    local.set 8
    local.get 4
    local.get 8
    i32.add
    local.set 9
    local.get 4
    local.get 9
    i32.store offset=24
    local.get 4
    i32.load offset=20
    local.set 10
    local.get 4
    i32.load offset=24
    local.set 11
    local.get 10
    local.get 11
    call $_ZN4core3ops8function6FnOnce9call_once17h12346e7351a3b12dE
    local.set 12
    local.get 4
    local.get 12
    i32.store8 offset=19
    local.get 4
    i32.load8_u offset=19
    local.set 13
    local.get 13
    local.get 5
    i32.add
    local.set 14
    i32.const 255
    local.set 15
    local.get 14
    local.get 15
    i32.and
    local.set 16
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          local.get 16
          br_table 0 (;@3;) 0 (;@3;) 1 (;@2;) 0 (;@3;)
        end
        i32.const 0
        local.set 17
        local.get 4
        local.get 17
        i32.store8 offset=30
        local.get 4
        i32.load offset=8
        local.set 18
        local.get 4
        local.get 18
        i32.store offset=12
        br 1 (;@1;)
      end
      i32.const 0
      local.set 19
      local.get 4
      local.get 19
      i32.store8 offset=31
      local.get 4
      i32.load offset=4
      local.set 20
      local.get 4
      local.get 20
      i32.store offset=12
    end
    local.get 4
    i32.load8_u offset=30
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
    local.get 4
    i32.load8_u offset=31
    local.set 24
    i32.const 1
    local.set 25
    local.get 24
    local.get 25
    i32.and
    local.set 26
    block  ;; label = @1
      local.get 26
      i32.eqz
      br_if 0 (;@1;)
    end
    local.get 4
    i32.load offset=12
    local.set 27
    i32.const 32
    local.set 28
    local.get 4
    local.get 28
    i32.add
    local.set 29
    local.get 29
    global.set $__stack_pointer
    local.get 27
    return
    unreachable)
  (func $_ZN4core3ops8function6FnOnce9call_once17h12346e7351a3b12dE (type 2) (param i32 i32) (result i32)
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
    call $_ZN4core3cmp5impls50_$LT$impl$u20$core..cmp..Ord$u20$for$u20$usize$GT$3cmp17h58aee2a32d7d5fa8E
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
  (func $_ZN4core3cmp6min_by17h49e049503750c28bE (type 2) (param i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
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
    i32.store offset=4
    local.get 4
    local.get 1
    i32.store offset=8
    i32.const 1
    local.set 5
    local.get 4
    local.get 5
    i32.store8 offset=31
    local.get 4
    local.get 5
    i32.store8 offset=30
    i32.const 4
    local.set 6
    local.get 4
    local.get 6
    i32.add
    local.set 7
    local.get 4
    local.get 7
    i32.store offset=20
    i32.const 8
    local.set 8
    local.get 4
    local.get 8
    i32.add
    local.set 9
    local.get 4
    local.get 9
    i32.store offset=24
    local.get 4
    i32.load offset=20
    local.set 10
    local.get 4
    i32.load offset=24
    local.set 11
    local.get 10
    local.get 11
    call $_ZN4core3ops8function6FnOnce9call_once17h12346e7351a3b12dE
    local.set 12
    local.get 4
    local.get 12
    i32.store8 offset=19
    local.get 4
    i32.load8_u offset=19
    local.set 13
    local.get 13
    local.get 5
    i32.add
    local.set 14
    i32.const 255
    local.set 15
    local.get 14
    local.get 15
    i32.and
    local.set 16
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          local.get 16
          br_table 0 (;@3;) 0 (;@3;) 1 (;@2;) 0 (;@3;)
        end
        i32.const 0
        local.set 17
        local.get 4
        local.get 17
        i32.store8 offset=31
        local.get 4
        i32.load offset=4
        local.set 18
        local.get 4
        local.get 18
        i32.store offset=12
        br 1 (;@1;)
      end
      i32.const 0
      local.set 19
      local.get 4
      local.get 19
      i32.store8 offset=30
      local.get 4
      i32.load offset=8
      local.set 20
      local.get 4
      local.get 20
      i32.store offset=12
    end
    local.get 4
    i32.load8_u offset=30
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
    local.get 4
    i32.load8_u offset=31
    local.set 24
    i32.const 1
    local.set 25
    local.get 24
    local.get 25
    i32.and
    local.set 26
    block  ;; label = @1
      local.get 26
      i32.eqz
      br_if 0 (;@1;)
    end
    local.get 4
    i32.load offset=12
    local.set 27
    i32.const 32
    local.set 28
    local.get 4
    local.get 28
    i32.add
    local.set 29
    local.get 29
    global.set $__stack_pointer
    local.get 27
    return
    unreachable)
  (func $_ZN4core3fmt5Write9write_fmt17he4c4efce63cb8009E (type 2) (param i32 i32) (result i32)
    (local i32 i32 i32)
    local.get 0
    local.get 1
    call $_ZN75_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write..write_fmt..SpecWriteFmt$GT$14spec_write_fmt17h6e789f577b89103fE
    local.set 2
    i32.const 1
    local.set 3
    local.get 2
    local.get 3
    i32.and
    local.set 4
    local.get 4
    return)
  (func $_ZN75_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write..write_fmt..SpecWriteFmt$GT$14spec_write_fmt17h6e789f577b89103fE (type 2) (param i32 i32) (result i32)
    (local i32 i32 i32 i32)
    i32.const 1048828
    local.set 2
    local.get 0
    local.get 2
    local.get 1
    call $_ZN4core3fmt5write17h362bec5724a70484E
    local.set 3
    i32.const 1
    local.set 4
    local.get 3
    local.get 4
    i32.and
    local.set 5
    local.get 5
    return)
  (func $_ZN4core3fmt9Arguments6new_v117h428008ca3fafacb9E (type 6) (param i32 i32 i32 i32 i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    local.set 5
    i32.const 48
    local.set 6
    local.get 5
    local.get 6
    i32.sub
    local.set 7
    local.get 7
    global.set $__stack_pointer
    local.get 2
    local.set 8
    local.get 4
    local.set 9
    local.get 8
    local.get 9
    i32.lt_u
    local.set 10
    i32.const 1
    local.set 11
    local.get 10
    local.get 11
    i32.and
    local.set 12
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          local.get 12
          br_if 0 (;@3;)
          i32.const 1
          local.set 13
          local.get 4
          local.get 13
          i32.add
          local.set 14
          local.get 2
          local.set 15
          local.get 14
          local.set 16
          local.get 15
          local.get 16
          i32.gt_u
          local.set 17
          i32.const 1
          local.set 18
          local.get 17
          local.get 18
          i32.and
          local.set 19
          local.get 19
          br_if 2 (;@1;)
          br 1 (;@2;)
        end
        br 1 (;@1;)
      end
      i32.const 0
      local.set 20
      local.get 7
      local.get 20
      i32.store offset=32
      local.get 0
      local.get 1
      i32.store
      local.get 0
      local.get 2
      i32.store offset=4
      local.get 7
      i32.load offset=32
      local.set 21
      local.get 7
      i32.load offset=36
      local.set 22
      local.get 0
      local.get 21
      i32.store offset=16
      local.get 0
      local.get 22
      i32.store offset=20
      local.get 0
      local.get 3
      i32.store offset=8
      local.get 0
      local.get 4
      i32.store offset=12
      i32.const 48
      local.set 23
      local.get 7
      local.get 23
      i32.add
      local.set 24
      local.get 24
      global.set $__stack_pointer
      return
    end
    i32.const 0
    local.set 25
    local.get 7
    local.get 25
    i32.store offset=40
    i32.const 1048728
    local.set 26
    local.get 7
    local.get 26
    i32.store offset=8
    i32.const 1
    local.set 27
    local.get 7
    local.get 27
    i32.store offset=12
    local.get 7
    i32.load offset=40
    local.set 28
    local.get 7
    i32.load offset=44
    local.set 29
    local.get 7
    local.get 28
    i32.store offset=24
    local.get 7
    local.get 29
    i32.store offset=28
    i32.const 1048604
    local.set 30
    local.get 7
    local.get 30
    i32.store offset=16
    i32.const 0
    local.set 31
    local.get 7
    local.get 31
    i32.store offset=20
    i32.const 8
    local.set 32
    local.get 7
    local.get 32
    i32.add
    local.set 33
    local.get 33
    local.set 34
    i32.const 1049016
    local.set 35
    local.get 34
    local.get 35
    call $_ZN4core9panicking9panic_fmt17h14c85a61aa3d538eE
    unreachable)
  (func $_ZN4core3ptr232drop_in_place$LT$alloc..vec..Vec$LT$index..Cell$GT$..extend_trusted$LT$core..iter..adapters..map..Map$LT$core..ops..range..Range$LT$u32$GT$$C$index..Universe..new..$u7b$$u7b$closure$u7d$$u7d$$GT$$GT$..$u7b$$u7b$closure$u7d$$u7d$$GT$17hef06c7cdca480da7E (type 7) (param i32)
    local.get 0
    call $_ZN4core3ptr62drop_in_place$LT$alloc..vec..set_len_on_drop..SetLenOnDrop$GT$17hc7da027bf3a57578E
    return)
  (func $_ZN4core3ptr62drop_in_place$LT$alloc..vec..set_len_on_drop..SetLenOnDrop$GT$17hc7da027bf3a57578E (type 7) (param i32)
    local.get 0
    call $_ZN83_$LT$alloc..vec..set_len_on_drop..SetLenOnDrop$u20$as$u20$core..ops..drop..Drop$GT$4drop17ha6ea0093e8de25feE
    return)
  (func $_ZN4core3ptr337drop_in_place$LT$core..iter..traits..iterator..Iterator..for_each..call$LT$index..Cell$C$alloc..vec..Vec$LT$index..Cell$GT$..extend_trusted$LT$core..iter..adapters..map..Map$LT$core..ops..range..Range$LT$u32$GT$$C$index..Universe..new..$u7b$$u7b$closure$u7d$$u7d$$GT$$GT$..$u7b$$u7b$closure$u7d$$u7d$$GT$..$u7b$$u7b$closure$u7d$$u7d$$GT$17hc6e3189f69a88f26E (type 7) (param i32)
    local.get 0
    call $_ZN4core3ptr232drop_in_place$LT$alloc..vec..Vec$LT$index..Cell$GT$..extend_trusted$LT$core..iter..adapters..map..Map$LT$core..ops..range..Range$LT$u32$GT$$C$index..Universe..new..$u7b$$u7b$closure$u7d$$u7d$$GT$$GT$..$u7b$$u7b$closure$u7d$$u7d$$GT$17hef06c7cdca480da7E
    return)
  (func $_ZN4core3ptr37drop_in_place$LT$core..fmt..Error$GT$17h3320a8636f572fa7E (type 7) (param i32)
    return)
  (func $_ZN4core3ptr42drop_in_place$LT$alloc..string..String$GT$17h74d38b69f88484d8E (type 7) (param i32)
    local.get 0
    call $_ZN4core3ptr46drop_in_place$LT$alloc..vec..Vec$LT$u8$GT$$GT$17hbad5bc2a916b47fcE
    return)
  (func $_ZN4core3ptr46drop_in_place$LT$alloc..vec..Vec$LT$u8$GT$$GT$17hbad5bc2a916b47fcE (type 7) (param i32)
    local.get 0
    call $_ZN70_$LT$alloc..vec..Vec$LT$T$C$A$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17h665033f981da57bdE
    local.get 0
    call $_ZN4core3ptr53drop_in_place$LT$alloc..raw_vec..RawVec$LT$u8$GT$$GT$17h2f429599acfc77f8E
    return)
  (func $_ZN70_$LT$alloc..vec..Vec$LT$T$C$A$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17h665033f981da57bdE (type 7) (param i32)
    (local i32 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    local.set 1
    i32.const 16
    local.set 2
    local.get 1
    local.get 2
    i32.sub
    local.set 3
    local.get 0
    i32.load
    local.set 4
    local.get 0
    i32.load offset=8
    local.set 5
    local.get 3
    local.get 4
    i32.store offset=8
    local.get 3
    local.get 5
    i32.store offset=12
    local.get 3
    i32.load offset=8
    local.set 6
    local.get 3
    i32.load offset=12
    local.set 7
    local.get 3
    local.get 6
    i32.store
    local.get 3
    local.get 7
    i32.store offset=4
    return)
  (func $_ZN4core3ptr53drop_in_place$LT$alloc..raw_vec..RawVec$LT$u8$GT$$GT$17h2f429599acfc77f8E (type 7) (param i32)
    local.get 0
    call $_ZN77_$LT$alloc..raw_vec..RawVec$LT$T$C$A$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17hd616b02d3d3d5238E
    return)
  (func $_ZN4core3ptr492drop_in_place$LT$core..iter..adapters..map..map_fold$LT$u32$C$index..Cell$C$$LP$$RP$$C$index..Universe..new..$u7b$$u7b$closure$u7d$$u7d$$C$core..iter..traits..iterator..Iterator..for_each..call$LT$index..Cell$C$alloc..vec..Vec$LT$index..Cell$GT$..extend_trusted$LT$core..iter..adapters..map..Map$LT$core..ops..range..Range$LT$u32$GT$$C$index..Universe..new..$u7b$$u7b$closure$u7d$$u7d$$GT$$GT$..$u7b$$u7b$closure$u7d$$u7d$$GT$..$u7b$$u7b$closure$u7d$$u7d$$GT$..$u7b$$u7b$closure$u7d$$u7d$$GT$17hcbe4b66420d1e594E (type 7) (param i32)
    local.get 0
    call $_ZN4core3ptr337drop_in_place$LT$core..iter..traits..iterator..Iterator..for_each..call$LT$index..Cell$C$alloc..vec..Vec$LT$index..Cell$GT$..extend_trusted$LT$core..iter..adapters..map..Map$LT$core..ops..range..Range$LT$u32$GT$$C$index..Universe..new..$u7b$$u7b$closure$u7d$$u7d$$GT$$GT$..$u7b$$u7b$closure$u7d$$u7d$$GT$..$u7b$$u7b$closure$u7d$$u7d$$GT$17hc6e3189f69a88f26E
    return)
  (func $_ZN77_$LT$alloc..raw_vec..RawVec$LT$T$C$A$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17hd616b02d3d3d5238E (type 7) (param i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
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
    i32.const 4
    local.set 4
    local.get 3
    local.get 4
    i32.add
    local.set 5
    local.get 5
    local.set 6
    local.get 6
    local.get 0
    call $_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$14current_memory17ha4b462c499445094E
    local.get 3
    i32.load offset=8
    local.set 7
    i32.const 0
    local.set 8
    i32.const 1
    local.set 9
    local.get 9
    local.get 8
    local.get 7
    select
    local.set 10
    i32.const 1
    local.set 11
    local.get 10
    local.set 12
    local.get 11
    local.set 13
    local.get 12
    local.get 13
    i32.eq
    local.set 14
    i32.const 1
    local.set 15
    local.get 14
    local.get 15
    i32.and
    local.set 16
    block  ;; label = @1
      local.get 16
      i32.eqz
      br_if 0 (;@1;)
      local.get 3
      i32.load offset=4
      local.set 17
      local.get 3
      i32.load offset=8
      local.set 18
      local.get 3
      i32.load offset=12
      local.set 19
      i32.const 8
      local.set 20
      local.get 0
      local.get 20
      i32.add
      local.set 21
      local.get 21
      local.get 17
      local.get 18
      local.get 19
      call $_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17haebe2a7e43aecc52E
    end
    i32.const 16
    local.set 22
    local.get 3
    local.get 22
    i32.add
    local.set 23
    local.get 23
    global.set $__stack_pointer
    return)
  (func $_ZN4core3ptr55drop_in_place$LT$alloc..vec..Vec$LT$index..Cell$GT$$GT$17h7e423565a133bf60E (type 7) (param i32)
    local.get 0
    call $_ZN70_$LT$alloc..vec..Vec$LT$T$C$A$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17h9b062bee7d6e5bb1E
    local.get 0
    call $_ZN4core3ptr62drop_in_place$LT$alloc..raw_vec..RawVec$LT$index..Cell$GT$$GT$17h60bb2f556d071f26E
    return)
  (func $_ZN70_$LT$alloc..vec..Vec$LT$T$C$A$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17h9b062bee7d6e5bb1E (type 7) (param i32)
    (local i32 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    local.set 1
    i32.const 16
    local.set 2
    local.get 1
    local.get 2
    i32.sub
    local.set 3
    local.get 0
    i32.load
    local.set 4
    local.get 0
    i32.load offset=8
    local.set 5
    local.get 3
    local.get 4
    i32.store offset=8
    local.get 3
    local.get 5
    i32.store offset=12
    local.get 3
    i32.load offset=8
    local.set 6
    local.get 3
    i32.load offset=12
    local.set 7
    local.get 3
    local.get 6
    i32.store
    local.get 3
    local.get 7
    i32.store offset=4
    return)
  (func $_ZN4core3ptr62drop_in_place$LT$alloc..raw_vec..RawVec$LT$index..Cell$GT$$GT$17h60bb2f556d071f26E (type 7) (param i32)
    local.get 0
    call $_ZN77_$LT$alloc..raw_vec..RawVec$LT$T$C$A$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17h3b75a7d5aa86b4edE
    return)
  (func $_ZN77_$LT$alloc..raw_vec..RawVec$LT$T$C$A$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17h3b75a7d5aa86b4edE (type 7) (param i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
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
    i32.const 4
    local.set 4
    local.get 3
    local.get 4
    i32.add
    local.set 5
    local.get 5
    local.set 6
    local.get 6
    local.get 0
    call $_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$14current_memory17ha73de0fe0a34a4bcE
    local.get 3
    i32.load offset=8
    local.set 7
    i32.const 0
    local.set 8
    i32.const 1
    local.set 9
    local.get 9
    local.get 8
    local.get 7
    select
    local.set 10
    i32.const 1
    local.set 11
    local.get 10
    local.set 12
    local.get 11
    local.set 13
    local.get 12
    local.get 13
    i32.eq
    local.set 14
    i32.const 1
    local.set 15
    local.get 14
    local.get 15
    i32.and
    local.set 16
    block  ;; label = @1
      local.get 16
      i32.eqz
      br_if 0 (;@1;)
      local.get 3
      i32.load offset=4
      local.set 17
      local.get 3
      i32.load offset=8
      local.set 18
      local.get 3
      i32.load offset=12
      local.set 19
      i32.const 8
      local.set 20
      local.get 0
      local.get 20
      i32.add
      local.set 21
      local.get 21
      local.get 17
      local.get 18
      local.get 19
      call $_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17haebe2a7e43aecc52E
    end
    i32.const 16
    local.set 22
    local.get 3
    local.get 22
    i32.add
    local.set 23
    local.get 23
    global.set $__stack_pointer
    return)
  (func $_ZN83_$LT$alloc..vec..set_len_on_drop..SetLenOnDrop$u20$as$u20$core..ops..drop..Drop$GT$4drop17ha6ea0093e8de25feE (type 7) (param i32)
    (local i32 i32)
    local.get 0
    i32.load offset=4
    local.set 1
    local.get 0
    i32.load
    local.set 2
    local.get 2
    local.get 1
    i32.store
    return)
  (func $_ZN4core4char7methods15encode_utf8_raw17h91b144acde76a0faE (type 8) (param i32 i32 i32 i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    local.set 4
    i32.const 112
    local.set 5
    local.get 4
    local.get 5
    i32.sub
    local.set 6
    local.get 6
    global.set $__stack_pointer
    local.get 6
    local.get 1
    i32.store offset=20
    local.get 6
    i32.load offset=20
    local.set 7
    i32.const 128
    local.set 8
    local.get 7
    local.set 9
    local.get 8
    local.set 10
    local.get 9
    local.get 10
    i32.lt_u
    local.set 11
    i32.const 1
    local.set 12
    local.get 11
    local.get 12
    i32.and
    local.set 13
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              block  ;; label = @6
                block  ;; label = @7
                  block  ;; label = @8
                    local.get 13
                    br_if 0 (;@8;)
                    i32.const 2048
                    local.set 14
                    local.get 7
                    local.set 15
                    local.get 14
                    local.set 16
                    local.get 15
                    local.get 16
                    i32.lt_u
                    local.set 17
                    i32.const 1
                    local.set 18
                    local.get 17
                    local.get 18
                    i32.and
                    local.set 19
                    local.get 19
                    br_if 2 (;@6;)
                    br 1 (;@7;)
                  end
                  i32.const 1
                  local.set 20
                  local.get 6
                  local.get 20
                  i32.store offset=24
                  br 6 (;@1;)
                end
                i32.const 65536
                local.set 21
                local.get 7
                local.set 22
                local.get 21
                local.set 23
                local.get 22
                local.get 23
                i32.lt_u
                local.set 24
                i32.const 1
                local.set 25
                local.get 24
                local.get 25
                i32.and
                local.set 26
                local.get 26
                br_if 2 (;@4;)
                br 1 (;@5;)
              end
              i32.const 2
              local.set 27
              local.get 6
              local.get 27
              i32.store offset=24
              br 3 (;@2;)
            end
            i32.const 4
            local.set 28
            local.get 6
            local.get 28
            i32.store offset=24
            br 1 (;@3;)
          end
          i32.const 3
          local.set 29
          local.get 6
          local.get 29
          i32.store offset=24
        end
      end
    end
    local.get 6
    i32.load offset=24
    local.set 30
    i32.const -1
    local.set 31
    local.get 30
    local.get 31
    i32.add
    local.set 32
    i32.const 3
    local.set 33
    local.get 32
    local.get 33
    i32.gt_u
    drop
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              block  ;; label = @6
                block  ;; label = @7
                  block  ;; label = @8
                    block  ;; label = @9
                      block  ;; label = @10
                        local.get 32
                        br_table 0 (;@10;) 1 (;@9;) 2 (;@8;) 3 (;@7;) 9 (;@1;)
                      end
                      i32.const 1
                      local.set 34
                      local.get 3
                      local.set 35
                      local.get 34
                      local.set 36
                      local.get 35
                      local.get 36
                      i32.ge_u
                      local.set 37
                      i32.const 1
                      local.set 38
                      local.get 37
                      local.get 38
                      i32.and
                      local.set 39
                      local.get 39
                      br_if 3 (;@6;)
                      br 8 (;@1;)
                    end
                    i32.const 2
                    local.set 40
                    local.get 3
                    local.set 41
                    local.get 40
                    local.set 42
                    local.get 41
                    local.get 42
                    i32.ge_u
                    local.set 43
                    i32.const 1
                    local.set 44
                    local.get 43
                    local.get 44
                    i32.and
                    local.set 45
                    local.get 45
                    br_if 3 (;@5;)
                    br 7 (;@1;)
                  end
                  i32.const 3
                  local.set 46
                  local.get 3
                  local.set 47
                  local.get 46
                  local.set 48
                  local.get 47
                  local.get 48
                  i32.ge_u
                  local.set 49
                  i32.const 1
                  local.set 50
                  local.get 49
                  local.get 50
                  i32.and
                  local.set 51
                  local.get 51
                  br_if 3 (;@4;)
                  br 6 (;@1;)
                end
                i32.const 4
                local.set 52
                local.get 3
                local.set 53
                local.get 52
                local.set 54
                local.get 53
                local.get 54
                i32.ge_u
                local.set 55
                i32.const 1
                local.set 56
                local.get 55
                local.get 56
                i32.and
                local.set 57
                local.get 57
                br_if 3 (;@3;)
                br 5 (;@1;)
              end
              local.get 6
              i32.load offset=20
              local.set 58
              local.get 2
              local.get 58
              i32.store8
              br 3 (;@2;)
            end
            local.get 6
            i32.load offset=20
            local.set 59
            i32.const 6
            local.set 60
            local.get 59
            local.get 60
            i32.shr_u
            local.set 61
            i32.const 31
            local.set 62
            local.get 61
            local.get 62
            i32.and
            local.set 63
            i32.const 192
            local.set 64
            local.get 63
            local.get 64
            i32.or
            local.set 65
            local.get 2
            local.get 65
            i32.store8
            local.get 6
            i32.load8_u offset=20
            local.set 66
            i32.const 63
            local.set 67
            local.get 66
            local.get 67
            i32.and
            local.set 68
            i32.const -128
            local.set 69
            local.get 68
            local.get 69
            i32.or
            local.set 70
            local.get 2
            local.get 70
            i32.store8 offset=1
            br 2 (;@2;)
          end
          local.get 6
          i32.load offset=20
          local.set 71
          i32.const 12
          local.set 72
          local.get 71
          local.get 72
          i32.shr_u
          local.set 73
          i32.const 15
          local.set 74
          local.get 73
          local.get 74
          i32.and
          local.set 75
          i32.const 224
          local.set 76
          local.get 75
          local.get 76
          i32.or
          local.set 77
          local.get 2
          local.get 77
          i32.store8
          local.get 6
          i32.load offset=20
          local.set 78
          i32.const 6
          local.set 79
          local.get 78
          local.get 79
          i32.shr_u
          local.set 80
          i32.const 63
          local.set 81
          local.get 80
          local.get 81
          i32.and
          local.set 82
          i32.const 128
          local.set 83
          local.get 82
          local.get 83
          i32.or
          local.set 84
          local.get 2
          local.get 84
          i32.store8 offset=1
          local.get 6
          i32.load8_u offset=20
          local.set 85
          local.get 85
          local.get 81
          i32.and
          local.set 86
          i32.const -128
          local.set 87
          local.get 86
          local.get 87
          i32.or
          local.set 88
          local.get 2
          local.get 88
          i32.store8 offset=2
          br 1 (;@2;)
        end
        local.get 6
        i32.load offset=20
        local.set 89
        i32.const 18
        local.set 90
        local.get 89
        local.get 90
        i32.shr_u
        local.set 91
        i32.const 7
        local.set 92
        local.get 91
        local.get 92
        i32.and
        local.set 93
        i32.const 240
        local.set 94
        local.get 93
        local.get 94
        i32.or
        local.set 95
        local.get 2
        local.get 95
        i32.store8
        local.get 6
        i32.load offset=20
        local.set 96
        i32.const 12
        local.set 97
        local.get 96
        local.get 97
        i32.shr_u
        local.set 98
        i32.const 63
        local.set 99
        local.get 98
        local.get 99
        i32.and
        local.set 100
        i32.const 128
        local.set 101
        local.get 100
        local.get 101
        i32.or
        local.set 102
        local.get 2
        local.get 102
        i32.store8 offset=1
        local.get 6
        i32.load offset=20
        local.set 103
        i32.const 6
        local.set 104
        local.get 103
        local.get 104
        i32.shr_u
        local.set 105
        local.get 105
        local.get 99
        i32.and
        local.set 106
        local.get 106
        local.get 101
        i32.or
        local.set 107
        local.get 2
        local.get 107
        i32.store8 offset=2
        local.get 6
        i32.load8_u offset=20
        local.set 108
        local.get 108
        local.get 99
        i32.and
        local.set 109
        i32.const -128
        local.set 110
        local.get 109
        local.get 110
        i32.or
        local.set 111
        local.get 2
        local.get 111
        i32.store8 offset=3
      end
      local.get 6
      i32.load offset=24
      local.set 112
      i32.const 0
      local.set 113
      local.get 6
      local.get 113
      i32.store offset=104
      local.get 6
      local.get 112
      i32.store offset=108
      local.get 6
      i32.load offset=104
      local.set 114
      local.get 6
      i32.load offset=108
      local.set 115
      i32.const 1049112
      local.set 116
      i32.const 8
      local.set 117
      local.get 6
      local.get 117
      i32.add
      local.set 118
      local.get 118
      local.get 114
      local.get 115
      local.get 2
      local.get 3
      local.get 116
      call $_ZN106_$LT$core..ops..range..Range$LT$usize$GT$$u20$as$u20$core..slice..index..SliceIndex$LT$$u5b$T$u5d$$GT$$GT$9index_mut17h81ed307bba01b2a8E
      local.get 6
      i32.load offset=8
      local.set 119
      local.get 6
      i32.load offset=12
      local.set 120
      local.get 0
      local.get 120
      i32.store offset=4
      local.get 0
      local.get 119
      i32.store
      i32.const 112
      local.set 121
      local.get 6
      local.get 121
      i32.add
      local.set 122
      local.get 122
      global.set $__stack_pointer
      return
    end
    i32.const 24
    local.set 123
    local.get 6
    local.get 123
    i32.add
    local.set 124
    local.get 124
    local.set 125
    local.get 6
    local.get 125
    i32.store offset=76
    i32.const 2
    local.set 126
    local.get 6
    local.get 126
    i32.store offset=80
    i32.const 20
    local.set 127
    local.get 6
    local.get 127
    i32.add
    local.set 128
    local.get 128
    local.set 129
    local.get 6
    local.get 129
    i32.store offset=84
    i32.const 3
    local.set 130
    local.get 6
    local.get 130
    i32.store offset=88
    local.get 6
    local.get 3
    i32.store offset=100
    i32.const 100
    local.set 131
    local.get 6
    local.get 131
    i32.add
    local.set 132
    local.get 132
    local.set 133
    local.get 6
    local.get 133
    i32.store offset=92
    i32.const 2
    local.set 134
    local.get 6
    local.get 134
    i32.store offset=96
    local.get 6
    i32.load offset=76
    local.set 135
    local.get 6
    i32.load offset=80
    local.set 136
    local.get 6
    local.get 135
    i32.store offset=52
    local.get 6
    local.get 136
    i32.store offset=56
    local.get 6
    i32.load offset=84
    local.set 137
    local.get 6
    i32.load offset=88
    local.set 138
    local.get 6
    local.get 137
    i32.store offset=60
    local.get 6
    local.get 138
    i32.store offset=64
    local.get 6
    i32.load offset=92
    local.set 139
    local.get 6
    i32.load offset=96
    local.set 140
    local.get 6
    local.get 139
    i32.store offset=68
    local.get 6
    local.get 140
    i32.store offset=72
    i32.const 28
    local.set 141
    local.get 6
    local.get 141
    i32.add
    local.set 142
    local.get 142
    local.set 143
    i32.const 1049188
    local.set 144
    i32.const 3
    local.set 145
    i32.const 52
    local.set 146
    local.get 6
    local.get 146
    i32.add
    local.set 147
    local.get 147
    local.set 148
    local.get 143
    local.get 144
    local.get 145
    local.get 148
    local.get 145
    call $_ZN4core3fmt9Arguments6new_v117h428008ca3fafacb9E
    i32.const 28
    local.set 149
    local.get 6
    local.get 149
    i32.add
    local.set 150
    local.get 150
    local.set 151
    i32.const 1049212
    local.set 152
    local.get 151
    local.get 152
    call $_ZN4core9panicking9panic_fmt17h14c85a61aa3d538eE
    unreachable)
  (func $_ZN4core4iter5range101_$LT$impl$u20$core..iter..traits..iterator..Iterator$u20$for$u20$core..ops..range..Range$LT$A$GT$$GT$4next17hb8a5ddf94a022688E (type 0) (param i32 i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32)
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
    i32.const 8
    local.set 5
    local.get 4
    local.get 5
    i32.add
    local.set 6
    local.get 6
    local.get 1
    call $_ZN89_$LT$core..ops..range..Range$LT$T$GT$$u20$as$u20$core..iter..range..RangeIteratorImpl$GT$9spec_next17h2ccfe74e6d393a7eE
    local.get 4
    i32.load offset=8
    local.set 7
    local.get 4
    i32.load offset=12
    local.set 8
    local.get 0
    local.get 8
    i32.store offset=4
    local.get 0
    local.get 7
    i32.store
    i32.const 16
    local.set 9
    local.get 4
    local.get 9
    i32.add
    local.set 10
    local.get 10
    global.set $__stack_pointer
    return)
  (func $_ZN89_$LT$core..ops..range..Range$LT$T$GT$$u20$as$u20$core..iter..range..RangeIteratorImpl$GT$9spec_next17h2ccfe74e6d393a7eE (type 0) (param i32 i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
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
    i32.load
    local.set 5
    local.get 1
    i32.load offset=4
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
        local.get 11
        br_if 0 (;@2;)
        i32.const 0
        local.set 12
        local.get 4
        local.get 12
        i32.store offset=8
        br 1 (;@1;)
      end
      local.get 1
      i32.load
      local.set 13
      i32.const 1
      local.set 14
      local.get 13
      local.get 14
      call $_ZN47_$LT$u32$u20$as$u20$core..iter..range..Step$GT$17forward_unchecked17h5c549402a7911c6aE
      local.set 15
      local.get 1
      local.get 15
      i32.store
      local.get 4
      local.get 13
      i32.store offset=12
      i32.const 1
      local.set 16
      local.get 4
      local.get 16
      i32.store offset=8
    end
    local.get 4
    i32.load offset=8
    local.set 17
    local.get 4
    i32.load offset=12
    local.set 18
    local.get 0
    local.get 18
    i32.store offset=4
    local.get 0
    local.get 17
    i32.store
    i32.const 16
    local.set 19
    local.get 4
    local.get 19
    i32.add
    local.set 20
    local.get 20
    global.set $__stack_pointer
    return)
  (func $_ZN4core4iter6traits8iterator8Iterator3map17h6424cf1e29a4fd28E (type 3) (param i32 i32 i32)
    (local i32 i32 i32 i32 i32)
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
    i32.store offset=8
    local.get 5
    local.get 2
    i32.store offset=12
    local.get 5
    i32.load offset=8
    local.set 6
    local.get 5
    i32.load offset=12
    local.set 7
    local.get 0
    local.get 7
    i32.store offset=4
    local.get 0
    local.get 6
    i32.store
    return)
  (func $_ZN4core4iter8adapters3map8map_fold28_$u7b$$u7b$closure$u7d$$u7d$17ha4a8b9f5d96ed1ddE (type 0) (param i32 i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
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
    i32.const 12
    local.set 5
    local.get 0
    local.get 5
    i32.add
    local.set 6
    local.get 4
    local.get 1
    i32.store offset=12
    local.get 4
    i32.load offset=12
    local.set 7
    local.get 6
    local.get 7
    call $_ZN5index8Universe3new28_$u7b$$u7b$closure$u7d$$u7d$17h6e692734aa7fd611E
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
    local.get 4
    i32.load8_u offset=11
    local.set 11
    i32.const 1
    local.set 12
    local.get 11
    local.get 12
    i32.and
    local.set 13
    local.get 0
    local.get 13
    call $_ZN4core4iter6traits8iterator8Iterator8for_each4call28_$u7b$$u7b$closure$u7d$$u7d$17hf7aa493f65175abaE
    i32.const 16
    local.set 14
    local.get 4
    local.get 14
    i32.add
    local.set 15
    local.get 15
    global.set $__stack_pointer
    return)
  (func $_ZN4core4iter6traits8iterator8Iterator6cloned17h3578c7209fd65b8cE (type 3) (param i32 i32 i32)
    (local i32 i32 i32 i32 i32)
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
    i32.store offset=8
    local.get 5
    local.get 2
    i32.store offset=12
    local.get 5
    i32.load offset=8
    local.set 6
    local.get 5
    i32.load offset=12
    local.set 7
    local.get 0
    local.get 7
    i32.store offset=4
    local.get 0
    local.get 6
    i32.store
    return)
  (func $_ZN4core4iter6traits8iterator8Iterator7collect17h5a7d05434a394ca9E (type 3) (param i32 i32 i32)
    local.get 0
    local.get 1
    local.get 2
    call $_ZN95_$LT$alloc..vec..Vec$LT$T$GT$$u20$as$u20$core..iter..traits..collect..FromIterator$LT$T$GT$$GT$9from_iter17hb01c814e8a44c691E
    return)
  (func $_ZN95_$LT$alloc..vec..Vec$LT$T$GT$$u20$as$u20$core..iter..traits..collect..FromIterator$LT$T$GT$$GT$9from_iter17hb01c814e8a44c691E (type 3) (param i32 i32 i32)
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
    local.get 1
    local.get 2
    call $_ZN63_$LT$I$u20$as$u20$core..iter..traits..collect..IntoIterator$GT$9into_iter17h0ba1ca6b454d9fe0E
    local.get 5
    i32.load offset=12
    local.set 8
    local.get 5
    i32.load offset=8
    local.set 9
    local.get 0
    local.get 9
    local.get 8
    call $_ZN98_$LT$alloc..vec..Vec$LT$T$GT$$u20$as$u20$alloc..vec..spec_from_iter..SpecFromIter$LT$T$C$I$GT$$GT$9from_iter17hef5f9e0868bfddb3E
    i32.const 16
    local.set 10
    local.get 5
    local.get 10
    i32.add
    local.set 11
    local.get 11
    global.set $__stack_pointer
    return)
  (func $_ZN4core4iter6traits8iterator8Iterator8for_each17h010828be079b2ddcE (type 3) (param i32 i32 i32)
    (local i32 i32 i32 i32 i32 i32 i32 i64 i32 i32 i32)
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
    local.get 2
    local.get 6
    i32.add
    local.set 7
    local.get 7
    i32.load
    local.set 8
    local.get 5
    local.get 6
    i32.add
    local.set 9
    local.get 9
    local.get 8
    i32.store
    local.get 2
    i64.load align=4
    local.set 10
    local.get 5
    local.get 10
    i64.store
    local.get 5
    local.set 11
    local.get 0
    local.get 1
    local.get 11
    call $_ZN102_$LT$core..iter..adapters..map..Map$LT$I$C$F$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4fold17h07ca9642c4fa0a53E
    i32.const 16
    local.set 12
    local.get 5
    local.get 12
    i32.add
    local.set 13
    local.get 13
    global.set $__stack_pointer
    return)
  (func $_ZN4core4iter6traits8iterator8Iterator8for_each4call28_$u7b$$u7b$closure$u7d$$u7d$17hf7aa493f65175abaE (type 0) (param i32 i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32)
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
    local.set 5
    local.get 4
    local.get 5
    i32.store8 offset=15
    local.get 4
    i32.load8_u offset=15
    local.set 6
    i32.const 1
    local.set 7
    local.get 6
    local.get 7
    i32.and
    local.set 8
    local.get 0
    local.get 8
    call $_ZN5alloc3vec16Vec$LT$T$C$A$GT$14extend_trusted28_$u7b$$u7b$closure$u7d$$u7d$17h93a915138884be3fE
    i32.const 16
    local.set 9
    local.get 4
    local.get 9
    i32.add
    local.set 10
    local.get 10
    global.set $__stack_pointer
    return)
  (func $_ZN5alloc3vec16Vec$LT$T$C$A$GT$14extend_trusted28_$u7b$$u7b$closure$u7d$$u7d$17h93a915138884be3fE (type 0) (param i32 i32)
    (local i32 i32 i32 i32 i32 i32 i32)
    local.get 0
    i32.load offset=8
    local.set 2
    local.get 0
    i32.load offset=4
    local.set 3
    local.get 2
    local.get 3
    i32.add
    local.set 4
    local.get 1
    local.set 5
    local.get 4
    local.get 5
    i32.store8
    local.get 0
    i32.load offset=4
    local.set 6
    i32.const 1
    local.set 7
    local.get 6
    local.get 7
    i32.add
    local.set 8
    local.get 0
    local.get 8
    i32.store offset=4
    return)
  (func $_ZN5index8Universe3new28_$u7b$$u7b$closure$u7d$$u7d$17h6e692734aa7fd611E (type 2) (param i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    local.set 2
    i32.const 16
    local.set 3
    local.get 2
    local.get 3
    i32.sub
    local.set 4
    i32.const 1
    local.set 5
    local.get 1
    local.get 5
    i32.and
    local.set 6
    block  ;; label = @1
      block  ;; label = @2
        local.get 6
        i32.eqz
        br_if 0 (;@2;)
        i32.const 7
        local.set 7
        local.get 1
        local.get 7
        i32.rem_u
        local.set 8
        local.get 8
        i32.eqz
        br_if 0 (;@2;)
        i32.const 0
        local.set 9
        local.get 4
        local.get 9
        i32.store8 offset=15
        br 1 (;@1;)
      end
      i32.const 1
      local.set 10
      local.get 4
      local.get 10
      i32.store8 offset=15
    end
    local.get 4
    i32.load8_u offset=15
    local.set 11
    i32.const 1
    local.set 12
    local.get 11
    local.get 12
    i32.and
    local.set 13
    local.get 13
    return)
  (func $_ZN4core5alloc6layout6Layout5array5inner17hde74f827f47f01deE (type 8) (param i32 i32 i32 i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
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
        i32.eqz
        br_if 0 (;@2;)
        local.get 6
        local.get 2
        i32.store offset=24
        local.get 6
        i32.load offset=24
        local.set 7
        i32.const 1
        local.set 8
        local.get 7
        local.get 8
        i32.sub
        local.set 9
        i32.const 2147483647
        local.set 10
        local.get 10
        local.get 9
        i32.sub
        local.set 11
        i32.const 0
        local.set 12
        local.get 1
        local.set 13
        local.get 12
        local.set 14
        local.get 13
        local.get 14
        i32.eq
        local.set 15
        i32.const 1
        local.set 16
        local.get 15
        local.get 16
        i32.and
        local.set 17
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              local.get 17
              br_if 0 (;@5;)
              local.get 11
              local.get 1
              i32.div_u
              local.set 18
              local.get 3
              local.set 19
              local.get 18
              local.set 20
              local.get 19
              local.get 20
              i32.gt_u
              local.set 21
              i32.const 1
              local.set 22
              local.get 21
              local.get 22
              i32.and
              local.set 23
              local.get 23
              br_if 2 (;@3;)
              br 1 (;@4;)
            end
            i32.const 1049328
            local.set 24
            i32.const 25
            local.set 25
            i32.const 1049308
            local.set 26
            local.get 24
            local.get 25
            local.get 26
            call $_ZN4core9panicking5panic17hb41dbc4083d9884eE
            unreachable
          end
          br 1 (;@2;)
        end
        i32.const 0
        local.set 27
        local.get 6
        local.get 27
        i32.store offset=8
        br 1 (;@1;)
      end
      local.get 1
      local.get 3
      i32.mul
      local.set 28
      local.get 6
      local.get 2
      i32.store offset=28
      local.get 6
      i32.load offset=28
      local.set 29
      local.get 6
      local.get 28
      i32.store offset=20
      local.get 6
      local.get 29
      i32.store offset=16
      local.get 6
      i32.load offset=16
      local.set 30
      local.get 6
      i32.load offset=20
      local.set 31
      local.get 6
      local.get 30
      i32.store offset=8
      local.get 6
      local.get 31
      i32.store offset=12
    end
    local.get 6
    i32.load offset=8
    local.set 32
    local.get 6
    i32.load offset=12
    local.set 33
    local.get 0
    local.get 33
    i32.store offset=4
    local.get 0
    local.get 32
    i32.store
    i32.const 32
    local.set 34
    local.get 6
    local.get 34
    i32.add
    local.set 35
    local.get 35
    global.set $__stack_pointer
    return)
  (func $_ZN4core5slice29_$LT$impl$u20$$u5b$T$u5d$$GT$4iter17h2f82be2143302357E (type 3) (param i32 i32 i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    local.set 3
    i32.const 16
    local.set 4
    local.get 3
    local.get 4
    i32.sub
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
        i32.const 2
        local.set 9
        local.get 2
        local.get 9
        i32.shl
        local.set 10
        local.get 1
        local.get 10
        i32.add
        local.set 11
        local.get 5
        local.get 11
        i32.store offset=8
        br 1 (;@1;)
      end
      local.get 5
      local.get 2
      i32.store offset=8
    end
    local.get 5
    local.get 1
    i32.store offset=12
    local.get 5
    i32.load offset=8
    local.set 12
    local.get 5
    i32.load offset=12
    local.set 13
    local.get 5
    local.get 13
    i32.store
    local.get 5
    local.get 12
    i32.store offset=4
    local.get 5
    i32.load
    local.set 14
    local.get 5
    i32.load offset=4
    local.set 15
    local.get 0
    local.get 15
    i32.store offset=4
    local.get 0
    local.get 14
    i32.store
    return)
  (func $_ZN4core5slice29_$LT$impl$u20$$u5b$T$u5d$$GT$6chunks17h3d5b5c43ca89da6dE (type 6) (param i32 i32 i32 i32 i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    local.set 5
    i32.const 64
    local.set 6
    local.get 5
    local.get 6
    i32.sub
    local.set 7
    local.get 7
    global.set $__stack_pointer
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          local.get 3
          br_if 0 (;@3;)
          i32.const 0
          local.set 8
          i32.const 1
          local.set 9
          local.get 8
          local.get 9
          i32.and
          local.set 10
          local.get 10
          br_if 2 (;@1;)
          br 1 (;@2;)
        end
        local.get 0
        local.get 1
        i32.store
        local.get 0
        local.get 2
        i32.store offset=4
        local.get 0
        local.get 3
        i32.store offset=8
        i32.const 64
        local.set 11
        local.get 7
        local.get 11
        i32.add
        local.set 12
        local.get 12
        global.set $__stack_pointer
        return
      end
      i32.const 0
      local.set 13
      local.get 7
      local.get 13
      i32.store offset=56
      i32.const 1049380
      local.set 14
      local.get 7
      local.get 14
      i32.store offset=8
      i32.const 1
      local.set 15
      local.get 7
      local.get 15
      i32.store offset=12
      local.get 7
      i32.load offset=56
      local.set 16
      local.get 7
      i32.load offset=60
      local.set 17
      local.get 7
      local.get 16
      i32.store offset=24
      local.get 7
      local.get 17
      i32.store offset=28
      i32.const 1048604
      local.set 18
      local.get 7
      local.get 18
      i32.store offset=16
      i32.const 0
      local.set 19
      local.get 7
      local.get 19
      i32.store offset=20
      i32.const 8
      local.set 20
      local.get 7
      local.get 20
      i32.add
      local.set 21
      local.get 21
      local.set 22
      local.get 22
      local.get 4
      call $_ZN4core9panicking9panic_fmt17h14c85a61aa3d538eE
      unreachable
    end
    i32.const 32
    local.set 23
    local.get 7
    local.get 23
    i32.add
    local.set 24
    local.get 24
    local.set 25
    i32.const 1048728
    local.set 26
    i32.const 1
    local.set 27
    local.get 25
    local.get 26
    local.get 27
    call $_ZN4core3fmt9Arguments9new_const17hc20d6a4705f59fffE
    i32.const 32
    local.set 28
    local.get 7
    local.get 28
    i32.add
    local.set 29
    local.get 29
    local.set 30
    i32.const 1048812
    local.set 31
    local.get 30
    local.get 31
    call $_ZN4core9panicking9panic_fmt17h14c85a61aa3d538eE
    unreachable)
  (func $_ZN4core5slice4iter87_$LT$impl$u20$core..iter..traits..collect..IntoIterator$u20$for$u20$$RF$$u5b$T$u5d$$GT$9into_iter17h2b52094caae78498E (type 3) (param i32 i32 i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    local.set 3
    i32.const 16
    local.set 4
    local.get 3
    local.get 4
    i32.sub
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
        local.get 1
        local.get 2
        i32.add
        local.set 9
        local.get 5
        local.get 9
        i32.store offset=8
        br 1 (;@1;)
      end
      local.get 5
      local.get 2
      i32.store offset=8
    end
    local.get 5
    local.get 1
    i32.store offset=12
    local.get 5
    i32.load offset=8
    local.set 10
    local.get 5
    i32.load offset=12
    local.set 11
    local.get 5
    local.get 11
    i32.store
    local.get 5
    local.get 10
    i32.store offset=4
    local.get 5
    i32.load
    local.set 12
    local.get 5
    i32.load offset=4
    local.set 13
    local.get 0
    local.get 13
    i32.store offset=4
    local.get 0
    local.get 12
    i32.store
    return)
  (func $_ZN4core6result19Result$LT$T$C$E$GT$7map_err17ha27e000805bea386E (type 8) (param i32 i32 i32 i32)
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
    i32.store offset=20
    local.get 6
    local.get 2
    i32.store offset=24
    i32.const 1
    local.set 7
    local.get 6
    local.get 7
    i32.store8 offset=31
    local.get 6
    i32.load offset=20
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
        i32.load offset=20
        local.set 12
        local.get 6
        i32.load offset=24
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
      call $_ZN5alloc7raw_vec11finish_grow28_$u7b$$u7b$closure$u7d$$u7d$17hf7394e4207fe76deE
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
  (func $_ZN5alloc7raw_vec11finish_grow28_$u7b$$u7b$closure$u7d$$u7d$17hf7394e4207fe76deE (type 0) (param i32 i32)
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
  (func $_ZN4core6result19Result$LT$T$C$E$GT$7map_err17hb170707739300343E (type 3) (param i32 i32 i32)
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
    i32.store offset=20
    local.get 5
    local.get 2
    i32.store offset=24
    i32.const 1
    local.set 6
    local.get 5
    local.get 6
    i32.store8 offset=47
    local.get 5
    i32.load offset=20
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
        i32.store offset=28
        br 1 (;@1;)
      end
      local.get 5
      i32.load offset=20
      local.set 18
      local.get 5
      i32.load offset=24
      local.set 19
      i32.const 0
      local.set 20
      local.get 5
      local.get 20
      i32.store8 offset=47
      local.get 5
      local.get 18
      i32.store offset=36
      local.get 5
      local.get 19
      i32.store offset=40
      local.get 5
      i32.load offset=36
      local.set 21
      local.get 5
      i32.load offset=40
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
      call $_ZN5alloc7raw_vec14handle_reserve28_$u7b$$u7b$closure$u7d$$u7d$17h30fb289a10eae6d1E
      local.get 5
      i32.load offset=12
      local.set 25
      local.get 5
      i32.load offset=8
      local.set 26
      local.get 5
      local.get 26
      i32.store offset=28
      local.get 5
      local.get 25
      i32.store offset=32
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
    i32.load offset=28
    local.set 30
    local.get 5
    i32.load offset=32
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
  (func $_ZN5alloc7raw_vec14handle_reserve28_$u7b$$u7b$closure$u7d$$u7d$17h30fb289a10eae6d1E (type 3) (param i32 i32 i32)
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
  (func $_ZN4core6result19Result$LT$T$C$E$GT$7map_err17hf981c3cf46e0176cE (type 3) (param i32 i32 i32)
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
    i32.store offset=20
    local.get 5
    local.get 2
    i32.store offset=24
    i32.const 1
    local.set 6
    local.get 5
    local.get 6
    i32.store8 offset=31
    local.get 5
    i32.load offset=20
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
        i32.load offset=20
        local.set 11
        local.get 5
        i32.load offset=24
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
      call $_ZN5alloc7raw_vec11finish_grow28_$u7b$$u7b$closure$u7d$$u7d$17h198907a555d90521E
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
  (func $_ZN5alloc7raw_vec11finish_grow28_$u7b$$u7b$closure$u7d$$u7d$17h198907a555d90521E (type 7) (param i32)
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
  (func $_ZN52_$LT$T$u20$as$u20$alloc..slice..hack..ConvertVec$GT$6to_vec17hbb25be0127bcc92dE (type 3) (param i32 i32 i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i64 i32 i32 i32 i32 i32 i32 i32 i32)
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
    i32.const 0
    local.set 6
    i32.const 8
    local.set 7
    local.get 5
    local.get 7
    i32.add
    local.set 8
    local.get 8
    local.get 2
    local.get 6
    call $_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$11allocate_in17h72fc51a304adc19aE
    local.get 5
    i32.load offset=12
    local.set 9
    local.get 5
    i32.load offset=8
    local.set 10
    local.get 5
    local.get 10
    i32.store offset=20
    local.get 5
    local.get 9
    i32.store offset=24
    i32.const 0
    local.set 11
    local.get 5
    local.get 11
    i32.store offset=28
    local.get 5
    i32.load offset=20
    local.set 12
    i32.const 0
    local.set 13
    local.get 2
    local.get 13
    i32.shl
    local.set 14
    local.get 12
    local.get 1
    local.get 14
    call $memcpy
    drop
    local.get 5
    local.get 2
    i32.store offset=28
    local.get 5
    i64.load offset=20 align=4
    local.set 15
    local.get 0
    local.get 15
    i64.store align=4
    i32.const 8
    local.set 16
    local.get 0
    local.get 16
    i32.add
    local.set 17
    i32.const 20
    local.set 18
    local.get 5
    local.get 18
    i32.add
    local.set 19
    local.get 19
    local.get 16
    i32.add
    local.set 20
    local.get 20
    i32.load
    local.set 21
    local.get 17
    local.get 21
    i32.store
    i32.const 32
    local.set 22
    local.get 5
    local.get 22
    i32.add
    local.set 23
    local.get 23
    global.set $__stack_pointer
    return)
  (func $_ZN58_$LT$alloc..string..String$u20$as$u20$core..fmt..Write$GT$10write_char17ha63d6b9ea41d3f5eE (type 2) (param i32 i32) (result i32)
    (local i32 i32 i32)
    local.get 0
    local.get 1
    call $_ZN5alloc6string6String4push17h85cf65877c43c877E
    i32.const 0
    local.set 2
    i32.const 1
    local.set 3
    local.get 2
    local.get 3
    i32.and
    local.set 4
    local.get 4
    return)
  (func $_ZN5alloc6string6String4push17h85cf65877c43c877E (type 0) (param i32 i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
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
    i32.const 128
    local.set 5
    local.get 1
    local.set 6
    local.get 5
    local.set 7
    local.get 6
    local.get 7
    i32.lt_u
    local.set 8
    i32.const 1
    local.set 9
    local.get 8
    local.get 9
    i32.and
    local.set 10
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              block  ;; label = @6
                block  ;; label = @7
                  block  ;; label = @8
                    local.get 10
                    br_if 0 (;@8;)
                    i32.const 2048
                    local.set 11
                    local.get 1
                    local.set 12
                    local.get 11
                    local.set 13
                    local.get 12
                    local.get 13
                    i32.lt_u
                    local.set 14
                    i32.const 1
                    local.set 15
                    local.get 14
                    local.get 15
                    i32.and
                    local.set 16
                    local.get 16
                    br_if 2 (;@6;)
                    br 1 (;@7;)
                  end
                  i32.const 1
                  local.set 17
                  local.get 4
                  local.get 17
                  i32.store offset=8
                  br 6 (;@1;)
                end
                i32.const 65536
                local.set 18
                local.get 1
                local.set 19
                local.get 18
                local.set 20
                local.get 19
                local.get 20
                i32.lt_u
                local.set 21
                i32.const 1
                local.set 22
                local.get 21
                local.get 22
                i32.and
                local.set 23
                local.get 23
                br_if 2 (;@4;)
                br 1 (;@5;)
              end
              i32.const 2
              local.set 24
              local.get 4
              local.get 24
              i32.store offset=8
              br 3 (;@2;)
            end
            i32.const 4
            local.set 25
            local.get 4
            local.get 25
            i32.store offset=8
            br 1 (;@3;)
          end
          i32.const 3
          local.set 26
          local.get 4
          local.get 26
          i32.store offset=8
        end
      end
    end
    local.get 4
    i32.load offset=8
    local.set 27
    i32.const 1
    local.set 28
    local.get 27
    local.set 29
    local.get 28
    local.set 30
    local.get 29
    local.get 30
    i32.eq
    local.set 31
    i32.const 1
    local.set 32
    local.get 31
    local.get 32
    i32.and
    local.set 33
    block  ;; label = @1
      block  ;; label = @2
        local.get 33
        i32.eqz
        br_if 0 (;@2;)
        local.get 0
        local.get 1
        call $_ZN5alloc3vec16Vec$LT$T$C$A$GT$4push17h2ad7b993b202687cE
        br 1 (;@1;)
      end
      i32.const 12
      local.set 34
      local.get 4
      local.get 34
      i32.add
      local.set 35
      local.get 35
      local.set 36
      i32.const 0
      local.set 37
      local.get 36
      local.get 37
      i32.store align=1
      i32.const 4
      local.set 38
      i32.const 12
      local.set 39
      local.get 4
      local.get 39
      i32.add
      local.set 40
      local.get 4
      local.get 1
      local.get 40
      local.get 38
      call $_ZN4core4char7methods15encode_utf8_raw17h91b144acde76a0faE
      local.get 4
      i32.load offset=4
      local.set 41
      local.get 4
      i32.load
      local.set 42
      local.get 0
      local.get 42
      local.get 41
      call $_ZN5alloc3vec16Vec$LT$T$C$A$GT$17extend_from_slice17ha116ed55dbc06e13E
    end
    i32.const 16
    local.set 43
    local.get 4
    local.get 43
    i32.add
    local.set 44
    local.get 44
    global.set $__stack_pointer
    return)
  (func $_ZN58_$LT$alloc..string..String$u20$as$u20$core..fmt..Write$GT$9write_str17h5739f5b458ff7fc1E (type 1) (param i32 i32 i32) (result i32)
    (local i32 i32 i32)
    local.get 0
    local.get 1
    local.get 2
    call $_ZN5alloc3vec16Vec$LT$T$C$A$GT$17extend_from_slice17ha116ed55dbc06e13E
    i32.const 0
    local.set 3
    i32.const 1
    local.set 4
    local.get 3
    local.get 4
    i32.and
    local.set 5
    local.get 5
    return)
  (func $_ZN5alloc3vec16Vec$LT$T$C$A$GT$17extend_from_slice17ha116ed55dbc06e13E (type 3) (param i32 i32 i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
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
        local.get 1
        local.get 2
        i32.add
        local.set 9
        local.get 5
        local.get 9
        i32.store offset=8
        br 1 (;@1;)
      end
      local.get 5
      local.get 2
      i32.store offset=8
    end
    local.get 5
    local.get 1
    i32.store offset=12
    local.get 5
    i32.load offset=8
    local.set 10
    local.get 5
    i32.load offset=12
    local.set 11
    local.get 5
    local.get 11
    i32.store
    local.get 5
    local.get 10
    i32.store offset=4
    local.get 5
    i32.load
    local.set 12
    local.get 5
    i32.load offset=4
    local.set 13
    local.get 0
    local.get 12
    local.get 13
    call $_ZN132_$LT$alloc..vec..Vec$LT$T$C$A$GT$$u20$as$u20$alloc..vec..spec_extend..SpecExtend$LT$$RF$T$C$core..slice..iter..Iter$LT$T$GT$$GT$$GT$11spec_extend17he8259e5e06c7688cE
    i32.const 16
    local.set 14
    local.get 5
    local.get 14
    i32.add
    local.set 15
    local.get 15
    global.set $__stack_pointer
    return)
  (func $_ZN59_$LT$alloc..alloc..Global$u20$as$u20$core..clone..Clone$GT$5clone17h7110c1abb4d70507E (type 7) (param i32)
    return)
  (func $_ZN5alloc3vec16Vec$LT$T$C$A$GT$14extend_trusted17h84834286af8af33cE (type 3) (param i32 i32 i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    local.set 3
    i32.const 112
    local.set 4
    local.get 3
    local.get 4
    i32.sub
    local.set 5
    local.get 5
    global.set $__stack_pointer
    local.get 5
    local.get 1
    i32.store offset=8
    local.get 5
    local.get 2
    i32.store offset=12
    i32.const 24
    local.set 6
    local.get 5
    local.get 6
    i32.add
    local.set 7
    local.get 7
    local.set 8
    i32.const 8
    local.set 9
    local.get 5
    local.get 9
    i32.add
    local.set 10
    local.get 10
    local.set 11
    local.get 8
    local.get 11
    call $_ZN102_$LT$core..iter..adapters..map..Map$LT$I$C$F$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$9size_hint17h02dbb3e914644c64E
    local.get 5
    i32.load offset=28
    local.set 12
    local.get 5
    i32.load offset=32
    local.set 13
    local.get 5
    local.get 12
    i32.store offset=16
    local.get 5
    local.get 13
    i32.store offset=20
    local.get 5
    i32.load offset=16
    local.set 14
    i32.const 1
    local.set 15
    local.get 14
    local.set 16
    local.get 15
    local.set 17
    local.get 16
    local.get 17
    i32.eq
    local.set 18
    i32.const 1
    local.set 19
    local.get 18
    local.get 19
    i32.and
    local.set 20
    block  ;; label = @1
      local.get 20
      i32.eqz
      br_if 0 (;@1;)
      local.get 5
      i32.load offset=20
      local.set 21
      local.get 0
      local.get 21
      call $_ZN5alloc3vec16Vec$LT$T$C$A$GT$7reserve17h60b34b485e4ec4baE
      local.get 0
      i32.load
      local.set 22
      i32.const 8
      local.set 23
      local.get 0
      local.get 23
      i32.add
      local.set 24
      local.get 0
      i32.load offset=8
      local.set 25
      local.get 5
      local.get 24
      i32.store offset=36
      local.get 5
      local.get 25
      i32.store offset=40
      local.get 5
      i32.load offset=8
      local.set 26
      local.get 5
      i32.load offset=12
      local.set 27
      local.get 5
      local.get 22
      i32.store offset=52
      local.get 5
      i32.load offset=36
      local.set 28
      local.get 5
      i32.load offset=40
      local.set 29
      local.get 5
      local.get 28
      i32.store offset=44
      local.get 5
      local.get 29
      i32.store offset=48
      i32.const 44
      local.set 30
      local.get 5
      local.get 30
      i32.add
      local.set 31
      local.get 31
      local.set 32
      local.get 26
      local.get 27
      local.get 32
      call $_ZN4core4iter6traits8iterator8Iterator8for_each17h010828be079b2ddcE
      i32.const 112
      local.set 33
      local.get 5
      local.get 33
      i32.add
      local.set 34
      local.get 34
      global.set $__stack_pointer
      return
    end
    i32.const 0
    local.set 35
    i32.const 1
    local.set 36
    local.get 35
    local.get 36
    i32.and
    local.set 37
    block  ;; label = @1
      local.get 37
      br_if 0 (;@1;)
      i32.const 0
      local.set 38
      local.get 5
      local.get 38
      i32.store offset=104
      i32.const 1048596
      local.set 39
      local.get 5
      local.get 39
      i32.store offset=56
      i32.const 1
      local.set 40
      local.get 5
      local.get 40
      i32.store offset=60
      local.get 5
      i32.load offset=104
      local.set 41
      local.get 5
      i32.load offset=108
      local.set 42
      local.get 5
      local.get 41
      i32.store offset=72
      local.get 5
      local.get 42
      i32.store offset=76
      i32.const 1048604
      local.set 43
      local.get 5
      local.get 43
      i32.store offset=64
      i32.const 0
      local.set 44
      local.get 5
      local.get 44
      i32.store offset=68
      i32.const 56
      local.set 45
      local.get 5
      local.get 45
      i32.add
      local.set 46
      local.get 46
      local.set 47
      i32.const 1049464
      local.set 48
      local.get 47
      local.get 48
      call $_ZN4core9panicking9panic_fmt17h14c85a61aa3d538eE
      unreachable
    end
    i32.const 80
    local.set 49
    local.get 5
    local.get 49
    i32.add
    local.set 50
    local.get 50
    local.set 51
    i32.const 1048728
    local.set 52
    i32.const 1
    local.set 53
    local.get 51
    local.get 52
    local.get 53
    call $_ZN4core3fmt9Arguments9new_const17hc20d6a4705f59fffE
    i32.const 80
    local.set 54
    local.get 5
    local.get 54
    i32.add
    local.set 55
    local.get 55
    local.set 56
    i32.const 1048812
    local.set 57
    local.get 56
    local.get 57
    call $_ZN4core9panicking9panic_fmt17h14c85a61aa3d538eE
    unreachable)
  (func $_ZN5alloc3vec16Vec$LT$T$C$A$GT$7reserve17h60b34b485e4ec4baE (type 0) (param i32 i32)
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
      call $_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$7reserve21do_reserve_and_handle17h04a9e7db033a5aeaE
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
  (func $_ZN5alloc3vec16Vec$LT$T$C$A$GT$4push17h2ad7b993b202687cE (type 0) (param i32 i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
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
    local.get 5
    local.set 12
    local.get 11
    local.set 13
    local.get 12
    local.get 13
    i32.eq
    local.set 14
    i32.const 1
    local.set 15
    local.get 14
    local.get 15
    i32.and
    local.set 16
    block  ;; label = @1
      block  ;; label = @2
        local.get 16
        br_if 0 (;@2;)
        br 1 (;@1;)
      end
      local.get 0
      i32.load offset=8
      local.set 17
      local.get 0
      local.get 17
      call $_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$16reserve_for_push17h474eadd3108fa100E
    end
    local.get 0
    i32.load
    local.set 18
    local.get 0
    i32.load offset=8
    local.set 19
    local.get 18
    local.get 19
    i32.add
    local.set 20
    local.get 20
    local.get 1
    i32.store8
    local.get 0
    i32.load offset=8
    local.set 21
    i32.const 1
    local.set 22
    local.get 21
    local.get 22
    i32.add
    local.set 23
    local.get 0
    local.get 23
    i32.store offset=8
    i32.const 16
    local.set 24
    local.get 4
    local.get 24
    i32.add
    local.set 25
    local.get 25
    global.set $__stack_pointer
    return)
  (func $_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$16reserve_for_push17h474eadd3108fa100E (type 0) (param i32 i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
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
    i32.const 1
    local.set 5
    i32.const 8
    local.set 6
    local.get 4
    local.get 6
    i32.add
    local.set 7
    local.get 7
    local.get 0
    local.get 1
    local.get 5
    call $_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$14grow_amortized17h1ffc49a20d99d8a2E
    local.get 4
    i32.load offset=12
    local.set 8
    local.get 4
    i32.load offset=8
    local.set 9
    local.get 9
    local.get 8
    call $_ZN5alloc7raw_vec14handle_reserve17h1c408bce1405e38fE
    i32.const 16
    local.set 10
    local.get 4
    local.get 10
    i32.add
    local.set 11
    local.get 11
    global.set $__stack_pointer
    return)
  (func $_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$7reserve21do_reserve_and_handle17h04a9e7db033a5aeaE (type 3) (param i32 i32 i32)
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
    call $_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$14grow_amortized17h9b6dece91f0c91a9E
    local.get 5
    i32.load offset=12
    local.set 8
    local.get 5
    i32.load offset=8
    local.set 9
    local.get 9
    local.get 8
    call $_ZN5alloc7raw_vec14handle_reserve17h1c408bce1405e38fE
    i32.const 16
    local.set 10
    local.get 5
    local.get 10
    i32.add
    local.set 11
    local.get 11
    global.set $__stack_pointer
    return)
  (func $_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$7reserve21do_reserve_and_handle17h50013dd7585d6be0E (type 3) (param i32 i32 i32)
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
    call $_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$14grow_amortized17h1ffc49a20d99d8a2E
    local.get 5
    i32.load offset=12
    local.set 8
    local.get 5
    i32.load offset=8
    local.set 9
    local.get 9
    local.get 8
    call $_ZN5alloc7raw_vec14handle_reserve17h1c408bce1405e38fE
    i32.const 16
    local.set 10
    local.get 5
    local.get 10
    i32.add
    local.set 11
    local.get 11
    global.set $__stack_pointer
    return)
  (func $_ZN5alloc3vec16Vec$LT$T$C$A$GT$8as_slice17hf58bef610c257386E (type 0) (param i32 i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    local.set 2
    i32.const 16
    local.set 3
    local.get 2
    local.get 3
    i32.sub
    local.set 4
    local.get 1
    i32.load
    local.set 5
    local.get 1
    i32.load offset=8
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
    i32.store offset=4
    local.get 0
    local.get 9
    i32.store
    return)
  (func $_ZN5alloc5alloc6Global10alloc_impl17hd02206459eed2f07E (type 6) (param i32 i32 i32 i32 i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    local.set 5
    i32.const 96
    local.set 6
    local.get 5
    local.get 6
    i32.sub
    local.set 7
    local.get 7
    global.set $__stack_pointer
    block  ;; label = @1
      block  ;; label = @2
        local.get 3
        br_if 0 (;@2;)
        local.get 7
        local.get 2
        i32.store offset=44
        local.get 7
        i32.load offset=44
        local.set 8
        local.get 7
        local.get 8
        i32.store offset=16
        local.get 7
        i32.load offset=16
        local.set 9
        local.get 7
        local.get 9
        i32.store offset=56
        i32.const 0
        local.set 10
        local.get 7
        local.get 10
        i32.store offset=60
        local.get 7
        i32.load offset=56
        local.set 11
        local.get 7
        i32.load offset=60
        local.set 12
        local.get 7
        local.get 11
        i32.store offset=48
        local.get 7
        local.get 12
        i32.store offset=52
        local.get 7
        i32.load offset=48
        local.set 13
        local.get 7
        i32.load offset=52
        local.set 14
        local.get 7
        local.get 13
        i32.store offset=8
        local.get 7
        local.get 14
        i32.store offset=12
        local.get 7
        i32.load offset=8
        local.set 15
        local.get 7
        i32.load offset=12
        local.set 16
        local.get 7
        local.get 15
        i32.store
        local.get 7
        local.get 16
        i32.store offset=4
        br 1 (;@1;)
      end
      local.get 4
      local.set 17
      block  ;; label = @2
        block  ;; label = @3
          local.get 17
          br_if 0 (;@3;)
          i32.const 0
          local.set 18
          local.get 18
          i32.load8_u offset=1051009
          local.set 19
          local.get 7
          local.get 19
          i32.store8 offset=95
          local.get 7
          local.get 2
          i32.store offset=68
          local.get 7
          i32.load offset=68
          local.set 20
          local.get 3
          local.get 20
          call $__rust_alloc
          local.set 21
          local.get 7
          local.get 21
          i32.store offset=20
          br 1 (;@2;)
        end
        local.get 7
        local.get 2
        i32.store offset=64
        local.get 7
        i32.load offset=64
        local.set 22
        local.get 3
        local.get 22
        call $__rust_alloc_zeroed
        local.set 23
        local.get 7
        local.get 23
        i32.store offset=20
      end
      local.get 7
      i32.load offset=20
      local.set 24
      block  ;; label = @2
        block  ;; label = @3
          local.get 24
          br_if 0 (;@3;)
          i32.const 0
          local.set 25
          local.get 7
          local.get 25
          i32.store offset=32
          br 1 (;@2;)
        end
        local.get 7
        local.get 24
        i32.store offset=72
        local.get 7
        i32.load offset=72
        local.set 26
        local.get 7
        local.get 26
        i32.store offset=32
      end
      local.get 7
      i32.load offset=32
      local.set 27
      i32.const 0
      local.set 28
      i32.const 1
      local.set 29
      local.get 29
      local.get 28
      local.get 27
      select
      local.set 30
      block  ;; label = @2
        block  ;; label = @3
          local.get 30
          br_if 0 (;@3;)
          i32.const 0
          local.set 31
          local.get 7
          local.get 31
          i32.store offset=28
          br 1 (;@2;)
        end
        local.get 7
        i32.load offset=32
        local.set 32
        local.get 7
        local.get 32
        i32.store offset=28
      end
      local.get 7
      i32.load offset=28
      local.set 33
      i32.const 1
      local.set 34
      i32.const 0
      local.set 35
      local.get 35
      local.get 34
      local.get 33
      select
      local.set 36
      block  ;; label = @2
        block  ;; label = @3
          local.get 36
          br_if 0 (;@3;)
          local.get 7
          i32.load offset=28
          local.set 37
          local.get 7
          local.get 37
          i32.store offset=24
          br 1 (;@2;)
        end
        i32.const 0
        local.set 38
        local.get 7
        local.get 38
        i32.store offset=24
      end
      local.get 7
      i32.load offset=24
      local.set 39
      i32.const 1
      local.set 40
      i32.const 0
      local.set 41
      local.get 41
      local.get 40
      local.get 39
      select
      local.set 42
      block  ;; label = @2
        local.get 42
        br_if 0 (;@2;)
        local.get 7
        i32.load offset=24
        local.set 43
        local.get 7
        local.get 43
        i32.store offset=84
        local.get 7
        local.get 3
        i32.store offset=88
        local.get 7
        i32.load offset=84
        local.set 44
        local.get 7
        i32.load offset=88
        local.set 45
        local.get 7
        local.get 44
        i32.store offset=76
        local.get 7
        local.get 45
        i32.store offset=80
        local.get 7
        i32.load offset=76
        local.set 46
        local.get 7
        i32.load offset=80
        local.set 47
        local.get 7
        local.get 46
        i32.store offset=36
        local.get 7
        local.get 47
        i32.store offset=40
        local.get 7
        i32.load offset=36
        local.set 48
        local.get 7
        i32.load offset=40
        local.set 49
        local.get 7
        local.get 48
        i32.store
        local.get 7
        local.get 49
        i32.store offset=4
        br 1 (;@1;)
      end
      i32.const 0
      local.set 50
      local.get 7
      local.get 50
      i32.store
    end
    local.get 7
    i32.load
    local.set 51
    local.get 7
    i32.load offset=4
    local.set 52
    local.get 0
    local.get 52
    i32.store offset=4
    local.get 0
    local.get 51
    i32.store
    i32.const 96
    local.set 53
    local.get 7
    local.get 53
    i32.add
    local.set 54
    local.get 54
    global.set $__stack_pointer
    return)
  (func $_ZN5alloc5alloc6Global9grow_impl17h8d3f0bd84b349e8aE (type 9) (param i32 i32 i32 i32 i32 i32 i32 i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    local.set 8
    i32.const 96
    local.set 9
    local.get 8
    local.get 9
    i32.sub
    local.set 10
    local.get 10
    global.set $__stack_pointer
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          local.get 4
          br_if 0 (;@3;)
          i32.const 1
          local.set 11
          local.get 7
          local.get 11
          i32.and
          local.set 12
          local.get 10
          local.get 1
          local.get 5
          local.get 6
          local.get 12
          call $_ZN5alloc5alloc6Global10alloc_impl17hd02206459eed2f07E
          local.get 10
          i32.load
          local.set 13
          local.get 10
          i32.load offset=4
          local.set 14
          local.get 10
          local.get 14
          i32.store offset=20
          local.get 10
          local.get 13
          i32.store offset=16
          br 1 (;@2;)
        end
        local.get 10
        local.get 3
        i32.store offset=60
        local.get 10
        i32.load offset=60
        local.set 15
        local.get 10
        local.get 5
        i32.store offset=64
        local.get 10
        i32.load offset=64
        local.set 16
        local.get 15
        local.set 17
        local.get 16
        local.set 18
        local.get 17
        local.get 18
        i32.eq
        local.set 19
        i32.const 1
        local.set 20
        local.get 19
        local.get 20
        i32.and
        local.set 21
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              block  ;; label = @6
                block  ;; label = @7
                  block  ;; label = @8
                    block  ;; label = @9
                      block  ;; label = @10
                        local.get 21
                        br_if 0 (;@10;)
                        i32.const 1
                        local.set 22
                        local.get 7
                        local.get 22
                        i32.and
                        local.set 23
                        i32.const 8
                        local.set 24
                        local.get 10
                        local.get 24
                        i32.add
                        local.set 25
                        local.get 25
                        local.get 1
                        local.get 5
                        local.get 6
                        local.get 23
                        call $_ZN5alloc5alloc6Global10alloc_impl17hd02206459eed2f07E
                        local.get 10
                        i32.load offset=8
                        local.set 26
                        local.get 10
                        i32.load offset=12
                        local.set 27
                        local.get 10
                        local.get 27
                        i32.store offset=56
                        local.get 10
                        local.get 26
                        i32.store offset=52
                        local.get 10
                        i32.load offset=52
                        local.set 28
                        i32.const 1
                        local.set 29
                        i32.const 0
                        local.set 30
                        local.get 30
                        local.get 29
                        local.get 28
                        select
                        local.set 31
                        local.get 31
                        i32.eqz
                        br_if 1 (;@9;)
                        br 2 (;@8;)
                      end
                      local.get 10
                      local.get 3
                      i32.store offset=68
                      local.get 10
                      i32.load offset=68
                      local.set 32
                      local.get 2
                      local.get 4
                      local.get 32
                      local.get 6
                      call $__rust_realloc
                      local.set 33
                      local.get 33
                      i32.eqz
                      br_if 3 (;@6;)
                      br 4 (;@5;)
                    end
                    local.get 10
                    i32.load offset=52
                    local.set 34
                    local.get 10
                    i32.load offset=56
                    local.set 35
                    local.get 10
                    local.get 34
                    i32.store offset=44
                    local.get 10
                    local.get 35
                    i32.store offset=48
                    br 1 (;@7;)
                  end
                  i32.const 0
                  local.set 36
                  local.get 10
                  local.get 36
                  i32.store offset=44
                end
                local.get 10
                i32.load offset=44
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
                block  ;; label = @7
                  local.get 40
                  br_if 0 (;@7;)
                  local.get 10
                  i32.load offset=44
                  local.set 41
                  local.get 10
                  i32.load offset=48
                  local.set 42
                  local.get 10
                  local.get 41
                  i32.store offset=92
                  local.get 10
                  i32.load offset=92
                  local.set 43
                  i32.const 0
                  local.set 44
                  local.get 4
                  local.get 44
                  i32.shl
                  local.set 45
                  local.get 43
                  local.get 2
                  local.get 45
                  call $memcpy
                  drop
                  local.get 1
                  local.get 2
                  local.get 3
                  local.get 4
                  call $_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17haebe2a7e43aecc52E
                  local.get 10
                  local.get 41
                  i32.store offset=16
                  local.get 10
                  local.get 42
                  i32.store offset=20
                  br 5 (;@2;)
                end
                i32.const 0
                local.set 46
                local.get 10
                local.get 46
                i32.store offset=16
                br 3 (;@3;)
              end
              i32.const 0
              local.set 47
              local.get 10
              local.get 47
              i32.store offset=32
              br 1 (;@4;)
            end
            local.get 10
            local.get 33
            i32.store offset=72
            local.get 10
            i32.load offset=72
            local.set 48
            local.get 10
            local.get 48
            i32.store offset=32
          end
          local.get 10
          i32.load offset=32
          local.set 49
          i32.const 0
          local.set 50
          i32.const 1
          local.set 51
          local.get 51
          local.get 50
          local.get 49
          select
          local.set 52
          block  ;; label = @4
            block  ;; label = @5
              local.get 52
              br_if 0 (;@5;)
              i32.const 0
              local.set 53
              local.get 10
              local.get 53
              i32.store offset=28
              br 1 (;@4;)
            end
            local.get 10
            i32.load offset=32
            local.set 54
            local.get 10
            local.get 54
            i32.store offset=28
          end
          local.get 10
          i32.load offset=28
          local.set 55
          i32.const 1
          local.set 56
          i32.const 0
          local.set 57
          local.get 57
          local.get 56
          local.get 55
          select
          local.set 58
          block  ;; label = @4
            block  ;; label = @5
              local.get 58
              br_if 0 (;@5;)
              local.get 10
              i32.load offset=28
              local.set 59
              local.get 10
              local.get 59
              i32.store offset=24
              br 1 (;@4;)
            end
            i32.const 0
            local.set 60
            local.get 10
            local.get 60
            i32.store offset=24
          end
          local.get 10
          i32.load offset=24
          local.set 61
          i32.const 1
          local.set 62
          i32.const 0
          local.set 63
          local.get 63
          local.get 62
          local.get 61
          select
          local.set 64
          block  ;; label = @4
            block  ;; label = @5
              block  ;; label = @6
                local.get 64
                br_if 0 (;@6;)
                local.get 10
                i32.load offset=24
                local.set 65
                local.get 7
                local.set 66
                local.get 66
                br_if 1 (;@5;)
                br 2 (;@4;)
              end
              i32.const 0
              local.set 67
              local.get 10
              local.get 67
              i32.store offset=16
              br 2 (;@3;)
            end
            local.get 33
            local.get 4
            i32.add
            local.set 68
            local.get 6
            local.get 4
            i32.sub
            local.set 69
            i32.const 0
            local.set 70
            local.get 69
            local.get 70
            i32.shl
            local.set 71
            i32.const 0
            local.set 72
            local.get 68
            local.get 72
            local.get 71
            call $memset
            drop
          end
          local.get 10
          local.get 65
          i32.store offset=84
          local.get 10
          local.get 6
          i32.store offset=88
          local.get 10
          i32.load offset=84
          local.set 73
          local.get 10
          i32.load offset=88
          local.set 74
          local.get 10
          local.get 73
          i32.store offset=76
          local.get 10
          local.get 74
          i32.store offset=80
          local.get 10
          i32.load offset=76
          local.set 75
          local.get 10
          i32.load offset=80
          local.set 76
          local.get 10
          local.get 75
          i32.store offset=36
          local.get 10
          local.get 76
          i32.store offset=40
          local.get 10
          i32.load offset=36
          local.set 77
          local.get 10
          i32.load offset=40
          local.set 78
          local.get 10
          local.get 77
          i32.store offset=16
          local.get 10
          local.get 78
          i32.store offset=20
          br 1 (;@2;)
        end
        br 1 (;@1;)
      end
    end
    local.get 10
    i32.load offset=16
    local.set 79
    local.get 10
    i32.load offset=20
    local.set 80
    local.get 0
    local.get 80
    i32.store offset=4
    local.get 0
    local.get 79
    i32.store
    i32.const 96
    local.set 81
    local.get 10
    local.get 81
    i32.add
    local.set 82
    local.get 82
    global.set $__stack_pointer
    return)
  (func $_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17haebe2a7e43aecc52E (type 8) (param i32 i32 i32 i32)
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
    global.set $__stack_pointer
    block  ;; label = @1
      block  ;; label = @2
        local.get 3
        br_if 0 (;@2;)
        br 1 (;@1;)
      end
      local.get 6
      local.get 2
      i32.store offset=12
      local.get 6
      i32.load offset=12
      local.set 7
      local.get 1
      local.get 3
      local.get 7
      call $__rust_dealloc
    end
    i32.const 16
    local.set 8
    local.get 6
    local.get 8
    i32.add
    local.set 9
    local.get 9
    global.set $__stack_pointer
    return)
  (func $_ZN5alloc7raw_vec11finish_grow17he731c50f6660e204E (type 6) (param i32 i32 i32 i32 i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
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
    call $_ZN4core6result19Result$LT$T$C$E$GT$7map_err17hf981c3cf46e0176cE
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
        i32.store offset=32
        local.get 7
        local.get 13
        i32.store offset=36
        i32.const 0
        local.set 14
        local.get 7
        local.get 14
        i32.store offset=28
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
      i32.store offset=96
      local.get 7
      local.get 16
      i32.store offset=100
      local.get 7
      i32.load offset=96
      local.set 17
      local.get 7
      i32.load offset=100
      local.set 18
      local.get 7
      local.get 17
      i32.store offset=32
      local.get 7
      local.get 18
      i32.store offset=36
      i32.const 1
      local.set 19
      local.get 7
      local.get 19
      i32.store offset=28
    end
    local.get 7
    i32.load offset=28
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
                i32.load offset=32
                local.set 21
                local.get 7
                i32.load offset=36
                local.set 22
                local.get 7
                local.get 21
                i32.store offset=20
                local.get 7
                local.get 22
                i32.store offset=24
                local.get 7
                i32.load offset=24
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
              i32.load offset=32
              local.set 30
              local.get 7
              i32.load offset=36
              local.set 31
              local.get 7
              local.get 30
              i32.store offset=52
              local.get 7
              local.get 31
              i32.store offset=56
              local.get 7
              i32.load offset=52
              local.set 32
              local.get 7
              i32.load offset=56
              local.set 33
              local.get 7
              local.get 32
              i32.store offset=104
              local.get 7
              local.get 33
              i32.store offset=108
              local.get 7
              i32.load offset=104
              local.set 34
              local.get 7
              i32.load offset=108
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
            i32.store offset=68
            br 1 (;@3;)
          end
          i32.const 0
          local.set 38
          local.get 7
          local.get 38
          i32.store offset=120
          local.get 7
          i32.load offset=120
          local.set 39
          local.get 7
          i32.load offset=124
          local.set 40
          local.get 7
          local.get 39
          i32.store offset=112
          local.get 7
          local.get 40
          i32.store offset=116
          local.get 7
          i32.load offset=112
          local.set 41
          local.get 7
          i32.load offset=116
          local.set 42
          local.get 7
          local.get 41
          i32.store offset=68
          local.get 7
          local.get 42
          i32.store offset=72
        end
        local.get 7
        i32.load offset=68
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
            i32.store offset=60
            br 1 (;@3;)
          end
          local.get 7
          i32.load offset=68
          local.set 54
          local.get 7
          i32.load offset=72
          local.set 55
          local.get 7
          local.get 54
          i32.store offset=128
          local.get 7
          local.get 55
          i32.store offset=132
          local.get 7
          i32.load offset=128
          local.set 56
          local.get 7
          i32.load offset=132
          local.set 57
          local.get 7
          local.get 56
          i32.store offset=60
          local.get 7
          local.get 57
          i32.store offset=64
        end
        local.get 7
        i32.load offset=60
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
              i32.load offset=60
              local.set 78
              local.get 7
              i32.load offset=64
              local.set 79
              local.get 7
              local.get 78
              i32.store offset=76
              local.get 7
              local.get 79
              i32.store offset=80
              local.get 7
              i32.load offset=76
              local.set 80
              local.get 7
              i32.load offset=80
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
            i32.store offset=136
            local.get 7
            i32.load offset=20
            local.set 88
            local.get 7
            local.get 88
            i32.store offset=140
            local.get 7
            i32.load offset=20
            local.set 89
            local.get 7
            i32.load offset=24
            local.set 90
            local.get 7
            local.get 4
            local.get 83
            local.get 84
            local.get 87
            local.get 89
            local.get 90
            call $_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$4grow17h0f5f317e4b5d6231E
            local.get 7
            i32.load
            local.set 91
            local.get 7
            i32.load offset=4
            local.set 92
            local.get 7
            local.get 92
            i32.store offset=88
            local.get 7
            local.get 91
            i32.store offset=84
            br 1 (;@3;)
          end
          local.get 7
          i32.load offset=20
          local.set 93
          local.get 7
          i32.load offset=24
          local.set 94
          i32.const 8
          local.set 95
          local.get 7
          local.get 95
          i32.add
          local.set 96
          local.get 96
          local.get 4
          local.get 93
          local.get 94
          call $_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$8allocate17h3e69157076b4a21bE
          local.get 7
          i32.load offset=8
          local.set 97
          local.get 7
          i32.load offset=12
          local.set 98
          local.get 7
          local.get 98
          i32.store offset=88
          local.get 7
          local.get 97
          i32.store offset=84
        end
        local.get 7
        i32.load offset=84
        local.set 99
        local.get 7
        i32.load offset=88
        local.set 100
        i32.const 20
        local.set 101
        local.get 7
        local.get 101
        i32.add
        local.set 102
        local.get 102
        local.set 103
        local.get 7
        local.get 103
        i32.store offset=92
        local.get 7
        i32.load offset=92
        local.set 104
        local.get 0
        local.get 99
        local.get 100
        local.get 104
        call $_ZN4core6result19Result$LT$T$C$E$GT$7map_err17ha27e000805bea386E
        br 1 (;@1;)
      end
    end
    i32.const 144
    local.set 105
    local.get 7
    local.get 105
    i32.add
    local.set 106
    local.get 106
    global.set $__stack_pointer
    return)
  (func $_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$4grow17h0f5f317e4b5d6231E (type 10) (param i32 i32 i32 i32 i32 i32 i32)
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
    call $_ZN5alloc5alloc6Global9grow_impl17h8d3f0bd84b349e8aE
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
  (func $_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$8allocate17h3e69157076b4a21bE (type 8) (param i32 i32 i32 i32)
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
    call $_ZN5alloc5alloc6Global10alloc_impl17hd02206459eed2f07E
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
  (func $_ZN5alloc7raw_vec14handle_reserve17h1c408bce1405e38fE (type 0) (param i32 i32)
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
    call $_ZN4core6result19Result$LT$T$C$E$GT$7map_err17hb170707739300343E
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
      call $_ZN5alloc7raw_vec17capacity_overflow17h6742d6b707f6ebe7E
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
    call $_ZN5alloc5alloc18handle_alloc_error17h0853c609cdf121f4E
    unreachable)
  (func $_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$15allocate_zeroed17hfe62bc75efbfd71cE (type 8) (param i32 i32 i32 i32)
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
    i32.const 1
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
    call $_ZN5alloc5alloc6Global10alloc_impl17hd02206459eed2f07E
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
  (func $_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$14current_memory17ha4b462c499445094E (type 0) (param i32 i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i64 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    local.set 2
    i32.const 32
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
        block  ;; label = @3
          local.get 7
          br_if 0 (;@3;)
          local.get 1
          i32.load offset=4
          local.set 8
          local.get 8
          br_if 1 (;@2;)
        end
        i32.const 0
        local.set 9
        local.get 0
        local.get 9
        i32.store offset=4
        br 1 (;@1;)
      end
      local.get 1
      i32.load offset=4
      local.set 10
      i32.const 0
      local.set 11
      local.get 10
      local.get 11
      i32.shl
      local.set 12
      local.get 4
      local.get 12
      i32.store offset=4
      i32.const 1
      local.set 13
      local.get 4
      local.get 13
      i32.store
      local.get 1
      i32.load
      local.set 14
      local.get 4
      local.get 14
      i32.store offset=24
      local.get 4
      i32.load offset=24
      local.set 15
      local.get 4
      local.get 15
      i32.store offset=28
      local.get 4
      i32.load offset=28
      local.set 16
      local.get 4
      local.get 16
      i32.store offset=20
      local.get 4
      i32.load offset=20
      local.set 17
      local.get 4
      local.get 17
      i32.store offset=8
      local.get 4
      i32.load
      local.set 18
      local.get 4
      i32.load offset=4
      local.set 19
      local.get 4
      local.get 18
      i32.store offset=12
      local.get 4
      local.get 19
      i32.store offset=16
      local.get 4
      i64.load offset=8 align=4
      local.set 20
      local.get 0
      local.get 20
      i64.store align=4
      i32.const 8
      local.set 21
      local.get 0
      local.get 21
      i32.add
      local.set 22
      i32.const 8
      local.set 23
      local.get 4
      local.get 23
      i32.add
      local.set 24
      local.get 24
      local.get 21
      i32.add
      local.set 25
      local.get 25
      i32.load
      local.set 26
      local.get 22
      local.get 26
      i32.store
    end
    return)
  (func $_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$14current_memory17ha73de0fe0a34a4bcE (type 0) (param i32 i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i64 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    local.set 2
    i32.const 32
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
        block  ;; label = @3
          local.get 7
          br_if 0 (;@3;)
          local.get 1
          i32.load offset=4
          local.set 8
          local.get 8
          br_if 1 (;@2;)
        end
        i32.const 0
        local.set 9
        local.get 0
        local.get 9
        i32.store offset=4
        br 1 (;@1;)
      end
      local.get 1
      i32.load offset=4
      local.set 10
      i32.const 0
      local.set 11
      local.get 10
      local.get 11
      i32.shl
      local.set 12
      local.get 4
      local.get 12
      i32.store offset=4
      i32.const 1
      local.set 13
      local.get 4
      local.get 13
      i32.store
      local.get 1
      i32.load
      local.set 14
      local.get 4
      local.get 14
      i32.store offset=24
      local.get 4
      i32.load offset=24
      local.set 15
      local.get 4
      local.get 15
      i32.store offset=28
      local.get 4
      i32.load offset=28
      local.set 16
      local.get 4
      local.get 16
      i32.store offset=20
      local.get 4
      i32.load offset=20
      local.set 17
      local.get 4
      local.get 17
      i32.store offset=8
      local.get 4
      i32.load
      local.set 18
      local.get 4
      i32.load offset=4
      local.set 19
      local.get 4
      local.get 18
      i32.store offset=12
      local.get 4
      local.get 19
      i32.store offset=16
      local.get 4
      i64.load offset=8 align=4
      local.set 20
      local.get 0
      local.get 20
      i64.store align=4
      i32.const 8
      local.set 21
      local.get 0
      local.get 21
      i32.add
      local.set 22
      i32.const 8
      local.set 23
      local.get 4
      local.get 23
      i32.add
      local.set 24
      local.get 24
      local.get 21
      i32.add
      local.set 25
      local.get 25
      i32.load
      local.set 26
      local.get 22
      local.get 26
      i32.store
    end
    return)
  (func $_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$14grow_amortized17h1ffc49a20d99d8a2E (type 8) (param i32 i32 i32 i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    local.set 4
    i32.const 144
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
              i32.const 1
              local.set 12
              local.get 11
              local.get 12
              i32.and
              local.set 13
              local.get 6
              local.get 13
              i32.store8 offset=143
              local.get 6
              i32.load8_u offset=143
              local.set 14
              i32.const 1
              local.set 15
              local.get 14
              local.get 15
              i32.and
              local.set 16
              local.get 16
              br_if 2 (;@3;)
              br 1 (;@4;)
            end
            i32.const 0
            local.set 17
            local.get 6
            local.get 17
            i32.store offset=24
            local.get 6
            i32.load offset=24
            local.set 18
            local.get 6
            i32.load offset=28
            local.set 19
            local.get 6
            local.get 18
            i32.store offset=16
            local.get 6
            local.get 19
            i32.store offset=20
            local.get 6
            i32.load offset=16
            local.set 20
            local.get 6
            i32.load offset=20
            local.set 21
            local.get 6
            local.get 20
            i32.store offset=8
            local.get 6
            local.get 21
            i32.store offset=12
            br 3 (;@1;)
          end
          local.get 6
          local.get 10
          i32.store offset=52
          i32.const 1
          local.set 22
          local.get 6
          local.get 22
          i32.store offset=48
          br 1 (;@2;)
        end
        i32.const 0
        local.set 23
        local.get 6
        local.get 23
        i32.store offset=48
      end
      i32.const 0
      local.set 24
      local.get 6
      local.get 24
      i32.store offset=56
      local.get 6
      i32.load offset=48
      local.set 25
      block  ;; label = @2
        block  ;; label = @3
          local.get 25
          br_if 0 (;@3;)
          local.get 6
          i32.load offset=56
          local.set 26
          local.get 6
          i32.load offset=60
          local.set 27
          local.get 6
          local.get 26
          i32.store offset=40
          local.get 6
          local.get 27
          i32.store offset=44
          br 1 (;@2;)
        end
        local.get 6
        i32.load offset=52
        local.set 28
        local.get 6
        local.get 28
        i32.store offset=44
        i32.const -2147483647
        local.set 29
        local.get 6
        local.get 29
        i32.store offset=40
      end
      local.get 6
      i32.load offset=40
      local.set 30
      i32.const -2147483647
      local.set 31
      local.get 30
      local.set 32
      local.get 31
      local.set 33
      local.get 32
      local.get 33
      i32.eq
      local.set 34
      i32.const 0
      local.set 35
      i32.const 1
      local.set 36
      i32.const 1
      local.set 37
      local.get 34
      local.get 37
      i32.and
      local.set 38
      local.get 35
      local.get 36
      local.get 38
      select
      local.set 39
      block  ;; label = @2
        block  ;; label = @3
          local.get 39
          br_if 0 (;@3;)
          local.get 6
          i32.load offset=44
          local.set 40
          local.get 6
          local.get 40
          i32.store offset=36
          i32.const -2147483647
          local.set 41
          local.get 6
          local.get 41
          i32.store offset=32
          br 1 (;@2;)
        end
        local.get 6
        i32.load offset=40
        local.set 42
        local.get 6
        i32.load offset=44
        local.set 43
        local.get 6
        local.get 42
        i32.store offset=116
        local.get 6
        local.get 43
        i32.store offset=120
        local.get 6
        i32.load offset=116
        local.set 44
        local.get 6
        i32.load offset=120
        local.set 45
        local.get 6
        local.get 44
        i32.store offset=32
        local.get 6
        local.get 45
        i32.store offset=36
      end
      local.get 6
      i32.load offset=32
      local.set 46
      i32.const -2147483647
      local.set 47
      local.get 46
      local.set 48
      local.get 47
      local.set 49
      local.get 48
      local.get 49
      i32.eq
      local.set 50
      i32.const 0
      local.set 51
      i32.const 1
      local.set 52
      i32.const 1
      local.set 53
      local.get 50
      local.get 53
      i32.and
      local.set 54
      local.get 51
      local.get 52
      local.get 54
      select
      local.set 55
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              local.get 55
              br_if 0 (;@5;)
              local.get 6
              i32.load offset=36
              local.set 56
              local.get 1
              i32.load offset=4
              local.set 57
              i32.const 1
              local.set 58
              local.get 57
              local.get 58
              i32.shl
              local.set 59
              local.get 59
              local.get 56
              call $_ZN4core3cmp6max_by17hcb9c71ffbd8edb51E
              local.set 60
              i32.const 8
              local.set 61
              local.get 61
              local.get 60
              call $_ZN4core3cmp6max_by17hcb9c71ffbd8edb51E
              local.set 62
              i32.const 1
              local.set 63
              local.get 6
              local.get 63
              local.get 63
              local.get 62
              call $_ZN4core5alloc6layout6Layout5array5inner17hde74f827f47f01deE
              local.get 6
              i32.load offset=4
              local.set 64
              local.get 6
              i32.load
              local.set 65
              i32.const 96
              local.set 66
              local.get 6
              local.get 66
              i32.add
              local.set 67
              local.get 67
              local.set 68
              local.get 68
              local.get 1
              call $_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$14current_memory17ha4b462c499445094E
              i32.const 8
              local.set 69
              local.get 1
              local.get 69
              i32.add
              local.set 70
              i32.const 84
              local.set 71
              local.get 6
              local.get 71
              i32.add
              local.set 72
              local.get 72
              local.set 73
              i32.const 96
              local.set 74
              local.get 6
              local.get 74
              i32.add
              local.set 75
              local.get 75
              local.set 76
              local.get 73
              local.get 65
              local.get 64
              local.get 76
              local.get 70
              call $_ZN5alloc7raw_vec11finish_grow17he731c50f6660e204E
              local.get 6
              i32.load offset=84
              local.set 77
              local.get 77
              i32.eqz
              br_if 1 (;@4;)
              br 2 (;@3;)
            end
            local.get 6
            i32.load offset=32
            local.set 78
            local.get 6
            i32.load offset=36
            local.set 79
            local.get 6
            local.get 78
            i32.store offset=64
            local.get 6
            local.get 79
            i32.store offset=68
            local.get 6
            i32.load offset=64
            local.set 80
            local.get 6
            i32.load offset=68
            local.set 81
            local.get 6
            local.get 80
            i32.store offset=124
            local.get 6
            local.get 81
            i32.store offset=128
            local.get 6
            i32.load offset=124
            local.set 82
            local.get 6
            i32.load offset=128
            local.set 83
            local.get 6
            local.get 82
            i32.store offset=8
            local.get 6
            local.get 83
            i32.store offset=12
            br 3 (;@1;)
          end
          local.get 6
          i32.load offset=88
          local.set 84
          local.get 6
          i32.load offset=92
          local.set 85
          local.get 6
          local.get 84
          i32.store offset=76
          local.get 6
          local.get 85
          i32.store offset=80
          i32.const 0
          local.set 86
          local.get 6
          local.get 86
          i32.store offset=72
          br 1 (;@2;)
        end
        local.get 6
        i32.load offset=88
        local.set 87
        local.get 6
        i32.load offset=92
        local.set 88
        local.get 6
        local.get 87
        i32.store offset=132
        local.get 6
        local.get 88
        i32.store offset=136
        local.get 6
        i32.load offset=132
        local.set 89
        local.get 6
        i32.load offset=136
        local.set 90
        local.get 6
        local.get 89
        i32.store offset=76
        local.get 6
        local.get 90
        i32.store offset=80
        i32.const 1
        local.set 91
        local.get 6
        local.get 91
        i32.store offset=72
      end
      local.get 6
      i32.load offset=72
      local.set 92
      block  ;; label = @2
        local.get 92
        br_if 0 (;@2;)
        local.get 6
        i32.load offset=76
        local.set 93
        local.get 6
        i32.load offset=80
        local.set 94
        local.get 1
        local.get 93
        local.get 94
        local.get 62
        call $_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$15set_ptr_and_cap17h6d3fa603e6504e05E
        i32.const -2147483647
        local.set 95
        local.get 6
        local.get 95
        i32.store offset=8
        br 1 (;@1;)
      end
      local.get 6
      i32.load offset=76
      local.set 96
      local.get 6
      i32.load offset=80
      local.set 97
      local.get 6
      local.get 96
      i32.store offset=108
      local.get 6
      local.get 97
      i32.store offset=112
      local.get 6
      i32.load offset=108
      local.set 98
      local.get 6
      i32.load offset=112
      local.set 99
      local.get 6
      local.get 98
      i32.store offset=8
      local.get 6
      local.get 99
      i32.store offset=12
    end
    local.get 6
    i32.load offset=8
    local.set 100
    local.get 6
    i32.load offset=12
    local.set 101
    local.get 0
    local.get 101
    i32.store offset=4
    local.get 0
    local.get 100
    i32.store
    i32.const 144
    local.set 102
    local.get 6
    local.get 102
    i32.add
    local.set 103
    local.get 103
    global.set $__stack_pointer
    return)
  (func $_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$15set_ptr_and_cap17h6d3fa603e6504e05E (type 8) (param i32 i32 i32 i32)
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
  (func $_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$14grow_amortized17h9b6dece91f0c91a9E (type 8) (param i32 i32 i32 i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    local.set 4
    i32.const 144
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
              i32.const 1
              local.set 12
              local.get 11
              local.get 12
              i32.and
              local.set 13
              local.get 6
              local.get 13
              i32.store8 offset=143
              local.get 6
              i32.load8_u offset=143
              local.set 14
              i32.const 1
              local.set 15
              local.get 14
              local.get 15
              i32.and
              local.set 16
              local.get 16
              br_if 2 (;@3;)
              br 1 (;@4;)
            end
            i32.const 0
            local.set 17
            local.get 6
            local.get 17
            i32.store offset=24
            local.get 6
            i32.load offset=24
            local.set 18
            local.get 6
            i32.load offset=28
            local.set 19
            local.get 6
            local.get 18
            i32.store offset=16
            local.get 6
            local.get 19
            i32.store offset=20
            local.get 6
            i32.load offset=16
            local.set 20
            local.get 6
            i32.load offset=20
            local.set 21
            local.get 6
            local.get 20
            i32.store offset=8
            local.get 6
            local.get 21
            i32.store offset=12
            br 3 (;@1;)
          end
          local.get 6
          local.get 10
          i32.store offset=52
          i32.const 1
          local.set 22
          local.get 6
          local.get 22
          i32.store offset=48
          br 1 (;@2;)
        end
        i32.const 0
        local.set 23
        local.get 6
        local.get 23
        i32.store offset=48
      end
      i32.const 0
      local.set 24
      local.get 6
      local.get 24
      i32.store offset=56
      local.get 6
      i32.load offset=48
      local.set 25
      block  ;; label = @2
        block  ;; label = @3
          local.get 25
          br_if 0 (;@3;)
          local.get 6
          i32.load offset=56
          local.set 26
          local.get 6
          i32.load offset=60
          local.set 27
          local.get 6
          local.get 26
          i32.store offset=40
          local.get 6
          local.get 27
          i32.store offset=44
          br 1 (;@2;)
        end
        local.get 6
        i32.load offset=52
        local.set 28
        local.get 6
        local.get 28
        i32.store offset=44
        i32.const -2147483647
        local.set 29
        local.get 6
        local.get 29
        i32.store offset=40
      end
      local.get 6
      i32.load offset=40
      local.set 30
      i32.const -2147483647
      local.set 31
      local.get 30
      local.set 32
      local.get 31
      local.set 33
      local.get 32
      local.get 33
      i32.eq
      local.set 34
      i32.const 0
      local.set 35
      i32.const 1
      local.set 36
      i32.const 1
      local.set 37
      local.get 34
      local.get 37
      i32.and
      local.set 38
      local.get 35
      local.get 36
      local.get 38
      select
      local.set 39
      block  ;; label = @2
        block  ;; label = @3
          local.get 39
          br_if 0 (;@3;)
          local.get 6
          i32.load offset=44
          local.set 40
          local.get 6
          local.get 40
          i32.store offset=36
          i32.const -2147483647
          local.set 41
          local.get 6
          local.get 41
          i32.store offset=32
          br 1 (;@2;)
        end
        local.get 6
        i32.load offset=40
        local.set 42
        local.get 6
        i32.load offset=44
        local.set 43
        local.get 6
        local.get 42
        i32.store offset=116
        local.get 6
        local.get 43
        i32.store offset=120
        local.get 6
        i32.load offset=116
        local.set 44
        local.get 6
        i32.load offset=120
        local.set 45
        local.get 6
        local.get 44
        i32.store offset=32
        local.get 6
        local.get 45
        i32.store offset=36
      end
      local.get 6
      i32.load offset=32
      local.set 46
      i32.const -2147483647
      local.set 47
      local.get 46
      local.set 48
      local.get 47
      local.set 49
      local.get 48
      local.get 49
      i32.eq
      local.set 50
      i32.const 0
      local.set 51
      i32.const 1
      local.set 52
      i32.const 1
      local.set 53
      local.get 50
      local.get 53
      i32.and
      local.set 54
      local.get 51
      local.get 52
      local.get 54
      select
      local.set 55
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              local.get 55
              br_if 0 (;@5;)
              local.get 6
              i32.load offset=36
              local.set 56
              local.get 1
              i32.load offset=4
              local.set 57
              i32.const 1
              local.set 58
              local.get 57
              local.get 58
              i32.shl
              local.set 59
              local.get 59
              local.get 56
              call $_ZN4core3cmp6max_by17hcb9c71ffbd8edb51E
              local.set 60
              i32.const 8
              local.set 61
              local.get 61
              local.get 60
              call $_ZN4core3cmp6max_by17hcb9c71ffbd8edb51E
              local.set 62
              i32.const 1
              local.set 63
              local.get 6
              local.get 63
              local.get 63
              local.get 62
              call $_ZN4core5alloc6layout6Layout5array5inner17hde74f827f47f01deE
              local.get 6
              i32.load offset=4
              local.set 64
              local.get 6
              i32.load
              local.set 65
              i32.const 96
              local.set 66
              local.get 6
              local.get 66
              i32.add
              local.set 67
              local.get 67
              local.set 68
              local.get 68
              local.get 1
              call $_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$14current_memory17ha73de0fe0a34a4bcE
              i32.const 8
              local.set 69
              local.get 1
              local.get 69
              i32.add
              local.set 70
              i32.const 84
              local.set 71
              local.get 6
              local.get 71
              i32.add
              local.set 72
              local.get 72
              local.set 73
              i32.const 96
              local.set 74
              local.get 6
              local.get 74
              i32.add
              local.set 75
              local.get 75
              local.set 76
              local.get 73
              local.get 65
              local.get 64
              local.get 76
              local.get 70
              call $_ZN5alloc7raw_vec11finish_grow17he731c50f6660e204E
              local.get 6
              i32.load offset=84
              local.set 77
              local.get 77
              i32.eqz
              br_if 1 (;@4;)
              br 2 (;@3;)
            end
            local.get 6
            i32.load offset=32
            local.set 78
            local.get 6
            i32.load offset=36
            local.set 79
            local.get 6
            local.get 78
            i32.store offset=64
            local.get 6
            local.get 79
            i32.store offset=68
            local.get 6
            i32.load offset=64
            local.set 80
            local.get 6
            i32.load offset=68
            local.set 81
            local.get 6
            local.get 80
            i32.store offset=124
            local.get 6
            local.get 81
            i32.store offset=128
            local.get 6
            i32.load offset=124
            local.set 82
            local.get 6
            i32.load offset=128
            local.set 83
            local.get 6
            local.get 82
            i32.store offset=8
            local.get 6
            local.get 83
            i32.store offset=12
            br 3 (;@1;)
          end
          local.get 6
          i32.load offset=88
          local.set 84
          local.get 6
          i32.load offset=92
          local.set 85
          local.get 6
          local.get 84
          i32.store offset=76
          local.get 6
          local.get 85
          i32.store offset=80
          i32.const 0
          local.set 86
          local.get 6
          local.get 86
          i32.store offset=72
          br 1 (;@2;)
        end
        local.get 6
        i32.load offset=88
        local.set 87
        local.get 6
        i32.load offset=92
        local.set 88
        local.get 6
        local.get 87
        i32.store offset=132
        local.get 6
        local.get 88
        i32.store offset=136
        local.get 6
        i32.load offset=132
        local.set 89
        local.get 6
        i32.load offset=136
        local.set 90
        local.get 6
        local.get 89
        i32.store offset=76
        local.get 6
        local.get 90
        i32.store offset=80
        i32.const 1
        local.set 91
        local.get 6
        local.get 91
        i32.store offset=72
      end
      local.get 6
      i32.load offset=72
      local.set 92
      block  ;; label = @2
        local.get 92
        br_if 0 (;@2;)
        local.get 6
        i32.load offset=76
        local.set 93
        local.get 6
        i32.load offset=80
        local.set 94
        local.get 1
        local.get 93
        local.get 94
        local.get 62
        call $_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$15set_ptr_and_cap17h2c89ff5ef243b551E
        i32.const -2147483647
        local.set 95
        local.get 6
        local.get 95
        i32.store offset=8
        br 1 (;@1;)
      end
      local.get 6
      i32.load offset=76
      local.set 96
      local.get 6
      i32.load offset=80
      local.set 97
      local.get 6
      local.get 96
      i32.store offset=108
      local.get 6
      local.get 97
      i32.store offset=112
      local.get 6
      i32.load offset=108
      local.set 98
      local.get 6
      i32.load offset=112
      local.set 99
      local.get 6
      local.get 98
      i32.store offset=8
      local.get 6
      local.get 99
      i32.store offset=12
    end
    local.get 6
    i32.load offset=8
    local.set 100
    local.get 6
    i32.load offset=12
    local.set 101
    local.get 0
    local.get 101
    i32.store offset=4
    local.get 0
    local.get 100
    i32.store
    i32.const 144
    local.set 102
    local.get 6
    local.get 102
    i32.add
    local.set 103
    local.get 103
    global.set $__stack_pointer
    return)
  (func $_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$15set_ptr_and_cap17h2c89ff5ef243b551E (type 8) (param i32 i32 i32 i32)
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
  (func $_ZN63_$LT$I$u20$as$u20$core..iter..traits..collect..IntoIterator$GT$9into_iter17h0ba1ca6b454d9fe0E (type 3) (param i32 i32 i32)
    local.get 0
    local.get 2
    i32.store offset=4
    local.get 0
    local.get 1
    i32.store
    return)
  (func $_ZN63_$LT$I$u20$as$u20$core..iter..traits..collect..IntoIterator$GT$9into_iter17h313fbb621871c988E (type 3) (param i32 i32 i32)
    local.get 0
    local.get 2
    i32.store offset=4
    local.get 0
    local.get 1
    i32.store
    return)
  (func $_ZN63_$LT$I$u20$as$u20$core..iter..traits..collect..IntoIterator$GT$9into_iter17hcfddbcd869d44ef5E (type 3) (param i32 i32 i32)
    local.get 0
    local.get 2
    i32.store offset=4
    local.get 0
    local.get 1
    i32.store
    return)
  (func $_ZN63_$LT$I$u20$as$u20$core..iter..traits..collect..IntoIterator$GT$9into_iter17hf1002aae9a2c2681E (type 0) (param i32 i32)
    (local i64 i32 i32 i32 i32)
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
    i32.load
    local.set 6
    local.get 4
    local.get 6
    i32.store
    return)
  (func $_ZN67_$LT$alloc..vec..Vec$LT$T$C$A$GT$$u20$as$u20$core..clone..Clone$GT$5clone17heebdd7c90834221cE (type 0) (param i32 i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
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
    i32.const 8
    local.set 5
    local.get 1
    local.get 5
    i32.add
    local.set 6
    local.get 6
    call $_ZN59_$LT$alloc..alloc..Global$u20$as$u20$core..clone..Clone$GT$5clone17h7110c1abb4d70507E
    local.get 1
    i32.load
    local.set 7
    local.get 1
    i32.load offset=8
    local.set 8
    local.get 4
    local.get 7
    i32.store offset=8
    local.get 4
    local.get 8
    i32.store offset=12
    local.get 4
    i32.load offset=8
    local.set 9
    local.get 4
    i32.load offset=12
    local.set 10
    local.get 4
    local.get 9
    i32.store
    local.get 4
    local.get 10
    i32.store offset=4
    local.get 4
    i32.load
    local.set 11
    local.get 4
    i32.load offset=4
    local.set 12
    local.get 0
    local.get 11
    local.get 12
    call $_ZN52_$LT$T$u20$as$u20$alloc..slice..hack..ConvertVec$GT$6to_vec17hbb25be0127bcc92dE
    i32.const 16
    local.set 13
    local.get 4
    local.get 13
    i32.add
    local.set 14
    local.get 14
    global.set $__stack_pointer
    return)
  (func $_ZN75_$LT$usize$u20$as$u20$core..slice..index..SliceIndex$LT$$u5b$T$u5d$$GT$$GT$5index17h585d43bdd37fa8a5E (type 11) (param i32 i32 i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32)
    local.get 0
    local.set 4
    local.get 2
    local.set 5
    local.get 4
    local.get 5
    i32.lt_u
    local.set 6
    i32.const 1
    local.set 7
    local.get 6
    local.get 7
    i32.and
    local.set 8
    block  ;; label = @1
      local.get 8
      i32.eqz
      br_if 0 (;@1;)
      local.get 1
      local.get 0
      i32.add
      local.set 9
      local.get 9
      return
    end
    local.get 0
    local.get 2
    local.get 3
    call $_ZN4core9panicking18panic_bounds_check17h66aea8b9574ca63eE
    unreachable)
  (func $_ZN75_$LT$usize$u20$as$u20$core..slice..index..SliceIndex$LT$$u5b$T$u5d$$GT$$GT$9index_mut17h4a6056bb7ffef6d7E (type 11) (param i32 i32 i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32)
    local.get 0
    local.set 4
    local.get 2
    local.set 5
    local.get 4
    local.get 5
    i32.lt_u
    local.set 6
    i32.const 1
    local.set 7
    local.get 6
    local.get 7
    i32.and
    local.set 8
    block  ;; label = @1
      local.get 8
      i32.eqz
      br_if 0 (;@1;)
      local.get 1
      local.get 0
      i32.add
      local.set 9
      local.get 9
      return
    end
    local.get 0
    local.get 2
    local.get 3
    call $_ZN4core9panicking18panic_bounds_check17h66aea8b9574ca63eE
    unreachable)
  (func $_ZN79_$LT$core..result..Result$LT$T$C$E$GT$$u20$as$u20$core..ops..try_trait..Try$GT$6branch17h8a3a2ca631598309E (type 4) (param i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    local.set 1
    i32.const 16
    local.set 2
    local.get 1
    local.get 2
    i32.sub
    local.set 3
    local.get 0
    local.set 4
    local.get 3
    local.get 4
    i32.store8 offset=14
    local.get 3
    i32.load8_u offset=14
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
        i32.const 0
        local.set 8
        local.get 3
        local.get 8
        i32.store8 offset=15
        br 1 (;@1;)
      end
      i32.const 1
      local.set 9
      local.get 3
      local.get 9
      i32.store8 offset=15
    end
    local.get 3
    i32.load8_u offset=15
    local.set 10
    i32.const 1
    local.set 11
    local.get 10
    local.get 11
    i32.and
    local.set 12
    local.get 12
    return)
  (func $_ZN81_$LT$alloc..vec..Vec$LT$T$C$A$GT$$u20$as$u20$core..ops..index..Index$LT$I$GT$$GT$5index17hc80771b6cdb9dca7E (type 1) (param i32 i32 i32) (result i32)
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
    global.set $__stack_pointer
    local.get 0
    i32.load
    local.set 6
    local.get 0
    i32.load offset=8
    local.set 7
    local.get 5
    local.get 6
    i32.store offset=8
    local.get 5
    local.get 7
    i32.store offset=12
    local.get 5
    i32.load offset=8
    local.set 8
    local.get 5
    i32.load offset=12
    local.set 9
    local.get 5
    local.get 8
    i32.store
    local.get 5
    local.get 9
    i32.store offset=4
    local.get 5
    i32.load
    local.set 10
    local.get 5
    i32.load offset=4
    local.set 11
    local.get 1
    local.get 10
    local.get 11
    local.get 2
    call $_ZN75_$LT$usize$u20$as$u20$core..slice..index..SliceIndex$LT$$u5b$T$u5d$$GT$$GT$5index17h585d43bdd37fa8a5E
    local.set 12
    i32.const 16
    local.set 13
    local.get 5
    local.get 13
    i32.add
    local.set 14
    local.get 14
    global.set $__stack_pointer
    local.get 12
    return)
  (func $_ZN84_$LT$alloc..vec..Vec$LT$T$C$A$GT$$u20$as$u20$core..ops..index..IndexMut$LT$I$GT$$GT$9index_mut17he9915f9782aea272E (type 1) (param i32 i32 i32) (result i32)
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
    global.set $__stack_pointer
    local.get 0
    i32.load
    local.set 6
    local.get 0
    i32.load offset=8
    local.set 7
    local.get 5
    local.get 6
    i32.store offset=8
    local.get 5
    local.get 7
    i32.store offset=12
    local.get 5
    i32.load offset=8
    local.set 8
    local.get 5
    i32.load offset=12
    local.set 9
    local.get 5
    local.get 8
    i32.store
    local.get 5
    local.get 9
    i32.store offset=4
    local.get 5
    i32.load
    local.set 10
    local.get 5
    i32.load offset=4
    local.set 11
    local.get 1
    local.get 10
    local.get 11
    local.get 2
    call $_ZN75_$LT$usize$u20$as$u20$core..slice..index..SliceIndex$LT$$u5b$T$u5d$$GT$$GT$9index_mut17h4a6056bb7ffef6d7E
    local.set 12
    i32.const 16
    local.set 13
    local.get 5
    local.get 13
    i32.add
    local.set 14
    local.get 14
    global.set $__stack_pointer
    local.get 12
    return)
  (func $_ZN91_$LT$core..slice..iter..Iter$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17h7476dad7275f695fE (type 4) (param i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
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
    i32.const 1
    local.set 5
    local.get 4
    local.get 5
    i32.and
    local.set 6
    block  ;; label = @1
      block  ;; label = @2
        local.get 6
        br_if 0 (;@2;)
        local.get 0
        i32.load offset=4
        local.set 7
        local.get 0
        i32.load
        local.set 8
        local.get 8
        local.set 9
        local.get 7
        local.set 10
        local.get 9
        local.get 10
        i32.eq
        local.set 11
        i32.const 1
        local.set 12
        local.get 11
        local.get 12
        i32.and
        local.set 13
        local.get 3
        local.get 13
        i32.store8 offset=11
        br 1 (;@1;)
      end
      local.get 0
      i32.load offset=4
      local.set 14
      i32.const 0
      local.set 15
      local.get 14
      local.set 16
      local.get 15
      local.set 17
      local.get 16
      local.get 17
      i32.eq
      local.set 18
      i32.const 1
      local.set 19
      local.get 18
      local.get 19
      i32.and
      local.set 20
      local.get 3
      local.get 20
      i32.store8 offset=11
    end
    local.get 3
    i32.load8_u offset=11
    local.set 21
    i32.const 1
    local.set 22
    local.get 21
    local.get 22
    i32.and
    local.set 23
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              local.get 23
              br_if 0 (;@5;)
              local.get 0
              i32.load
              local.set 24
              i32.const 0
              local.set 25
              i32.const 1
              local.set 26
              local.get 25
              local.get 26
              i32.and
              local.set 27
              local.get 27
              br_if 2 (;@3;)
              br 1 (;@4;)
            end
            i32.const 0
            local.set 28
            local.get 3
            local.get 28
            i32.store offset=4
            br 3 (;@1;)
          end
          local.get 0
          i32.load
          local.set 29
          i32.const 1
          local.set 30
          local.get 29
          local.get 30
          i32.add
          local.set 31
          local.get 3
          local.get 31
          i32.store offset=12
          local.get 3
          i32.load offset=12
          local.set 32
          local.get 0
          local.get 32
          i32.store
          br 1 (;@2;)
        end
        local.get 0
        i32.load offset=4
        local.set 33
        i32.const 1
        local.set 34
        local.get 33
        local.get 34
        i32.sub
        local.set 35
        local.get 0
        local.get 35
        i32.store offset=4
      end
      local.get 3
      local.get 24
      i32.store offset=4
    end
    local.get 3
    i32.load offset=4
    local.set 36
    local.get 36
    return)
  (func $_ZN93_$LT$core..slice..iter..Chunks$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17h51255239889b08a6E (type 0) (param i32 i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    local.set 2
    i32.const 48
    local.set 3
    local.get 2
    local.get 3
    i32.sub
    local.set 4
    local.get 4
    global.set $__stack_pointer
    local.get 1
    i32.load offset=4
    local.set 5
    block  ;; label = @1
      block  ;; label = @2
        local.get 5
        br_if 0 (;@2;)
        i32.const 0
        local.set 6
        local.get 4
        local.get 6
        i32.store offset=8
        br 1 (;@1;)
      end
      local.get 1
      i32.load offset=4
      local.set 7
      local.get 1
      i32.load offset=8
      local.set 8
      local.get 7
      local.get 8
      call $_ZN4core3cmp6min_by17h49e049503750c28bE
      local.set 9
      local.get 1
      i32.load
      local.set 10
      local.get 1
      i32.load offset=4
      local.set 11
      local.get 9
      local.set 12
      local.get 11
      local.set 13
      local.get 12
      local.get 13
      i32.le_u
      local.set 14
      i32.const 1
      local.set 15
      local.get 14
      local.get 15
      i32.and
      local.set 16
      block  ;; label = @2
        local.get 16
        br_if 0 (;@2;)
        i32.const 1049480
        local.set 17
        i32.const 35
        local.set 18
        i32.const 1049596
        local.set 19
        local.get 17
        local.get 18
        local.get 19
        call $_ZN4core9panicking5panic17hb41dbc4083d9884eE
        unreachable
      end
      local.get 4
      local.get 10
      i32.store offset=24
      local.get 4
      local.get 9
      i32.store offset=28
      local.get 4
      i32.load offset=24
      local.set 20
      local.get 4
      i32.load offset=28
      local.set 21
      local.get 4
      local.get 20
      i32.store offset=16
      local.get 4
      local.get 21
      i32.store offset=20
      local.get 4
      i32.load offset=16
      local.set 22
      local.get 4
      i32.load offset=20
      local.set 23
      local.get 10
      local.get 9
      i32.add
      local.set 24
      local.get 11
      local.get 9
      i32.sub
      local.set 25
      local.get 4
      local.get 24
      i32.store offset=40
      local.get 4
      local.get 25
      i32.store offset=44
      local.get 4
      i32.load offset=40
      local.set 26
      local.get 4
      i32.load offset=44
      local.set 27
      local.get 4
      local.get 26
      i32.store offset=32
      local.get 4
      local.get 27
      i32.store offset=36
      local.get 4
      i32.load offset=32
      local.set 28
      local.get 4
      i32.load offset=36
      local.set 29
      local.get 1
      local.get 28
      i32.store
      local.get 1
      local.get 29
      i32.store offset=4
      local.get 4
      local.get 22
      i32.store offset=8
      local.get 4
      local.get 23
      i32.store offset=12
    end
    local.get 4
    i32.load offset=8
    local.set 30
    local.get 4
    i32.load offset=12
    local.set 31
    local.get 0
    local.get 31
    i32.store offset=4
    local.get 0
    local.get 30
    i32.store
    i32.const 48
    local.set 32
    local.get 4
    local.get 32
    i32.add
    local.set 33
    local.get 33
    global.set $__stack_pointer
    return)
  (func $_ZN98_$LT$alloc..vec..Vec$LT$T$GT$$u20$as$u20$alloc..vec..spec_from_iter..SpecFromIter$LT$T$C$I$GT$$GT$9from_iter17hef5f9e0868bfddb3E (type 3) (param i32 i32 i32)
    local.get 0
    local.get 1
    local.get 2
    call $_ZN111_$LT$alloc..vec..Vec$LT$T$GT$$u20$as$u20$alloc..vec..spec_from_iter_nested..SpecFromIterNested$LT$T$C$I$GT$$GT$9from_iter17h6f338b4443ee7d7bE
    return)
  (func $new (type 7) (param i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i64 i32 i32 i32 i32 i32 i64 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
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
    i32.const 0
    local.set 4
    i32.const 4096
    local.set 5
    i32.const 1
    local.set 6
    local.get 4
    local.get 6
    i32.and
    local.set 7
    block  ;; label = @1
      local.get 7
      br_if 0 (;@1;)
      i32.const 0
      local.set 8
      local.get 3
      local.get 8
      i32.store offset=40
      local.get 3
      local.get 5
      i32.store offset=44
      local.get 3
      i32.load offset=40
      local.set 9
      local.get 3
      i32.load offset=44
      local.set 10
      local.get 3
      local.get 9
      local.get 10
      call $_ZN4core4iter6traits8iterator8Iterator3map17h6424cf1e29a4fd28E
      local.get 3
      i32.load offset=4
      local.set 11
      local.get 3
      i32.load
      local.set 12
      i32.const 28
      local.set 13
      local.get 3
      local.get 13
      i32.add
      local.set 14
      local.get 14
      local.get 12
      local.get 11
      call $_ZN4core4iter6traits8iterator8Iterator7collect17h5a7d05434a394ca9E
      i32.const 8
      local.set 15
      i32.const 48
      local.set 16
      local.get 3
      local.get 16
      i32.add
      local.set 17
      local.get 17
      local.get 15
      i32.add
      local.set 18
      i32.const 28
      local.set 19
      local.get 3
      local.get 19
      i32.add
      local.set 20
      local.get 20
      local.get 15
      i32.add
      local.set 21
      local.get 21
      i32.load
      local.set 22
      local.get 18
      local.get 22
      i32.store
      local.get 3
      i64.load offset=28 align=4
      local.set 23
      local.get 3
      local.get 23
      i64.store offset=48
      i32.const 64
      local.set 24
      local.get 3
      local.get 24
      i32.store offset=20
      local.get 3
      local.get 24
      i32.store offset=24
      i32.const 8
      local.set 25
      local.get 3
      local.get 25
      i32.add
      local.set 26
      local.get 26
      local.get 15
      i32.add
      local.set 27
      local.get 18
      i32.load
      local.set 28
      local.get 27
      local.get 28
      i32.store
      local.get 3
      i64.load offset=48
      local.set 29
      local.get 3
      local.get 29
      i64.store offset=8
      local.get 27
      i32.load
      local.set 30
      local.get 3
      i32.load offset=8
      local.set 31
      local.get 3
      i32.load offset=12
      local.set 32
      local.get 3
      i32.load offset=20
      local.set 33
      local.get 3
      i32.load offset=24
      local.set 34
      local.get 0
      local.get 34
      i32.store offset=16
      local.get 0
      local.get 33
      i32.store offset=12
      local.get 0
      local.get 30
      i32.store offset=8
      local.get 0
      local.get 32
      i32.store offset=4
      local.get 0
      local.get 31
      i32.store
      i32.const 64
      local.set 35
      local.get 3
      local.get 35
      i32.add
      local.set 36
      local.get 36
      global.set $__stack_pointer
      return
    end
    i32.const 1049696
    local.set 37
    i32.const 33
    local.set 38
    i32.const 1049668
    local.set 39
    local.get 37
    local.get 38
    local.get 39
    call $_ZN4core9panicking5panic17hb41dbc4083d9884eE
    unreachable)
  (func $render (type 0) (param i32 i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
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
    i32.const 4
    local.set 5
    local.get 4
    local.get 5
    i32.add
    local.set 6
    local.get 6
    local.get 1
    call $_ZN45_$LT$T$u20$as$u20$alloc..string..ToString$GT$9to_string17hb6bda17ee49bda31E
    local.get 4
    i32.load offset=4
    local.set 7
    local.get 4
    i32.load offset=8
    local.set 8
    local.get 4
    i32.load offset=12
    local.set 9
    local.get 0
    local.get 9
    i32.store offset=8
    local.get 0
    local.get 8
    i32.store offset=4
    local.get 0
    local.get 7
    i32.store
    i32.const 16
    local.set 10
    local.get 4
    local.get 10
    i32.add
    local.set 11
    local.get 11
    global.set $__stack_pointer
    return)
  (func $tick (type 7) (param i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i64 i64 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    local.set 1
    i32.const 112
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
    local.set 6
    local.get 6
    local.get 0
    call $_ZN67_$LT$alloc..vec..Vec$LT$T$C$A$GT$$u20$as$u20$core..clone..Clone$GT$5clone17heebdd7c90834221cE
    local.get 0
    i32.load offset=16
    local.set 7
    i32.const 0
    local.set 8
    local.get 3
    local.get 8
    i32.store offset=44
    local.get 3
    local.get 7
    i32.store offset=48
    local.get 3
    i32.load offset=44
    local.set 9
    local.get 3
    i32.load offset=48
    local.set 10
    i32.const 24
    local.set 11
    local.get 3
    local.get 11
    i32.add
    local.set 12
    local.get 12
    local.get 9
    local.get 10
    call $_ZN63_$LT$I$u20$as$u20$core..iter..traits..collect..IntoIterator$GT$9into_iter17hcfddbcd869d44ef5E
    local.get 3
    i32.load offset=28
    local.set 13
    local.get 3
    i32.load offset=24
    local.set 14
    local.get 3
    local.get 14
    i32.store offset=52
    local.get 3
    local.get 13
    i32.store offset=56
    loop  ;; label = @1
      i32.const 16
      local.set 15
      local.get 3
      local.get 15
      i32.add
      local.set 16
      i32.const 52
      local.set 17
      local.get 3
      local.get 17
      i32.add
      local.set 18
      local.get 16
      local.get 18
      call $_ZN4core4iter5range101_$LT$impl$u20$core..iter..traits..iterator..Iterator$u20$for$u20$core..ops..range..Range$LT$A$GT$$GT$4next17hb8a5ddf94a022688E
      local.get 3
      i32.load offset=16
      local.set 19
      local.get 3
      i32.load offset=20
      local.set 20
      local.get 3
      local.get 20
      i32.store offset=64
      local.get 3
      local.get 19
      i32.store offset=60
      local.get 3
      i32.load offset=60
      local.set 21
      block  ;; label = @2
        local.get 21
        br_if 0 (;@2;)
        i32.const 8
        local.set 22
        i32.const 96
        local.set 23
        local.get 3
        local.get 23
        i32.add
        local.set 24
        local.get 24
        local.get 22
        i32.add
        local.set 25
        i32.const 32
        local.set 26
        local.get 3
        local.get 26
        i32.add
        local.set 27
        local.get 27
        local.get 22
        i32.add
        local.set 28
        local.get 28
        i32.load
        local.set 29
        local.get 25
        local.get 29
        i32.store
        local.get 3
        i64.load offset=32 align=4
        local.set 30
        local.get 3
        local.get 30
        i64.store offset=96
        local.get 0
        call $_ZN4core3ptr55drop_in_place$LT$alloc..vec..Vec$LT$index..Cell$GT$$GT$17h7e423565a133bf60E
        local.get 3
        i64.load offset=96 align=4
        local.set 31
        local.get 0
        local.get 31
        i64.store align=4
        i32.const 8
        local.set 32
        local.get 0
        local.get 32
        i32.add
        local.set 33
        i32.const 96
        local.set 34
        local.get 3
        local.get 34
        i32.add
        local.set 35
        local.get 35
        local.get 32
        i32.add
        local.set 36
        local.get 36
        i32.load
        local.set 37
        local.get 33
        local.get 37
        i32.store
        i32.const 112
        local.set 38
        local.get 3
        local.get 38
        i32.add
        local.set 39
        local.get 39
        global.set $__stack_pointer
        return
      end
      local.get 3
      i32.load offset=64
      local.set 40
      local.get 0
      i32.load offset=12
      local.set 41
      i32.const 0
      local.set 42
      local.get 3
      local.get 42
      i32.store offset=68
      local.get 3
      local.get 41
      i32.store offset=72
      local.get 3
      i32.load offset=68
      local.set 43
      local.get 3
      i32.load offset=72
      local.set 44
      i32.const 8
      local.set 45
      local.get 3
      local.get 45
      i32.add
      local.set 46
      local.get 46
      local.get 43
      local.get 44
      call $_ZN63_$LT$I$u20$as$u20$core..iter..traits..collect..IntoIterator$GT$9into_iter17hcfddbcd869d44ef5E
      local.get 3
      i32.load offset=12
      local.set 47
      local.get 3
      i32.load offset=8
      local.set 48
      local.get 3
      local.get 48
      i32.store offset=76
      local.get 3
      local.get 47
      i32.store offset=80
      loop  ;; label = @2
        i32.const 76
        local.set 49
        local.get 3
        local.get 49
        i32.add
        local.set 50
        local.get 3
        local.get 50
        call $_ZN4core4iter5range101_$LT$impl$u20$core..iter..traits..iterator..Iterator$u20$for$u20$core..ops..range..Range$LT$A$GT$$GT$4next17hb8a5ddf94a022688E
        local.get 3
        i32.load
        local.set 51
        local.get 3
        i32.load offset=4
        local.set 52
        local.get 3
        local.get 52
        i32.store offset=88
        local.get 3
        local.get 51
        i32.store offset=84
        local.get 3
        i32.load offset=84
        local.set 53
        local.get 53
        i32.eqz
        br_if 1 (;@1;)
        local.get 3
        i32.load offset=88
        local.set 54
        local.get 0
        local.get 40
        local.get 54
        call $_ZN5index8Universe9get_index17h5a48cdd7f3281fb5E
        local.set 55
        i32.const 1049732
        local.set 56
        local.get 0
        local.get 55
        local.get 56
        call $_ZN81_$LT$alloc..vec..Vec$LT$T$C$A$GT$$u20$as$u20$core..ops..index..Index$LT$I$GT$$GT$5index17hc80771b6cdb9dca7E
        local.set 57
        local.get 57
        i32.load8_u
        local.set 58
        local.get 0
        local.get 40
        local.get 54
        call $_ZN5index8Universe19live_neighbor_count17heb1f02b6fca859a7E
        local.set 59
        i32.const 1
        local.set 60
        local.get 58
        local.get 60
        i32.and
        local.set 61
        local.get 3
        local.get 61
        i32.store8 offset=94
        local.get 3
        local.get 59
        i32.store8 offset=95
        local.get 3
        i32.load8_u offset=94
        local.set 62
        i32.const 1
        local.set 63
        local.get 62
        local.get 63
        i32.and
        local.set 64
        i32.const 0
        local.set 65
        i32.const 255
        local.set 66
        local.get 64
        local.get 66
        i32.and
        local.set 67
        i32.const 255
        local.set 68
        local.get 65
        local.get 68
        i32.and
        local.set 69
        local.get 67
        local.get 69
        i32.eq
        local.set 70
        i32.const 1
        local.set 71
        local.get 70
        local.get 71
        i32.and
        local.set 72
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              block  ;; label = @6
                block  ;; label = @7
                  block  ;; label = @8
                    block  ;; label = @9
                      block  ;; label = @10
                        block  ;; label = @11
                          local.get 72
                          i32.eqz
                          br_if 0 (;@11;)
                          local.get 3
                          i32.load8_u offset=95
                          local.set 73
                          i32.const 3
                          local.set 74
                          i32.const 255
                          local.set 75
                          local.get 73
                          local.get 75
                          i32.and
                          local.set 76
                          i32.const 255
                          local.set 77
                          local.get 74
                          local.get 77
                          i32.and
                          local.set 78
                          local.get 76
                          local.get 78
                          i32.eq
                          local.set 79
                          i32.const 1
                          local.set 80
                          local.get 79
                          local.get 80
                          i32.and
                          local.set 81
                          local.get 81
                          br_if 1 (;@10;)
                          br 7 (;@4;)
                        end
                        local.get 3
                        i32.load8_u offset=95
                        local.set 82
                        i32.const 2
                        local.set 83
                        i32.const 255
                        local.set 84
                        local.get 82
                        local.get 84
                        i32.and
                        local.set 85
                        i32.const 255
                        local.set 86
                        local.get 83
                        local.get 86
                        i32.and
                        local.set 87
                        local.get 85
                        local.get 87
                        i32.lt_u
                        local.set 88
                        i32.const 1
                        local.set 89
                        local.get 88
                        local.get 89
                        i32.and
                        local.set 90
                        local.get 90
                        br_if 2 (;@8;)
                        br 1 (;@9;)
                      end
                      i32.const 1
                      local.set 91
                      local.get 3
                      local.get 91
                      i32.store8 offset=93
                      br 6 (;@3;)
                    end
                    local.get 3
                    i32.load8_u offset=95
                    local.set 92
                    i32.const -2
                    local.set 93
                    local.get 92
                    local.get 93
                    i32.add
                    local.set 94
                    i32.const 255
                    local.set 95
                    local.get 94
                    local.get 95
                    i32.and
                    local.set 96
                    i32.const 2
                    local.set 97
                    local.get 96
                    local.get 97
                    i32.lt_u
                    local.set 98
                    local.get 98
                    br_if 2 (;@6;)
                    br 1 (;@7;)
                  end
                  i32.const 0
                  local.set 99
                  local.get 3
                  local.get 99
                  i32.store8 offset=93
                  br 4 (;@3;)
                end
                local.get 3
                i32.load8_u offset=95
                local.set 100
                i32.const 3
                local.set 101
                i32.const 255
                local.set 102
                local.get 100
                local.get 102
                i32.and
                local.set 103
                i32.const 255
                local.set 104
                local.get 101
                local.get 104
                i32.and
                local.set 105
                local.get 103
                local.get 105
                i32.gt_u
                local.set 106
                i32.const 1
                local.set 107
                local.get 106
                local.get 107
                i32.and
                local.set 108
                local.get 108
                br_if 1 (;@5;)
                br 2 (;@4;)
              end
              i32.const 1
              local.set 109
              local.get 3
              local.get 109
              i32.store8 offset=93
              br 2 (;@3;)
            end
            i32.const 0
            local.set 110
            local.get 3
            local.get 110
            i32.store8 offset=93
            br 1 (;@3;)
          end
          local.get 3
          i32.load8_u offset=94
          local.set 111
          i32.const 1
          local.set 112
          local.get 111
          local.get 112
          i32.and
          local.set 113
          local.get 3
          local.get 113
          i32.store8 offset=93
        end
        local.get 3
        i32.load8_u offset=93
        local.set 114
        i32.const 32
        local.set 115
        local.get 3
        local.get 115
        i32.add
        local.set 116
        local.get 116
        local.set 117
        i32.const 1049748
        local.set 118
        local.get 117
        local.get 55
        local.get 118
        call $_ZN84_$LT$alloc..vec..Vec$LT$T$C$A$GT$$u20$as$u20$core..ops..index..IndexMut$LT$I$GT$$GT$9index_mut17he9915f9782aea272E
        local.set 119
        i32.const 1
        local.set 120
        local.get 114
        local.get 120
        i32.and
        local.set 121
        local.get 119
        local.get 121
        i32.store8
        br 0 (;@2;)
      end
    end)
  (func $_ZN5index8Universe9get_index17h5a48cdd7f3281fb5E (type 1) (param i32 i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    local.get 0
    i32.load offset=12
    local.set 3
    local.get 1
    local.get 3
    i32.add
    local.set 4
    local.get 4
    local.get 1
    i32.lt_u
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
          local.get 7
          br_if 0 (;@3;)
          local.get 4
          local.get 2
          i32.add
          local.set 8
          local.get 8
          local.get 4
          i32.lt_u
          local.set 9
          i32.const 1
          local.set 10
          local.get 9
          local.get 10
          i32.and
          local.set 11
          local.get 11
          br_if 2 (;@1;)
          br 1 (;@2;)
        end
        i32.const 1049792
        local.set 12
        i32.const 28
        local.set 13
        i32.const 1049764
        local.set 14
        local.get 12
        local.get 13
        local.get 14
        call $_ZN4core9panicking5panic17hb41dbc4083d9884eE
        unreachable
      end
      local.get 8
      return
    end
    i32.const 1049792
    local.set 15
    i32.const 28
    local.set 16
    i32.const 1049820
    local.set 17
    local.get 15
    local.get 16
    local.get 17
    call $_ZN4core9panicking5panic17hb41dbc4083d9884eE
    unreachable)
  (func $_ZN5index8Universe19live_neighbor_count17heb1f02b6fca859a7E (type 1) (param i32 i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    local.set 3
    i32.const 128
    local.set 4
    local.get 3
    local.get 4
    i32.sub
    local.set 5
    local.get 5
    global.set $__stack_pointer
    i32.const 0
    local.set 6
    local.get 5
    local.get 6
    i32.store8 offset=67
    local.get 0
    i32.load offset=16
    local.set 7
    i32.const 1
    local.set 8
    local.get 7
    local.get 8
    i32.sub
    local.set 9
    i32.const 1
    local.set 10
    local.get 7
    local.set 11
    local.get 10
    local.set 12
    local.get 11
    local.get 12
    i32.lt_u
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
        local.get 5
        local.get 9
        i32.store offset=68
        i32.const 0
        local.set 16
        local.get 5
        local.get 16
        i32.store offset=72
        i32.const 1
        local.set 17
        local.get 5
        local.get 17
        i32.store offset=76
        i32.const 3
        local.set 18
        i32.const 40
        local.set 19
        local.get 5
        local.get 19
        i32.add
        local.set 20
        i32.const 68
        local.set 21
        local.get 5
        local.get 21
        i32.add
        local.set 22
        local.get 20
        local.get 22
        local.get 18
        call $_ZN4core5slice29_$LT$impl$u20$$u5b$T$u5d$$GT$4iter17h2f82be2143302357E
        local.get 5
        i32.load offset=44
        local.set 23
        local.get 5
        i32.load offset=40
        local.set 24
        i32.const 48
        local.set 25
        local.get 5
        local.get 25
        i32.add
        local.set 26
        local.get 26
        local.get 24
        local.get 23
        call $_ZN4core4iter6traits8iterator8Iterator6cloned17h3578c7209fd65b8cE
        local.get 5
        i32.load offset=52
        local.set 27
        local.get 5
        i32.load offset=48
        local.set 28
        i32.const 56
        local.set 29
        local.get 5
        local.get 29
        i32.add
        local.set 30
        local.get 30
        local.get 28
        local.get 27
        call $_ZN63_$LT$I$u20$as$u20$core..iter..traits..collect..IntoIterator$GT$9into_iter17h313fbb621871c988E
        local.get 5
        i32.load offset=60
        local.set 31
        local.get 5
        i32.load offset=56
        local.set 32
        local.get 5
        local.get 32
        i32.store offset=80
        local.get 5
        local.get 31
        i32.store offset=84
        br 1 (;@1;)
      end
      i32.const 1049856
      local.set 33
      i32.const 33
      local.set 34
      i32.const 1049836
      local.set 35
      local.get 33
      local.get 34
      local.get 35
      call $_ZN4core9panicking5panic17hb41dbc4083d9884eE
      unreachable
    end
    loop  ;; label = @1
      i32.const 32
      local.set 36
      local.get 5
      local.get 36
      i32.add
      local.set 37
      i32.const 80
      local.set 38
      local.get 5
      local.get 38
      i32.add
      local.set 39
      local.get 37
      local.get 39
      call $_ZN104_$LT$core..iter..adapters..cloned..Cloned$LT$I$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17haaa1e9c7b03f1d44E
      local.get 5
      i32.load offset=32
      local.set 40
      local.get 5
      i32.load offset=36
      local.set 41
      local.get 5
      local.get 41
      i32.store offset=92
      local.get 5
      local.get 40
      i32.store offset=88
      local.get 5
      i32.load offset=88
      local.set 42
      block  ;; label = @2
        local.get 42
        br_if 0 (;@2;)
        local.get 5
        i32.load8_u offset=67
        local.set 43
        i32.const 128
        local.set 44
        local.get 5
        local.get 44
        i32.add
        local.set 45
        local.get 45
        global.set $__stack_pointer
        local.get 43
        return
      end
      local.get 5
      i32.load offset=92
      local.set 46
      local.get 0
      i32.load offset=12
      local.set 47
      i32.const 1
      local.set 48
      local.get 47
      local.get 48
      i32.sub
      local.set 49
      i32.const 1
      local.set 50
      local.get 47
      local.set 51
      local.get 50
      local.set 52
      local.get 51
      local.get 52
      i32.lt_u
      local.set 53
      i32.const 1
      local.set 54
      local.get 53
      local.get 54
      i32.and
      local.set 55
      block  ;; label = @2
        block  ;; label = @3
          local.get 55
          br_if 0 (;@3;)
          local.get 5
          local.get 49
          i32.store offset=96
          i32.const 0
          local.set 56
          local.get 5
          local.get 56
          i32.store offset=100
          i32.const 1
          local.set 57
          local.get 5
          local.get 57
          i32.store offset=104
          i32.const 3
          local.set 58
          i32.const 8
          local.set 59
          local.get 5
          local.get 59
          i32.add
          local.set 60
          i32.const 96
          local.set 61
          local.get 5
          local.get 61
          i32.add
          local.set 62
          local.get 60
          local.get 62
          local.get 58
          call $_ZN4core5slice29_$LT$impl$u20$$u5b$T$u5d$$GT$4iter17h2f82be2143302357E
          local.get 5
          i32.load offset=12
          local.set 63
          local.get 5
          i32.load offset=8
          local.set 64
          i32.const 16
          local.set 65
          local.get 5
          local.get 65
          i32.add
          local.set 66
          local.get 66
          local.get 64
          local.get 63
          call $_ZN4core4iter6traits8iterator8Iterator6cloned17h3578c7209fd65b8cE
          local.get 5
          i32.load offset=20
          local.set 67
          local.get 5
          i32.load offset=16
          local.set 68
          i32.const 24
          local.set 69
          local.get 5
          local.get 69
          i32.add
          local.set 70
          local.get 70
          local.get 68
          local.get 67
          call $_ZN63_$LT$I$u20$as$u20$core..iter..traits..collect..IntoIterator$GT$9into_iter17h313fbb621871c988E
          local.get 5
          i32.load offset=28
          local.set 71
          local.get 5
          i32.load offset=24
          local.set 72
          local.get 5
          local.get 72
          i32.store offset=108
          local.get 5
          local.get 71
          i32.store offset=112
          br 1 (;@2;)
        end
        i32.const 1049856
        local.set 73
        i32.const 33
        local.set 74
        i32.const 1049892
        local.set 75
        local.get 73
        local.get 74
        local.get 75
        call $_ZN4core9panicking5panic17hb41dbc4083d9884eE
        unreachable
      end
      loop  ;; label = @2
        i32.const 108
        local.set 76
        local.get 5
        local.get 76
        i32.add
        local.set 77
        local.get 5
        local.get 77
        call $_ZN104_$LT$core..iter..adapters..cloned..Cloned$LT$I$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17haaa1e9c7b03f1d44E
        local.get 5
        i32.load
        local.set 78
        local.get 5
        i32.load offset=4
        local.set 79
        local.get 5
        local.get 79
        i32.store offset=120
        local.get 5
        local.get 78
        i32.store offset=116
        local.get 5
        i32.load offset=116
        local.set 80
        local.get 80
        i32.eqz
        br_if 1 (;@1;)
        local.get 5
        i32.load offset=120
        local.set 81
        block  ;; label = @3
          local.get 46
          br_if 0 (;@3;)
          local.get 81
          i32.eqz
          br_if 1 (;@2;)
        end
        local.get 1
        local.get 46
        i32.add
        local.set 82
        local.get 82
        local.get 1
        i32.lt_u
        local.set 83
        i32.const 1
        local.set 84
        local.get 83
        local.get 84
        i32.and
        local.set 85
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              block  ;; label = @6
                block  ;; label = @7
                  block  ;; label = @8
                    block  ;; label = @9
                      block  ;; label = @10
                        block  ;; label = @11
                          local.get 85
                          br_if 0 (;@11;)
                          local.get 0
                          i32.load offset=16
                          local.set 86
                          i32.const 0
                          local.set 87
                          local.get 86
                          local.set 88
                          local.get 87
                          local.set 89
                          local.get 88
                          local.get 89
                          i32.eq
                          local.set 90
                          i32.const 1
                          local.set 91
                          local.get 90
                          local.get 91
                          i32.and
                          local.set 92
                          local.get 92
                          br_if 2 (;@9;)
                          br 1 (;@10;)
                        end
                        i32.const 1049792
                        local.set 93
                        i32.const 28
                        local.set 94
                        i32.const 1049908
                        local.set 95
                        local.get 93
                        local.get 94
                        local.get 95
                        call $_ZN4core9panicking5panic17hb41dbc4083d9884eE
                        unreachable
                      end
                      local.get 82
                      local.get 86
                      i32.rem_u
                      local.set 96
                      local.get 2
                      local.get 81
                      i32.add
                      local.set 97
                      local.get 97
                      local.get 2
                      i32.lt_u
                      local.set 98
                      i32.const 1
                      local.set 99
                      local.get 98
                      local.get 99
                      i32.and
                      local.set 100
                      local.get 100
                      br_if 2 (;@7;)
                      br 1 (;@8;)
                    end
                    i32.const 1049936
                    local.set 101
                    i32.const 57
                    local.set 102
                    i32.const 1049908
                    local.set 103
                    local.get 101
                    local.get 102
                    local.get 103
                    call $_ZN4core9panicking5panic17hb41dbc4083d9884eE
                    unreachable
                  end
                  local.get 0
                  i32.load offset=12
                  local.set 104
                  i32.const 0
                  local.set 105
                  local.get 104
                  local.set 106
                  local.get 105
                  local.set 107
                  local.get 106
                  local.get 107
                  i32.eq
                  local.set 108
                  i32.const 1
                  local.set 109
                  local.get 108
                  local.get 109
                  i32.and
                  local.set 110
                  local.get 110
                  br_if 2 (;@5;)
                  br 1 (;@6;)
                end
                i32.const 1049792
                local.set 111
                i32.const 28
                local.set 112
                i32.const 1049996
                local.set 113
                local.get 111
                local.get 112
                local.get 113
                call $_ZN4core9panicking5panic17hb41dbc4083d9884eE
                unreachable
              end
              local.get 97
              local.get 104
              i32.rem_u
              local.set 114
              local.get 0
              local.get 96
              local.get 114
              call $_ZN5index8Universe9get_index17h5a48cdd7f3281fb5E
              local.set 115
              i32.const 1050012
              local.set 116
              local.get 0
              local.get 115
              local.get 116
              call $_ZN81_$LT$alloc..vec..Vec$LT$T$C$A$GT$$u20$as$u20$core..ops..index..Index$LT$I$GT$$GT$5index17hc80771b6cdb9dca7E
              local.set 117
              local.get 117
              i32.load8_u
              local.set 118
              local.get 5
              local.get 118
              i32.store8 offset=127
              local.get 5
              i32.load8_u offset=127
              local.set 119
              local.get 5
              i32.load8_u offset=67
              local.set 120
              local.get 120
              local.get 119
              i32.add
              local.set 121
              i32.const 255
              local.set 122
              local.get 121
              local.get 122
              i32.and
              local.set 123
              local.get 123
              local.get 121
              i32.ne
              local.set 124
              local.get 121
              local.set 125
              i32.const 1
              local.set 126
              local.get 124
              local.get 126
              i32.and
              local.set 127
              local.get 127
              br_if 2 (;@3;)
              br 1 (;@4;)
            end
            i32.const 1049936
            local.set 128
            i32.const 57
            local.set 129
            i32.const 1049996
            local.set 130
            local.get 128
            local.get 129
            local.get 130
            call $_ZN4core9panicking5panic17hb41dbc4083d9884eE
            unreachable
          end
          local.get 5
          local.get 125
          i32.store8 offset=67
          br 1 (;@2;)
        end
      end
    end
    i32.const 1049792
    local.set 131
    i32.const 28
    local.set 132
    i32.const 1050028
    local.set 133
    local.get 131
    local.get 132
    local.get 133
    call $_ZN4core9panicking5panic17hb41dbc4083d9884eE
    unreachable)
  (func $_ZN52_$LT$index..Cell$u20$as$u20$core..cmp..PartialEq$GT$2eq17h986f028f9909c227E (type 2) (param i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    local.get 0
    i32.load8_u
    local.set 2
    i32.const 1
    local.set 3
    local.get 2
    local.get 3
    i32.and
    local.set 4
    local.get 1
    i32.load8_u
    local.set 5
    i32.const 1
    local.set 6
    local.get 5
    local.get 6
    i32.and
    local.set 7
    i32.const 255
    local.set 8
    local.get 4
    local.get 8
    i32.and
    local.set 9
    i32.const 255
    local.set 10
    local.get 7
    local.get 10
    i32.and
    local.set 11
    local.get 9
    local.get 11
    i32.eq
    local.set 12
    i32.const 1
    local.set 13
    local.get 12
    local.get 13
    i32.and
    local.set 14
    local.get 14
    return)
  (func $__rust_alloc (type 2) (param i32 i32) (result i32)
    (local i32)
    local.get 0
    local.get 1
    call $__rdl_alloc
    local.set 2
    local.get 2
    return)
  (func $__rust_dealloc (type 3) (param i32 i32 i32)
    local.get 0
    local.get 1
    local.get 2
    call $__rdl_dealloc
    return)
  (func $__rust_realloc (type 11) (param i32 i32 i32 i32) (result i32)
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
  (func $_ZN36_$LT$T$u20$as$u20$core..any..Any$GT$7type_id17ha70a4555b5aec906E (type 0) (param i32 i32)
    local.get 0
    i64.const -163230743173927068
    i64.store offset=8
    local.get 0
    i64.const -4493808902380553279
    i64.store)
  (func $_ZN36_$LT$T$u20$as$u20$core..any..Any$GT$7type_id17hc1fa5cd7ba7b388fE (type 0) (param i32 i32)
    local.get 0
    i64.const 3183233196353969263
    i64.store offset=8
    local.get 0
    i64.const -5992187996373156989
    i64.store)
  (func $_ZN36_$LT$T$u20$as$u20$core..any..Any$GT$7type_id17he9d5f3dc2d5feb11E (type 0) (param i32 i32)
    local.get 0
    i64.const 3621418216119541392
    i64.store offset=8
    local.get 0
    i64.const -6096952686898433405
    i64.store)
  (func $_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$7reserve21do_reserve_and_handle17h24c2b8330ce7897eE (type 3) (param i32 i32 i32)
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
        i32.load offset=4
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
            br_if 0 (;@4;)
            local.get 3
            i32.const 0
            i32.store offset=24
            br 1 (;@3;)
          end
          local.get 3
          local.get 1
          i32.store offset=28
          local.get 3
          i32.const 1
          i32.store offset=24
          local.get 3
          local.get 0
          i32.load
          i32.store offset=20
        end
        local.get 3
        i32.const 8
        i32.add
        local.get 4
        local.get 2
        local.get 3
        i32.const 20
        i32.add
        call $_ZN5alloc7raw_vec11finish_grow17h5245e68c71414715E
        local.get 3
        i32.load offset=12
        local.set 1
        block  ;; label = @3
          local.get 3
          i32.load offset=8
          br_if 0 (;@3;)
          local.get 0
          local.get 2
          i32.store offset=4
          local.get 0
          local.get 1
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
        i32.const 16
        i32.add
        i32.load
        call $_ZN5alloc5alloc18handle_alloc_error17h0853c609cdf121f4E
        unreachable
      end
      call $_ZN5alloc7raw_vec17capacity_overflow17h6742d6b707f6ebe7E
      unreachable
    end
    local.get 3
    i32.const 32
    i32.add
    global.set $__stack_pointer)
  (func $_ZN4core3fmt5Write9write_fmt17he52a8376fe10e016E (type 2) (param i32 i32) (result i32)
    local.get 0
    i32.const 1050160
    local.get 1
    call $_ZN4core3fmt5write17h362bec5724a70484E)
  (func $_ZN4core3ptr120drop_in_place$LT$$LP$$RF$std..ffi..os_str..OsString$C$$RF$core..option..Option$LT$std..ffi..os_str..OsString$GT$$RP$$GT$17ha27ad9ced7d25b5bE (type 7) (param i32))
  (func $_ZN4core3ptr29drop_in_place$LT$$LP$$RP$$GT$17h23e4e6157c2e3123E (type 7) (param i32))
  (func $_ZN4core3ptr42drop_in_place$LT$alloc..string..String$GT$17h43a2c67c5ee0fda2E (type 7) (param i32)
    (local i32)
    block  ;; label = @1
      local.get 0
      i32.load offset=4
      local.tee 1
      i32.eqz
      br_if 0 (;@1;)
      local.get 0
      i32.load
      local.get 1
      i32.const 1
      call $__rust_dealloc
    end)
  (func $_ZN4core3ptr77drop_in_place$LT$std..panicking..begin_panic_handler..FormatStringPayload$GT$17h48c273b6ad39dcc5E (type 7) (param i32)
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
  (func $_ZN58_$LT$alloc..string..String$u20$as$u20$core..fmt..Write$GT$10write_char17ha17b8b7c0f49fe81E (type 2) (param i32 i32) (result i32)
    (local i32 i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 2
    global.set $__stack_pointer
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
            call $_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$16reserve_for_push17h93cfef48d3b0a4faE
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
        call $_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$7reserve21do_reserve_and_handle17h24c2b8330ce7897eE
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
  (func $_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$16reserve_for_push17h93cfef48d3b0a4faE (type 0) (param i32 i32)
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
        i32.load offset=4
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
            br_if 0 (;@4;)
            local.get 2
            i32.const 0
            i32.store offset=24
            br 1 (;@3;)
          end
          local.get 2
          local.get 3
          i32.store offset=28
          local.get 2
          i32.const 1
          i32.store offset=24
          local.get 2
          local.get 0
          i32.load
          i32.store offset=20
        end
        local.get 2
        i32.const 8
        i32.add
        local.get 4
        local.get 1
        local.get 2
        i32.const 20
        i32.add
        call $_ZN5alloc7raw_vec11finish_grow17h5245e68c71414715E
        local.get 2
        i32.load offset=12
        local.set 3
        block  ;; label = @3
          local.get 2
          i32.load offset=8
          br_if 0 (;@3;)
          local.get 0
          local.get 1
          i32.store offset=4
          local.get 0
          local.get 3
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
        i32.const 16
        i32.add
        i32.load
        call $_ZN5alloc5alloc18handle_alloc_error17h0853c609cdf121f4E
        unreachable
      end
      call $_ZN5alloc7raw_vec17capacity_overflow17h6742d6b707f6ebe7E
      unreachable
    end
    local.get 2
    i32.const 32
    i32.add
    global.set $__stack_pointer)
  (func $_ZN58_$LT$alloc..string..String$u20$as$u20$core..fmt..Write$GT$9write_str17hf2204cbc5b4f5a57E (type 1) (param i32 i32 i32) (result i32)
    (local i32)
    block  ;; label = @1
      local.get 0
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
      call $_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$7reserve21do_reserve_and_handle17h24c2b8330ce7897eE
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
  (func $_ZN5alloc7raw_vec11finish_grow17h5245e68c71414715E (type 8) (param i32 i32 i32 i32)
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
                  i32.load8_u offset=1051009
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
              i32.load8_u offset=1051009
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
  (func $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$13dispose_chunk17h0b25ee30658eb07bE (type 0) (param i32 i32)
    (local i32 i32 i32 i32)
    local.get 0
    local.get 1
    call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h10af76c6d2e34d25E
    local.set 2
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              block  ;; label = @6
                block  ;; label = @7
                  local.get 0
                  call $_ZN8dlmalloc8dlmalloc5Chunk6pinuse17hb674a446c3254c29E
                  br_if 0 (;@7;)
                  local.get 0
                  i32.load
                  local.set 3
                  local.get 0
                  call $_ZN8dlmalloc8dlmalloc5Chunk7mmapped17hc9e33fd0b0c5432fE
                  br_if 1 (;@6;)
                  local.get 3
                  local.get 1
                  i32.add
                  local.set 1
                  block  ;; label = @8
                    local.get 0
                    local.get 3
                    call $_ZN8dlmalloc8dlmalloc5Chunk12minus_offset17hc4a0fdc2ff1abc38E
                    local.tee 0
                    i32.const 0
                    i32.load offset=1051460
                    i32.ne
                    br_if 0 (;@8;)
                    local.get 2
                    i32.load offset=4
                    i32.const 3
                    i32.and
                    i32.const 3
                    i32.ne
                    br_if 1 (;@7;)
                    i32.const 0
                    local.get 1
                    i32.store offset=1051452
                    local.get 0
                    local.get 1
                    local.get 2
                    call $_ZN8dlmalloc8dlmalloc5Chunk20set_free_with_pinuse17h1e6a59985180e994E
                    return
                  end
                  block  ;; label = @8
                    local.get 3
                    i32.const 256
                    i32.lt_u
                    br_if 0 (;@8;)
                    local.get 0
                    call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$18unlink_large_chunk17h057503926679f426E
                    br 1 (;@7;)
                  end
                  block  ;; label = @8
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
                    br_if 0 (;@8;)
                    local.get 5
                    local.get 4
                    i32.store offset=12
                    local.get 4
                    local.get 5
                    i32.store offset=8
                    br 1 (;@7;)
                  end
                  i32.const 0
                  i32.const 0
                  i32.load offset=1051444
                  i32.const -2
                  local.get 3
                  i32.const 3
                  i32.shr_u
                  i32.rotl
                  i32.and
                  i32.store offset=1051444
                end
                local.get 2
                call $_ZN8dlmalloc8dlmalloc5Chunk6cinuse17hb4677a5fcbb82422E
                br_if 2 (;@4;)
                local.get 2
                i32.const 0
                i32.load offset=1051464
                i32.eq
                br_if 4 (;@2;)
                local.get 2
                i32.const 0
                i32.load offset=1051460
                i32.ne
                br_if 1 (;@5;)
                i32.const 0
                local.get 0
                i32.store offset=1051460
                i32.const 0
                i32.const 0
                i32.load offset=1051452
                local.get 1
                i32.add
                local.tee 1
                i32.store offset=1051452
                local.get 0
                local.get 1
                call $_ZN8dlmalloc8dlmalloc5Chunk33set_size_and_pinuse_of_free_chunk17hb8c49fbc662a8751E
                return
              end
              i32.const 1051488
              local.get 0
              local.get 3
              i32.sub
              local.get 1
              local.get 3
              i32.add
              i32.const 16
              i32.add
              local.tee 0
              call $_ZN61_$LT$dlmalloc..sys..System$u20$as$u20$dlmalloc..Allocator$GT$4free17h17c630ddfc3296e0E
              i32.eqz
              br_if 4 (;@1;)
              i32.const 0
              i32.const 0
              i32.load offset=1051468
              local.get 0
              i32.sub
              i32.store offset=1051468
              return
            end
            local.get 2
            call $_ZN8dlmalloc8dlmalloc5Chunk4size17h6ea85aca232e3ec5E
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
                call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$18unlink_large_chunk17h057503926679f426E
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
              i32.load offset=1051444
              i32.const -2
              local.get 3
              i32.const 3
              i32.shr_u
              i32.rotl
              i32.and
              i32.store offset=1051444
            end
            local.get 0
            local.get 1
            call $_ZN8dlmalloc8dlmalloc5Chunk33set_size_and_pinuse_of_free_chunk17hb8c49fbc662a8751E
            local.get 0
            i32.const 0
            i32.load offset=1051460
            i32.ne
            br_if 1 (;@3;)
            i32.const 0
            local.get 1
            i32.store offset=1051452
            return
          end
          local.get 0
          local.get 1
          local.get 2
          call $_ZN8dlmalloc8dlmalloc5Chunk20set_free_with_pinuse17h1e6a59985180e994E
        end
        block  ;; label = @3
          local.get 1
          i32.const 256
          i32.lt_u
          br_if 0 (;@3;)
          local.get 0
          local.get 1
          call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$18insert_large_chunk17hc73af8a4cd0b31d7E
          return
        end
        local.get 1
        i32.const -8
        i32.and
        i32.const 1051180
        i32.add
        local.set 2
        block  ;; label = @3
          block  ;; label = @4
            i32.const 0
            i32.load offset=1051444
            local.tee 3
            i32.const 1
            local.get 1
            i32.const 3
            i32.shr_u
            i32.shl
            local.tee 1
            i32.and
            br_if 0 (;@4;)
            i32.const 0
            local.get 3
            local.get 1
            i32.or
            i32.store offset=1051444
            local.get 2
            local.set 1
            br 1 (;@3;)
          end
          local.get 2
          i32.load offset=8
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
        return
      end
      i32.const 0
      local.get 0
      i32.store offset=1051464
      i32.const 0
      i32.const 0
      i32.load offset=1051456
      local.get 1
      i32.add
      local.tee 1
      i32.store offset=1051456
      local.get 0
      local.get 1
      i32.const 1
      i32.or
      i32.store offset=4
      local.get 0
      i32.const 0
      i32.load offset=1051460
      i32.ne
      br_if 0 (;@1;)
      i32.const 0
      i32.const 0
      i32.store offset=1051452
      i32.const 0
      i32.const 0
      i32.store offset=1051460
    end)
  (func $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$18unlink_large_chunk17h057503926679f426E (type 7) (param i32)
    (local i32 i32 i32 i32 i32)
    local.get 0
    i32.load offset=24
    local.set 1
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          local.get 0
          call $_ZN8dlmalloc8dlmalloc9TreeChunk4next17h0948dbff5b1fa27aE
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
        call $_ZN8dlmalloc8dlmalloc9TreeChunk4prev17hb7068ddb0a3bc75dE
        local.tee 4
        local.get 0
        call $_ZN8dlmalloc8dlmalloc9TreeChunk4next17h0948dbff5b1fa27aE
        local.tee 2
        call $_ZN8dlmalloc8dlmalloc9TreeChunk5chunk17hdd6a267a52100ff9E
        i32.store offset=12
        local.get 2
        local.get 4
        call $_ZN8dlmalloc8dlmalloc9TreeChunk5chunk17hdd6a267a52100ff9E
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
          i32.const 1051036
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
        i32.load offset=1051448
        i32.const -2
        local.get 0
        i32.load offset=28
        i32.rotl
        i32.and
        i32.store offset=1051448
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
  (func $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$18insert_large_chunk17hc73af8a4cd0b31d7E (type 0) (param i32 i32)
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
    i32.const 1051036
    i32.add
    local.set 3
    local.get 0
    call $_ZN8dlmalloc8dlmalloc9TreeChunk5chunk17hdd6a267a52100ff9E
    local.set 4
    block  ;; label = @1
      block  ;; label = @2
        i32.const 0
        i32.load offset=1051448
        local.tee 5
        i32.const 1
        local.get 2
        i32.shl
        local.tee 6
        i32.and
        br_if 0 (;@2;)
        i32.const 0
        local.get 5
        local.get 6
        i32.or
        i32.store offset=1051448
        local.get 3
        local.get 0
        i32.store
        local.get 0
        local.get 3
        i32.store offset=24
        br 1 (;@1;)
      end
      local.get 3
      i32.load
      local.set 5
      local.get 2
      call $_ZN8dlmalloc8dlmalloc24leftshift_for_tree_index17he8264d4c8bb74329E
      local.set 2
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            local.get 5
            call $_ZN8dlmalloc8dlmalloc9TreeChunk5chunk17hdd6a267a52100ff9E
            call $_ZN8dlmalloc8dlmalloc5Chunk4size17h6ea85aca232e3ec5E
            local.get 1
            i32.ne
            br_if 0 (;@4;)
            local.get 5
            local.set 2
            br 1 (;@3;)
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
            call $_ZN8dlmalloc8dlmalloc9TreeChunk5chunk17hdd6a267a52100ff9E
            call $_ZN8dlmalloc8dlmalloc5Chunk4size17h6ea85aca232e3ec5E
            local.get 1
            i32.ne
            br_if 0 (;@4;)
          end
        end
        local.get 2
        call $_ZN8dlmalloc8dlmalloc9TreeChunk5chunk17hdd6a267a52100ff9E
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
  (func $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$23release_unused_segments17hfee793f58e61465bE (type 12) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    i32.const 0
    local.set 0
    i32.const 0
    local.set 1
    block  ;; label = @1
      i32.const 0
      i32.load offset=1051172
      local.tee 2
      i32.eqz
      br_if 0 (;@1;)
      i32.const 1051164
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
            i32.const 1051488
            local.get 4
            i32.load offset=12
            i32.const 1
            i32.shr_u
            call $_ZN61_$LT$dlmalloc..sys..System$u20$as$u20$dlmalloc..Allocator$GT$16can_release_part17he396a577db875ec0E
            i32.eqz
            br_if 0 (;@4;)
            local.get 4
            call $_ZN8dlmalloc8dlmalloc7Segment9is_extern17hce2b6c60378fecbaE
            br_if 0 (;@4;)
            local.get 6
            local.get 6
            call $_ZN8dlmalloc8dlmalloc5Chunk6to_mem17h50c7b3bad37923f8E
            local.tee 7
            i32.const 8
            call $_ZN8dlmalloc8dlmalloc8align_up17hf58412c808f1bdfcE
            local.get 7
            i32.sub
            i32.add
            local.tee 7
            call $_ZN8dlmalloc8dlmalloc5Chunk4size17h6ea85aca232e3ec5E
            local.set 8
            call $_ZN8dlmalloc8dlmalloc5Chunk10mem_offset17hb4f8ba9389e35f03E
            local.tee 9
            i32.const 8
            call $_ZN8dlmalloc8dlmalloc8align_up17hf58412c808f1bdfcE
            local.set 10
            i32.const 20
            i32.const 8
            call $_ZN8dlmalloc8dlmalloc8align_up17hf58412c808f1bdfcE
            local.set 11
            i32.const 16
            i32.const 8
            call $_ZN8dlmalloc8dlmalloc8align_up17hf58412c808f1bdfcE
            local.set 12
            local.get 7
            call $_ZN8dlmalloc8dlmalloc5Chunk5inuse17h18988138fdbf78b6E
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
                i32.load offset=1051460
                i32.eq
                br_if 0 (;@6;)
                local.get 7
                call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$18unlink_large_chunk17h057503926679f426E
                br 1 (;@5;)
              end
              i32.const 0
              i32.const 0
              i32.store offset=1051452
              i32.const 0
              i32.const 0
              i32.store offset=1051460
            end
            block  ;; label = @5
              i32.const 1051488
              local.get 6
              local.get 5
              call $_ZN61_$LT$dlmalloc..sys..System$u20$as$u20$dlmalloc..Allocator$GT$4free17h17c630ddfc3296e0E
              br_if 0 (;@5;)
              local.get 7
              local.get 8
              call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$18insert_large_chunk17hc73af8a4cd0b31d7E
              br 1 (;@4;)
            end
            i32.const 0
            i32.const 0
            i32.load offset=1051468
            local.get 5
            i32.sub
            i32.store offset=1051468
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
    i32.store offset=1051484
    local.get 1)
  (func $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$4free17h0a66a05f2e0e0048E (type 7) (param i32)
    (local i32 i32 i32 i32 i32 i32)
    local.get 0
    call $_ZN8dlmalloc8dlmalloc5Chunk8from_mem17h979df28b2facc7dcE
    local.set 0
    local.get 0
    local.get 0
    call $_ZN8dlmalloc8dlmalloc5Chunk4size17h6ea85aca232e3ec5E
    local.tee 1
    call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h10af76c6d2e34d25E
    local.set 2
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              block  ;; label = @6
                block  ;; label = @7
                  block  ;; label = @8
                    block  ;; label = @9
                      local.get 0
                      call $_ZN8dlmalloc8dlmalloc5Chunk6pinuse17hb674a446c3254c29E
                      br_if 0 (;@9;)
                      local.get 0
                      i32.load
                      local.set 3
                      local.get 0
                      call $_ZN8dlmalloc8dlmalloc5Chunk7mmapped17hc9e33fd0b0c5432fE
                      br_if 1 (;@8;)
                      local.get 3
                      local.get 1
                      i32.add
                      local.set 1
                      block  ;; label = @10
                        local.get 0
                        local.get 3
                        call $_ZN8dlmalloc8dlmalloc5Chunk12minus_offset17hc4a0fdc2ff1abc38E
                        local.tee 0
                        i32.const 0
                        i32.load offset=1051460
                        i32.ne
                        br_if 0 (;@10;)
                        local.get 2
                        i32.load offset=4
                        i32.const 3
                        i32.and
                        i32.const 3
                        i32.ne
                        br_if 1 (;@9;)
                        i32.const 0
                        local.get 1
                        i32.store offset=1051452
                        local.get 0
                        local.get 1
                        local.get 2
                        call $_ZN8dlmalloc8dlmalloc5Chunk20set_free_with_pinuse17h1e6a59985180e994E
                        br 9 (;@1;)
                      end
                      block  ;; label = @10
                        local.get 3
                        i32.const 256
                        i32.lt_u
                        br_if 0 (;@10;)
                        local.get 0
                        call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$18unlink_large_chunk17h057503926679f426E
                        br 1 (;@9;)
                      end
                      block  ;; label = @10
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
                        br_if 0 (;@10;)
                        local.get 5
                        local.get 4
                        i32.store offset=12
                        local.get 4
                        local.get 5
                        i32.store offset=8
                        br 1 (;@9;)
                      end
                      i32.const 0
                      i32.const 0
                      i32.load offset=1051444
                      i32.const -2
                      local.get 3
                      i32.const 3
                      i32.shr_u
                      i32.rotl
                      i32.and
                      i32.store offset=1051444
                    end
                    local.get 2
                    call $_ZN8dlmalloc8dlmalloc5Chunk6cinuse17hb4677a5fcbb82422E
                    br_if 2 (;@6;)
                    local.get 2
                    i32.const 0
                    i32.load offset=1051464
                    i32.eq
                    br_if 4 (;@4;)
                    local.get 2
                    i32.const 0
                    i32.load offset=1051460
                    i32.ne
                    br_if 1 (;@7;)
                    i32.const 0
                    local.get 0
                    i32.store offset=1051460
                    i32.const 0
                    i32.const 0
                    i32.load offset=1051452
                    local.get 1
                    i32.add
                    local.tee 1
                    i32.store offset=1051452
                    local.get 0
                    local.get 1
                    call $_ZN8dlmalloc8dlmalloc5Chunk33set_size_and_pinuse_of_free_chunk17hb8c49fbc662a8751E
                    return
                  end
                  i32.const 1051488
                  local.get 0
                  local.get 3
                  i32.sub
                  local.get 1
                  local.get 3
                  i32.add
                  i32.const 16
                  i32.add
                  local.tee 0
                  call $_ZN61_$LT$dlmalloc..sys..System$u20$as$u20$dlmalloc..Allocator$GT$4free17h17c630ddfc3296e0E
                  i32.eqz
                  br_if 6 (;@1;)
                  i32.const 0
                  i32.const 0
                  i32.load offset=1051468
                  local.get 0
                  i32.sub
                  i32.store offset=1051468
                  return
                end
                local.get 2
                call $_ZN8dlmalloc8dlmalloc5Chunk4size17h6ea85aca232e3ec5E
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
                    call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$18unlink_large_chunk17h057503926679f426E
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
                  i32.load offset=1051444
                  i32.const -2
                  local.get 3
                  i32.const 3
                  i32.shr_u
                  i32.rotl
                  i32.and
                  i32.store offset=1051444
                end
                local.get 0
                local.get 1
                call $_ZN8dlmalloc8dlmalloc5Chunk33set_size_and_pinuse_of_free_chunk17hb8c49fbc662a8751E
                local.get 0
                i32.const 0
                i32.load offset=1051460
                i32.ne
                br_if 1 (;@5;)
                i32.const 0
                local.get 1
                i32.store offset=1051452
                return
              end
              local.get 0
              local.get 1
              local.get 2
              call $_ZN8dlmalloc8dlmalloc5Chunk20set_free_with_pinuse17h1e6a59985180e994E
            end
            local.get 1
            i32.const 256
            i32.lt_u
            br_if 1 (;@3;)
            local.get 0
            local.get 1
            call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$18insert_large_chunk17hc73af8a4cd0b31d7E
            i32.const 0
            i32.const 0
            i32.load offset=1051484
            i32.const -1
            i32.add
            local.tee 0
            i32.store offset=1051484
            local.get 0
            br_if 3 (;@1;)
            call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$23release_unused_segments17hfee793f58e61465bE
            drop
            return
          end
          i32.const 0
          local.get 0
          i32.store offset=1051464
          i32.const 0
          i32.const 0
          i32.load offset=1051456
          local.get 1
          i32.add
          local.tee 1
          i32.store offset=1051456
          local.get 0
          local.get 1
          i32.const 1
          i32.or
          i32.store offset=4
          block  ;; label = @4
            local.get 0
            i32.const 0
            i32.load offset=1051460
            i32.ne
            br_if 0 (;@4;)
            i32.const 0
            i32.const 0
            i32.store offset=1051452
            i32.const 0
            i32.const 0
            i32.store offset=1051460
          end
          local.get 1
          i32.const 0
          i32.load offset=1051476
          i32.le_u
          br_if 2 (;@1;)
          call $_ZN8dlmalloc8dlmalloc5Chunk10mem_offset17hb4f8ba9389e35f03E
          local.tee 0
          i32.const 8
          call $_ZN8dlmalloc8dlmalloc8align_up17hf58412c808f1bdfcE
          local.set 1
          i32.const 20
          i32.const 8
          call $_ZN8dlmalloc8dlmalloc8align_up17hf58412c808f1bdfcE
          local.set 2
          i32.const 16
          i32.const 8
          call $_ZN8dlmalloc8dlmalloc8align_up17hf58412c808f1bdfcE
          local.set 3
          i32.const 0
          i32.const 16
          i32.const 8
          call $_ZN8dlmalloc8dlmalloc8align_up17hf58412c808f1bdfcE
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
          br_if 2 (;@1;)
          i32.const 0
          i32.load offset=1051464
          i32.eqz
          br_if 2 (;@1;)
          call $_ZN8dlmalloc8dlmalloc5Chunk10mem_offset17hb4f8ba9389e35f03E
          local.tee 0
          i32.const 8
          call $_ZN8dlmalloc8dlmalloc8align_up17hf58412c808f1bdfcE
          local.set 1
          i32.const 20
          i32.const 8
          call $_ZN8dlmalloc8dlmalloc8align_up17hf58412c808f1bdfcE
          local.set 3
          i32.const 16
          i32.const 8
          call $_ZN8dlmalloc8dlmalloc8align_up17hf58412c808f1bdfcE
          local.set 4
          i32.const 0
          local.set 2
          i32.const 0
          i32.load offset=1051456
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
          br_if 1 (;@2;)
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
          i32.load offset=1051464
          local.set 1
          i32.const 1051164
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
                call $_ZN8dlmalloc8dlmalloc7Segment3top17hdd4d160761d7a4c1E
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
          call $_ZN8dlmalloc8dlmalloc7Segment9is_extern17hce2b6c60378fecbaE
          br_if 1 (;@2;)
          i32.const 1051488
          local.get 0
          i32.load offset=12
          i32.const 1
          i32.shr_u
          call $_ZN61_$LT$dlmalloc..sys..System$u20$as$u20$dlmalloc..Allocator$GT$16can_release_part17he396a577db875ec0E
          i32.eqz
          br_if 1 (;@2;)
          local.get 0
          i32.load offset=4
          local.get 3
          i32.lt_u
          br_if 1 (;@2;)
          i32.const 1051164
          local.set 1
          loop  ;; label = @4
            local.get 0
            local.get 1
            call $_ZN8dlmalloc8dlmalloc7Segment5holds17hd979b70163a9ea52E
            br_if 2 (;@2;)
            local.get 1
            i32.load offset=8
            local.tee 1
            br_if 0 (;@4;)
          end
          i32.const 1051488
          local.get 0
          i32.load
          local.get 0
          i32.load offset=4
          local.tee 1
          local.get 1
          local.get 3
          i32.sub
          call $_ZN61_$LT$dlmalloc..sys..System$u20$as$u20$dlmalloc..Allocator$GT$9free_part17h6e5bac3b0cfb8f54E
          local.set 1
          local.get 3
          i32.eqz
          br_if 1 (;@2;)
          local.get 1
          i32.eqz
          br_if 1 (;@2;)
          local.get 0
          local.get 0
          i32.load offset=4
          local.get 3
          i32.sub
          i32.store offset=4
          i32.const 0
          i32.const 0
          i32.load offset=1051468
          local.get 3
          i32.sub
          i32.store offset=1051468
          i32.const 0
          i32.load offset=1051456
          local.set 1
          i32.const 0
          i32.load offset=1051464
          local.set 0
          i32.const 0
          local.get 0
          local.get 0
          call $_ZN8dlmalloc8dlmalloc5Chunk6to_mem17h50c7b3bad37923f8E
          local.tee 2
          i32.const 8
          call $_ZN8dlmalloc8dlmalloc8align_up17hf58412c808f1bdfcE
          local.get 2
          i32.sub
          local.tee 2
          call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h10af76c6d2e34d25E
          local.tee 0
          i32.store offset=1051464
          i32.const 0
          local.get 1
          local.get 4
          local.get 2
          i32.add
          i32.sub
          i32.const 65536
          i32.add
          local.tee 1
          i32.store offset=1051456
          local.get 0
          local.get 1
          i32.const 1
          i32.or
          i32.store offset=4
          call $_ZN8dlmalloc8dlmalloc5Chunk10mem_offset17hb4f8ba9389e35f03E
          local.tee 2
          i32.const 8
          call $_ZN8dlmalloc8dlmalloc8align_up17hf58412c808f1bdfcE
          local.set 4
          i32.const 20
          i32.const 8
          call $_ZN8dlmalloc8dlmalloc8align_up17hf58412c808f1bdfcE
          local.set 5
          i32.const 16
          i32.const 8
          call $_ZN8dlmalloc8dlmalloc8align_up17hf58412c808f1bdfcE
          local.set 6
          local.get 0
          local.get 1
          call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h10af76c6d2e34d25E
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
          i32.store offset=1051476
          local.get 3
          local.set 2
          br 1 (;@2;)
        end
        local.get 1
        i32.const -8
        i32.and
        i32.const 1051180
        i32.add
        local.set 2
        block  ;; label = @3
          block  ;; label = @4
            i32.const 0
            i32.load offset=1051444
            local.tee 3
            i32.const 1
            local.get 1
            i32.const 3
            i32.shr_u
            i32.shl
            local.tee 1
            i32.and
            br_if 0 (;@4;)
            i32.const 0
            local.get 3
            local.get 1
            i32.or
            i32.store offset=1051444
            local.get 2
            local.set 1
            br 1 (;@3;)
          end
          local.get 2
          i32.load offset=8
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
        return
      end
      call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$23release_unused_segments17hfee793f58e61465bE
      i32.const 0
      local.get 2
      i32.sub
      i32.ne
      br_if 0 (;@1;)
      i32.const 0
      i32.load offset=1051456
      i32.const 0
      i32.load offset=1051476
      i32.le_u
      br_if 0 (;@1;)
      i32.const 0
      i32.const -1
      i32.store offset=1051476
      return
    end)
  (func $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$6malloc17h464a2d96faf011fdE (type 4) (param i32) (result i32)
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
              local.get 0
              i32.const 245
              i32.lt_u
              br_if 0 (;@5;)
              call $_ZN8dlmalloc8dlmalloc5Chunk10mem_offset17hb4f8ba9389e35f03E
              local.tee 2
              i32.const 8
              call $_ZN8dlmalloc8dlmalloc8align_up17hf58412c808f1bdfcE
              local.set 3
              i32.const 20
              i32.const 8
              call $_ZN8dlmalloc8dlmalloc8align_up17hf58412c808f1bdfcE
              local.set 4
              i32.const 16
              i32.const 8
              call $_ZN8dlmalloc8dlmalloc8align_up17hf58412c808f1bdfcE
              local.set 5
              i32.const 0
              local.set 6
              i32.const 0
              i32.const 16
              i32.const 8
              call $_ZN8dlmalloc8dlmalloc8align_up17hf58412c808f1bdfcE
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
              br_if 4 (;@1;)
              local.get 0
              i32.const 4
              i32.add
              i32.const 8
              call $_ZN8dlmalloc8dlmalloc8align_up17hf58412c808f1bdfcE
              local.set 2
              i32.const 0
              i32.load offset=1051448
              i32.eqz
              br_if 3 (;@2;)
              i32.const 0
              local.set 8
              block  ;; label = @6
                local.get 2
                i32.const 256
                i32.lt_u
                br_if 0 (;@6;)
                i32.const 31
                local.set 8
                local.get 2
                i32.const 16777215
                i32.gt_u
                br_if 0 (;@6;)
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
              block  ;; label = @6
                local.get 8
                i32.const 2
                i32.shl
                i32.const 1051036
                i32.add
                i32.load
                local.tee 3
                br_if 0 (;@6;)
                i32.const 0
                local.set 0
                i32.const 0
                local.set 4
                br 2 (;@4;)
              end
              local.get 2
              local.get 8
              call $_ZN8dlmalloc8dlmalloc24leftshift_for_tree_index17he8264d4c8bb74329E
              i32.shl
              local.set 5
              i32.const 0
              local.set 0
              i32.const 0
              local.set 4
              loop  ;; label = @6
                block  ;; label = @7
                  local.get 3
                  call $_ZN8dlmalloc8dlmalloc9TreeChunk5chunk17hdd6a267a52100ff9E
                  call $_ZN8dlmalloc8dlmalloc5Chunk4size17h6ea85aca232e3ec5E
                  local.tee 7
                  local.get 2
                  i32.lt_u
                  br_if 0 (;@7;)
                  local.get 7
                  local.get 2
                  i32.sub
                  local.tee 7
                  local.get 6
                  i32.ge_u
                  br_if 0 (;@7;)
                  local.get 7
                  local.set 6
                  local.get 3
                  local.set 4
                  local.get 7
                  br_if 0 (;@7;)
                  i32.const 0
                  local.set 6
                  local.get 3
                  local.set 4
                  local.get 3
                  local.set 0
                  i32.const 0
                  local.set 3
                  br 4 (;@3;)
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
                br_if 2 (;@4;)
                br 0 (;@6;)
              end
            end
            i32.const 16
            local.get 0
            i32.const 4
            i32.add
            i32.const 16
            i32.const 8
            call $_ZN8dlmalloc8dlmalloc8align_up17hf58412c808f1bdfcE
            i32.const -5
            i32.add
            local.get 0
            i32.gt_u
            select
            i32.const 8
            call $_ZN8dlmalloc8dlmalloc8align_up17hf58412c808f1bdfcE
            local.set 2
            block  ;; label = @5
              i32.const 0
              i32.load offset=1051444
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
              br_if 0 (;@5;)
              block  ;; label = @6
                block  ;; label = @7
                  local.get 0
                  i32.const -1
                  i32.xor
                  i32.const 1
                  i32.and
                  local.get 6
                  i32.add
                  local.tee 6
                  i32.const 3
                  i32.shl
                  local.tee 3
                  i32.const 1051188
                  i32.add
                  i32.load
                  local.tee 0
                  i32.const 8
                  i32.add
                  i32.load
                  local.tee 2
                  local.get 3
                  i32.const 1051180
                  i32.add
                  local.tee 3
                  i32.eq
                  br_if 0 (;@7;)
                  local.get 2
                  local.get 3
                  i32.store offset=12
                  local.get 3
                  local.get 2
                  i32.store offset=8
                  br 1 (;@6;)
                end
                i32.const 0
                local.get 4
                i32.const -2
                local.get 6
                i32.rotl
                i32.and
                i32.store offset=1051444
              end
              local.get 0
              local.get 6
              i32.const 3
              i32.shl
              call $_ZN8dlmalloc8dlmalloc5Chunk20set_inuse_and_pinuse17hb5017cd9994d56b7E
              local.get 0
              call $_ZN8dlmalloc8dlmalloc5Chunk6to_mem17h50c7b3bad37923f8E
              local.set 6
              br 4 (;@1;)
            end
            local.get 2
            i32.const 0
            i32.load offset=1051452
            i32.le_u
            br_if 2 (;@2;)
            block  ;; label = @5
              block  ;; label = @6
                block  ;; label = @7
                  block  ;; label = @8
                    block  ;; label = @9
                      block  ;; label = @10
                        block  ;; label = @11
                          local.get 0
                          br_if 0 (;@11;)
                          i32.const 0
                          i32.load offset=1051448
                          local.tee 0
                          i32.eqz
                          br_if 9 (;@2;)
                          local.get 0
                          call $_ZN8dlmalloc8dlmalloc9least_bit17h6d1d38bf68f60a15E
                          i32.ctz
                          i32.const 2
                          i32.shl
                          i32.const 1051036
                          i32.add
                          i32.load
                          local.tee 3
                          call $_ZN8dlmalloc8dlmalloc9TreeChunk5chunk17hdd6a267a52100ff9E
                          call $_ZN8dlmalloc8dlmalloc5Chunk4size17h6ea85aca232e3ec5E
                          local.get 2
                          i32.sub
                          local.set 6
                          block  ;; label = @12
                            local.get 3
                            call $_ZN8dlmalloc8dlmalloc9TreeChunk14leftmost_child17h6480385e5d33dc8cE
                            local.tee 0
                            i32.eqz
                            br_if 0 (;@12;)
                            loop  ;; label = @13
                              local.get 0
                              call $_ZN8dlmalloc8dlmalloc9TreeChunk5chunk17hdd6a267a52100ff9E
                              call $_ZN8dlmalloc8dlmalloc5Chunk4size17h6ea85aca232e3ec5E
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
                              call $_ZN8dlmalloc8dlmalloc9TreeChunk14leftmost_child17h6480385e5d33dc8cE
                              local.tee 0
                              br_if 0 (;@13;)
                            end
                          end
                          local.get 3
                          call $_ZN8dlmalloc8dlmalloc9TreeChunk5chunk17hdd6a267a52100ff9E
                          local.tee 0
                          local.get 2
                          call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h10af76c6d2e34d25E
                          local.set 4
                          local.get 3
                          call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$18unlink_large_chunk17h057503926679f426E
                          local.get 6
                          i32.const 16
                          i32.const 8
                          call $_ZN8dlmalloc8dlmalloc8align_up17hf58412c808f1bdfcE
                          i32.lt_u
                          br_if 2 (;@9;)
                          local.get 4
                          call $_ZN8dlmalloc8dlmalloc9TreeChunk5chunk17hdd6a267a52100ff9E
                          local.set 4
                          local.get 0
                          local.get 2
                          call $_ZN8dlmalloc8dlmalloc5Chunk34set_size_and_pinuse_of_inuse_chunk17hc6d12ed1fddec215E
                          local.get 4
                          local.get 6
                          call $_ZN8dlmalloc8dlmalloc5Chunk33set_size_and_pinuse_of_free_chunk17hb8c49fbc662a8751E
                          i32.const 0
                          i32.load offset=1051452
                          local.tee 7
                          br_if 1 (;@10;)
                          br 5 (;@6;)
                        end
                        block  ;; label = @11
                          block  ;; label = @12
                            i32.const 1
                            local.get 6
                            i32.const 31
                            i32.and
                            local.tee 6
                            i32.shl
                            call $_ZN8dlmalloc8dlmalloc9left_bits17hfd760f4678f8d918E
                            local.get 0
                            local.get 6
                            i32.shl
                            i32.and
                            call $_ZN8dlmalloc8dlmalloc9least_bit17h6d1d38bf68f60a15E
                            i32.ctz
                            local.tee 6
                            i32.const 3
                            i32.shl
                            local.tee 4
                            i32.const 1051188
                            i32.add
                            i32.load
                            local.tee 0
                            i32.const 8
                            i32.add
                            i32.load
                            local.tee 3
                            local.get 4
                            i32.const 1051180
                            i32.add
                            local.tee 4
                            i32.eq
                            br_if 0 (;@12;)
                            local.get 3
                            local.get 4
                            i32.store offset=12
                            local.get 4
                            local.get 3
                            i32.store offset=8
                            br 1 (;@11;)
                          end
                          i32.const 0
                          i32.const 0
                          i32.load offset=1051444
                          i32.const -2
                          local.get 6
                          i32.rotl
                          i32.and
                          i32.store offset=1051444
                        end
                        local.get 0
                        local.get 2
                        call $_ZN8dlmalloc8dlmalloc5Chunk34set_size_and_pinuse_of_inuse_chunk17hc6d12ed1fddec215E
                        local.get 0
                        local.get 2
                        call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h10af76c6d2e34d25E
                        local.tee 4
                        local.get 6
                        i32.const 3
                        i32.shl
                        local.get 2
                        i32.sub
                        local.tee 5
                        call $_ZN8dlmalloc8dlmalloc5Chunk33set_size_and_pinuse_of_free_chunk17hb8c49fbc662a8751E
                        i32.const 0
                        i32.load offset=1051452
                        local.tee 3
                        br_if 2 (;@8;)
                        br 3 (;@7;)
                      end
                      local.get 7
                      i32.const -8
                      i32.and
                      i32.const 1051180
                      i32.add
                      local.set 5
                      i32.const 0
                      i32.load offset=1051460
                      local.set 3
                      block  ;; label = @10
                        block  ;; label = @11
                          i32.const 0
                          i32.load offset=1051444
                          local.tee 8
                          i32.const 1
                          local.get 7
                          i32.const 3
                          i32.shr_u
                          i32.shl
                          local.tee 7
                          i32.and
                          br_if 0 (;@11;)
                          i32.const 0
                          local.get 8
                          local.get 7
                          i32.or
                          i32.store offset=1051444
                          local.get 5
                          local.set 7
                          br 1 (;@10;)
                        end
                        local.get 5
                        i32.load offset=8
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
                      br 3 (;@6;)
                    end
                    local.get 0
                    local.get 6
                    local.get 2
                    i32.add
                    call $_ZN8dlmalloc8dlmalloc5Chunk20set_inuse_and_pinuse17hb5017cd9994d56b7E
                    br 3 (;@5;)
                  end
                  local.get 3
                  i32.const -8
                  i32.and
                  i32.const 1051180
                  i32.add
                  local.set 2
                  i32.const 0
                  i32.load offset=1051460
                  local.set 6
                  block  ;; label = @8
                    block  ;; label = @9
                      i32.const 0
                      i32.load offset=1051444
                      local.tee 7
                      i32.const 1
                      local.get 3
                      i32.const 3
                      i32.shr_u
                      i32.shl
                      local.tee 3
                      i32.and
                      br_if 0 (;@9;)
                      i32.const 0
                      local.get 7
                      local.get 3
                      i32.or
                      i32.store offset=1051444
                      local.get 2
                      local.set 3
                      br 1 (;@8;)
                    end
                    local.get 2
                    i32.load offset=8
                    local.set 3
                  end
                  local.get 2
                  local.get 6
                  i32.store offset=8
                  local.get 3
                  local.get 6
                  i32.store offset=12
                  local.get 6
                  local.get 2
                  i32.store offset=12
                  local.get 6
                  local.get 3
                  i32.store offset=8
                end
                i32.const 0
                local.get 4
                i32.store offset=1051460
                i32.const 0
                local.get 5
                i32.store offset=1051452
                local.get 0
                call $_ZN8dlmalloc8dlmalloc5Chunk6to_mem17h50c7b3bad37923f8E
                local.set 6
                br 5 (;@1;)
              end
              i32.const 0
              local.get 4
              i32.store offset=1051460
              i32.const 0
              local.get 6
              i32.store offset=1051452
            end
            local.get 0
            call $_ZN8dlmalloc8dlmalloc5Chunk6to_mem17h50c7b3bad37923f8E
            local.tee 6
            i32.eqz
            br_if 2 (;@2;)
            br 3 (;@1;)
          end
          block  ;; label = @4
            local.get 0
            local.get 4
            i32.or
            br_if 0 (;@4;)
            i32.const 0
            local.set 4
            i32.const 1
            local.get 8
            i32.shl
            call $_ZN8dlmalloc8dlmalloc9left_bits17hfd760f4678f8d918E
            i32.const 0
            i32.load offset=1051448
            i32.and
            local.tee 0
            i32.eqz
            br_if 2 (;@2;)
            local.get 0
            call $_ZN8dlmalloc8dlmalloc9least_bit17h6d1d38bf68f60a15E
            i32.ctz
            i32.const 2
            i32.shl
            i32.const 1051036
            i32.add
            i32.load
            local.set 0
          end
          i32.const 1
          local.set 3
        end
        loop  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              local.get 3
              br_table 0 (;@5;) 1 (;@4;) 1 (;@4;)
            end
            local.get 4
            local.get 0
            local.get 4
            local.get 0
            call $_ZN8dlmalloc8dlmalloc9TreeChunk5chunk17hdd6a267a52100ff9E
            call $_ZN8dlmalloc8dlmalloc5Chunk4size17h6ea85aca232e3ec5E
            local.tee 3
            local.get 2
            i32.sub
            local.tee 5
            local.get 6
            i32.lt_u
            local.tee 7
            select
            local.get 3
            local.get 2
            i32.lt_u
            local.tee 3
            select
            local.set 4
            local.get 6
            local.get 5
            local.get 6
            local.get 7
            select
            local.get 3
            select
            local.set 6
            local.get 0
            call $_ZN8dlmalloc8dlmalloc9TreeChunk14leftmost_child17h6480385e5d33dc8cE
            local.set 0
            i32.const 1
            local.set 3
            br 1 (;@3;)
          end
          block  ;; label = @4
            local.get 0
            br_if 0 (;@4;)
            local.get 4
            i32.eqz
            br_if 2 (;@2;)
            block  ;; label = @5
              i32.const 0
              i32.load offset=1051452
              local.tee 0
              local.get 2
              i32.lt_u
              br_if 0 (;@5;)
              local.get 6
              local.get 0
              local.get 2
              i32.sub
              i32.ge_u
              br_if 3 (;@2;)
            end
            local.get 4
            call $_ZN8dlmalloc8dlmalloc9TreeChunk5chunk17hdd6a267a52100ff9E
            local.tee 0
            local.get 2
            call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h10af76c6d2e34d25E
            local.set 3
            local.get 4
            call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$18unlink_large_chunk17h057503926679f426E
            block  ;; label = @5
              block  ;; label = @6
                local.get 6
                i32.const 16
                i32.const 8
                call $_ZN8dlmalloc8dlmalloc8align_up17hf58412c808f1bdfcE
                i32.lt_u
                br_if 0 (;@6;)
                local.get 0
                local.get 2
                call $_ZN8dlmalloc8dlmalloc5Chunk34set_size_and_pinuse_of_inuse_chunk17hc6d12ed1fddec215E
                local.get 3
                local.get 6
                call $_ZN8dlmalloc8dlmalloc5Chunk33set_size_and_pinuse_of_free_chunk17hb8c49fbc662a8751E
                block  ;; label = @7
                  local.get 6
                  i32.const 256
                  i32.lt_u
                  br_if 0 (;@7;)
                  local.get 3
                  local.get 6
                  call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$18insert_large_chunk17hc73af8a4cd0b31d7E
                  br 2 (;@5;)
                end
                local.get 6
                i32.const -8
                i32.and
                i32.const 1051180
                i32.add
                local.set 4
                block  ;; label = @7
                  block  ;; label = @8
                    i32.const 0
                    i32.load offset=1051444
                    local.tee 5
                    i32.const 1
                    local.get 6
                    i32.const 3
                    i32.shr_u
                    i32.shl
                    local.tee 6
                    i32.and
                    br_if 0 (;@8;)
                    i32.const 0
                    local.get 5
                    local.get 6
                    i32.or
                    i32.store offset=1051444
                    local.get 4
                    local.set 6
                    br 1 (;@7;)
                  end
                  local.get 4
                  i32.load offset=8
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
                br 1 (;@5;)
              end
              local.get 0
              local.get 6
              local.get 2
              i32.add
              call $_ZN8dlmalloc8dlmalloc5Chunk20set_inuse_and_pinuse17hb5017cd9994d56b7E
            end
            local.get 0
            call $_ZN8dlmalloc8dlmalloc5Chunk6to_mem17h50c7b3bad37923f8E
            local.tee 6
            br_if 3 (;@1;)
            br 2 (;@2;)
          end
          i32.const 0
          local.set 3
          br 0 (;@3;)
        end
      end
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            i32.const 0
            i32.load offset=1051452
            local.tee 6
            local.get 2
            i32.ge_u
            br_if 0 (;@4;)
            block  ;; label = @5
              i32.const 0
              i32.load offset=1051456
              local.tee 0
              local.get 2
              i32.gt_u
              br_if 0 (;@5;)
              local.get 1
              i32.const 4
              i32.add
              i32.const 1051488
              local.get 2
              call $_ZN8dlmalloc8dlmalloc5Chunk10mem_offset17hb4f8ba9389e35f03E
              local.tee 0
              i32.sub
              local.get 0
              i32.const 8
              call $_ZN8dlmalloc8dlmalloc8align_up17hf58412c808f1bdfcE
              i32.add
              i32.const 20
              i32.const 8
              call $_ZN8dlmalloc8dlmalloc8align_up17hf58412c808f1bdfcE
              i32.add
              i32.const 16
              i32.const 8
              call $_ZN8dlmalloc8dlmalloc8align_up17hf58412c808f1bdfcE
              i32.add
              i32.const 8
              i32.add
              i32.const 65536
              call $_ZN8dlmalloc8dlmalloc8align_up17hf58412c808f1bdfcE
              call $_ZN61_$LT$dlmalloc..sys..System$u20$as$u20$dlmalloc..Allocator$GT$5alloc17hed1977c094ba06f0E
              block  ;; label = @6
                local.get 1
                i32.load offset=4
                local.tee 6
                br_if 0 (;@6;)
                i32.const 0
                local.set 6
                br 5 (;@1;)
              end
              local.get 1
              i32.load offset=12
              local.set 8
              i32.const 0
              i32.const 0
              i32.load offset=1051468
              local.get 1
              i32.load offset=8
              local.tee 5
              i32.add
              local.tee 0
              i32.store offset=1051468
              i32.const 0
              i32.const 0
              i32.load offset=1051472
              local.tee 3
              local.get 0
              local.get 3
              local.get 0
              i32.gt_u
              select
              i32.store offset=1051472
              block  ;; label = @6
                block  ;; label = @7
                  i32.const 0
                  i32.load offset=1051464
                  i32.eqz
                  br_if 0 (;@7;)
                  i32.const 1051164
                  local.set 0
                  loop  ;; label = @8
                    local.get 6
                    local.get 0
                    call $_ZN8dlmalloc8dlmalloc7Segment3top17hdd4d160761d7a4c1E
                    i32.eq
                    br_if 2 (;@6;)
                    local.get 0
                    i32.load offset=8
                    local.tee 0
                    br_if 0 (;@8;)
                    br 5 (;@3;)
                  end
                end
                block  ;; label = @7
                  block  ;; label = @8
                    i32.const 0
                    i32.load offset=1051480
                    local.tee 0
                    i32.eqz
                    br_if 0 (;@8;)
                    local.get 6
                    local.get 0
                    i32.ge_u
                    br_if 1 (;@7;)
                  end
                  i32.const 0
                  local.get 6
                  i32.store offset=1051480
                end
                i32.const 0
                i32.const 4095
                i32.store offset=1051484
                i32.const 0
                local.get 8
                i32.store offset=1051176
                i32.const 0
                local.get 5
                i32.store offset=1051168
                i32.const 0
                local.get 6
                i32.store offset=1051164
                i32.const 0
                i32.const 1051180
                i32.store offset=1051192
                i32.const 0
                i32.const 1051188
                i32.store offset=1051200
                i32.const 0
                i32.const 1051180
                i32.store offset=1051188
                i32.const 0
                i32.const 1051196
                i32.store offset=1051208
                i32.const 0
                i32.const 1051188
                i32.store offset=1051196
                i32.const 0
                i32.const 1051204
                i32.store offset=1051216
                i32.const 0
                i32.const 1051196
                i32.store offset=1051204
                i32.const 0
                i32.const 1051212
                i32.store offset=1051224
                i32.const 0
                i32.const 1051204
                i32.store offset=1051212
                i32.const 0
                i32.const 1051220
                i32.store offset=1051232
                i32.const 0
                i32.const 1051212
                i32.store offset=1051220
                i32.const 0
                i32.const 1051228
                i32.store offset=1051240
                i32.const 0
                i32.const 1051220
                i32.store offset=1051228
                i32.const 0
                i32.const 1051236
                i32.store offset=1051248
                i32.const 0
                i32.const 1051228
                i32.store offset=1051236
                i32.const 0
                i32.const 1051244
                i32.store offset=1051256
                i32.const 0
                i32.const 1051236
                i32.store offset=1051244
                i32.const 0
                i32.const 1051244
                i32.store offset=1051252
                i32.const 0
                i32.const 1051252
                i32.store offset=1051264
                i32.const 0
                i32.const 1051252
                i32.store offset=1051260
                i32.const 0
                i32.const 1051260
                i32.store offset=1051272
                i32.const 0
                i32.const 1051260
                i32.store offset=1051268
                i32.const 0
                i32.const 1051268
                i32.store offset=1051280
                i32.const 0
                i32.const 1051268
                i32.store offset=1051276
                i32.const 0
                i32.const 1051276
                i32.store offset=1051288
                i32.const 0
                i32.const 1051276
                i32.store offset=1051284
                i32.const 0
                i32.const 1051284
                i32.store offset=1051296
                i32.const 0
                i32.const 1051284
                i32.store offset=1051292
                i32.const 0
                i32.const 1051292
                i32.store offset=1051304
                i32.const 0
                i32.const 1051292
                i32.store offset=1051300
                i32.const 0
                i32.const 1051300
                i32.store offset=1051312
                i32.const 0
                i32.const 1051300
                i32.store offset=1051308
                i32.const 0
                i32.const 1051308
                i32.store offset=1051320
                i32.const 0
                i32.const 1051316
                i32.store offset=1051328
                i32.const 0
                i32.const 1051308
                i32.store offset=1051316
                i32.const 0
                i32.const 1051324
                i32.store offset=1051336
                i32.const 0
                i32.const 1051316
                i32.store offset=1051324
                i32.const 0
                i32.const 1051332
                i32.store offset=1051344
                i32.const 0
                i32.const 1051324
                i32.store offset=1051332
                i32.const 0
                i32.const 1051340
                i32.store offset=1051352
                i32.const 0
                i32.const 1051332
                i32.store offset=1051340
                i32.const 0
                i32.const 1051348
                i32.store offset=1051360
                i32.const 0
                i32.const 1051340
                i32.store offset=1051348
                i32.const 0
                i32.const 1051356
                i32.store offset=1051368
                i32.const 0
                i32.const 1051348
                i32.store offset=1051356
                i32.const 0
                i32.const 1051364
                i32.store offset=1051376
                i32.const 0
                i32.const 1051356
                i32.store offset=1051364
                i32.const 0
                i32.const 1051372
                i32.store offset=1051384
                i32.const 0
                i32.const 1051364
                i32.store offset=1051372
                i32.const 0
                i32.const 1051380
                i32.store offset=1051392
                i32.const 0
                i32.const 1051372
                i32.store offset=1051380
                i32.const 0
                i32.const 1051388
                i32.store offset=1051400
                i32.const 0
                i32.const 1051380
                i32.store offset=1051388
                i32.const 0
                i32.const 1051396
                i32.store offset=1051408
                i32.const 0
                i32.const 1051388
                i32.store offset=1051396
                i32.const 0
                i32.const 1051404
                i32.store offset=1051416
                i32.const 0
                i32.const 1051396
                i32.store offset=1051404
                i32.const 0
                i32.const 1051412
                i32.store offset=1051424
                i32.const 0
                i32.const 1051404
                i32.store offset=1051412
                i32.const 0
                i32.const 1051420
                i32.store offset=1051432
                i32.const 0
                i32.const 1051412
                i32.store offset=1051420
                i32.const 0
                i32.const 1051428
                i32.store offset=1051440
                i32.const 0
                i32.const 1051420
                i32.store offset=1051428
                i32.const 0
                i32.const 1051428
                i32.store offset=1051436
                call $_ZN8dlmalloc8dlmalloc5Chunk10mem_offset17hb4f8ba9389e35f03E
                local.tee 3
                i32.const 8
                call $_ZN8dlmalloc8dlmalloc8align_up17hf58412c808f1bdfcE
                local.set 4
                i32.const 20
                i32.const 8
                call $_ZN8dlmalloc8dlmalloc8align_up17hf58412c808f1bdfcE
                local.set 7
                i32.const 16
                i32.const 8
                call $_ZN8dlmalloc8dlmalloc8align_up17hf58412c808f1bdfcE
                local.set 8
                i32.const 0
                local.get 6
                local.get 6
                call $_ZN8dlmalloc8dlmalloc5Chunk6to_mem17h50c7b3bad37923f8E
                local.tee 0
                i32.const 8
                call $_ZN8dlmalloc8dlmalloc8align_up17hf58412c808f1bdfcE
                local.get 0
                i32.sub
                local.tee 9
                call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h10af76c6d2e34d25E
                local.tee 0
                i32.store offset=1051464
                i32.const 0
                local.get 3
                local.get 5
                i32.add
                local.get 8
                local.get 4
                local.get 7
                i32.add
                i32.add
                local.get 9
                i32.add
                i32.sub
                local.tee 6
                i32.store offset=1051456
                local.get 0
                local.get 6
                i32.const 1
                i32.or
                i32.store offset=4
                call $_ZN8dlmalloc8dlmalloc5Chunk10mem_offset17hb4f8ba9389e35f03E
                local.tee 3
                i32.const 8
                call $_ZN8dlmalloc8dlmalloc8align_up17hf58412c808f1bdfcE
                local.set 4
                i32.const 20
                i32.const 8
                call $_ZN8dlmalloc8dlmalloc8align_up17hf58412c808f1bdfcE
                local.set 5
                i32.const 16
                i32.const 8
                call $_ZN8dlmalloc8dlmalloc8align_up17hf58412c808f1bdfcE
                local.set 7
                local.get 0
                local.get 6
                call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h10af76c6d2e34d25E
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
                i32.store offset=1051476
                br 4 (;@2;)
              end
              local.get 0
              call $_ZN8dlmalloc8dlmalloc7Segment9is_extern17hce2b6c60378fecbaE
              br_if 2 (;@3;)
              local.get 0
              call $_ZN8dlmalloc8dlmalloc7Segment9sys_flags17ha34d71c2c0a2f4f8E
              local.get 8
              i32.ne
              br_if 2 (;@3;)
              local.get 0
              i32.const 0
              i32.load offset=1051464
              call $_ZN8dlmalloc8dlmalloc7Segment5holds17hd979b70163a9ea52E
              i32.eqz
              br_if 2 (;@3;)
              local.get 0
              local.get 0
              i32.load offset=4
              local.get 5
              i32.add
              i32.store offset=4
              i32.const 0
              i32.load offset=1051464
              i32.const 0
              i32.load offset=1051456
              local.get 5
              i32.add
              call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$8init_top17haeeb56bfbe3f1e70E
              br 3 (;@2;)
            end
            i32.const 0
            local.get 0
            local.get 2
            i32.sub
            local.tee 6
            i32.store offset=1051456
            i32.const 0
            i32.const 0
            i32.load offset=1051464
            local.tee 0
            local.get 2
            call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h10af76c6d2e34d25E
            local.tee 3
            i32.store offset=1051464
            local.get 3
            local.get 6
            i32.const 1
            i32.or
            i32.store offset=4
            local.get 0
            local.get 2
            call $_ZN8dlmalloc8dlmalloc5Chunk34set_size_and_pinuse_of_inuse_chunk17hc6d12ed1fddec215E
            local.get 0
            call $_ZN8dlmalloc8dlmalloc5Chunk6to_mem17h50c7b3bad37923f8E
            local.set 6
            br 3 (;@1;)
          end
          i32.const 0
          i32.load offset=1051460
          local.set 0
          block  ;; label = @4
            local.get 6
            local.get 2
            i32.sub
            local.tee 6
            i32.const 16
            i32.const 8
            call $_ZN8dlmalloc8dlmalloc8align_up17hf58412c808f1bdfcE
            i32.lt_u
            br_if 0 (;@4;)
            local.get 0
            local.get 2
            call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h10af76c6d2e34d25E
            local.set 3
            i32.const 0
            local.get 6
            i32.store offset=1051452
            i32.const 0
            local.get 3
            i32.store offset=1051460
            local.get 3
            local.get 6
            call $_ZN8dlmalloc8dlmalloc5Chunk33set_size_and_pinuse_of_free_chunk17hb8c49fbc662a8751E
            local.get 0
            local.get 2
            call $_ZN8dlmalloc8dlmalloc5Chunk34set_size_and_pinuse_of_inuse_chunk17hc6d12ed1fddec215E
            local.get 0
            call $_ZN8dlmalloc8dlmalloc5Chunk6to_mem17h50c7b3bad37923f8E
            local.set 6
            br 3 (;@1;)
          end
          i32.const 0
          i32.const 0
          i32.store offset=1051460
          i32.const 0
          i32.load offset=1051452
          local.set 6
          i32.const 0
          i32.const 0
          i32.store offset=1051452
          local.get 0
          local.get 6
          call $_ZN8dlmalloc8dlmalloc5Chunk20set_inuse_and_pinuse17hb5017cd9994d56b7E
          local.get 0
          call $_ZN8dlmalloc8dlmalloc5Chunk6to_mem17h50c7b3bad37923f8E
          local.set 6
          br 2 (;@1;)
        end
        i32.const 0
        i32.const 0
        i32.load offset=1051480
        local.tee 0
        local.get 6
        local.get 6
        local.get 0
        i32.gt_u
        select
        i32.store offset=1051480
        local.get 6
        local.get 5
        i32.add
        local.set 3
        i32.const 1051164
        local.set 0
        block  ;; label = @3
          block  ;; label = @4
            loop  ;; label = @5
              local.get 0
              i32.load
              local.get 3
              i32.eq
              br_if 1 (;@4;)
              local.get 0
              i32.load offset=8
              local.tee 0
              br_if 0 (;@5;)
              br 2 (;@3;)
            end
          end
          local.get 0
          call $_ZN8dlmalloc8dlmalloc7Segment9is_extern17hce2b6c60378fecbaE
          br_if 0 (;@3;)
          local.get 0
          call $_ZN8dlmalloc8dlmalloc7Segment9sys_flags17ha34d71c2c0a2f4f8E
          local.get 8
          i32.ne
          br_if 0 (;@3;)
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
          call $_ZN8dlmalloc8dlmalloc5Chunk6to_mem17h50c7b3bad37923f8E
          local.tee 0
          i32.const 8
          call $_ZN8dlmalloc8dlmalloc8align_up17hf58412c808f1bdfcE
          local.set 3
          local.get 4
          call $_ZN8dlmalloc8dlmalloc5Chunk6to_mem17h50c7b3bad37923f8E
          local.tee 5
          i32.const 8
          call $_ZN8dlmalloc8dlmalloc8align_up17hf58412c808f1bdfcE
          local.set 7
          local.get 6
          local.get 3
          local.get 0
          i32.sub
          i32.add
          local.tee 6
          local.get 2
          call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h10af76c6d2e34d25E
          local.set 3
          local.get 6
          local.get 2
          call $_ZN8dlmalloc8dlmalloc5Chunk34set_size_and_pinuse_of_inuse_chunk17hc6d12ed1fddec215E
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
          block  ;; label = @4
            block  ;; label = @5
              local.get 0
              i32.const 0
              i32.load offset=1051464
              i32.eq
              br_if 0 (;@5;)
              local.get 0
              i32.const 0
              i32.load offset=1051460
              i32.eq
              br_if 1 (;@4;)
              block  ;; label = @6
                local.get 0
                call $_ZN8dlmalloc8dlmalloc5Chunk5inuse17h18988138fdbf78b6E
                br_if 0 (;@6;)
                block  ;; label = @7
                  block  ;; label = @8
                    local.get 0
                    call $_ZN8dlmalloc8dlmalloc5Chunk4size17h6ea85aca232e3ec5E
                    local.tee 4
                    i32.const 256
                    i32.lt_u
                    br_if 0 (;@8;)
                    local.get 0
                    call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$18unlink_large_chunk17h057503926679f426E
                    br 1 (;@7;)
                  end
                  block  ;; label = @8
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
                    br_if 0 (;@8;)
                    local.get 7
                    local.get 5
                    i32.store offset=12
                    local.get 5
                    local.get 7
                    i32.store offset=8
                    br 1 (;@7;)
                  end
                  i32.const 0
                  i32.const 0
                  i32.load offset=1051444
                  i32.const -2
                  local.get 4
                  i32.const 3
                  i32.shr_u
                  i32.rotl
                  i32.and
                  i32.store offset=1051444
                end
                local.get 4
                local.get 2
                i32.add
                local.set 2
                local.get 0
                local.get 4
                call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h10af76c6d2e34d25E
                local.set 0
              end
              local.get 3
              local.get 2
              local.get 0
              call $_ZN8dlmalloc8dlmalloc5Chunk20set_free_with_pinuse17h1e6a59985180e994E
              block  ;; label = @6
                local.get 2
                i32.const 256
                i32.lt_u
                br_if 0 (;@6;)
                local.get 3
                local.get 2
                call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$18insert_large_chunk17hc73af8a4cd0b31d7E
                local.get 6
                call $_ZN8dlmalloc8dlmalloc5Chunk6to_mem17h50c7b3bad37923f8E
                local.set 6
                br 5 (;@1;)
              end
              local.get 2
              i32.const -8
              i32.and
              i32.const 1051180
              i32.add
              local.set 0
              block  ;; label = @6
                block  ;; label = @7
                  i32.const 0
                  i32.load offset=1051444
                  local.tee 4
                  i32.const 1
                  local.get 2
                  i32.const 3
                  i32.shr_u
                  i32.shl
                  local.tee 2
                  i32.and
                  br_if 0 (;@7;)
                  i32.const 0
                  local.get 4
                  local.get 2
                  i32.or
                  i32.store offset=1051444
                  local.get 0
                  local.set 2
                  br 1 (;@6;)
                end
                local.get 0
                i32.load offset=8
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
              call $_ZN8dlmalloc8dlmalloc5Chunk6to_mem17h50c7b3bad37923f8E
              local.set 6
              br 4 (;@1;)
            end
            i32.const 0
            local.get 3
            i32.store offset=1051464
            i32.const 0
            i32.const 0
            i32.load offset=1051456
            local.get 2
            i32.add
            local.tee 0
            i32.store offset=1051456
            local.get 3
            local.get 0
            i32.const 1
            i32.or
            i32.store offset=4
            local.get 6
            call $_ZN8dlmalloc8dlmalloc5Chunk6to_mem17h50c7b3bad37923f8E
            local.set 6
            br 3 (;@1;)
          end
          i32.const 0
          local.get 3
          i32.store offset=1051460
          i32.const 0
          i32.const 0
          i32.load offset=1051452
          local.get 2
          i32.add
          local.tee 0
          i32.store offset=1051452
          local.get 3
          local.get 0
          call $_ZN8dlmalloc8dlmalloc5Chunk33set_size_and_pinuse_of_free_chunk17hb8c49fbc662a8751E
          local.get 6
          call $_ZN8dlmalloc8dlmalloc5Chunk6to_mem17h50c7b3bad37923f8E
          local.set 6
          br 2 (;@1;)
        end
        i32.const 0
        i32.load offset=1051464
        local.set 3
        i32.const 1051164
        local.set 0
        block  ;; label = @3
          loop  ;; label = @4
            block  ;; label = @5
              local.get 0
              i32.load
              local.get 3
              i32.gt_u
              br_if 0 (;@5;)
              local.get 0
              call $_ZN8dlmalloc8dlmalloc7Segment3top17hdd4d160761d7a4c1E
              local.get 3
              i32.gt_u
              br_if 2 (;@3;)
            end
            local.get 0
            i32.load offset=8
            local.tee 0
            br_if 0 (;@4;)
          end
          i32.const 0
          local.set 0
        end
        local.get 0
        call $_ZN8dlmalloc8dlmalloc7Segment3top17hdd4d160761d7a4c1E
        local.tee 4
        i32.const 20
        i32.const 8
        call $_ZN8dlmalloc8dlmalloc8align_up17hf58412c808f1bdfcE
        local.tee 10
        i32.sub
        i32.const -23
        i32.add
        local.set 0
        local.get 3
        local.get 0
        local.get 0
        call $_ZN8dlmalloc8dlmalloc5Chunk6to_mem17h50c7b3bad37923f8E
        local.tee 7
        i32.const 8
        call $_ZN8dlmalloc8dlmalloc8align_up17hf58412c808f1bdfcE
        local.get 7
        i32.sub
        i32.add
        local.tee 0
        local.get 0
        local.get 3
        i32.const 16
        i32.const 8
        call $_ZN8dlmalloc8dlmalloc8align_up17hf58412c808f1bdfcE
        i32.add
        i32.lt_u
        select
        local.tee 7
        call $_ZN8dlmalloc8dlmalloc5Chunk6to_mem17h50c7b3bad37923f8E
        local.set 9
        local.get 7
        local.get 10
        call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h10af76c6d2e34d25E
        local.set 0
        call $_ZN8dlmalloc8dlmalloc5Chunk10mem_offset17hb4f8ba9389e35f03E
        local.tee 11
        i32.const 8
        call $_ZN8dlmalloc8dlmalloc8align_up17hf58412c808f1bdfcE
        local.set 12
        i32.const 20
        i32.const 8
        call $_ZN8dlmalloc8dlmalloc8align_up17hf58412c808f1bdfcE
        local.set 13
        i32.const 16
        i32.const 8
        call $_ZN8dlmalloc8dlmalloc8align_up17hf58412c808f1bdfcE
        local.set 14
        i32.const 0
        local.get 6
        local.get 6
        call $_ZN8dlmalloc8dlmalloc5Chunk6to_mem17h50c7b3bad37923f8E
        local.tee 15
        i32.const 8
        call $_ZN8dlmalloc8dlmalloc8align_up17hf58412c808f1bdfcE
        local.get 15
        i32.sub
        local.tee 16
        call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h10af76c6d2e34d25E
        local.tee 15
        i32.store offset=1051464
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
        i32.store offset=1051456
        local.get 15
        local.get 11
        i32.const 1
        i32.or
        i32.store offset=4
        call $_ZN8dlmalloc8dlmalloc5Chunk10mem_offset17hb4f8ba9389e35f03E
        local.tee 12
        i32.const 8
        call $_ZN8dlmalloc8dlmalloc8align_up17hf58412c808f1bdfcE
        local.set 13
        i32.const 20
        i32.const 8
        call $_ZN8dlmalloc8dlmalloc8align_up17hf58412c808f1bdfcE
        local.set 14
        i32.const 16
        i32.const 8
        call $_ZN8dlmalloc8dlmalloc8align_up17hf58412c808f1bdfcE
        local.set 16
        local.get 15
        local.get 11
        call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h10af76c6d2e34d25E
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
        i32.store offset=1051476
        local.get 7
        local.get 10
        call $_ZN8dlmalloc8dlmalloc5Chunk34set_size_and_pinuse_of_inuse_chunk17hc6d12ed1fddec215E
        i32.const 0
        i64.load offset=1051164 align=4
        local.set 17
        local.get 9
        i32.const 8
        i32.add
        i32.const 0
        i64.load offset=1051172 align=4
        i64.store align=4
        local.get 9
        local.get 17
        i64.store align=4
        i32.const 0
        local.get 8
        i32.store offset=1051176
        i32.const 0
        local.get 5
        i32.store offset=1051168
        i32.const 0
        local.get 6
        i32.store offset=1051164
        i32.const 0
        local.get 9
        i32.store offset=1051172
        loop  ;; label = @3
          local.get 0
          i32.const 4
          call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h10af76c6d2e34d25E
          local.set 6
          local.get 0
          call $_ZN8dlmalloc8dlmalloc5Chunk14fencepost_head17h9c894b28b6a333e9E
          i32.store offset=4
          local.get 6
          local.set 0
          local.get 6
          i32.const 4
          i32.add
          local.get 4
          i32.lt_u
          br_if 0 (;@3;)
        end
        local.get 7
        local.get 3
        i32.eq
        br_if 0 (;@2;)
        local.get 7
        local.get 3
        i32.sub
        local.set 0
        local.get 3
        local.get 0
        local.get 3
        local.get 0
        call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h10af76c6d2e34d25E
        call $_ZN8dlmalloc8dlmalloc5Chunk20set_free_with_pinuse17h1e6a59985180e994E
        block  ;; label = @3
          local.get 0
          i32.const 256
          i32.lt_u
          br_if 0 (;@3;)
          local.get 3
          local.get 0
          call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$18insert_large_chunk17hc73af8a4cd0b31d7E
          br 1 (;@2;)
        end
        local.get 0
        i32.const -8
        i32.and
        i32.const 1051180
        i32.add
        local.set 6
        block  ;; label = @3
          block  ;; label = @4
            i32.const 0
            i32.load offset=1051444
            local.tee 4
            i32.const 1
            local.get 0
            i32.const 3
            i32.shr_u
            i32.shl
            local.tee 0
            i32.and
            br_if 0 (;@4;)
            i32.const 0
            local.get 4
            local.get 0
            i32.or
            i32.store offset=1051444
            local.get 6
            local.set 0
            br 1 (;@3;)
          end
          local.get 6
          i32.load offset=8
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
      end
      i32.const 0
      local.set 6
      i32.const 0
      i32.load offset=1051456
      local.tee 0
      local.get 2
      i32.le_u
      br_if 0 (;@1;)
      i32.const 0
      local.get 0
      local.get 2
      i32.sub
      local.tee 6
      i32.store offset=1051456
      i32.const 0
      i32.const 0
      i32.load offset=1051464
      local.tee 0
      local.get 2
      call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h10af76c6d2e34d25E
      local.tee 3
      i32.store offset=1051464
      local.get 3
      local.get 6
      i32.const 1
      i32.or
      i32.store offset=4
      local.get 0
      local.get 2
      call $_ZN8dlmalloc8dlmalloc5Chunk34set_size_and_pinuse_of_inuse_chunk17hc6d12ed1fddec215E
      local.get 0
      call $_ZN8dlmalloc8dlmalloc5Chunk6to_mem17h50c7b3bad37923f8E
      local.set 6
    end
    local.get 1
    i32.const 16
    i32.add
    global.set $__stack_pointer
    local.get 6)
  (func $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$8init_top17haeeb56bfbe3f1e70E (type 0) (param i32 i32)
    (local i32 i32 i32 i32)
    local.get 0
    local.get 0
    call $_ZN8dlmalloc8dlmalloc5Chunk6to_mem17h50c7b3bad37923f8E
    local.tee 2
    i32.const 8
    call $_ZN8dlmalloc8dlmalloc8align_up17hf58412c808f1bdfcE
    local.get 2
    i32.sub
    local.tee 2
    call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h10af76c6d2e34d25E
    local.set 0
    i32.const 0
    local.get 1
    local.get 2
    i32.sub
    local.tee 1
    i32.store offset=1051456
    i32.const 0
    local.get 0
    i32.store offset=1051464
    local.get 0
    local.get 1
    i32.const 1
    i32.or
    i32.store offset=4
    call $_ZN8dlmalloc8dlmalloc5Chunk10mem_offset17hb4f8ba9389e35f03E
    local.tee 2
    i32.const 8
    call $_ZN8dlmalloc8dlmalloc8align_up17hf58412c808f1bdfcE
    local.set 3
    i32.const 20
    i32.const 8
    call $_ZN8dlmalloc8dlmalloc8align_up17hf58412c808f1bdfcE
    local.set 4
    i32.const 16
    i32.const 8
    call $_ZN8dlmalloc8dlmalloc8align_up17hf58412c808f1bdfcE
    local.set 5
    local.get 0
    local.get 1
    call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h10af76c6d2e34d25E
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
    i32.store offset=1051476)
  (func $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$8memalign17h95037d0abac42865E (type 2) (param i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32)
    block  ;; label = @1
      i32.const 16
      i32.const 8
      call $_ZN8dlmalloc8dlmalloc8align_up17hf58412c808f1bdfcE
      local.get 0
      i32.le_u
      br_if 0 (;@1;)
      i32.const 16
      i32.const 8
      call $_ZN8dlmalloc8dlmalloc8align_up17hf58412c808f1bdfcE
      local.set 0
    end
    call $_ZN8dlmalloc8dlmalloc5Chunk10mem_offset17hb4f8ba9389e35f03E
    local.tee 2
    i32.const 8
    call $_ZN8dlmalloc8dlmalloc8align_up17hf58412c808f1bdfcE
    local.set 3
    i32.const 20
    i32.const 8
    call $_ZN8dlmalloc8dlmalloc8align_up17hf58412c808f1bdfcE
    local.set 4
    i32.const 16
    i32.const 8
    call $_ZN8dlmalloc8dlmalloc8align_up17hf58412c808f1bdfcE
    local.set 5
    i32.const 0
    local.set 6
    block  ;; label = @1
      i32.const 0
      i32.const 16
      i32.const 8
      call $_ZN8dlmalloc8dlmalloc8align_up17hf58412c808f1bdfcE
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
      call $_ZN8dlmalloc8dlmalloc8align_up17hf58412c808f1bdfcE
      i32.const -5
      i32.add
      local.get 1
      i32.gt_u
      select
      i32.const 8
      call $_ZN8dlmalloc8dlmalloc8align_up17hf58412c808f1bdfcE
      local.tee 3
      i32.add
      i32.const 16
      i32.const 8
      call $_ZN8dlmalloc8dlmalloc8align_up17hf58412c808f1bdfcE
      i32.add
      i32.const -4
      i32.add
      call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$6malloc17h464a2d96faf011fdE
      local.tee 2
      i32.eqz
      br_if 0 (;@1;)
      local.get 2
      call $_ZN8dlmalloc8dlmalloc5Chunk8from_mem17h979df28b2facc7dcE
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
        call $_ZN8dlmalloc8dlmalloc5Chunk8from_mem17h979df28b2facc7dcE
        local.set 6
        i32.const 16
        i32.const 8
        call $_ZN8dlmalloc8dlmalloc8align_up17hf58412c808f1bdfcE
        local.set 2
        local.get 1
        call $_ZN8dlmalloc8dlmalloc5Chunk4size17h6ea85aca232e3ec5E
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
          call $_ZN8dlmalloc8dlmalloc5Chunk7mmapped17hc9e33fd0b0c5432fE
          br_if 0 (;@3;)
          local.get 0
          local.get 2
          call $_ZN8dlmalloc8dlmalloc5Chunk9set_inuse17h6303961e692a6b87E
          local.get 1
          local.get 6
          call $_ZN8dlmalloc8dlmalloc5Chunk9set_inuse17h6303961e692a6b87E
          local.get 1
          local.get 6
          call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$13dispose_chunk17h0b25ee30658eb07bE
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
        call $_ZN8dlmalloc8dlmalloc5Chunk7mmapped17hc9e33fd0b0c5432fE
        br_if 0 (;@2;)
        local.get 0
        call $_ZN8dlmalloc8dlmalloc5Chunk4size17h6ea85aca232e3ec5E
        local.tee 1
        i32.const 16
        i32.const 8
        call $_ZN8dlmalloc8dlmalloc8align_up17hf58412c808f1bdfcE
        local.get 3
        i32.add
        i32.le_u
        br_if 0 (;@2;)
        local.get 0
        local.get 3
        call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h10af76c6d2e34d25E
        local.set 6
        local.get 0
        local.get 3
        call $_ZN8dlmalloc8dlmalloc5Chunk9set_inuse17h6303961e692a6b87E
        local.get 6
        local.get 1
        local.get 3
        i32.sub
        local.tee 1
        call $_ZN8dlmalloc8dlmalloc5Chunk9set_inuse17h6303961e692a6b87E
        local.get 6
        local.get 1
        call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$13dispose_chunk17h0b25ee30658eb07bE
      end
      local.get 0
      call $_ZN8dlmalloc8dlmalloc5Chunk6to_mem17h50c7b3bad37923f8E
      local.set 6
      local.get 0
      call $_ZN8dlmalloc8dlmalloc5Chunk7mmapped17hc9e33fd0b0c5432fE
      drop
    end
    local.get 6)
  (func $_ZN3std10sys_common9backtrace26__rust_end_short_backtrace17hf9e2f055fb5ef672E (type 7) (param i32)
    local.get 0
    call $_ZN3std9panicking19begin_panic_handler28_$u7b$$u7b$closure$u7d$$u7d$17hc07db454214d2c87E
    unreachable)
  (func $_ZN3std9panicking19begin_panic_handler28_$u7b$$u7b$closure$u7d$$u7d$17hc07db454214d2c87E (type 7) (param i32)
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
          i32.const 1050116
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
      i32.const 1050368
      local.get 0
      i32.load offset=4
      local.tee 2
      call $_ZN4core5panic10panic_info9PanicInfo7message17hd4c13a2e438e62f2E
      local.get 0
      i32.load offset=8
      local.get 2
      call $_ZN4core5panic10panic_info9PanicInfo10can_unwind17h28bb5a3a95a12ae3E
      local.get 2
      i32.load8_u offset=17
      call $_ZN3std9panicking20rust_panic_with_hook17hbf46ef0245cc9589E
      unreachable
    end
    local.get 1
    i32.const 0
    i32.store offset=4
    local.get 1
    local.get 2
    i32.store
    local.get 1
    i32.const 1050388
    local.get 0
    i32.load offset=4
    local.tee 2
    call $_ZN4core5panic10panic_info9PanicInfo7message17hd4c13a2e438e62f2E
    local.get 0
    i32.load offset=8
    local.get 2
    call $_ZN4core5panic10panic_info9PanicInfo10can_unwind17h28bb5a3a95a12ae3E
    local.get 2
    i32.load8_u offset=17
    call $_ZN3std9panicking20rust_panic_with_hook17hbf46ef0245cc9589E
    unreachable)
  (func $_ZN3std5alloc24default_alloc_error_hook17hc2a71c6bbbdfc2afE (type 0) (param i32 i32)
    (local i32)
    global.get $__stack_pointer
    i32.const 48
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    block  ;; label = @1
      i32.const 0
      i32.load8_u offset=1051008
      i32.eqz
      br_if 0 (;@1;)
      local.get 2
      i32.const 24
      i32.add
      i64.const 1
      i64.store align=4
      local.get 2
      i32.const 2
      i32.store offset=16
      local.get 2
      i32.const 1050220
      i32.store offset=12
      local.get 2
      i32.const 2
      i32.store offset=40
      local.get 2
      local.get 1
      i32.store offset=44
      local.get 2
      local.get 2
      i32.const 36
      i32.add
      i32.store offset=20
      local.get 2
      local.get 2
      i32.const 44
      i32.add
      i32.store offset=36
      local.get 2
      i32.const 12
      i32.add
      i32.const 1050260
      call $_ZN4core9panicking9panic_fmt17h14c85a61aa3d538eE
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
      call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$8memalign17h95037d0abac42865E
      return
    end
    local.get 0
    call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$6malloc17h464a2d96faf011fdE)
  (func $__rdl_dealloc (type 3) (param i32 i32 i32)
    local.get 0
    call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$4free17h0a66a05f2e0e0048E)
  (func $__rdl_realloc (type 11) (param i32 i32 i32 i32) (result i32)
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
                call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$8memalign17h95037d0abac42865E
                local.tee 2
                br_if 1 (;@5;)
                i32.const 0
                return
              end
              call $_ZN8dlmalloc8dlmalloc5Chunk10mem_offset17hb4f8ba9389e35f03E
              local.tee 1
              i32.const 8
              call $_ZN8dlmalloc8dlmalloc8align_up17hf58412c808f1bdfcE
              local.set 4
              i32.const 20
              i32.const 8
              call $_ZN8dlmalloc8dlmalloc8align_up17hf58412c808f1bdfcE
              local.set 5
              i32.const 16
              i32.const 8
              call $_ZN8dlmalloc8dlmalloc8align_up17hf58412c808f1bdfcE
              local.set 6
              i32.const 0
              local.set 2
              i32.const 0
              i32.const 16
              i32.const 8
              call $_ZN8dlmalloc8dlmalloc8align_up17hf58412c808f1bdfcE
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
              call $_ZN8dlmalloc8dlmalloc8align_up17hf58412c808f1bdfcE
              i32.const -5
              i32.add
              local.get 3
              i32.gt_u
              select
              i32.const 8
              call $_ZN8dlmalloc8dlmalloc8align_up17hf58412c808f1bdfcE
              local.set 4
              local.get 0
              call $_ZN8dlmalloc8dlmalloc5Chunk8from_mem17h979df28b2facc7dcE
              local.set 1
              local.get 1
              local.get 1
              call $_ZN8dlmalloc8dlmalloc5Chunk4size17h6ea85aca232e3ec5E
              local.tee 5
              call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h10af76c6d2e34d25E
              local.set 6
              block  ;; label = @6
                block  ;; label = @7
                  block  ;; label = @8
                    block  ;; label = @9
                      block  ;; label = @10
                        block  ;; label = @11
                          block  ;; label = @12
                            local.get 1
                            call $_ZN8dlmalloc8dlmalloc5Chunk7mmapped17hc9e33fd0b0c5432fE
                            br_if 0 (;@12;)
                            local.get 5
                            local.get 4
                            i32.ge_u
                            br_if 4 (;@8;)
                            local.get 6
                            i32.const 0
                            i32.load offset=1051464
                            i32.eq
                            br_if 6 (;@6;)
                            local.get 6
                            i32.const 0
                            i32.load offset=1051460
                            i32.eq
                            br_if 3 (;@9;)
                            local.get 6
                            call $_ZN8dlmalloc8dlmalloc5Chunk6cinuse17hb4677a5fcbb82422E
                            br_if 9 (;@3;)
                            local.get 6
                            call $_ZN8dlmalloc8dlmalloc5Chunk4size17h6ea85aca232e3ec5E
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
                            call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$18unlink_large_chunk17h057503926679f426E
                            br 2 (;@10;)
                          end
                          local.get 1
                          call $_ZN8dlmalloc8dlmalloc5Chunk4size17h6ea85aca232e3ec5E
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
                          i32.const 1051488
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
                          i32.const 1051488
                          call $_ZN61_$LT$dlmalloc..sys..System$u20$as$u20$dlmalloc..Allocator$GT$9page_size17h459e98b74b287111E
                          call $_ZN8dlmalloc8dlmalloc8align_up17hf58412c808f1bdfcE
                          local.tee 5
                          i32.const 1
                          call $_ZN61_$LT$dlmalloc..sys..System$u20$as$u20$dlmalloc..Allocator$GT$5remap17hcd1e52d496e8313fE
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
                          call $_ZN8dlmalloc8dlmalloc5Chunk14fencepost_head17h9c894b28b6a333e9E
                          local.set 0
                          local.get 1
                          local.get 2
                          call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h10af76c6d2e34d25E
                          local.get 0
                          i32.store offset=4
                          local.get 1
                          local.get 3
                          i32.const -12
                          i32.add
                          call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h10af76c6d2e34d25E
                          i32.const 0
                          i32.store offset=4
                          i32.const 0
                          i32.const 0
                          i32.load offset=1051468
                          local.get 5
                          local.get 7
                          i32.sub
                          i32.add
                          local.tee 3
                          i32.store offset=1051468
                          i32.const 0
                          i32.const 0
                          i32.load offset=1051480
                          local.tee 2
                          local.get 4
                          local.get 4
                          local.get 2
                          i32.gt_u
                          select
                          i32.store offset=1051480
                          i32.const 0
                          i32.const 0
                          i32.load offset=1051472
                          local.tee 2
                          local.get 3
                          local.get 2
                          local.get 3
                          i32.gt_u
                          select
                          i32.store offset=1051472
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
                        i32.load offset=1051444
                        i32.const -2
                        local.get 7
                        i32.const 3
                        i32.shr_u
                        i32.rotl
                        i32.and
                        i32.store offset=1051444
                      end
                      block  ;; label = @10
                        local.get 8
                        i32.const 16
                        i32.const 8
                        call $_ZN8dlmalloc8dlmalloc8align_up17hf58412c808f1bdfcE
                        i32.lt_u
                        br_if 0 (;@10;)
                        local.get 1
                        local.get 4
                        call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h10af76c6d2e34d25E
                        local.set 5
                        local.get 1
                        local.get 4
                        call $_ZN8dlmalloc8dlmalloc5Chunk9set_inuse17h6303961e692a6b87E
                        local.get 5
                        local.get 8
                        call $_ZN8dlmalloc8dlmalloc5Chunk9set_inuse17h6303961e692a6b87E
                        local.get 5
                        local.get 8
                        call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$13dispose_chunk17h0b25ee30658eb07bE
                        local.get 1
                        br_if 9 (;@1;)
                        br 7 (;@3;)
                      end
                      local.get 1
                      local.get 5
                      call $_ZN8dlmalloc8dlmalloc5Chunk9set_inuse17h6303961e692a6b87E
                      local.get 1
                      br_if 8 (;@1;)
                      br 6 (;@3;)
                    end
                    i32.const 0
                    i32.load offset=1051452
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
                        call $_ZN8dlmalloc8dlmalloc8align_up17hf58412c808f1bdfcE
                        i32.ge_u
                        br_if 0 (;@10;)
                        local.get 1
                        local.get 5
                        call $_ZN8dlmalloc8dlmalloc5Chunk9set_inuse17h6303961e692a6b87E
                        i32.const 0
                        local.set 6
                        i32.const 0
                        local.set 5
                        br 1 (;@9;)
                      end
                      local.get 1
                      local.get 4
                      call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h10af76c6d2e34d25E
                      local.tee 5
                      local.get 6
                      call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h10af76c6d2e34d25E
                      local.set 7
                      local.get 1
                      local.get 4
                      call $_ZN8dlmalloc8dlmalloc5Chunk9set_inuse17h6303961e692a6b87E
                      local.get 5
                      local.get 6
                      call $_ZN8dlmalloc8dlmalloc5Chunk33set_size_and_pinuse_of_free_chunk17hb8c49fbc662a8751E
                      local.get 7
                      call $_ZN8dlmalloc8dlmalloc5Chunk12clear_pinuse17ha5f0a52b38d69e23E
                    end
                    i32.const 0
                    local.get 5
                    i32.store offset=1051460
                    i32.const 0
                    local.get 6
                    i32.store offset=1051452
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
                  call $_ZN8dlmalloc8dlmalloc8align_up17hf58412c808f1bdfcE
                  i32.lt_u
                  br_if 0 (;@7;)
                  local.get 1
                  local.get 4
                  call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h10af76c6d2e34d25E
                  local.set 6
                  local.get 1
                  local.get 4
                  call $_ZN8dlmalloc8dlmalloc5Chunk9set_inuse17h6303961e692a6b87E
                  local.get 6
                  local.get 5
                  call $_ZN8dlmalloc8dlmalloc5Chunk9set_inuse17h6303961e692a6b87E
                  local.get 6
                  local.get 5
                  call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$13dispose_chunk17h0b25ee30658eb07bE
                end
                local.get 1
                br_if 5 (;@1;)
                br 3 (;@3;)
              end
              i32.const 0
              i32.load offset=1051456
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
            call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$4free17h0a66a05f2e0e0048E
            br 2 (;@2;)
          end
          local.get 1
          local.get 4
          call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h10af76c6d2e34d25E
          local.set 6
          local.get 1
          local.get 4
          call $_ZN8dlmalloc8dlmalloc5Chunk9set_inuse17h6303961e692a6b87E
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
          i32.store offset=1051456
          i32.const 0
          local.get 6
          i32.store offset=1051464
          local.get 1
          br_if 2 (;@1;)
        end
        local.get 3
        call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$6malloc17h464a2d96faf011fdE
        local.tee 4
        i32.eqz
        br_if 0 (;@2;)
        local.get 4
        local.get 0
        local.get 1
        call $_ZN8dlmalloc8dlmalloc5Chunk4size17h6ea85aca232e3ec5E
        i32.const -8
        i32.const -4
        local.get 1
        call $_ZN8dlmalloc8dlmalloc5Chunk7mmapped17hc9e33fd0b0c5432fE
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
        call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$4free17h0a66a05f2e0e0048E
        local.get 3
        return
      end
      local.get 2
      return
    end
    local.get 1
    call $_ZN8dlmalloc8dlmalloc5Chunk7mmapped17hc9e33fd0b0c5432fE
    drop
    local.get 1
    call $_ZN8dlmalloc8dlmalloc5Chunk6to_mem17h50c7b3bad37923f8E)
  (func $__rdl_alloc_zeroed (type 2) (param i32 i32) (result i32)
    block  ;; label = @1
      block  ;; label = @2
        local.get 1
        i32.const 9
        i32.lt_u
        br_if 0 (;@2;)
        local.get 1
        local.get 0
        call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$8memalign17h95037d0abac42865E
        local.set 1
        br 1 (;@1;)
      end
      local.get 0
      call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$6malloc17h464a2d96faf011fdE
      local.set 1
    end
    block  ;; label = @1
      local.get 1
      i32.eqz
      br_if 0 (;@1;)
      block  ;; label = @2
        i32.const 1051488
        call $_ZN61_$LT$dlmalloc..sys..System$u20$as$u20$dlmalloc..Allocator$GT$15allocates_zeros17h7dd58abcff7a9dfdE
        i32.eqz
        br_if 0 (;@2;)
        local.get 1
        call $_ZN8dlmalloc8dlmalloc5Chunk8from_mem17h979df28b2facc7dcE
        call $_ZN8dlmalloc8dlmalloc5Chunk7mmapped17hc9e33fd0b0c5432fE
        br_if 1 (;@1;)
      end
      local.get 1
      i32.const 0
      local.get 0
      call $memset
      drop
    end
    local.get 1)
  (func $rust_begin_unwind (type 7) (param i32)
    (local i32 i32 i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 1
    global.set $__stack_pointer
    block  ;; label = @1
      block  ;; label = @2
        local.get 0
        call $_ZN4core5panic10panic_info9PanicInfo8location17hd4d0a91e5314f4e9E
        local.tee 2
        i32.eqz
        br_if 0 (;@2;)
        local.get 0
        call $_ZN4core5panic10panic_info9PanicInfo7message17hd4c13a2e438e62f2E
        local.tee 3
        i32.eqz
        br_if 1 (;@1;)
        local.get 1
        local.get 2
        i32.store offset=12
        local.get 1
        local.get 0
        i32.store offset=8
        local.get 1
        local.get 3
        i32.store offset=4
        local.get 1
        i32.const 4
        i32.add
        call $_ZN3std10sys_common9backtrace26__rust_end_short_backtrace17hf9e2f055fb5ef672E
        unreachable
      end
      i32.const 1050116
      i32.const 43
      i32.const 1050304
      call $_ZN4core9panicking5panic17hb41dbc4083d9884eE
      unreachable
    end
    i32.const 1050116
    i32.const 43
    i32.const 1050320
    call $_ZN4core9panicking5panic17hb41dbc4083d9884eE
    unreachable)
  (func $_ZN102_$LT$std..panicking..begin_panic_handler..FormatStringPayload$u20$as$u20$core..panic..PanicPayload$GT$8take_box17h5929bfcf172a673bE (type 0) (param i32 i32)
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
      i32.const 36
      i32.add
      i32.const 8
      i32.add
      local.tee 5
      i32.const 0
      i32.store
      local.get 2
      i64.const 1
      i64.store offset=36 align=4
      local.get 2
      i32.const 36
      i32.add
      i32.const 1050160
      local.get 4
      call $_ZN4core3fmt5write17h362bec5724a70484E
      drop
      local.get 2
      i32.const 24
      i32.add
      i32.const 8
      i32.add
      local.get 5
      i32.load
      local.tee 4
      i32.store
      local.get 2
      local.get 2
      i64.load offset=36 align=4
      local.tee 6
      i64.store offset=24
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
    i32.load8_u offset=1051009
    drop
    local.get 2
    local.get 6
    i64.store offset=8
    block  ;; label = @1
      i32.const 12
      i32.const 4
      call $__rust_alloc
      local.tee 1
      br_if 0 (;@1;)
      i32.const 4
      i32.const 12
      call $_ZN5alloc5alloc18handle_alloc_error17h0853c609cdf121f4E
      unreachable
    end
    local.get 1
    local.get 2
    i64.load offset=8
    i64.store align=4
    local.get 1
    i32.const 8
    i32.add
    local.get 4
    i32.load
    i32.store
    local.get 0
    i32.const 1050336
    i32.store offset=4
    local.get 0
    local.get 1
    i32.store
    local.get 2
    i32.const 48
    i32.add
    global.set $__stack_pointer)
  (func $_ZN102_$LT$std..panicking..begin_panic_handler..FormatStringPayload$u20$as$u20$core..panic..PanicPayload$GT$3get17ha6f02a3978ce3c39E (type 0) (param i32 i32)
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
      i32.const 20
      i32.add
      i32.const 8
      i32.add
      local.tee 4
      i32.const 0
      i32.store
      local.get 2
      i64.const 1
      i64.store offset=20 align=4
      local.get 2
      i32.const 20
      i32.add
      i32.const 1050160
      local.get 1
      call $_ZN4core3fmt5write17h362bec5724a70484E
      drop
      local.get 2
      i32.const 8
      i32.add
      i32.const 8
      i32.add
      local.get 4
      i32.load
      local.tee 1
      i32.store
      local.get 2
      local.get 2
      i64.load offset=20 align=4
      local.tee 5
      i64.store offset=8
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
    i32.const 1050336
    i32.store offset=4
    local.get 0
    local.get 3
    i32.store
    local.get 2
    i32.const 32
    i32.add
    global.set $__stack_pointer)
  (func $_ZN99_$LT$std..panicking..begin_panic_handler..StaticStrPayload$u20$as$u20$core..panic..PanicPayload$GT$8take_box17he8029361236923d4E (type 0) (param i32 i32)
    (local i32 i32)
    i32.const 0
    i32.load8_u offset=1051009
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
      call $_ZN5alloc5alloc18handle_alloc_error17h0853c609cdf121f4E
      unreachable
    end
    local.get 1
    local.get 2
    i32.store offset=4
    local.get 1
    local.get 3
    i32.store
    local.get 0
    i32.const 1050352
    i32.store offset=4
    local.get 0
    local.get 1
    i32.store)
  (func $_ZN99_$LT$std..panicking..begin_panic_handler..StaticStrPayload$u20$as$u20$core..panic..PanicPayload$GT$3get17hc439086ced5b4208E (type 0) (param i32 i32)
    local.get 0
    i32.const 1050352
    i32.store offset=4
    local.get 0
    local.get 1
    i32.store)
  (func $_ZN3std9panicking20rust_panic_with_hook17hbf46ef0245cc9589E (type 5) (param i32 i32 i32 i32 i32 i32)
    (local i32 i32)
    global.get $__stack_pointer
    i32.const 32
    i32.sub
    local.tee 6
    global.set $__stack_pointer
    i32.const 0
    i32.const 0
    i32.load offset=1051032
    local.tee 7
    i32.const 1
    i32.add
    i32.store offset=1051032
    block  ;; label = @1
      block  ;; label = @2
        local.get 7
        i32.const 0
        i32.lt_s
        br_if 0 (;@2;)
        i32.const 0
        i32.load8_u offset=1051492
        i32.const 255
        i32.and
        br_if 0 (;@2;)
        i32.const 0
        i32.const 1
        i32.store8 offset=1051492
        i32.const 0
        i32.const 0
        i32.load offset=1051488
        i32.const 1
        i32.add
        i32.store offset=1051488
        local.get 6
        local.get 5
        i32.store8 offset=29
        local.get 6
        local.get 4
        i32.store8 offset=28
        local.get 6
        local.get 3
        i32.store offset=24
        local.get 6
        local.get 2
        i32.store offset=20
        local.get 6
        i32.const 1050408
        i32.store offset=16
        local.get 6
        i32.const 1050116
        i32.store offset=12
        i32.const 0
        i32.load offset=1051016
        local.tee 7
        i32.const -1
        i32.le_s
        br_if 0 (;@2;)
        i32.const 0
        local.get 7
        i32.const 1
        i32.add
        i32.store offset=1051016
        block  ;; label = @3
          i32.const 0
          i32.load offset=1051024
          i32.eqz
          br_if 0 (;@3;)
          local.get 6
          local.get 0
          local.get 1
          i32.load offset=16
          call_indirect (type 0)
          local.get 6
          local.get 6
          i64.load
          i64.store offset=12 align=4
          i32.const 0
          i32.load offset=1051024
          local.get 6
          i32.const 12
          i32.add
          i32.const 0
          i32.load offset=1051028
          i32.load offset=20
          call_indirect (type 0)
          i32.const 0
          i32.load offset=1051016
          i32.const -1
          i32.add
          local.set 7
        end
        i32.const 0
        local.get 7
        i32.store offset=1051016
        i32.const 0
        i32.const 0
        i32.store8 offset=1051492
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
    i32.load offset=1051012
    local.tee 2
    i32.const 10
    local.get 2
    select
    call_indirect (type 0)
    unreachable
    unreachable)
  (func $__rust_start_panic (type 2) (param i32 i32) (result i32)
    unreachable
    unreachable)
  (func $_ZN8dlmalloc8dlmalloc8align_up17hf58412c808f1bdfcE (type 2) (param i32 i32) (result i32)
    local.get 0
    local.get 1
    i32.add
    i32.const -1
    i32.add
    i32.const 0
    local.get 1
    i32.sub
    i32.and)
  (func $_ZN8dlmalloc8dlmalloc9left_bits17hfd760f4678f8d918E (type 4) (param i32) (result i32)
    local.get 0
    i32.const 1
    i32.shl
    local.tee 0
    i32.const 0
    local.get 0
    i32.sub
    i32.or)
  (func $_ZN8dlmalloc8dlmalloc9least_bit17h6d1d38bf68f60a15E (type 4) (param i32) (result i32)
    i32.const 0
    local.get 0
    i32.sub
    local.get 0
    i32.and)
  (func $_ZN8dlmalloc8dlmalloc24leftshift_for_tree_index17he8264d4c8bb74329E (type 4) (param i32) (result i32)
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
  (func $_ZN8dlmalloc8dlmalloc5Chunk14fencepost_head17h9c894b28b6a333e9E (type 12) (result i32)
    i32.const 7)
  (func $_ZN8dlmalloc8dlmalloc5Chunk4size17h6ea85aca232e3ec5E (type 4) (param i32) (result i32)
    local.get 0
    i32.load offset=4
    i32.const -8
    i32.and)
  (func $_ZN8dlmalloc8dlmalloc5Chunk6cinuse17hb4677a5fcbb82422E (type 4) (param i32) (result i32)
    local.get 0
    i32.load8_u offset=4
    i32.const 2
    i32.and
    i32.const 1
    i32.shr_u)
  (func $_ZN8dlmalloc8dlmalloc5Chunk6pinuse17hb674a446c3254c29E (type 4) (param i32) (result i32)
    local.get 0
    i32.load offset=4
    i32.const 1
    i32.and)
  (func $_ZN8dlmalloc8dlmalloc5Chunk12clear_pinuse17ha5f0a52b38d69e23E (type 7) (param i32)
    local.get 0
    local.get 0
    i32.load offset=4
    i32.const -2
    i32.and
    i32.store offset=4)
  (func $_ZN8dlmalloc8dlmalloc5Chunk5inuse17h18988138fdbf78b6E (type 4) (param i32) (result i32)
    local.get 0
    i32.load offset=4
    i32.const 3
    i32.and
    i32.const 1
    i32.ne)
  (func $_ZN8dlmalloc8dlmalloc5Chunk7mmapped17hc9e33fd0b0c5432fE (type 4) (param i32) (result i32)
    local.get 0
    i32.load8_u offset=4
    i32.const 3
    i32.and
    i32.eqz)
  (func $_ZN8dlmalloc8dlmalloc5Chunk9set_inuse17h6303961e692a6b87E (type 0) (param i32 i32)
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
  (func $_ZN8dlmalloc8dlmalloc5Chunk20set_inuse_and_pinuse17hb5017cd9994d56b7E (type 0) (param i32 i32)
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
  (func $_ZN8dlmalloc8dlmalloc5Chunk34set_size_and_pinuse_of_inuse_chunk17hc6d12ed1fddec215E (type 0) (param i32 i32)
    local.get 0
    local.get 1
    i32.const 3
    i32.or
    i32.store offset=4)
  (func $_ZN8dlmalloc8dlmalloc5Chunk33set_size_and_pinuse_of_free_chunk17hb8c49fbc662a8751E (type 0) (param i32 i32)
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
  (func $_ZN8dlmalloc8dlmalloc5Chunk20set_free_with_pinuse17h1e6a59985180e994E (type 3) (param i32 i32 i32)
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
  (func $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h10af76c6d2e34d25E (type 2) (param i32 i32) (result i32)
    local.get 0
    local.get 1
    i32.add)
  (func $_ZN8dlmalloc8dlmalloc5Chunk12minus_offset17hc4a0fdc2ff1abc38E (type 2) (param i32 i32) (result i32)
    local.get 0
    local.get 1
    i32.sub)
  (func $_ZN8dlmalloc8dlmalloc5Chunk6to_mem17h50c7b3bad37923f8E (type 4) (param i32) (result i32)
    local.get 0
    i32.const 8
    i32.add)
  (func $_ZN8dlmalloc8dlmalloc5Chunk10mem_offset17hb4f8ba9389e35f03E (type 12) (result i32)
    i32.const 8)
  (func $_ZN8dlmalloc8dlmalloc5Chunk8from_mem17h979df28b2facc7dcE (type 4) (param i32) (result i32)
    local.get 0
    i32.const -8
    i32.add)
  (func $_ZN8dlmalloc8dlmalloc9TreeChunk14leftmost_child17h6480385e5d33dc8cE (type 4) (param i32) (result i32)
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
  (func $_ZN8dlmalloc8dlmalloc9TreeChunk5chunk17hdd6a267a52100ff9E (type 4) (param i32) (result i32)
    local.get 0)
  (func $_ZN8dlmalloc8dlmalloc9TreeChunk4next17h0948dbff5b1fa27aE (type 4) (param i32) (result i32)
    local.get 0
    i32.load offset=12)
  (func $_ZN8dlmalloc8dlmalloc9TreeChunk4prev17hb7068ddb0a3bc75dE (type 4) (param i32) (result i32)
    local.get 0
    i32.load offset=8)
  (func $_ZN8dlmalloc8dlmalloc7Segment9is_extern17hce2b6c60378fecbaE (type 4) (param i32) (result i32)
    local.get 0
    i32.load offset=12
    i32.const 1
    i32.and)
  (func $_ZN8dlmalloc8dlmalloc7Segment9sys_flags17ha34d71c2c0a2f4f8E (type 4) (param i32) (result i32)
    local.get 0
    i32.load offset=12
    i32.const 1
    i32.shr_u)
  (func $_ZN8dlmalloc8dlmalloc7Segment5holds17hd979b70163a9ea52E (type 2) (param i32 i32) (result i32)
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
  (func $_ZN8dlmalloc8dlmalloc7Segment3top17hdd4d160761d7a4c1E (type 4) (param i32) (result i32)
    local.get 0
    i32.load
    local.get 0
    i32.load offset=4
    i32.add)
  (func $_ZN61_$LT$dlmalloc..sys..System$u20$as$u20$dlmalloc..Allocator$GT$5alloc17hed1977c094ba06f0E (type 3) (param i32 i32 i32)
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
  (func $_ZN61_$LT$dlmalloc..sys..System$u20$as$u20$dlmalloc..Allocator$GT$5remap17hcd1e52d496e8313fE (type 13) (param i32 i32 i32 i32 i32) (result i32)
    i32.const 0)
  (func $_ZN61_$LT$dlmalloc..sys..System$u20$as$u20$dlmalloc..Allocator$GT$9free_part17h6e5bac3b0cfb8f54E (type 11) (param i32 i32 i32 i32) (result i32)
    i32.const 0)
  (func $_ZN61_$LT$dlmalloc..sys..System$u20$as$u20$dlmalloc..Allocator$GT$4free17h17c630ddfc3296e0E (type 1) (param i32 i32 i32) (result i32)
    i32.const 0)
  (func $_ZN61_$LT$dlmalloc..sys..System$u20$as$u20$dlmalloc..Allocator$GT$16can_release_part17he396a577db875ec0E (type 2) (param i32 i32) (result i32)
    i32.const 0)
  (func $_ZN61_$LT$dlmalloc..sys..System$u20$as$u20$dlmalloc..Allocator$GT$15allocates_zeros17h7dd58abcff7a9dfdE (type 4) (param i32) (result i32)
    i32.const 1)
  (func $_ZN61_$LT$dlmalloc..sys..System$u20$as$u20$dlmalloc..Allocator$GT$9page_size17h459e98b74b287111E (type 4) (param i32) (result i32)
    i32.const 65536)
  (func $_ZN5alloc5alloc18handle_alloc_error17h0853c609cdf121f4E (type 0) (param i32 i32)
    local.get 0
    local.get 1
    call $_ZN5alloc5alloc18handle_alloc_error8rt_error17he3b3ec192280323dE
    unreachable)
  (func $_ZN5alloc7raw_vec17capacity_overflow17h6742d6b707f6ebe7E (type 14)
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
    i32.const 1050472
    i32.store offset=8
    local.get 0
    i32.const 1050424
    i32.store offset=16
    local.get 0
    i32.const 8
    i32.add
    i32.const 1050480
    call $_ZN4core9panicking9panic_fmt17h14c85a61aa3d538eE
    unreachable)
  (func $_ZN5alloc5alloc18handle_alloc_error8rt_error17he3b3ec192280323dE (type 0) (param i32 i32)
    local.get 1
    local.get 0
    call $__rust_alloc_error_handler
    unreachable)
  (func $_ZN4core3ops8function6FnOnce9call_once17h76fe3987e9baa657E (type 2) (param i32 i32) (result i32)
    local.get 0
    i32.load
    drop
    loop (result i32)  ;; label = @1
      br 0 (;@1;)
    end)
  (func $_ZN4core3ptr37drop_in_place$LT$core..fmt..Error$GT$17h758e210251b6ee64E (type 7) (param i32))
  (func $_ZN4core9panicking9panic_fmt17h14c85a61aa3d538eE (type 0) (param i32 i32)
    (local i32)
    global.get $__stack_pointer
    i32.const 32
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    local.get 2
    i32.const 1
    i32.store16 offset=28
    local.get 2
    local.get 1
    i32.store offset=24
    local.get 2
    local.get 0
    i32.store offset=20
    local.get 2
    i32.const 1050496
    i32.store offset=16
    local.get 2
    i32.const 1050496
    i32.store offset=12
    local.get 2
    i32.const 12
    i32.add
    call $rust_begin_unwind
    unreachable)
  (func $_ZN4core5slice5index26slice_start_index_len_fail17hb6eb0f03f001b495E (type 3) (param i32 i32 i32)
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
    i32.const 2
    i32.store
    local.get 3
    i32.const 2
    i32.store offset=12
    local.get 3
    i32.const 1050900
    i32.store offset=8
    local.get 3
    i32.const 2
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
    call $_ZN4core9panicking9panic_fmt17h14c85a61aa3d538eE
    unreachable)
  (func $_ZN4core9panicking18panic_bounds_check17h66aea8b9574ca63eE (type 3) (param i32 i32 i32)
    (local i32)
    global.get $__stack_pointer
    i32.const 48
    i32.sub
    local.tee 3
    global.set $__stack_pointer
    local.get 3
    local.get 1
    i32.store offset=4
    local.get 3
    local.get 0
    i32.store
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
    i32.const 2
    i32.store
    local.get 3
    i32.const 2
    i32.store offset=12
    local.get 3
    i32.const 1050564
    i32.store offset=8
    local.get 3
    i32.const 2
    i32.store offset=36
    local.get 3
    local.get 3
    i32.const 32
    i32.add
    i32.store offset=16
    local.get 3
    local.get 3
    i32.store offset=40
    local.get 3
    local.get 3
    i32.const 4
    i32.add
    i32.store offset=32
    local.get 3
    i32.const 8
    i32.add
    local.get 2
    call $_ZN4core9panicking9panic_fmt17h14c85a61aa3d538eE
    unreachable)
  (func $_ZN4core5slice5index24slice_end_index_len_fail17h6448231a3cf176e8E (type 3) (param i32 i32 i32)
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
    i32.const 2
    i32.store
    local.get 3
    i32.const 2
    i32.store offset=12
    local.get 3
    i32.const 1050932
    i32.store offset=8
    local.get 3
    i32.const 2
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
    call $_ZN4core9panicking9panic_fmt17h14c85a61aa3d538eE
    unreachable)
  (func $_ZN4core3fmt9Formatter3pad17hdfdd925968056d8dE (type 1) (param i32 i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32)
    block  ;; label = @1
      local.get 0
      i32.load
      local.tee 3
      local.get 0
      i32.load offset=8
      local.tee 4
      i32.or
      i32.eqz
      br_if 0 (;@1;)
      block  ;; label = @2
        local.get 4
        i32.eqz
        br_if 0 (;@2;)
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
        block  ;; label = @3
          loop  ;; label = @4
            local.get 8
            local.set 4
            local.get 6
            i32.const -1
            i32.add
            local.tee 6
            i32.eqz
            br_if 1 (;@3;)
            local.get 4
            local.get 5
            i32.eq
            br_if 2 (;@2;)
            block  ;; label = @5
              block  ;; label = @6
                local.get 4
                i32.load8_s
                local.tee 9
                i32.const -1
                i32.le_s
                br_if 0 (;@6;)
                local.get 4
                i32.const 1
                i32.add
                local.set 8
                local.get 9
                i32.const 255
                i32.and
                local.set 9
                br 1 (;@5;)
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
              block  ;; label = @6
                local.get 9
                i32.const -33
                i32.gt_u
                br_if 0 (;@6;)
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
                br 1 (;@5;)
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
              block  ;; label = @6
                local.get 9
                i32.const -16
                i32.ge_u
                br_if 0 (;@6;)
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
                br 1 (;@5;)
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
              br_if 3 (;@2;)
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
            br_if 0 (;@4;)
            br 2 (;@2;)
          end
        end
        local.get 4
        local.get 5
        i32.eq
        br_if 0 (;@2;)
        block  ;; label = @3
          local.get 4
          i32.load8_s
          local.tee 8
          i32.const -1
          i32.gt_s
          br_if 0 (;@3;)
          local.get 8
          i32.const -32
          i32.lt_u
          br_if 0 (;@3;)
          local.get 8
          i32.const -16
          i32.lt_u
          br_if 0 (;@3;)
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
          br_if 1 (;@2;)
        end
        block  ;; label = @3
          block  ;; label = @4
            local.get 7
            i32.eqz
            br_if 0 (;@4;)
            block  ;; label = @5
              local.get 7
              local.get 2
              i32.lt_u
              br_if 0 (;@5;)
              i32.const 0
              local.set 4
              local.get 7
              local.get 2
              i32.eq
              br_if 1 (;@4;)
              br 2 (;@3;)
            end
            i32.const 0
            local.set 4
            local.get 1
            local.get 7
            i32.add
            i32.load8_s
            i32.const -64
            i32.lt_s
            br_if 1 (;@3;)
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
      block  ;; label = @2
        local.get 3
        br_if 0 (;@2;)
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
      block  ;; label = @2
        block  ;; label = @3
          local.get 2
          i32.const 16
          i32.lt_u
          br_if 0 (;@3;)
          local.get 1
          local.get 2
          call $_ZN4core3str5count14do_count_chars17h96cd483782209bbbE
          local.set 4
          br 1 (;@2;)
        end
        block  ;; label = @3
          local.get 2
          br_if 0 (;@3;)
          i32.const 0
          local.set 4
          br 1 (;@2;)
        end
        local.get 2
        i32.const 3
        i32.and
        local.set 6
        block  ;; label = @3
          block  ;; label = @4
            local.get 2
            i32.const 4
            i32.ge_u
            br_if 0 (;@4;)
            i32.const 0
            local.set 4
            i32.const 0
            local.set 9
            br 1 (;@3;)
          end
          local.get 2
          i32.const -4
          i32.and
          local.set 7
          i32.const 0
          local.set 4
          i32.const 0
          local.set 9
          loop  ;; label = @4
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
            br_if 0 (;@4;)
          end
        end
        local.get 6
        i32.eqz
        br_if 0 (;@2;)
        local.get 1
        local.get 9
        i32.add
        local.set 8
        loop  ;; label = @3
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
          br_if 0 (;@3;)
        end
      end
      block  ;; label = @2
        block  ;; label = @3
          local.get 5
          local.get 4
          i32.le_u
          br_if 0 (;@3;)
          local.get 5
          local.get 4
          i32.sub
          local.set 7
          i32.const 0
          local.set 4
          block  ;; label = @4
            block  ;; label = @5
              block  ;; label = @6
                local.get 0
                i32.load8_u offset=32
                br_table 2 (;@4;) 0 (;@6;) 1 (;@5;) 2 (;@4;) 2 (;@4;)
              end
              local.get 7
              local.set 4
              i32.const 0
              local.set 7
              br 1 (;@4;)
            end
            local.get 7
            i32.const 1
            i32.shr_u
            local.set 4
            local.get 7
            i32.const 1
            i32.add
            i32.const 1
            i32.shr_u
            local.set 7
          end
          local.get 4
          i32.const 1
          i32.add
          local.set 4
          local.get 0
          i32.const 24
          i32.add
          i32.load
          local.set 8
          local.get 0
          i32.load offset=16
          local.set 6
          local.get 0
          i32.load offset=20
          local.set 9
          loop  ;; label = @4
            local.get 4
            i32.const -1
            i32.add
            local.tee 4
            i32.eqz
            br_if 2 (;@2;)
            local.get 9
            local.get 6
            local.get 8
            i32.load offset=16
            call_indirect (type 2)
            i32.eqz
            br_if 0 (;@4;)
          end
          i32.const 1
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
      i32.const 1
      local.set 4
      block  ;; label = @2
        local.get 9
        local.get 1
        local.get 2
        local.get 8
        i32.load offset=12
        call_indirect (type 1)
        br_if 0 (;@2;)
        i32.const 0
        local.set 4
        block  ;; label = @3
          loop  ;; label = @4
            block  ;; label = @5
              local.get 7
              local.get 4
              i32.ne
              br_if 0 (;@5;)
              local.get 7
              local.set 4
              br 2 (;@3;)
            end
            local.get 4
            i32.const 1
            i32.add
            local.set 4
            local.get 9
            local.get 6
            local.get 8
            i32.load offset=16
            call_indirect (type 2)
            i32.eqz
            br_if 0 (;@4;)
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
    call_indirect (type 1))
  (func $_ZN4core9panicking5panic17hb41dbc4083d9884eE (type 3) (param i32 i32 i32)
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
    i32.const 1050496
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
    call $_ZN4core9panicking9panic_fmt17h14c85a61aa3d538eE
    unreachable)
  (func $_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$u32$GT$3fmt17h4e0e32fdcb1fd671E (type 2) (param i32 i32) (result i32)
    local.get 0
    i64.load32_u
    i32.const 1
    local.get 1
    call $_ZN4core3fmt3num3imp7fmt_u6417hfad12596563b72deE)
  (func $_ZN4core3fmt5write17h362bec5724a70484E (type 1) (param i32 i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    i32.const 48
    i32.sub
    local.tee 3
    global.set $__stack_pointer
    local.get 3
    i32.const 36
    i32.add
    local.get 1
    i32.store
    local.get 3
    i32.const 3
    i32.store8 offset=44
    local.get 3
    i32.const 32
    i32.store offset=28
    i32.const 0
    local.set 4
    local.get 3
    i32.const 0
    i32.store offset=40
    local.get 3
    local.get 0
    i32.store offset=32
    local.get 3
    i32.const 0
    i32.store offset=20
    local.get 3
    i32.const 0
    i32.store offset=12
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              local.get 2
              i32.load offset=16
              local.tee 5
              br_if 0 (;@5;)
              local.get 2
              i32.const 12
              i32.add
              i32.load
              local.tee 0
              i32.eqz
              br_if 1 (;@4;)
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
              loop  ;; label = @6
                block  ;; label = @7
                  local.get 0
                  i32.const 4
                  i32.add
                  i32.load
                  local.tee 7
                  i32.eqz
                  br_if 0 (;@7;)
                  local.get 3
                  i32.load offset=32
                  local.get 0
                  i32.load
                  local.get 7
                  local.get 3
                  i32.load offset=36
                  i32.load offset=12
                  call_indirect (type 1)
                  br_if 4 (;@3;)
                end
                local.get 1
                i32.load
                local.get 3
                i32.const 12
                i32.add
                local.get 1
                i32.const 4
                i32.add
                i32.load
                call_indirect (type 2)
                br_if 3 (;@3;)
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
                br_if 0 (;@6;)
                br 2 (;@4;)
              end
            end
            local.get 2
            i32.const 20
            i32.add
            i32.load
            local.tee 1
            i32.eqz
            br_if 0 (;@4;)
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
            i32.load offset=8
            local.set 9
            local.get 2
            i32.load
            local.set 0
            i32.const 0
            local.set 6
            loop  ;; label = @5
              block  ;; label = @6
                local.get 0
                i32.const 4
                i32.add
                i32.load
                local.tee 1
                i32.eqz
                br_if 0 (;@6;)
                local.get 3
                i32.load offset=32
                local.get 0
                i32.load
                local.get 1
                local.get 3
                i32.load offset=36
                i32.load offset=12
                call_indirect (type 1)
                br_if 3 (;@3;)
              end
              local.get 3
              local.get 5
              local.get 6
              i32.add
              local.tee 1
              i32.const 16
              i32.add
              i32.load
              i32.store offset=28
              local.get 3
              local.get 1
              i32.const 28
              i32.add
              i32.load8_u
              i32.store8 offset=44
              local.get 3
              local.get 1
              i32.const 24
              i32.add
              i32.load
              i32.store offset=40
              local.get 1
              i32.const 12
              i32.add
              i32.load
              local.set 10
              i32.const 0
              local.set 11
              i32.const 0
              local.set 7
              block  ;; label = @6
                block  ;; label = @7
                  block  ;; label = @8
                    local.get 1
                    i32.const 8
                    i32.add
                    i32.load
                    br_table 1 (;@7;) 0 (;@8;) 2 (;@6;) 1 (;@7;)
                  end
                  local.get 10
                  i32.const 3
                  i32.shl
                  local.set 12
                  i32.const 0
                  local.set 7
                  local.get 9
                  local.get 12
                  i32.add
                  local.tee 12
                  i32.load offset=4
                  i32.const 25
                  i32.ne
                  br_if 1 (;@6;)
                  local.get 12
                  i32.load
                  i32.load
                  local.set 10
                end
                i32.const 1
                local.set 7
              end
              local.get 3
              local.get 10
              i32.store offset=16
              local.get 3
              local.get 7
              i32.store offset=12
              local.get 1
              i32.const 4
              i32.add
              i32.load
              local.set 7
              block  ;; label = @6
                block  ;; label = @7
                  block  ;; label = @8
                    local.get 1
                    i32.load
                    br_table 1 (;@7;) 0 (;@8;) 2 (;@6;) 1 (;@7;)
                  end
                  local.get 7
                  i32.const 3
                  i32.shl
                  local.set 10
                  local.get 9
                  local.get 10
                  i32.add
                  local.tee 10
                  i32.load offset=4
                  i32.const 25
                  i32.ne
                  br_if 1 (;@6;)
                  local.get 10
                  i32.load
                  i32.load
                  local.set 7
                end
                i32.const 1
                local.set 11
              end
              local.get 3
              local.get 7
              i32.store offset=24
              local.get 3
              local.get 11
              i32.store offset=20
              local.get 9
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
              i32.const 12
              i32.add
              local.get 1
              i32.load offset=4
              call_indirect (type 2)
              br_if 2 (;@3;)
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
              br_if 0 (;@5;)
            end
          end
          local.get 4
          local.get 2
          i32.load offset=4
          i32.ge_u
          br_if 1 (;@2;)
          local.get 3
          i32.load offset=32
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
          i32.load offset=36
          i32.load offset=12
          call_indirect (type 1)
          i32.eqz
          br_if 1 (;@2;)
        end
        i32.const 1
        local.set 1
        br 1 (;@1;)
      end
      i32.const 0
      local.set 1
    end
    local.get 3
    i32.const 48
    i32.add
    global.set $__stack_pointer
    local.get 1)
  (func $_ZN4core3fmt9Formatter12pad_integral17h7b816fd454935dbfE (type 15) (param i32 i32 i32 i32 i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32)
    block  ;; label = @1
      block  ;; label = @2
        local.get 1
        br_if 0 (;@2;)
        local.get 5
        i32.const 1
        i32.add
        local.set 6
        local.get 0
        i32.load offset=28
        local.set 7
        i32.const 45
        local.set 8
        br 1 (;@1;)
      end
      i32.const 43
      i32.const 1114112
      local.get 0
      i32.load offset=28
      local.tee 7
      i32.const 1
      i32.and
      local.tee 1
      select
      local.set 8
      local.get 1
      local.get 5
      i32.add
      local.set 6
    end
    block  ;; label = @1
      block  ;; label = @2
        local.get 7
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
          call $_ZN4core3str5count14do_count_chars17h96cd483782209bbbE
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
      local.get 6
      i32.add
      local.set 6
    end
    block  ;; label = @1
      block  ;; label = @2
        local.get 0
        i32.load
        br_if 0 (;@2;)
        i32.const 1
        local.set 1
        local.get 0
        i32.load offset=20
        local.tee 12
        local.get 0
        i32.load offset=24
        local.tee 10
        local.get 8
        local.get 2
        local.get 3
        call $_ZN4core3fmt9Formatter12pad_integral12write_prefix17h633cee055c70f5b3E
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
        local.get 6
        i32.gt_u
        br_if 0 (;@2;)
        i32.const 1
        local.set 1
        local.get 0
        i32.load offset=20
        local.tee 12
        local.get 0
        i32.load offset=24
        local.tee 10
        local.get 8
        local.get 2
        local.get 3
        call $_ZN4core3fmt9Formatter12pad_integral12write_prefix17h633cee055c70f5b3E
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
        local.get 7
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
        local.set 7
        i32.const 1
        local.set 1
        local.get 0
        i32.const 1
        i32.store8 offset=32
        local.get 0
        i32.load offset=20
        local.tee 12
        local.get 0
        i32.load offset=24
        local.tee 10
        local.get 8
        local.get 2
        local.get 3
        call $_ZN4core3fmt9Formatter12pad_integral12write_prefix17h633cee055c70f5b3E
        br_if 1 (;@1;)
        local.get 9
        local.get 6
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
        local.get 7
        i32.store8 offset=32
        local.get 0
        local.get 11
        i32.store offset=16
        i32.const 0
        local.set 1
        br 1 (;@1;)
      end
      local.get 9
      local.get 6
      i32.sub
      local.set 6
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            local.get 0
            i32.load8_u offset=32
            local.tee 1
            br_table 2 (;@2;) 0 (;@4;) 1 (;@3;) 0 (;@4;) 2 (;@2;)
          end
          local.get 6
          local.set 1
          i32.const 0
          local.set 6
          br 1 (;@2;)
        end
        local.get 6
        i32.const 1
        i32.shr_u
        local.set 1
        local.get 6
        i32.const 1
        i32.add
        i32.const 1
        i32.shr_u
        local.set 6
      end
      local.get 1
      i32.const 1
      i32.add
      local.set 1
      local.get 0
      i32.const 24
      i32.add
      i32.load
      local.set 12
      local.get 0
      i32.load offset=16
      local.set 9
      local.get 0
      i32.load offset=20
      local.set 10
      block  ;; label = @2
        loop  ;; label = @3
          local.get 1
          i32.const -1
          i32.add
          local.tee 1
          i32.eqz
          br_if 1 (;@2;)
          local.get 10
          local.get 9
          local.get 12
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
      local.get 10
      local.get 12
      local.get 8
      local.get 2
      local.get 3
      call $_ZN4core3fmt9Formatter12pad_integral12write_prefix17h633cee055c70f5b3E
      br_if 0 (;@1;)
      local.get 10
      local.get 4
      local.get 5
      local.get 12
      i32.load offset=12
      call_indirect (type 1)
      br_if 0 (;@1;)
      i32.const 0
      local.set 1
      loop  ;; label = @2
        block  ;; label = @3
          local.get 6
          local.get 1
          i32.ne
          br_if 0 (;@3;)
          local.get 6
          local.get 6
          i32.lt_u
          return
        end
        local.get 1
        i32.const 1
        i32.add
        local.set 1
        local.get 10
        local.get 9
        local.get 12
        i32.load offset=16
        call_indirect (type 2)
        i32.eqz
        br_if 0 (;@2;)
      end
      local.get 1
      i32.const -1
      i32.add
      local.get 6
      i32.lt_u
      return
    end
    local.get 1)
  (func $_ZN36_$LT$T$u20$as$u20$core..any..Any$GT$7type_id17h657a530d99624e05E (type 0) (param i32 i32)
    local.get 0
    i64.const 3621418216119541392
    i64.store offset=8
    local.get 0
    i64.const -6096952686898433405
    i64.store)
  (func $_ZN4core5slice5index22slice_index_order_fail17h511e34aef03a49cbE (type 3) (param i32 i32 i32)
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
    i32.const 2
    i32.store
    local.get 3
    i32.const 2
    i32.store offset=12
    local.get 3
    i32.const 1050984
    i32.store offset=8
    local.get 3
    i32.const 2
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
    call $_ZN4core9panicking9panic_fmt17h14c85a61aa3d538eE
    unreachable)
  (func $_ZN4core6result13unwrap_failed17hc368cb5845aa399dE (type 6) (param i32 i32 i32 i32 i32)
    (local i32)
    global.get $__stack_pointer
    i32.const 64
    i32.sub
    local.tee 5
    global.set $__stack_pointer
    local.get 5
    local.get 1
    i32.store offset=12
    local.get 5
    local.get 0
    i32.store offset=8
    local.get 5
    local.get 3
    i32.store offset=20
    local.get 5
    local.get 2
    i32.store offset=16
    local.get 5
    i32.const 24
    i32.add
    i32.const 12
    i32.add
    i64.const 2
    i64.store align=4
    local.get 5
    i32.const 48
    i32.add
    i32.const 12
    i32.add
    i32.const 26
    i32.store
    local.get 5
    i32.const 2
    i32.store offset=28
    local.get 5
    i32.const 1050584
    i32.store offset=24
    local.get 5
    i32.const 27
    i32.store offset=52
    local.get 5
    local.get 5
    i32.const 48
    i32.add
    i32.store offset=32
    local.get 5
    local.get 5
    i32.const 16
    i32.add
    i32.store offset=56
    local.get 5
    local.get 5
    i32.const 8
    i32.add
    i32.store offset=48
    local.get 5
    i32.const 24
    i32.add
    local.get 4
    call $_ZN4core9panicking9panic_fmt17h14c85a61aa3d538eE
    unreachable)
  (func $_ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17h39acb405d1bb9472E (type 2) (param i32 i32) (result i32)
    local.get 1
    local.get 0
    i32.load
    local.get 0
    i32.load offset=4
    call $_ZN4core3fmt9Formatter3pad17hdfdd925968056d8dE)
  (func $_ZN4core5panic10panic_info9PanicInfo7message17hd4c13a2e438e62f2E (type 4) (param i32) (result i32)
    local.get 0
    i32.load offset=8)
  (func $_ZN4core5panic10panic_info9PanicInfo8location17hd4d0a91e5314f4e9E (type 4) (param i32) (result i32)
    local.get 0
    i32.load offset=12)
  (func $_ZN4core5panic10panic_info9PanicInfo10can_unwind17h28bb5a3a95a12ae3E (type 4) (param i32) (result i32)
    local.get 0
    i32.load8_u offset=16)
  (func $_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h85162f68fed8fde8E (type 2) (param i32 i32) (result i32)
    local.get 0
    i32.load
    local.get 1
    local.get 0
    i32.load offset=4
    i32.load offset=12
    call_indirect (type 2))
  (func $_ZN4core3fmt9Formatter3new17h6af65e07b3260355E (type 3) (param i32 i32 i32)
    local.get 0
    i32.const 3
    i32.store8 offset=32
    local.get 0
    i32.const 32
    i32.store offset=16
    local.get 0
    i32.const 0
    i32.store offset=28
    local.get 0
    local.get 1
    i32.store offset=20
    local.get 0
    i32.const 0
    i32.store offset=8
    local.get 0
    i32.const 0
    i32.store
    local.get 0
    i32.const 24
    i32.add
    local.get 2
    i32.store)
  (func $_ZN4core3str5count14do_count_chars17h96cd483782209bbbE (type 2) (param i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32)
    block  ;; label = @1
      block  ;; label = @2
        local.get 1
        local.get 0
        i32.const 3
        i32.add
        i32.const -4
        i32.and
        local.tee 2
        local.get 0
        i32.sub
        local.tee 3
        i32.lt_u
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
          local.tee 7
          br_if 0 (;@3;)
          i32.const 0
          local.set 1
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
              local.set 8
              br 1 (;@4;)
            end
            i32.const 0
            local.set 8
            loop  ;; label = @5
              local.get 1
              local.get 0
              local.get 8
              i32.add
              local.tee 9
              i32.load8_s
              i32.const -65
              i32.gt_s
              i32.add
              local.get 9
              i32.const 1
              i32.add
              i32.load8_s
              i32.const -65
              i32.gt_s
              i32.add
              local.get 9
              i32.const 2
              i32.add
              i32.load8_s
              i32.const -65
              i32.gt_s
              i32.add
              local.get 9
              i32.const 3
              i32.add
              i32.load8_s
              i32.const -65
              i32.gt_s
              i32.add
              local.set 1
              local.get 8
              i32.const 4
              i32.add
              local.tee 8
              br_if 0 (;@5;)
            end
          end
          local.get 7
          br_if 0 (;@3;)
          local.get 0
          local.get 2
          i32.sub
          local.set 2
          local.get 0
          local.get 8
          i32.add
          local.set 9
          loop  ;; label = @4
            local.get 1
            local.get 9
            i32.load8_s
            i32.const -65
            i32.gt_s
            i32.add
            local.set 1
            local.get 9
            i32.const 1
            i32.add
            local.set 9
            local.get 2
            i32.const 1
            i32.add
            local.tee 2
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
          local.tee 9
          i32.load8_s
          i32.const -65
          i32.gt_s
          local.set 6
          local.get 5
          i32.const 1
          i32.eq
          br_if 0 (;@3;)
          local.get 6
          local.get 9
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
          local.get 9
          i32.load8_s offset=2
          i32.const -65
          i32.gt_s
          i32.add
          local.set 6
        end
        local.get 4
        i32.const 2
        i32.shr_u
        local.set 3
        local.get 6
        local.get 1
        i32.add
        local.set 2
        loop  ;; label = @3
          local.get 8
          local.set 6
          local.get 3
          i32.eqz
          br_if 2 (;@1;)
          local.get 3
          i32.const 192
          local.get 3
          i32.const 192
          i32.lt_u
          select
          local.tee 4
          i32.const 3
          i32.and
          local.set 7
          local.get 4
          i32.const 2
          i32.shl
          local.set 5
          i32.const 0
          local.set 9
          block  ;; label = @4
            local.get 4
            i32.const 4
            i32.lt_u
            br_if 0 (;@4;)
            local.get 6
            local.get 5
            i32.const 1008
            i32.and
            i32.add
            local.set 0
            i32.const 0
            local.set 9
            local.get 6
            local.set 1
            loop  ;; label = @5
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
              local.get 9
              i32.add
              i32.add
              i32.add
              i32.add
              local.set 9
              local.get 1
              i32.const 16
              i32.add
              local.tee 1
              local.get 0
              i32.ne
              br_if 0 (;@5;)
            end
          end
          local.get 3
          local.get 4
          i32.sub
          local.set 3
          local.get 6
          local.get 5
          i32.add
          local.set 8
          local.get 9
          i32.const 8
          i32.shr_u
          i32.const 16711935
          i32.and
          local.get 9
          i32.const 16711935
          i32.and
          i32.add
          i32.const 65537
          i32.mul
          i32.const 16
          i32.shr_u
          local.get 2
          i32.add
          local.set 2
          local.get 7
          i32.eqz
          br_if 0 (;@3;)
        end
        local.get 6
        local.get 4
        i32.const 252
        i32.and
        i32.const 2
        i32.shl
        i32.add
        local.tee 9
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
        block  ;; label = @3
          local.get 7
          i32.const 1
          i32.eq
          br_if 0 (;@3;)
          local.get 9
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
          local.get 7
          i32.const 2
          i32.eq
          br_if 0 (;@3;)
          local.get 9
          i32.load offset=8
          local.tee 9
          i32.const -1
          i32.xor
          i32.const 7
          i32.shr_u
          local.get 9
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
        local.get 2
        i32.add
        return
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
          local.set 2
          i32.const 0
          local.set 9
          br 1 (;@2;)
        end
        local.get 1
        i32.const -4
        i32.and
        local.set 3
        i32.const 0
        local.set 2
        i32.const 0
        local.set 9
        loop  ;; label = @3
          local.get 2
          local.get 0
          local.get 9
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
          local.set 2
          local.get 3
          local.get 9
          i32.const 4
          i32.add
          local.tee 9
          i32.ne
          br_if 0 (;@3;)
        end
      end
      local.get 8
      i32.eqz
      br_if 0 (;@1;)
      local.get 0
      local.get 9
      i32.add
      local.set 1
      loop  ;; label = @2
        local.get 2
        local.get 1
        i32.load8_s
        i32.const -65
        i32.gt_s
        i32.add
        local.set 2
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
    local.get 2)
  (func $_ZN4core3fmt9Formatter12pad_integral12write_prefix17h633cee055c70f5b3E (type 13) (param i32 i32 i32 i32 i32) (result i32)
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
  (func $_ZN4core3fmt9Formatter9write_fmt17h9753a560d984b64cE (type 2) (param i32 i32) (result i32)
    local.get 0
    i32.load offset=20
    local.get 0
    i32.const 24
    i32.add
    i32.load
    local.get 1
    call $_ZN4core3fmt5write17h362bec5724a70484E)
  (func $_ZN43_$LT$char$u20$as$u20$core..fmt..Display$GT$3fmt17hffed32b4ee7feec1E (type 2) (param i32 i32) (result i32)
    (local i32)
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
        local.get 1
        i32.load
        local.get 1
        i32.load offset=8
        i32.or
        i32.eqz
        br_if 0 (;@2;)
        local.get 2
        i32.const 0
        i32.store offset=12
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              block  ;; label = @6
                local.get 0
                i32.const 128
                i32.lt_u
                br_if 0 (;@6;)
                local.get 0
                i32.const 2048
                i32.lt_u
                br_if 1 (;@5;)
                local.get 0
                i32.const 65536
                i32.ge_u
                br_if 2 (;@4;)
                local.get 2
                local.get 0
                i32.const 63
                i32.and
                i32.const 128
                i32.or
                i32.store8 offset=14
                local.get 2
                local.get 0
                i32.const 12
                i32.shr_u
                i32.const 224
                i32.or
                i32.store8 offset=12
                local.get 2
                local.get 0
                i32.const 6
                i32.shr_u
                i32.const 63
                i32.and
                i32.const 128
                i32.or
                i32.store8 offset=13
                i32.const 3
                local.set 0
                br 3 (;@3;)
              end
              local.get 2
              local.get 0
              i32.store8 offset=12
              i32.const 1
              local.set 0
              br 2 (;@3;)
            end
            local.get 2
            local.get 0
            i32.const 63
            i32.and
            i32.const 128
            i32.or
            i32.store8 offset=13
            local.get 2
            local.get 0
            i32.const 6
            i32.shr_u
            i32.const 192
            i32.or
            i32.store8 offset=12
            i32.const 2
            local.set 0
            br 1 (;@3;)
          end
          local.get 2
          local.get 0
          i32.const 63
          i32.and
          i32.const 128
          i32.or
          i32.store8 offset=15
          local.get 2
          local.get 0
          i32.const 18
          i32.shr_u
          i32.const 240
          i32.or
          i32.store8 offset=12
          local.get 2
          local.get 0
          i32.const 6
          i32.shr_u
          i32.const 63
          i32.and
          i32.const 128
          i32.or
          i32.store8 offset=14
          local.get 2
          local.get 0
          i32.const 12
          i32.shr_u
          i32.const 63
          i32.and
          i32.const 128
          i32.or
          i32.store8 offset=13
          i32.const 4
          local.set 0
        end
        local.get 1
        local.get 2
        i32.const 12
        i32.add
        local.get 0
        call $_ZN4core3fmt9Formatter3pad17hdfdd925968056d8dE
        local.set 1
        br 1 (;@1;)
      end
      local.get 1
      i32.load offset=20
      local.get 0
      local.get 1
      i32.const 24
      i32.add
      i32.load
      i32.load offset=16
      call_indirect (type 2)
      local.set 1
    end
    local.get 2
    i32.const 16
    i32.add
    global.set $__stack_pointer
    local.get 1)
  (func $_ZN4core3fmt3num3imp7fmt_u6417hfad12596563b72deE (type 16) (param i64 i32 i32) (result i32)
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
        i32.const 1050648
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
        i32.const 1050648
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
      i32.const 1050648
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
        i32.const 1050648
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
    i32.const 1050496
    i32.const 0
    local.get 3
    i32.const 9
    i32.add
    local.get 4
    i32.add
    i32.const 39
    local.get 4
    i32.sub
    call $_ZN4core3fmt9Formatter12pad_integral17h7b816fd454935dbfE
    local.set 4
    local.get 3
    i32.const 48
    i32.add
    global.set $__stack_pointer
    local.get 4)
  (func $_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..UpperHex$u20$for$u20$i32$GT$3fmt17ha1f7928f6729e454E (type 2) (param i32 i32) (result i32)
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
      i32.const 128
      i32.le_u
      br_if 0 (;@1;)
      local.get 0
      i32.const 128
      i32.const 1050632
      call $_ZN4core5slice5index26slice_start_index_len_fail17hb6eb0f03f001b495E
      unreachable
    end
    local.get 1
    i32.const 1
    i32.const 1050600
    i32.const 2
    local.get 2
    local.get 3
    i32.add
    i32.const 128
    i32.add
    i32.const 0
    local.get 3
    i32.sub
    call $_ZN4core3fmt9Formatter12pad_integral17h7b816fd454935dbfE
    local.set 0
    local.get 2
    i32.const 128
    i32.add
    global.set $__stack_pointer
    local.get 0)
  (func $_ZN53_$LT$core..fmt..Error$u20$as$u20$core..fmt..Debug$GT$3fmt17h69954b3d7196f27cE (type 2) (param i32 i32) (result i32)
    local.get 1
    i32.load offset=20
    i32.const 1051000
    i32.const 5
    local.get 1
    i32.const 24
    i32.add
    i32.load
    i32.load offset=12
    call_indirect (type 1))
  (func $_ZN17compiler_builtins3mem6memcpy17hcd9ed85d913ea258E (type 1) (param i32 i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32)
    block  ;; label = @1
      block  ;; label = @2
        local.get 2
        i32.const 16
        i32.ge_u
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
  (func $_ZN17compiler_builtins3mem6memset17h20f0440529ece8f9E (type 1) (param i32 i32 i32) (result i32)
    (local i32 i32 i32)
    block  ;; label = @1
      block  ;; label = @2
        local.get 2
        i32.const 16
        i32.ge_u
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
    call $_ZN17compiler_builtins3mem6memcpy17hcd9ed85d913ea258E)
  (func $memset (type 1) (param i32 i32 i32) (result i32)
    local.get 0
    local.get 1
    local.get 2
    call $_ZN17compiler_builtins3mem6memset17h20f0440529ece8f9E)
  (table (;0;) 30 30 funcref)
  (memory (;0;) 17)
  (global $__stack_pointer (mut i32) (i32.const 1048576))
  (global (;1;) i32 (i32.const 1051493))
  (global (;2;) i32 (i32.const 1051504))
  (export "memory" (memory 0))
  (export "new" (func $new))
  (export "render" (func $render))
  (export "tick" (func $tick))
  (export "__data_end" (global 1))
  (export "__heap_base" (global 2))
  (elem (;0;) (i32.const 1) func $_ZN43_$LT$char$u20$as$u20$core..fmt..Display$GT$3fmt17hffed32b4ee7feec1E $_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$u32$GT$3fmt17h4e0e32fdcb1fd671E $_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..UpperHex$u20$for$u20$i32$GT$3fmt17ha1f7928f6729e454E $_ZN4core3ptr42drop_in_place$LT$alloc..string..String$GT$17h74d38b69f88484d8E $_ZN58_$LT$alloc..string..String$u20$as$u20$core..fmt..Write$GT$9write_str17h5739f5b458ff7fc1E $_ZN58_$LT$alloc..string..String$u20$as$u20$core..fmt..Write$GT$10write_char17ha63d6b9ea41d3f5eE $_ZN4core3fmt5Write9write_fmt17he4c4efce63cb8009E $_ZN4core3ptr37drop_in_place$LT$core..fmt..Error$GT$17h3320a8636f572fa7E $_ZN53_$LT$core..fmt..Error$u20$as$u20$core..fmt..Debug$GT$3fmt17h69954b3d7196f27cE $_ZN3std5alloc24default_alloc_error_hook17hc2a71c6bbbdfc2afE $_ZN4core3ptr42drop_in_place$LT$alloc..string..String$GT$17h43a2c67c5ee0fda2E $_ZN58_$LT$alloc..string..String$u20$as$u20$core..fmt..Write$GT$9write_str17hf2204cbc5b4f5a57E $_ZN58_$LT$alloc..string..String$u20$as$u20$core..fmt..Write$GT$10write_char17ha17b8b7c0f49fe81E $_ZN4core3fmt5Write9write_fmt17he52a8376fe10e016E $_ZN36_$LT$T$u20$as$u20$core..any..Any$GT$7type_id17hc1fa5cd7ba7b388fE $_ZN4core3ptr120drop_in_place$LT$$LP$$RF$std..ffi..os_str..OsString$C$$RF$core..option..Option$LT$std..ffi..os_str..OsString$GT$$RP$$GT$17ha27ad9ced7d25b5bE $_ZN36_$LT$T$u20$as$u20$core..any..Any$GT$7type_id17ha70a4555b5aec906E $_ZN99_$LT$std..panicking..begin_panic_handler..StaticStrPayload$u20$as$u20$core..panic..PanicPayload$GT$8take_box17he8029361236923d4E $_ZN99_$LT$std..panicking..begin_panic_handler..StaticStrPayload$u20$as$u20$core..panic..PanicPayload$GT$3get17hc439086ced5b4208E $_ZN4core3ptr77drop_in_place$LT$std..panicking..begin_panic_handler..FormatStringPayload$GT$17h48c273b6ad39dcc5E $_ZN102_$LT$std..panicking..begin_panic_handler..FormatStringPayload$u20$as$u20$core..panic..PanicPayload$GT$8take_box17h5929bfcf172a673bE $_ZN102_$LT$std..panicking..begin_panic_handler..FormatStringPayload$u20$as$u20$core..panic..PanicPayload$GT$3get17ha6f02a3978ce3c39E $_ZN4core3ptr29drop_in_place$LT$$LP$$RP$$GT$17h23e4e6157c2e3123E $_ZN36_$LT$T$u20$as$u20$core..any..Any$GT$7type_id17he9d5f3dc2d5feb11E $_ZN4core3ops8function6FnOnce9call_once17h76fe3987e9baa657E $_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h85162f68fed8fde8E $_ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17h39acb405d1bb9472E $_ZN4core3ptr37drop_in_place$LT$core..fmt..Error$GT$17h758e210251b6ee64E $_ZN36_$LT$T$u20$as$u20$core..any..Any$GT$7type_id17h657a530d99624e05E)
  (data $.rodata (i32.const 1048576) "capacity overflow\00\00\00\00\00\10\00\11\00\00\00/rustc/a28077b28a02b92985b3a3faecf92813155f1ea1/library/alloc/src/vec/spec_from_iter_nested.rs\00\00\1c\00\10\00^\00\00\00;\00\00\00\12\00\00\00invalid args\8c\00\10\00\0c\00\00\00/rustc/a28077b28a02b92985b3a3faecf92813155f1ea1/library/core/src/fmt/mod.rs\00\a0\00\10\00K\00\00\00?\01\00\00\0d\00\00\00\04\00\00\00\0c\00\00\00\04\00\00\00\05\00\00\00\06\00\00\00\07\00\00\00a Display implementation returned an error unexpectedly\00\08\00\00\00\00\00\00\00\01\00\00\00\09\00\00\00/rustc/a28077b28a02b92985b3a3faecf92813155f1ea1/library/alloc/src/string.rs\00\5c\01\10\00K\00\00\00\9c\09\00\00\0e\00\00\00\a0\00\10\00K\00\00\00I\01\00\00\0d\00\00\00/rustc/a28077b28a02b92985b3a3faecf92813155f1ea1/library/core/src/char/methods.rs\c8\01\10\00P\00\00\00\03\07\00\00\0d\00\00\00encode_utf8: need  bytes to encode U+, but the buffer has \00\00(\02\10\00\12\00\00\00:\02\10\00\13\00\00\00M\02\10\00\15\00\00\00\c8\01\10\00P\00\00\00\fc\06\00\00\0e\00\00\00/rustc/a28077b28a02b92985b3a3faecf92813155f1ea1/library/core/src/alloc/layout.rs\8c\02\10\00P\00\00\00\bf\01\00\00)\00\00\00\00\00\00\00attempt to divide by zerochunk size must be non-zero\09\03\10\00\1b\00\00\00/rustc/a28077b28a02b92985b3a3faecf92813155f1ea1/library/alloc/src/vec/mod.rs,\03\10\00L\00\00\00O\0b\00\00\0d\00\00\00assertion failed: mid <= self.len()/rustc/a28077b28a02b92985b3a3faecf92813155f1ea1/library/core/src/slice/iter.rs\00\00\00\ab\03\10\00N\00\00\00\c3\05\00\00%\00\00\00/home/don/wasm-r3/tests/node/rust-game-of-life/index.rs\00\0c\04\10\007\00\00\00\16\00\00\00\19\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00attempt to multiply with overflow\00\00\00\0c\04\10\007\00\00\003\00\00\00&\00\00\00\0c\04\10\007\00\00\00<\00\00\00\15\00\00\00\0c\04\10\007\00\00\00C\00\00\00\0a\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00attempt to add with overflow\0c\04\10\007\00\00\00C\00\00\00\09\00\00\00\0c\04\10\007\00\00\00H\00\00\00\1b\00\00\00\00\00\00\00attempt to subtract with overflow\00\00\00\0c\04\10\007\00\00\00I\00\00\00\1f\00\00\00\0c\04\10\007\00\00\00N\00\00\00$\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00attempt to calculate the remainder with a divisor of zero\00\00\00\0c\04\10\007\00\00\00O\00\00\00$\00\00\00\0c\04\10\007\00\00\00Q\00\00\00$\00\00\00\0c\04\10\007\00\00\00Q\00\00\00\11\00\00\00\0c\04\10\007\00\00\00Z\00\00\00+\00\00\00\0a\00\00\00\cc\05\10\00\01\00\00\00\0c\04\10\007\00\00\00_\00\00\00\0d\00\00\00\00\00\00\00\1c\00\10\00\00\00\00\00\0c\04\10\007\00\00\00]\00\00\00\11\00\00\00called `Option::unwrap()` on a `None` value\00\0b\00\00\00\0c\00\00\00\04\00\00\00\0c\00\00\00\0d\00\00\00\0e\00\00\00memory allocation of  bytes failed\00\00H\06\10\00\15\00\00\00]\06\10\00\0d\00\00\00library/std/src/alloc.rs|\06\10\00\18\00\00\00b\01\00\00\09\00\00\00library/std/src/panicking.rs\a4\06\10\00\1c\00\00\00S\02\00\00\1f\00\00\00\a4\06\10\00\1c\00\00\00T\02\00\00\1e\00\00\00\0b\00\00\00\0c\00\00\00\04\00\00\00\0f\00\00\00\10\00\00\00\08\00\00\00\04\00\00\00\11\00\00\00\10\00\00\00\08\00\00\00\04\00\00\00\12\00\00\00\13\00\00\00\14\00\00\00\10\00\00\00\04\00\00\00\15\00\00\00\16\00\00\00\17\00\00\00\00\00\00\00\01\00\00\00\18\00\00\00library/alloc/src/raw_vec.rscapacity overflow\00\00\00T\07\10\00\11\00\00\008\07\10\00\1c\00\00\00\16\02\00\00\05\00\00\00\1c\00\00\00\00\00\00\00\01\00\00\00\1d\00\00\00index out of bounds: the len is  but the index is \00\00\90\07\10\00 \00\00\00\b0\07\10\00\12\00\00\00: \00\00\80\07\10\00\00\00\00\00\d4\07\10\00\02\00\00\000xlibrary/core/src/fmt/num.rs\00\00\00\ea\07\10\00\1b\00\00\00i\00\00\00\17\00\00\0000010203040506070809101112131415161718192021222324252627282930313233343536373839404142434445464748495051525354555657585960616263646566676869707172737475767778798081828384858687888990919293949596979899range start index  out of range for slice of length \e0\08\10\00\12\00\00\00\f2\08\10\00\22\00\00\00range end index $\09\10\00\10\00\00\00\f2\08\10\00\22\00\00\00slice index starts at  but ends at \00D\09\10\00\16\00\00\00Z\09\10\00\0d\00\00\00Error"))

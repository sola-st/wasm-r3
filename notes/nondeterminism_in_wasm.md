# Sources of nondeterminism in WebAssembly

## 1 Call to an imported function (return value)
```wasm
(module
    (import $import "host" "js" (param i32) (result i32))
    (func
        i32.const 0
        call $import ;; returns 1
    )
)
```
===> replay
```wasm
(module
    (func $import (param i32) (result i32)
        ;; map input params to results
        i32.const 0
        local.get 0
        (if
            i32.const 1
            return
        )
        ;; ...
    )
    (func
        i32.const 0
        call $import
    )
)
```
## 2 Call of an exported function (parameters)
```wasm
(module
    (func $handler (export "handler") (param i32)
        local.get 0 ;; push 1 on the stack
    )
    ;; ...
)
```
===> replay
```wasm
(module
    (func (export "replay") ;; entry point of the replay binary
        ;; ...
        i32.const 1
        call $handler
        ;; ...
    )
    (func $handler (export "handler") (param i32)
        local.get 0 ;; push 1 on the stack
    )
    ;; ...
)
```
## 3 Import memory (memory initialization)
```wasm
(module
    (import "js" "mem" (memory 1))
)
```
===> replay
```wasm
(module
    (memory $mem 1)
    (data $mem (i32.const 0) "state of the memory at import")
)
```
## 4 Import table (table initialization)
```wasm
(module
    (import "js" "table" (table 1 funcref))
    (func
        i32.const 0
        call_indirect (param i32) (result i32)
    )
)
```
===> replay
```wasm
(module
    (func $js_func (param i32) (result i32)
        ;; this func mimics the behavior of host func
        ;; which was stored in the import table
        ;; with param to result mapping like in [1]
    )
    (table $table 1 funcref)
    (elem $table (i32.const 0) $js_func)
)
```
## 5 Exported memory present
### 5.1 Call to an imported function (memory change)
```wasm
(module
    (import $import "js" "import")
    (func
        i32.const 1234
        i32.const 42
        i32.store
        call $import
        i32.const 1234
        i32.load ;; returns 69
        call $import
        i32.const 1234
        i32.load ;; returns 420
    )
    (memory (export "mem") 1))
)
```
===> replay
```wasm
(module
    (func $import_01
        i32.const 1234
        i32.const 69
        i32.store
    )
    (func $import_02
        i32.const 1234
        i32.const 420
        i32.store
    )
    (func
        i32.const 1234
        i32.const 42
        i32.store
        call $import_01
        i32.const 1234
        i32.load
        call $import_02
        i32.const 1234
        i32.load
    )
    (memory 1)
)
```
### 5.2 Call of an exported function (memory state)
```wasm
(module
    (func $handler (export "handler")
        i32.const 1234
        i32.load ;; returns 42
    )
    (memory (export "mem") 1)
    ;; ...
)
```
===> replay
```wasm
(module
    (func (export "replay") ;; entry point of the replay binary
        ;; ...
        i32.const 1234
        i32.const 42
        i32.store ;; only perform this when there different memory then before
        ;; ...
    )
    (func $handler (export "handler")
        i32.const 1234
        i32.load
    )
    (memory 1)
    ;; ...
)
```
## 6 Exported table present
!!!\
It seems like there is no way to properly model this only with wasm because you cannot modify the table in a webassembly file. So in order to model that properly you need javascript.
### 6.1 Call to an imported function (table change)
```wasm
(module
    (import $import "js" "import")
    (func
        i32.const 0
        call_indirect ;; calls $a
        call $import
        i32.const 0
        call_indirect ;; calls $b
        call $import
        i32.const 0
        call_indirect ;; calls $c
    )
    (func $a (export "a"))
    (func $b (export "b"))
    (func $c (export "c"))
    (table $table (export "table") 1))
    (elem $table (i32.const 0) $a)
)
```
===> replay
```wasm
(module
    (func $import_01
        ;; !!not possible to change the table in wasm!!
    )
    (func $import_02
        ;; !!not possible to change the table in wasm!!
    )
    (func
        i32.const 0
        call_indirect ;; calls $a
        call $import
        i32.const 0
        call_indirect ;; calls $b
        call $import
        i32.const 0
        call_indirect ;; calls $c
    )
    (func $a (export "a"))
    (func $b (export "b"))
    (func $c (export "c"))
    (table $table 1))
    (elem $table (i32.const 0) $a)
)
```
### 6.2 Call of an exported function (table state)
```wasm
(module
    (func $handler (export "handler")
        i32.const 0
        call_indirect ;; calls $b
    )
    (func $a (export "a"))
    (func $b (export "b"))
    (table $table (export "table") 1))
    (elem $table (i32.const 0) $a)
    ;; ...
)
```
===> replay
```wasm
(module
    (func (export "replay") ;; entry point of the replay binary
        ;; ...
        ;; !!not possible to change the table in wasm!!
        ;; ...
    )
    (func $handler (export "handler")
        i32.const 0
        call_indirect
    )
    (func $a (export "a"))
    (func $b (export "b"))
    (table $table (export "table") 1))
    (elem $table (i32.const 0) $a)
    ;; ...
)
```
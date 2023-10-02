## First execution
```wasm
(import "env" "host" (func $host (param i32)))
(module
    (func $main
        i32.const 10
        i32.const 0
        i32.store
        call $host
        i32.const 10
        i32.load
        (if (then
            ;; one branch
        )
        (else
            ;; other branch
        ))
    )
    (start $main)
    (export "memory" (memory 1))
    ;; more code
)
```
```javascript
function host() {
    memory[10] = 1
}
```

## Second execution
```wasm
(module
    (func $main
        i32.const 10
        i32.const 0
        i32.store
        nop ;; instead of call $host
        i32.const 10
        i32.load
        (if (then
            ;; one branch
        )
        (else
            ;; other branch
        ))
    )
    (start $main)
    (export "memory" (memory 1))
    ;; more code
)
```
Based on the load our program behaves completely differently. Our second record phase will be completely different

# Lets try to fix the problem

## First execution
```wasm
(import "env" "host" (func $host (param i32)))
(module
    (func $main
        i32.const 10
        i32.const 0
        i32.store
        call $host
        i32.const 10
        i32.load
        $trace_load ;;
        (if (then
            ;; one branch
        )
        (else
            ;; other branch
        ))
    )
    (start $main)
    (export "memory" (memory 1))
    ;; more code
)
```
```javascript
function host() {
    memory[10] = 1
}
```

## Second execution
```wasm
(module
    (func $main
        i32.const 10
        i32.const 0
        i32.store
        nop ;; instead of call $host
        i32.const 10
        i32.load
        call $compare_load ;; takes the actual load compares it with the load of the first recording and returns the load of the first execution
        (if (then
            ;; one branch
        )
        (else
            ;; other branch
        ))
    )
    (start $main)
    (export "memory" (memory 1))
    ;; more code
)
```
Based on the load our program behaves completely differently. Our second record phase will be completely different
# Detecting memory changes through ShadowMemory

The same concept is applicable for tables (ShadwTable).

## Situation:
```wasm
;; lets say initially the memory is filled with zeroes
i32.const 1234
i32.const 42
i32.store
call $imported_function
i32.const 1234
i32.load ;; we get 69
```
Idea:
* We maintain a shadowMemory, a datastructure that holds the current state of the memory
    * `Initialize once when first webassembly function call`
* When there is a store in wasm, alter the shadowMemory accordingly
* When there is a load in wasm, and the loaded value does not match the shadowMemory this means the memory must have been altered outside the wasm.

## Problem:
Consider:
```wasm
;; lets say initially the memory is filled with zeroes
call $imported_function_1
call $imported_function_2
i32.const 1234
i32.load ;; we get 69
```
Where did the memory modification happen? `$imported_function_1` or `$imported_function_2`??

### Solution
It does not really matter, because the end result is the same, so we choose `imported_function_2` as the location where the modification happens. Or does it? Lets say we find the following structure in a different part in the program:
```wasm
;; memory now is again filled with zeroes
call $imported_function_1
i32.const 1234
i32.load ;; we get 69
```
Hmmm, it seems like after all `$imported_function_1` was responsible for the memory change. So we need to add it here too. This is no thread to the soundness but it is not efficient and hard to optimise.

## Another Problem:
Consider:
```wasm
;; memory again filled with zeroes
(func 
    ;; example control flow begins here
    call $imported_function_03
    i32.const 1234
    i32.load ;; we get 69
)
(func (export "exported_function")
    i32.const 1234
    i32.load ;; we get 420
)
```
Hostcode:
```js
function imported_function() {
    // ... some code (sets mem[1234] = 420)
    instance.exports.exported_function()
    // ... some code (mem[1234] = 69)
}
```
We need to know in which order certain events happened in the host function!

## Solution
Tracing whenever a function in wasm is entered. That way we know later if a specific memory store happened before a certain function call or after.

<!-- ## Solution
My solution involves a specific trace design:
The trace will be a `list` which contains information of the call history of all called **imported** functions.

## Algorithm
* When we discover `call $some_imported_function` we append an object with the `function_id` and `parameters` and `events` which is by itsef an empty list to our call history.
* When we return from that function (fight after `call $some_imported_function`) we append `return_values` to that function object that is most last in the call history **AND** does not already have return values. (Yes this can happen, think about it). This means the execution of the function is closed and this function object in our call history can not be modified anymore
* When we discover `xxx.store` we modify shadowMemory
* When we discover `xxx.load` and it doesnt match with our shadowMemory we will append a `mem_change` event to the very last function object in our call history.
* When we enter a function in wasm which gets exported **AND** there is somewhere in our call history a function object which doesnt have return values, we add a `wasm_call` event to the last function object in our call history that does **not** have return values.

The specific steps work simillar for tables. We need to pay attention here on the `call_indirect` instruction.\
Again, we might have many redundant instructions in our replay binary with this strategy, but the algorithm overall should be sound for what it is intended. -->


## A Third Problem
Wasabi does not suppot table.set instructions and the new memory./table.init/copy/fill yet. In order to implement our approach we need to extend Wasabi with that functionality.
export default async function test(wasmBinary) {
    let instance
    let imports = {
        env: {
            abort: () => { },
            enlargeMemory: () => { },
            getTotalMemory: () => { },
            abortOnCannotGrowMemory: () => { },
            _pthread_getspecific: () => { },
            ___syscall54: () => { },
            _pthread_setspecific: () => { },
            ___lock: () => { },
            _abort: () => { },
            ___setErrNo: () => { },
            ___syscall6: () => { },
            ___syscall140: () => { },
            _pthread_once: () => { },
            _emscripten_memcpy_big: () => { },
            _pthread_key_create: () => { },
            ___unlock: () => { },
            ___assert_fail: () => { },
            ___syscall146: () => { },
            memory: new WebAssembly.Memory({ initial: 256, maximum: 256 }),
            table: new WebAssembly.Table({ element: "anyfunc", initial: 34, maximum: 34 }),
            memoryBase: new WebAssembly.Global({ value: "i32" }),
            tableBase: new WebAssembly.Global({ value: "i32" }),
            DYNAMICTOP_PTR: new WebAssembly.Global({ value: "i32" }),
            STACKTOP: new WebAssembly.Global({ value: "i32" }),
            STACK_MAX: new WebAssembly.Global({ value: "i32" }),
        },
        asm2wasm: {
            "f64-to-int": () => { }
        }
    }
    let wasm = await WebAssembly.instantiate(wasmBinary, imports)
    instance = wasm.instance
    instance.exports._fib(40)
    instance.exports._fib(40)
}
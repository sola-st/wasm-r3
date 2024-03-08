
// in this runtime available available is:
// - setup(wasabiBinary) you need to call this to make the next function available
// - instrument_wasm() a function that takes a wasm buffer and instruments it with wasabi.
// - the setupAnalysis function returns a new Analysis instance when given the Wasabi object
export function setup(filePath) {
    let i = 0
    // const p_timeToFirstInstantiate = performanceEvent('time until instantiation of first wasm module in this context')
    const printWelcome = function () {
        // console.log('---------------------------------------------')
        // console.log('             Instrumenting Wasm              ')
        // console.log('---------------------------------------------')
        // console.log('WebAssembly module instantiated.             ')
    }
    let instance
    let importsLength
    const r3 = {
        check_mem: () => {
            const trace = instance.exports.trace.buffer.slice(0, instance.exports.trace_byte_length.value)
            fs.writeFileSync(filePath, Buffer.from(trace))
        },
        // check_table: () => {
        //     const lookupTable = instance.exports.lookup;
        //     const lookupPointer = instance.exports.lookup_table_pointer.value;
        //     let funcIdxes = []
        //     for (let i = 0; i < lookupPointer; i++) {
        //         let funcIdx = lookupTable.get(i).name - 2
        //         funcIdxes.push(funcIdx)
        //     }
        //     fs.writeFileSync(`${filePath}.lookup`, funcIdxes.join('\n'));
        // }
    }

    const binaryString = atob(tracerBinary);
    const uint8Array = new Uint8Array(binaryString.length);
    for (let i = 0; i < binaryString.length; i++) {
        uint8Array[i] = binaryString.charCodeAt(i);
    }
    const buffer = uint8Array.buffer;
    initSync(buffer)
    let original_instantiate = WebAssembly.instantiate
    WebAssembly.instantiate = async function (buffer, importObject) {
        importObject.r3 = r3
        buffer = (buffer.byte) ? buffer.byte : buffer
        const this_i = i
        i += 1
        printWelcome()
        let result
        try {
            const { instrumented, stats } = instrument_wasm_js(new Uint8Array(buffer));
            // console.log('stats', stats)
            // console.log('instrumented', instrumented)
            buffer = new Uint8Array(instrumented)
            fs.writeFileSync('test.wasm', buffer)
            result = await original_instantiate(buffer, importObject)
            WebAssembly.instantiate = original_instantiate
        } catch (e) {
            WebAssembly.instantiate = original_instantiate
            throw e
        }
        instance = result.instance
        importsLength = WebAssembly.Module.imports(result.module).filter((d) => d.kind === 'function').length - 1
        return result
    };


    return () => {
        r3.check_mem();
        // r3.check_table();
    }

}
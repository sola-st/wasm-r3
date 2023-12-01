import fs from 'fs'

export default async function test(wasmBinary) {
    let instance
    let imports = {
        env: {
            foo: () => { },
            foo1: () => { },
            foo2: () => { },
            foo3: () => { },
            foo4: () => { },
            foo5: () => { },
            foo6: () => { },
            foo7: () => { },
            foo8: () => { },
            foo9: () => { },
            foo10: () => { },
        }
    }
    let friendImports = {
        env: {
            tony: () => { },
            jannik: () => { }
        }
    }
    let wasm = await WebAssembly.instantiate(wasmBinary, imports)
    const friendBinary = fs.readFileSync('/Users/jakob/Desktop/wasm-r3/tests/node/table-exp-host-add-jsref/friend.wasm')
    let friend = await WebAssembly.instantiate(friendBinary, friendImports)
    instance = wasm.instance
    instance.exports.table.set(0, friend.instance.exports.greet)
    instance.exports.main()
}
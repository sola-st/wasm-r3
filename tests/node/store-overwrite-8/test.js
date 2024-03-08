export default async function test(wasmBinary) {
  let instance;
  let imports = {};
  let wasm = await WebAssembly.instantiate(wasmBinary, imports);
  instance = wasm.instance;
  new Uint8Array(instance.exports.memory.buffer)[0] = 1;
  new Uint8Array(instance.exports.memory.buffer)[1] = 1;
  instance.exports.entry();
}

let original_instantiate = WebAssembly.instantiate;
function instrument(buffer) {
  // fs.writeFileSync('./pspdf.wasm', buffer as NodeJS.ArrayBufferView)
  // cp.execSync("wasabi /Users/jakob/Desktop/wasm-r3/tool/pspdf.wasm -o /Users/jakob/Desktop/wasm-r3/tool/")
  console.log(buffer)
  return buffer
}

WebAssembly.instantiate = function (buffer) {
  buffer = instrument(buffer)
  return original_instantiate.call(WebAssembly, ...arguments);
};
// replace instantiateStreaming
WebAssembly.instantiateStreaming = async function (source, obj) {
  let response = await source;
  let body = await response.arrayBuffer();
  return WebAssembly.instantiate(body, obj);
}
//replace compile
let original_compile = WebAssembly.compile;
WebAssembly.compile = function (buffer) {
  buffer = instrument(buffer)
  return original_compile.call(WebAssembly, ...arguments);
};
// replace compileStreaming
WebAssembly.compileStreaming = async function (source) {
  let response = await source;
  let body = await response.arrayBuffer();
  return WebAssembly.compile(body);
};
import fs from 'fs'

// Replace 'your-wasm-file.wasm' with the path to your Wasm file
const wasmFilePath = './public/wasabi_bg.wasm';

// Read the Wasm file as binary data
const wasmBinary = fs.readFileSync(wasmFilePath);

// Encode the binary data as Base64
const wasmBase64 = wasmBinary.toString('base64');

fs.writeFileSync('./public/wasabi_bg.wasm.string', wasmBase64)
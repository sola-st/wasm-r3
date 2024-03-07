// extern crate tracer;
// use std::fs;

// use tracer::instrument_wasm;

// fn main() {
//     let test_name = "tests/funky-kart";
//     let buffer = &fs::read(format!("{}.wasm", test_name)).unwrap();
//     let _ = match instrument_wasm(buffer) {
//         Ok(output) => {
//             dbg!(output.stats);
//             fs::write("tests/instrumented.wasm", &output.instrumented).unwrap();
//             let wat = wasmprinter::print_bytes(output.instrumented).unwrap();
//             fs::write("tests/generated.wat", wat)
//         }
//         Err(str) => {
//             let _ = fs::write("tests/generated.wat", str);
//             // panic!();
//             panic!("{str}");
//         }
//     };
// }

fn main() {}

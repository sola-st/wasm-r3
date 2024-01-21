use std::fs::File;
use std::io::{self, BufRead};
use std::path::Path;

use std::{env, fs};

use replay_gen::irgen::IRGenerator;
use replay_gen::jsgen::generate_replay_javascript;
use replay_gen::opt::{discard_empty_body, merge_fn_results};
use replay_gen::trace;
use replay_gen::wasmgen::generate_replay_wasm;
use walrus::Module;

fn main() -> io::Result<()> {
    // TODO: use clap to parse args. currently just panics.
    let args: Vec<String> = env::args().collect();
    let trace_path = Path::new(&args[1]);
    let wasm_path = Path::new(&args[2]);
    let binding = args.get(3);
    let replay_path = match &binding {
        Some(str) => Some(Path::new(str)),
        None => None,
    };
    let file = File::open(&trace_path)?;
    let reader = io::BufReader::new(file);

    let mut trace = trace::Trace::new();
    for line in reader.lines() {
        let line = line?;
        let event = match line.parse() {
            Ok(event) => event,
            Err(err) => match err {
                trace::ErrorKind::LegacyTrace => continue,
                trace::ErrorKind::UnknownTrace => panic!("error: {:?}", err),
            },
        };
        trace.push(event);
    }

    // irgen phase
    let buffer = &fs::read(wasm_path).unwrap();
    let module = Module::from_buffer(buffer).unwrap();
    let mut generator = IRGenerator::new(module);
    generator.generate_replay(&trace);

    // opt phase
    merge_fn_results(&mut generator.replay);
    discard_empty_body(&mut generator.replay);

    // codegen phase
    let is_standalone = replay_path.is_none();
    let is_replay_wasm = !is_standalone && replay_path.unwrap().extension().unwrap() == "wasm";
    if is_replay_wasm {
        generate_replay_wasm(replay_path.unwrap(), &generator.replay)?;
    } else {
        generate_replay_javascript(replay_path.unwrap(), &generator.replay)?;
    }

    Ok(())
}

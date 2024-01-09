use std::fs::File;
use std::io::{self, BufRead};
use std::path::Path;

use std::{env, fs};

use replay_gen::codegen::{generate_javascript, generate_standalone};
use replay_gen::irgen::IRGenerator;
use replay_gen::opt::merge_fn_results;
use replay_gen::trace;
use walrus::Module;

fn main() -> io::Result<()> {
    // TODO: use clap to parse args. currently just panics.
    let args: Vec<String> = env::args().collect();
    let trace_path = Path::new(&args[1]);
    let wasm_path = Path::new(&args[2]);
    let binding = args.get(3);
    let js_path = match &binding {
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

    let buffer = &fs::read(wasm_path).unwrap();
    let module = Module::from_buffer(buffer).unwrap();
    let mut generator = IRGenerator::new(module);
    generator.generate_replay(&trace);

    // opt paths
    merge_fn_results(&mut generator.replay);

    let is_standalone = js_path.is_none();
    if is_standalone {
        generate_standalone(wasm_path, &generator.replay)?;
    } else {
        generate_javascript(js_path.unwrap(), &generator.replay)?;
    }

    Ok(())
}

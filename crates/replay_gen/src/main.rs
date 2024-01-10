use replay_gen::codegen::{generate_javascript, generate_standalone};
use replay_gen::irgen::IRGenerator;
use replay_gen::opt::Optimiser;
use replay_gen::trace::{self};
use std::io::{self};
use std::path::Path;
use std::{env, fs};
use trace::Trace;
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

    let mut trace = Trace::from_text_file(trace_path).unwrap();

    let buffer = &fs::read(wasm_path).unwrap();
    let module = Module::from_buffer(buffer).unwrap();

    // opt trace
    Optimiser::shadow_mem(&mut trace, &module);

    let mut generator = IRGenerator::new(module);
    generator.generate_replay(trace);

    // opt replay
    Optimiser::merge_fn_results(&mut generator.replay);

    let is_standalone = js_path.is_none();
    if is_standalone {
        generate_standalone(wasm_path, &generator.replay)?;
    } else {
        generate_javascript(js_path.unwrap(), &generator.replay)?;
    }

    Ok(())
}

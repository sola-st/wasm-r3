use replay_gen::codegen::{generate_javascript, generate_standalone};
use replay_gen::irgen::IRGenerator;
use replay_gen::opt::Optimiser;
use replay_gen::trace::{self, WasmEvent};
use replay_gen::trace_optimisation::{ShadowMemoryOptimiser, TraceOptimiser};
use std::fs::File;
use std::io::{self, BufReader};
use std::path::Path;
use std::{env, fs};
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

    let file = File::open(trace_path).unwrap();
    let mut reader = BufReader::new(file);
    let buffer = &fs::read(wasm_path).unwrap();
    let module = Module::from_buffer(buffer).unwrap();
    let mut shadow_mem_optimiser = ShadowMemoryOptimiser::new(&module);
    let mut generator = IRGenerator::new(module);
    while let Ok(event) = WasmEvent::decode_string(&mut reader) {
        let event = match shadow_mem_optimiser.consume_event(event) {
            Some(e) => e,
            None => continue,
        };
        generator.consume_event(event);
    }

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

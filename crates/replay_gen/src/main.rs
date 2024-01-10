use std::io::{self, BufRead, Write};
use std::path::Path;
use std::process::Command;
use std::task::Poll;
use std::{env, fs};
use tokio::fs::File;

use futures::{AsyncRead, Stream, StreamExt};
use replay_gen::codegen::{generate_javascript, generate_standalone, write};
use replay_gen::irgen::IRGenerator;
use replay_gen::opt::merge_fn_results;
use replay_gen::trace::{self, WasmEvent};
use trace::Trace;
use walrus::Module;

pub struct TextStream(File);

#[tokio::main]
async fn main() -> io::Result<()> {
    // TODO: use clap to parse args. currently just panics.
    let args: Vec<String> = env::args().collect();
    let trace_path = Path::new(&args[1]);
    let wasm_path = Path::new(&args[2]);
    let binding = args.get(3);
    let js_path = match &binding {
        Some(str) => Some(Path::new(str)),
        None => None,
    };

    let buffer = &fs::read(wasm_path).unwrap();
    let module = Module::from_buffer(buffer).unwrap();

    let file = File::open(&trace_path).await?;
    let mut trace = Trace::from_text(file, module);
    trace.shadow_optimise();
    // let file2 = File::open(&trace_path).await?;
    // trace.to_text(file2);

    // let mut generator = IRGenerator::new(module);
    // generator.generate_replay(trace).await;

    // // opt paths
    // merge_fn_results(&mut generator.replay);

    // let is_standalone = js_path.is_none();
    // if is_standalone {
    //     generate_standalone(wasm_path, &generator.replay)?;
    // } else {
    //     generate_javascript(js_path.unwrap(), &generator.replay)?;
    // }

    Ok(())
}

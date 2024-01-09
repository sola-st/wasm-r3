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

// impl Stream for TextStream<File> {
//     type Item = String;

//     fn poll_next(
//         self: std::pin::Pin<&mut Self>,
//         cx: &mut std::task::Context<'_>,
//     ) -> std::task::Poll<Option<Self::Item>> {
//         let mut reader = io::BufReader::new(file);
//         let mut line = String::new();
//         match reader.read_line(&mut line) {
//             Ok(_) => Poll::Ready(Some(line)),
//             Err(_) => Poll::Ready(None),
//         }
//         // let mut buf = [0; 1];
//         // match Pin::new(&mut self.0).poll_read(cx, &mut buf) {
//         //     Poll::Ready(Ok(n)) => {
//         //         if n == 0 {
//         //             Poll::Ready(None)
//         //         } else {
//         //             Poll::Ready(Ok(n))
//         //         }
//         //     }
//         //     Poll::Ready(Err(_)) => Poll::Ready(None),
//         //     Poll::Pending => Poll::Pending,
//         // }
//     }
// }

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

    let file = File::open(&trace_path).await?;
    let mut trace = Trace::from_text(file);
    trace.shadow_optimise();
    // let file2 = File::open(&trace_path).await?;
    // trace.to_text(file2);

    let buffer = &fs::read(wasm_path).unwrap();
    let module = Module::from_buffer(buffer).unwrap();
    let mut generator = IRGenerator::new(module);
    generator.generate_replay(trace).await;

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

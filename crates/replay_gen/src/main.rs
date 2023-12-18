use std::env;
use std::fs::File;
use std::io::{self, BufRead};
use std::path::Path;

use replay_gen::jsgen::js::generate_javascript;
use replay_gen::jsgen::Generator;
use replay_gen::trace;

fn main() -> io::Result<()> {
    // FIXME: use clap to parse args. currently just panics.
    let args: Vec<String> = env::args().collect();
    let trace_path = Path::new(&args[1]);
    let out_path = Path::new(&args[2]);
    let file = File::open(&trace_path)?;
    let reader = io::BufReader::new(file);

    let mut trace = trace::Trace::new();
    for line in reader.lines() {
        let line = line?;
        let event = line.parse()?;
        trace.push(event);
    }
    let mut generator = Generator::new();
    generator.generate_replay(&trace);
    let path = Path::new(out_path);
    let mut file = File::create(&path)?;
    generate_javascript(&mut file, &generator.code)?;
    Ok(())
}

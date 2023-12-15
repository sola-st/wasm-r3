use std::env;
use std::fs::File;
use std::io::{self, BufRead};
use std::path::Path;

use replay_gen::trace;

fn main() -> io::Result<()> {
    // FIXME: use clap to parse args. currently just panics.
    let args: Vec<String> = env::args().collect();
    let newline = &args[1];
    let path = Path::new(newline);
    let file = File::open(&path)?;
    let reader = io::BufReader::new(file);

    let mut lines = reader.lines().peekable();

    while let Some(line) = lines.next() {
        let line = line?;
        let event = line.parse::<trace::WasmEvent>()?;
        // hack to print the last event without a newline that matches the current behavior.
        if lines.peek().is_some() {
            println!("{:?}", event);
        } else {
            print!("{:?}", event);
        }
    }
    Ok(())
}

use std::{fs::File, io::Write};

pub mod irgen;
pub mod opt;
pub mod trace;
pub mod wasmgen;

pub fn write(stream: &mut File, s: &str) -> std::io::Result<()> {
    if stream.write_all(s.as_bytes()).is_err() {
        stream.flush()?;
    }
    Ok(())
}

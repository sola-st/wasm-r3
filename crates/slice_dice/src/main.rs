use anyhow::{Error, Result};
use slice_dice::htmlgen;
use slice_dice::preprocess;
use slice_dice::wasmgen;
use std::collections::HashSet;
use std::env;
use std::fs;
use std::path::PathBuf;
use std::process::Command;

fn main() -> Result<()> {
    let args: Vec<String> = env::args().collect();

    let path = args
        .get(1)
        .ok_or_else(|| Error::msg("No WASM file path provided"))?;

    let mut int_list: Vec<i32> = match args.get(2) {
        Some(s) => s
            .split(',')
            .map(|s| s.trim().parse::<i32>())
            .collect::<std::result::Result<Vec<i32>, _>>()
            .map_err(|e| Error::msg(format!("Failed to parse integers: {}", e)))?,
        None => {
            preprocess::run_wizard(path)?;
            return Ok(());
        }
    };
    int_list.sort();

    println!("Parsed unique integers: {:?}", int_list);

    let rep_count: usize = match args.get(3) {
        Some(s) => s.parse::<usize>()?,
        None => 1,
    };

    let pathbuf = PathBuf::from(path);
    let parent_dir = pathbuf.parent().ok_or_else(|| Error::msg("Invalid path"))?;
    let out_dir = parent_dir.join(format!(
        "out/{}",
        int_list
            .iter()
            .map(|i| i.to_string())
            .collect::<Vec<String>>()
            .join(",")
    ));
    println! {"Output directory: {:?}", out_dir};
    fs::create_dir_all(&out_dir)?;

    let orig_wat_path = out_dir.join("orig.wat");
    let args = [
        "--all-features",
        "-o",
        orig_wat_path
            .to_str()
            .ok_or_else(|| Error::msg("Invalid output path"))?,
        path,
    ];
    let output = Command::new("wasm-dis")
        .args(&args)
        .current_dir(parent_dir)
        .output()?;

    if !output.status.success() {
        let error_message = String::from_utf8_lossy(&output.stderr);
        return Err(Error::msg(format!("wasm-dis failed: {}", error_message)));
    }

    let func_name = wasmgen::generate(
        &out_dir,
        orig_wat_path,
        int_list.iter().cloned().collect(),
        parent_dir,
    )?;

    htmlgen::generate(out_dir, func_name, rep_count)?;

    Ok(())
}

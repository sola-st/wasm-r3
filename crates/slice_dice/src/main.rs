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

    preprocess::run_wizard(path)?;

    let int_list: HashSet<i32> = args
        .get(2)
        .ok_or_else(|| Error::msg("No list of integers provided"))?
        .split(',')
        .map(|s| s.trim().parse::<i32>())
        .collect::<std::result::Result<HashSet<i32>, _>>()
        .map_err(|e| Error::msg(format!("Failed to parse integers: {}", e)))?;

    println!("Parsed unique integers: {:?}", int_list);
    let smallest = int_list
        .iter()
        .min()
        .ok_or_else(|| Error::msg("Empty list of integers"))?;
    let int_list = vec![*smallest];
    let first_int = int_list[0];
    println!("Smallest element: {:?}", first_int);

    let pathbuf = PathBuf::from(path);
    let parent_dir = pathbuf.parent().ok_or_else(|| Error::msg("Invalid path"))?;
    let out_dir = parent_dir.join(format!("out/{first_int}"));
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

    let func_name = wasmgen::generate(&out_dir, orig_wat_path, int_list, parent_dir)?;

    htmlgen::generate(out_dir, func_name)?;

    Ok(())
}

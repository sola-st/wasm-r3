use anyhow::{Error, Result};
use std::collections::HashMap;
use std::fs;
use std::io::{BufRead, BufReader, Write};
use std::path::PathBuf;
use std::process::Command;

// TODO: we require wasm-as allowing import after non-import to make our implementation easier.
// This worked in 9784f012848a7eb321c2037bdb363dfe0eab8bc9, and not in 6b93a84032cd00840c797d52ac01a7ca3bcb913e
// This is just for a convenience and workaround seems possible.

pub fn generate(
    out_dir: &PathBuf,
    orig_wat_path: PathBuf,
    int_list: Vec<i32>,
    parent_dir: &std::path::Path,
) -> Result<HashMap<i32, String>, Error> {
    let orig_part_path = out_dir.join("orig_part.wat");
    let orig_rest_path = out_dir.join("orig_rest.wat");
    let mut part_file = fs::File::create(&orig_part_path)?;
    let mut rest_file = fs::File::create(&orig_rest_path)?;
    let orig_file = fs::File::open(&orig_wat_path)?;
    let reader = BufReader::new(orig_file);
    let mut in_func = false;
    let mut curr_func = -1;
    let mut fidx_to_name: HashMap<i32, String> = HashMap::new();
    for (_index, line) in reader.lines().enumerate() {
        let line = line?;
        if line.starts_with(" (memory") {
            writeln!(rest_file, "{}", rest_transform_memory(&line))?;
            writeln!(part_file, "{}", part_transform_memory(&line))?;
            continue;
        }
        if line.starts_with(" (table") {
            writeln!(rest_file, "{}", rest_transform_table(&line))?;
            writeln!(part_file, "{}", part_transform_table(&line))?;
            continue;
        }
        if line.starts_with(" (global") {
            writeln!(rest_file, "{}", rest_transform_global(&line))?;
            writeln!(part_file, "{}", part_transform_global(&line))?;
            continue;
        }
        if line.starts_with(" (export") {
            writeln!(rest_file, "{}", line)?;
            // writeln!(part_file, "{}", line)?;
            continue;
        }
        if line.starts_with(" (func") {
            curr_func += 1;
            in_func = true;
            if int_list.contains(&curr_func) {
                let (rest_line, _extracted_name) = rest_transform_func(&line);
                let (part_line, extracted_name) = part_transform_func(&line);
                fidx_to_name.insert(curr_func, extracted_name);
                writeln!(rest_file, "{rest_line}",)?;
                writeln!(part_file, "{part_line}",)?;
                continue;
            } else {
                let (rest_line, _extracted_name) = rest_export_func(&line);
                let (part_line, _extracted_name) = part_import_func(&line);
                writeln!(rest_file, "{rest_line}",)?;
                writeln!(part_file, "{part_line}",)?;
                continue;
            }
        } else if line.starts_with(" )") {
            in_func = false;
            writeln!(rest_file, "{}", &line)?;
            if int_list.contains(&curr_func) {
                writeln!(part_file, "{}", &line)?;
            }
            continue;
        }
        match (in_func, int_list.contains(&curr_func)) {
            (true, true) => {
                writeln!(part_file, "{}", line)?;
            }
            (true, false) => {
                writeln!(rest_file, "{}", line)?;
            }
            (false, _) => {
                writeln!(part_file, "{}", line)?;
                writeln!(rest_file, "{}", line)?;
            }
        }
    }
    let binding = out_dir.join("orig_rest.wasm");
    let args = [
        "--all-features",
        "-o",
        binding
            .to_str()
            .ok_or_else(|| Error::msg("Invalid output path"))?,
        orig_rest_path.to_str().unwrap(),
    ];
    let output = Command::new("wasm-as")
        .args(&args)
        .current_dir(parent_dir)
        .output()?;
    if !output.status.success() {
        let error_message = String::from_utf8_lossy(&output.stderr);
        return Err(Error::msg(format!(
            "wasm-as for rest failed: {}",
            error_message
        )));
    }
    let binding = out_dir.join("orig_part.wasm");
    let args = [
        "--all-features",
        "-o",
        binding
            .to_str()
            .ok_or_else(|| Error::msg("Invalid output path"))?,
        orig_part_path.to_str().unwrap(),
    ];
    let output = Command::new("wasm-as")
        .args(&args)
        .current_dir(parent_dir)
        .output()?;
    if !output.status.success() {
        let error_message = String::from_utf8_lossy(&output.stderr);
        return Err(Error::msg(format!(
            "wasm-as for part failed: {}",
            error_message
        )));
    }
    Ok(fidx_to_name)
}

fn rest_transform_func(line: &str) -> (String, String) {
    if line.trim().starts_with("(func ") {
        let parts: Vec<&str> = line.trim_start().splitn(3, ' ').collect();
        if parts.len() >= 2 {
            let func_keyword = parts[0];
            let func_name = parts[1];
            let rest = parts[2..].join(" ");
            return (
                format!(" {func_keyword} {func_name} (import \"part\" \"{func_name}\") {rest}",),
                func_name.to_string(),
            );
        }
    }
    unreachable!("{line}")
}

fn rest_export_func(line: &str) -> (String, String) {
    if line.trim().starts_with("(func ") {
        let parts: Vec<&str> = line.trim_start().splitn(3, ' ').collect();
        if parts.len() >= 2 {
            let func_keyword = parts[0];
            let func_name = parts[1];
            let rest = parts[2..].join(" ");
            let var_name = (
                format!(" {func_keyword} {func_name} (export \"{func_name}\") {rest}",),
                func_name.to_string(),
            );
            return var_name;
        }
    }
    unreachable!("{line}")
}

fn part_import_func(line: &str) -> (String, String) {
    if line.trim().starts_with("(func ") {
        let parts: Vec<&str> = line.trim_start().splitn(3, ' ').collect();
        if parts.len() >= 2 {
            let func_keyword = parts[0];
            let func_name = parts[1];
            let rest = parts[2..].join(" ");
            let var_name = (
                format!(" {func_keyword} {func_name} (export \"r3_{func_name}\") (import \"rest\" \"{func_name}\") {rest})",),
                func_name.to_string(),
            );
            return var_name;
        }
    }
    unreachable!("{line}")
}

fn part_transform_func(line: &str) -> (String, String) {
    if line.trim().starts_with("(func ") {
        let parts: Vec<&str> = line.trim_start().splitn(3, ' ').collect();
        if parts.len() >= 2 {
            let func_keyword = parts[0];
            let func_name = parts[1];
            let rest = parts[2..].join(" ");
            return (
                format!(
                    " {} {} (export \"{}\") {}",
                    func_keyword, func_name, func_name, rest
                ),
                func_name.to_owned(),
            );
        }
    }
    unreachable!()
}

fn rest_transform_memory(line: &str) -> String {
    if line.trim().starts_with("(memory ") {
        let parts: Vec<&str> = line.trim_start().splitn(3, ' ').collect();
        if parts.len() >= 2 {
            let memory_keyword = parts[0];
            let memory_name = parts[1];
            let rest = parts[2..].join(" ");
            return format!(
                " {} {} (export \"memory\") {}",
                memory_keyword, memory_name, rest
            );
        }
    }
    line.to_string()
}

fn part_transform_memory(line: &str) -> String {
    if line.trim().starts_with("(memory ") {
        let parts: Vec<&str> = line.trim_start().splitn(3, ' ').collect();
        if parts.len() >= 2 {
            let memory_keyword = parts[0];
            let memory_name = parts[1];
            let rest = parts[2..].join(" ");
            return format!(
                " {} {} (import \"rest\" \"memory\") {}",
                memory_keyword, memory_name, rest
            );
        }
    }
    line.to_string()
}

fn rest_transform_table(line: &str) -> String {
    if line.trim().starts_with("(table ") {
        let parts: Vec<&str> = line.trim_start().splitn(3, ' ').collect();
        if parts.len() >= 2 {
            let table_keyword = parts[0];
            let table_name = parts[1];
            let rest = parts[2..].join(" ");
            return format!(
                " {} {} (export \"r3_table\") {}",
                table_keyword, table_name, rest
            );
        }
    }
    line.to_string()
}

fn part_transform_table(line: &str) -> String {
    if line.trim().starts_with("(table ") {
        let parts: Vec<&str> = line.trim_start().splitn(3, ' ').collect();
        if parts.len() >= 2 {
            let table_keyword = parts[0];
            let table_name = parts[1];
            let rest = parts[2..].join(" ");
            return format!(
                " {} {} (import \"rest\" \"r3_table\") {}",
                table_keyword, table_name, rest
            );
        }
    }
    line.to_string()
}

fn rest_transform_global(line: &str) -> String {
    if line.trim().starts_with("(global ") {
        let parts: Vec<&str> = line.trim_start().splitn(3, ' ').collect();
        if parts.len() >= 2 {
            let global_keyword = parts[0];
            let global_name = parts[1];
            let rest = parts[2..].join(" ");
            return format!(
                " {} {} (export \"{global_name}\") {}",
                global_keyword, global_name, rest
            );
        }
    }
    line.to_string()
}

fn part_transform_global(line: &str) -> String {
    if line.trim().starts_with("(global ") {
        let parts: Vec<&str> = line.trim_start().splitn(3, ' ').collect();
        if parts.len() >= 2 {
            let global_keyword = parts[0];
            let global_name = parts[1];
            let rest = parts[2..].join(" ");
            return format!(
                " {} {} (import \"rest\" \"{global_name}\") {}",
                global_keyword, global_name, rest
            );
        }
    }
    line.to_string()
}

use anyhow::{Error, Result};
use std::process::Command;

pub fn run_wizard(path: &String) -> Result<(), Error> {
    let output = Command::new("wizeng.x86-64-linux")
        .arg("-csv")
        .arg("--monitors=icount")
        .arg(path)
        .output()?;
    if !output.status.success() {
        let error_message = String::from_utf8_lossy(&output.stderr);
        return Err(Error::msg(format!(
            "Failed to run wasm binary: {}",
            error_message
        )));
    }
    use std::collections::HashMap;
    fn parse_csv_to_map(csv_data: &str) -> Result<HashMap<usize, usize>> {
        let mut map = HashMap::new();
        for line in csv_data.lines().skip(1) {
            // Skip header
            let parts: Vec<&str> = line.split(',').collect();
            if parts.len() >= 3 {
                let function_index = parts[0].trim_start_matches('#').parse::<usize>()?;
                let dynamic_count = parts[2].parse::<usize>()?;
                map.insert(function_index, dynamic_count);
            }
        }
        Ok(map)
    }
    let csv_output = String::from_utf8_lossy(&output.stdout);
    let function_map = parse_csv_to_map(&csv_output)?;
    let non_zero_keys: Vec<_> = function_map
        .iter()
        .filter(|&(_, &v)| v > 0)
        .map(|(&k, _)| k)
        .collect();
    let mut sorted_keys = non_zero_keys;
    sorted_keys.sort_unstable();
    sorted_keys.retain(|&k| k != 0);
    println!("Pick one among these: {:?}", sorted_keys);
    Ok(())
    }

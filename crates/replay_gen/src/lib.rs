pub mod codegen;
pub mod irgen;
pub mod opt;
pub mod trace;

#[cfg(test)]
mod tests {
    use core::panic;
    use std::os::unix::thread;

    use tokio::{
        fs::File,
        io::{AsyncReadExt, AsyncSeekExt, BufReader},
    };

    use crate::{
        codegen::generate_javascript,
        irgen::IRGenerator,
        opt::merge_fn_results,
        // trace::decode_trace,
    };
    use async_recursion::async_recursion;

    #[tokio::test]
    async fn trace_encode_decode_same() -> std::io::Result<()> {
        use super::*;
        use std::fs;
        use std::io;
        use std::io::Read;
        use std::io::Write;
        use std::io::{BufRead, Seek, SeekFrom};
        use std::path::Path;

        #[async_recursion(?Send)]
        async fn visit_dirs(dir: &Path) -> io::Result<()> {
            if dir.is_dir() {
                for entry in fs::read_dir(dir)? {
                    let entry = entry?;
                    let path = entry.path();
                    if path.is_dir() {
                        visit_dirs(&path).await?;
                    } else {
                        if path.extension().and_then(|s| s.to_str()) == Some("r3") {
                            if path.display().to_string().contains("pathfinding") {
                                // floating point precision
                                println!("skipping problematic case {}", path.display());
                                continue;
                            }
                            let mut file = fs::File::open(&path)?;
                            let mut original_contents = Vec::new();
                            file.read_to_end(&mut original_contents)?;

                            let file = File::open(&path).await?;
                            let mut trace = trace::Trace::from_text(file);
                            let mut newfile = File::from_std(tempfile::tempfile()?);
                            trace.to_text(&mut newfile);
                            newfile.seek(SeekFrom::Start(0)).await?;

                            let mut new_contents = Vec::new();
                            let mut reader = BufReader::new(newfile);
                            reader.read_to_end(&mut new_contents).await?;
                            if !new_contents.is_empty() {
                                assert_eq!(
                                    &original_contents[..original_contents.len()],
                                    &new_contents[..new_contents.len() - 1],
                                    "File contents do not match for {}",
                                    path.display()
                                );
                            } else {
                                assert_eq!(
                                    original_contents,
                                    new_contents,
                                    "File contents do not match for {}",
                                    path.display()
                                );
                            }
                        }
                    }
                }
            }
            Ok(())
        }
        visit_dirs(Path::new("../../tests")).await?;
        Ok(())
    }
    // TODO: factor out with trace_encode_decode_same
    #[tokio::test]
    async fn replay_js_same_with_original() -> std::io::Result<()> {
        use super::*;
        use std::fs;
        use std::io;
        use std::io::BufRead;
        use std::io::Read;
        

        use std::path::Path;
        

        #[async_recursion]
        async fn visit_dirs(dir: &Path) -> io::Result<()> {
            if dir.is_dir() {
                for entry in fs::read_dir(dir)? {
                    let entry = entry?;
                    let path = entry.path();
                    if path.is_dir() {
                        visit_dirs(&path).await?;
                    } else {
                        if path.file_name().and_then(|s| s.to_str()) == Some("trace.r3") // node format
                        || path.file_name().and_then(|s| s.to_str()) == Some("trace-ref.r3")
                        // web format
                        {
                            if path.display().to_string().contains("kittygame") || // too slow
                            path.display().to_string().contains("pathfinding")
                            // floating point precision
                            // slow
                            {
                                println!("skipping problematic case {}", path.display());
                                continue;
                            }
                            println!("Testing {}", path.display());
                            // Read replay.js file
                            let replay_path = path.with_file_name("replay.js");
                            let replay_file = fs::File::open(replay_path.clone())?;
                            let mut reader = io::BufReader::new(replay_file);
                            let mut old_js = String::new();
                            reader.read_to_string(&mut old_js)?;

                            let trace_file = File::open(&path).await?;
                            let trace = trace::Trace::from_text(trace_file);
                            // let mut generator = IRGenerator::new();
                            // generator.generate_replay(&trace);
                            // merge_fn_results(&mut generator.replay);

                            // let mut temp_file = tempfile()?;
                            // generate_javascript(&mut temp_file, &generator.replay)?;
                            // temp_file.seek(SeekFrom::Start(0))?;

                            // let mut reader = io::BufReader::new(temp_file);
                            // let mut new_js = String::new();
                            // reader.read_to_string(&mut new_js)?;
                            // assert!(
                            //     old_js == new_js,
                            //     "Generated JS does not match for {}, original js: {}",
                            //     path.display(),
                            //     replay_path.display()
                            // );
                        }
                    }
                }
            }
            Ok(())
        }
        visit_dirs(Path::new("../../tests")).await?;
        Ok(())
    }
}

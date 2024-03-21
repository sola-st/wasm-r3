use replay_gen::irgen::IRGenerator;
use replay_gen::jsgen::generate_replay_javascript;
use replay_gen::opt::Optimiser;
use replay_gen::trace::{ErrorKind, WasmEvent};
use replay_gen::trace_optimisation::{
    CallOptimiser, FuncEntryTransformer, ShadowMemoryOptimiser, ShadowTableOptimiser, TraceOptimiser,
};
use replay_gen::wasmgen::generate_replay_wasm;
use std::fs::File;
use std::io::{self, BufReader, BufWriter, Write};
use std::path::{Path, PathBuf};
use std::{env, fs};
use walrus::Module;

fn main() -> io::Result<()> {
    // TODO: use clap to parse args. currently just panics.
    let args: Vec<String> = env::args().collect();
    let subcommand = &args[1];
    if subcommand == "generate" {
        generate(args)
    } else if subcommand == "stringify" {
        bin_trace_to_string_representation(args)
    } else {
        panic!()
    }
}

fn generate(args: Vec<String>) -> io::Result<()> {
    let trace_path = Path::new(&args[2]);
    let wasm_path = Path::new(&args[3]);
    let binary = &args[4];
    let binding = args.get(5);
    let replay_path = match &binding {
        Some(str) => Some(Path::new(str)),
        None => None,
    };

    let buffer = &fs::read(wasm_path).unwrap();
    let mut generator = IRGenerator::new(Module::from_buffer(buffer).unwrap());
    let module = Module::from_buffer(buffer).unwrap();
    let trace = if binary == "true" {
        // let mut shadow_mem_optimiser = ShadowMemoryOptimiser::new(&module);
        // let mut shadow_table_optimiser = ShadowTableOptimiser::new(&module);
        // let mut func_entry_transformer = FuncEntryTransformer::new(&module);
        // let mut call_optimiser = CallOptimiser::new(&module);
        Trace::new(trace_path, &module, true)
            .map(|e| e.unwrap())
            // .filter(|e| call_optimiser.discard_event(e))
            // .filter(|e| shadow_mem_optimiser.discard_event(e))
            // .filter(|e| shadow_table_optimiser.discard_event(e))
            // .map(|e| func_entry_transformer.transform_event(e))
            .for_each(|e| generator.consume_event(e));
    } else {
        Trace::new(trace_path, &module, false)
            .map(|e| e.unwrap())
            .for_each(|e| generator.consume_event(e));
    };

    // opt replay
    Optimiser::merge_fn_results(&mut generator.replay);
    Optimiser::discard_empty_body(&mut generator.replay);

    let is_standalone = replay_path.is_none();
    let is_replay_wasm = !is_standalone && replay_path.unwrap().extension().unwrap() == "wasm";
    if is_replay_wasm {
        let index_path = wasm_path.parent().unwrap().join("index.wasm");
        let base_path = wasm_path.parent().unwrap().parent().unwrap().parent().unwrap();
        let sub_dir = wasm_path.parent().unwrap().file_name().unwrap();
        let noopt_path = base_path.join(&format!("noopt/{}/replay.wasm", sub_dir.to_str().unwrap()));
        let merge_path = base_path.join(&format!("merge/{}/replay.wasm", sub_dir.to_str().unwrap()));
        let split_path = base_path.join(&format!("split/{}/replay.wasm", sub_dir.to_str().unwrap()));

        std::fs::create_dir_all(noopt_path.parent().unwrap())?;
        std::fs::copy(&index_path, &noopt_path.parent().unwrap().join("index.wasm"))?;
        std::fs::create_dir_all(merge_path.parent().unwrap())?;
        std::fs::copy(&index_path, &merge_path.parent().unwrap().join("index.wasm"))?;
        std::fs::create_dir_all(split_path.parent().unwrap())?;
        std::fs::copy(&index_path, &split_path.parent().unwrap().join("index.wasm"))?;
        
        generate_replay_wasm(&noopt_path, &generator.replay, false)?;
        generate_replay_wasm(&merge_path, &generator.replay, true)?;
        Optimiser::split_big_body(&mut generator.replay); // works only for wasm
        generate_replay_wasm(&split_path, &generator.replay, false)?;
        generate_replay_wasm(wasm_path, &generator.replay, true)?;
    } else {
        generate_replay_javascript(replay_path.unwrap(), &generator.replay)?;
    }

    Ok(())
}

fn bin_trace_to_string_representation(args: Vec<String>) -> io::Result<()> {
    let trace_path = Path::new(&args[2]);
    let wasm_path = Path::new(&args[3]);
    let string_trace_path = Path::new(&args[4]);
    let buffer = &fs::read(wasm_path).unwrap();
    let module = Module::from_buffer(buffer).unwrap();
    let trace: Trace<'_> = Trace::new(trace_path, &module, true);
    let output_file = File::create(string_trace_path).unwrap();
    let mut writer = BufWriter::new(output_file);
    trace.for_each(|e| {
        let e = e.unwrap();
        // dbg!(&e);
        writer.write_fmt(format_args!("{}", e)).unwrap();
    });
    writer.flush()
}

fn decode_event(
    reader: &mut BufReader<File>,
    module: &Module,
    binary: bool,
    lookup: &Vec<i32>,
) -> Result<Vec<WasmEvent>, ErrorKind> {
    if binary == true {
        WasmEvent::decode_bin(reader, module, lookup)
    } else {
        WasmEvent::decode_string(reader)
    }
}

struct Trace<'a> {
    reader: BufReader<File>,
    module: &'a Module,
    binary: bool,
    lookup: Vec<i32>,
    event_buffer: Vec<WasmEvent>,
}

impl<'a> Trace<'a> {
    fn new(path: &Path, module: &'a Module, binary: bool) -> Trace<'a> {
        let file = File::open(path).unwrap();
        let lookup = match fs::read_to_string(PathBuf::from(format!("{}.lookup", path.display()))) {
            Ok(l) => {
                if l.len() == 0 {
                    vec![]
                } else {
                    l.split("\n").map(|i| i.parse().unwrap()).collect()
                }
            }
            Err(_) => Vec::new(),
        };
        let reader = BufReader::new(file);
        Trace { reader, module, binary, lookup, event_buffer: Vec::new() }
    }
}

impl<'a> Iterator for Trace<'a> {
    type Item = Result<WasmEvent, ErrorKind>; // Replace `YourErrorType` with the actual error type

    fn next(&mut self) -> Option<Self::Item> {
        if self.event_buffer.len() > 0 {
            Some(Ok(self.event_buffer.remove(0)))
        } else {
            match decode_event(&mut self.reader, self.module, self.binary, &self.lookup) {
                Ok(events) => {
                    if events.len() > 0 {
                        self.event_buffer.extend(events);
                        Some(Ok(self.event_buffer.remove(0)))
                    } else {
                        None
                    }
                }
                Err(e) => Some(Err(e)),
            }
        }
    }
}

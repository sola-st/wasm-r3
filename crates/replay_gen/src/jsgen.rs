use std::{
    collections::{BTreeMap, HashMap},
    io::{Seek, SeekFrom},
};

use crate::{
    jsgen::js::generate_javascript,
    trace::{
        self, ExportCall, ImportCall, ImportFunc, ImportGlobal, ImportMemory, ImportTable, Trace,
        ValType, WasmEvent, F64,
    },
};

pub struct Generator {
    pub code: Replay,
    state: State,
}

pub struct Replay {
    func_imports: BTreeMap<i32, Function>,
    mem_imports: BTreeMap<i32, Memory>,
    table_imports: BTreeMap<i32, Table>,
    global_imports: BTreeMap<i32, Global>,
    calls: Vec<(String, Vec<F64>)>,
    initialization: Vec<Event>,
    modules: Vec<String>,
}

struct State {
    import_call_stack: Vec<i32>,
    last_func: i32,
    global_scope: bool,
    last_func_return: bool,
    import_call_stack_function: Vec<i32>,
}

#[derive(Clone)]
pub enum EventType {
    Call,
    TableCall,
    Store,
    MemGrow,
    TableSet,
    TableGrow,
    GlobalGet,
}

#[derive(Clone, Debug)]
pub struct Call {
    name: String,
    params: Vec<F64>,
}
#[derive(Clone, Debug)]
pub struct TableCall {
    table_name: String,
    funcidx: i32,
    params: Vec<F64>,
}
#[derive(Clone, Debug)]
pub struct Store {
    addr: i32,
    data: Vec<F64>,
    import: bool,
    name: String,
}
#[derive(Clone, Debug)]
pub struct MemGrow {
    amount: i32,
    import: bool,
    name: String,
}
#[derive(Clone, Debug)]
pub struct TableSet {
    idx: i32,
    func_import: bool,
    func_name: String,
    import: bool,
    name: String,
}
#[derive(Clone, Debug)]
pub struct TableGrow {
    idx: i32,
    amount: i32,
    import: bool,
    name: String,
}
#[derive(Clone, Debug)]
pub struct GlobalGet {
    value: F64,
    big_int: bool,
    import: bool,
    name: String,
}

#[derive(Clone, Debug)]
pub enum Event {
    Call(Call),
    TableCall(TableCall),
    Store(Store),
    MemGrow(MemGrow),
    TableSet(TableSet),
    TableGrow(TableGrow),
    GlobalGet(GlobalGet),
}

pub struct Import {
    module: String,
    name: String,
}

#[derive(Clone, Debug)]
pub struct WriteResult {
    results: Vec<F64>,
    reps: i32,
}

pub type Context = Vec<Event>;

#[derive(Clone, Debug)]
pub struct Function {
    pub module: String,
    pub name: String,
    bodys: Vec<Context>,
    results: Vec<WriteResult>,
}

pub struct Memory {
    pub module: String,
    pub name: String,
    pub initial: F64,
    pub maximum: Option<F64>,
}

pub struct Table {
    pub module: String,
    pub name: String,
    // enum is better
    pub element: String,
    pub initial: F64,
    pub maximum: Option<F64>,
}

pub struct Global {
    pub module: String,
    pub name: String,
    pub mutable: bool,
    pub initial: F64,
    pub value: ValType,
}

impl Generator {
    pub fn new() -> Self {
        let mut func_imports = BTreeMap::new();
        func_imports.insert(
            -1,
            Function {
                module: "wasm-r3".to_string(),
                name: "initialization".to_string(),
                bodys: vec![vec![]],
                results: vec![],
            },
        );
        Self {
            code: Replay {
                func_imports,
                mem_imports: BTreeMap::new(),
                table_imports: BTreeMap::new(),
                global_imports: BTreeMap::new(),
                calls: Vec::new(),
                initialization: Vec::new(),
                modules: Vec::new(),
            },
            state: State {
                import_call_stack: vec![-1],
                last_func: -1,  
                global_scope: true,
                last_func_return: false,
                import_call_stack_function: Vec::new(),
            },
        }
    }

    pub fn generate_replay(&mut self, trace: &Trace) -> &Replay {
        for event in trace.iter() { 
            self.consume_event(event);
        }
        &self.code
    }

    fn consume_event(&mut self, event: &WasmEvent) {
        match event {
            WasmEvent::ExportCall(ExportCall { name, params }) => {
                self.push_event(Event::Call(Call {
                    name: name.clone(),
                    params: params.clone(),
                }));
            }
            WasmEvent::TableCall(trace::TableCall {
                tablename,
                funcidx,
                params,
            }) => {
                self.push_event(Event::TableCall(TableCall {
                    table_name: tablename.clone(),
                    funcidx: *funcidx,
                    params: params.clone(),
                }));
            }
            WasmEvent::ExportReturn => {
                self.state.global_scope = true;
            }
            WasmEvent::ImportCall(ImportCall { idx, name }) => {
                self.state.global_scope = false;
                self.code
                    .func_imports
                    .get_mut(idx)
                    .unwrap()
                    .bodys
                    .push(vec![]);
                self.state.import_call_stack.push(*idx);
                self.state.last_func = *idx;
                let value = self.code.func_imports.get(&idx).unwrap().clone();
                self.state.import_call_stack_function.push(*idx);
                self.state.last_func_return = false;
            }
            WasmEvent::ImportReturn(trace::ImportReturn { idx, name, results }) => 'label: {
                let current_fn_idx = self.state.import_call_stack_function.last().unwrap();
                let r = &mut self
                    .code
                    .func_imports
                    .get_mut(&current_fn_idx)
                    .unwrap()
                    .results;
                if !r.is_empty() {
                    let tmp = r.last().unwrap();
                    if (!tmp.results.is_empty() && tmp.results[0] == results[0])
                        || (tmp.results.is_empty() && results.is_empty())
                    {
                        self.state.last_func_return = true;
                        r.last_mut().unwrap().reps += 1;
                        self.state.import_call_stack.pop();
                        self.state.import_call_stack_function.pop();
                        break 'label;
                    }
                }
                self.state.last_func_return = true;
                r.push(WriteResult {
                    results: results.clone(),
                    reps: 1,
                });
                self.state.import_call_stack.pop();
                self.state.import_call_stack_function.pop();
            }
            WasmEvent::Load(trace::Load {
                idx,
                name,
                offset,
                data,
            }) => {
                self.push_event(Event::Store(Store {
                    import: self.code.mem_imports.contains_key(&idx),
                    name: name.clone(),
                    addr: *offset,
                    data: data.clone(),
                }));
            }
            WasmEvent::MemGrow(trace::MemGrow { idx, name, amount }) => {
                self.push_event(Event::MemGrow(MemGrow {
                    import: self.code.mem_imports.contains_key(idx),
                    name: name.clone(),
                    amount: *amount,
                }));
            }
            WasmEvent::TableGet(trace::TableGet {
                tableidx,
                name,
                idx,
                funcidx,
                funcname,
            }) => {
                self.push_event(Event::TableSet(TableSet {
                    import: self.code.table_imports.contains_key(&tableidx),
                    name: name.clone(),
                    idx: *idx,
                    func_import: self.code.func_imports.contains_key(funcidx),
                    func_name: funcname.clone(),
                }));
            }
            WasmEvent::TableGrow(trace::TableGrow { idx, name, amount }) => {
                self.push_event(Event::TableGrow(TableGrow {
                    import: self.code.table_imports.contains_key(idx),
                    name: name.clone(),
                    idx: *idx,
                    amount: *amount,
                }));
            }
            WasmEvent::ImportMemory(ImportMemory {
                idx,
                module,
                name,
                initial,
                maximum,
            }) => {
                self.add_module(module);
                self.code.mem_imports.insert(
                    *idx,
                    Memory {
                        module: module.clone(),
                        name: name.clone(),
                        initial: *initial,
                        maximum: *maximum,
                    },
                );
            }
            WasmEvent::GlobalGet(trace::GlobalGet {
                idx,
                name,
                value,
                valtype,
            }) => {
                self.push_event(Event::GlobalGet(GlobalGet {
                    import: self.code.global_imports.contains_key(&idx),
                    name: name.clone(),
                    value: *value,
                    big_int: *valtype == ValType::I64,
                }));
            }
            WasmEvent::ImportTable(ImportTable {
                idx,
                module,
                name,
                initial,
                maximum,
                element,
            }) => {
                self.add_module(module);
                self.code.table_imports.insert(
                    *idx,
                    Table {
                        module: module.clone(),
                        name: name.clone(),
                        initial: initial.clone(),
                        maximum: maximum.clone(),
                        element: element.clone(),
                    },
                );
            }
            WasmEvent::ImportGlobal(ImportGlobal {
                idx,
                module,
                name,
                mutable,
                initial,
                value,
            }) => {
                self.add_module(module);
                self.code.global_imports.insert(
                    *idx,
                    Global {
                        module: module.clone(),
                        name: name.clone(),
                        value: value.clone(),
                        initial: initial.clone(),
                        mutable: *mutable,
                    },
                );
            }
            WasmEvent::ImportFunc(ImportFunc { idx, module, name }) => {
                self.add_module(module);
                self.code.func_imports.insert(
                    *idx,
                    Function {
                        module: module.clone(),
                        name: name.clone(),
                        bodys: vec![],
                        results: vec![],
                    },
                );
            }
            WasmEvent::FuncEntry(_) | WasmEvent::FuncReturn(_) => (),
        }
    }
    fn push_event(&mut self, event: Event) {
        match event {
            Event::Call(_) | Event::TableCall(_) => {
                let idx = self.state.import_call_stack.last().unwrap();
                if *idx == -1 {
                    self.code.initialization.push(event.clone());
                }
                let current_context = self
                    .code
                    .func_imports
                    .get_mut(idx)
                    .unwrap()
                    .bodys
                    .last_mut()
                    .unwrap();
                current_context.push(event.clone());
                return;
            }
            _ => {
                let idx = self.state.import_call_stack.last().unwrap();
                let current_context = if self.state.global_scope {
                    &mut self.code.initialization
                } else {
                    self.code
                        .func_imports
                        .get_mut(idx)
                        .unwrap()
                        .bodys
                        .last_mut()
                        .unwrap()
                };
                match current_context.last() {
                    Some(Event::Call(_)) | Some(Event::TableCall(_)) => {
                        if !self.state.last_func_return {
                            current_context.insert(current_context.len() - 1, event);
                        } else {
                            let idx = self.state.last_func;
                            let current_context = self
                                .code
                                .func_imports
                                .get_mut(&idx)
                                .unwrap()
                                .bodys
                                .last_mut()
                                .unwrap();
                            current_context.push(event.clone());
                        }
                    }
                    _ => {
                        current_context.push(event.clone());
                    }
                }
            }
        }
    }
    fn add_module(&mut self, module: &String) {
        if !self.code.modules.contains(module) {
            self.code.modules.push(module.clone());
        }
    }
}

pub mod js {
    use std::fs::File;
    use std::io::Write;

    use crate::trace::F64;

    use super::Context;
    use super::Event;
    use super::Replay;
    use super::WriteResult;

    pub fn generate_javascript(stream: &mut File, code: &Replay) -> std::io::Result<()> {
        write(stream, "import fs from 'fs'\n")?;
        write(stream, "import path from 'path'\n")?;
        write(stream, "let instance\n")?;
        write(stream, "let imports = {}\n")?;

        // Init modules
        for module in &code.modules {
            write(stream, &format!("{}\n", write_module(module)))?;
        }
        // Init memories
        for (i, mem) in &code.mem_imports {
            write(
                stream,
                &format!(
                    "const {} = new WebAssembly.Memory({{ initial: {}, maximum: {} }})\n",
                    mem.name,
                    mem.initial,
                    match mem.maximum {
                        Some(max) => max.to_string(),
                        None => "undefined".to_string(),
                    }
                ),
            )?;
            write(
                stream,
                &format!("{}{}\n", write_import(&mem.module, &mem.name), mem.name),
            )?;
        }
        // Init globals
        for (i, global) in &code.global_imports {
            if global.initial.0.is_nan() || !global.initial.0.is_finite() {
                if global.name.to_lowercase() == "infinity" {
                    write(
                        stream,
                        &format!("{}Infinity\n", write_import(&global.module, &global.name)),
                    )?;
                } else if global.name.to_lowercase() == "nan" {
                    write(
                        stream,
                        &format!("{}NaN\n", write_import(&global.module, &global.name)),
                    )?;
                } else {
                    panic!("Could not generate javascript code for the global initialisation, the initial value is NaN. The website you where recording did some weired stuff that I was not considering during the implementation of Wasm-R3. Tried to genereate global:");
                }
            } else {
                write(
                    stream,
                    &format!(
                        "const {} = new WebAssembly.Global({{ value: '{:?}', mutable: {}}}, {})\n",
                        global.name, global.value, global.mutable, global.initial
                    ),
                )?;
                write(
                    stream,
                    &format!(
                        "{}{}\n",
                        write_import(&global.module, &global.name),
                        global.name
                    ),
                )?;
            }
        }
        // Init tables
        for (i, table) in &code.table_imports {
            write(stream, &format!("const {} = new WebAssembly.Table({{ initial: {}, maximum: {}, element: '{}'}})\n", table.name, table.initial, match table.maximum {
                Some(max) => max.to_string(),
                None => "undefined".to_string(),
            }, table.element))?;
            write(
                stream,
                &format!(
                    "{}{}\n",
                    write_import(&table.module, &table.name),
                    table.name
                ),
            )?;
        }
        // Imported functions
        for (funcidx, func) in &code.func_imports {
            // FIXME: this is a hack to avoid the initialization function
            if *funcidx == -1 {
                continue;
            }
            write(
                stream,
                &format!("let {} = -1\n", write_func_global(funcidx)),
            )?;
            write(
                stream,
                &format!("{}() => {{\n", write_import(&func.module, &func.name)),
            )?;
            write(stream, &format!("{}++\n", write_func_global(funcidx)))?;
            if !func.bodys.is_empty() {
                write(
                    stream,
                    &format!("switch ({}) {{\n", write_func_global(funcidx)),
                )?;
                for (i, body) in func.bodys.iter().enumerate() {
                    write_body(stream, body, i)?;
                }
                write(stream, "}\n")?;
            }
            write_results(stream, &func.results, &write_func_global(funcidx))?;
            write(stream, "}\n")?;
        }
        write(stream, "export function replay(wasm) {")?;
        write(stream, "instance = wasm.instance\n")?;
        for (name, params) in &code.calls {
            write(
                stream,
                &format!(
                    "instance.exports.${}(${}) \n",
                    name,
                    write_params_string(params)
                ),
            )?;
        }
        for event in &code.initialization {
            match event {
                Event::Call(event) => write!(stream, "{}", call_event(event))?,
                Event::TableCall(event) => write!(stream, "{}", table_call_event(event))?,
                Event::Store(event) => write!(stream, "{}", store_event(event))?,
                Event::MemGrow(event) => write!(stream, "{}", mem_grow_event(event))?,
                Event::TableSet(event) => write!(stream, "{}", table_set_event(event))?,
                Event::TableGrow(event) => write!(stream, "{}", table_grow_event(event))?,
                Event::GlobalGet(event) => write!(stream, "{}", global_get(event))?,
            }
        }
        write(stream, "}\n")?;
        write(stream, "export function instantiate(wasmBinary) {\n")?;
        write(
            stream,
            "return WebAssembly.instantiate(wasmBinary, imports)\n",
        )?;
        write(stream, "}\n")?;
        write(stream, "if (process.argv[2] === 'run') {\n")?;
        write(stream, "const p = path.join(path.dirname(import.meta.url).replace(/^file:/, ''), 'index.wasm')\n")?;
        write(stream, "const wasmBinary = fs.readFileSync(p)\n")?;
        write(
            stream,
            "instantiate(wasmBinary).then((wasm) => replay(wasm))\n",
        )?;
        write(stream, "}\n")?;
        Ok(())
    }

    fn write_body(stream: &mut File, b: &Context, i: usize) -> std::io::Result<()> {
        if !b.is_empty() {
            writeln!(stream, "case {}:", i)?;
            for event in b {
                match event {
                    Event::Call(event) => write!(stream, "{}", call_event(event))?,
                    Event::TableCall(event) => write!(stream, "{}", table_call_event(event))?,
                    Event::Store(event) => write!(stream, "{}", store_event(event))?,
                    Event::MemGrow(event) => write!(stream, "{}", mem_grow_event(event))?,
                    Event::TableSet(event) => write!(stream, "{}", table_set_event(event))?,
                    Event::TableGrow(event) => write!(stream, "{}", table_grow_event(event))?,
                    Event::GlobalGet(event) => write!(stream, "{}", global_get(event))?,
                }
            }
            writeln!(stream, "break")?;
        }
        Ok(())
    }

    fn write_results(
        stream: &mut File,
        results: &[WriteResult],
        func_global: &str,
    ) -> std::io::Result<()> {
        let mut current = 0;
        for r in results {
            let new_c = current + r.reps;
            writeln!(
                stream,
                "if (({} >= {}) && {} < {}) {{",
                func_global, current, func_global, new_c
            )?;
            let res = match r.results.get(0) {
                Some(r) => r.to_string(),
                None => "undefined".to_string(),
            };
            writeln!(stream, "return {} }}", res)?;
            current = new_c;
        }
        Ok(())
    }

    fn write(stream: &mut File, s: &str) -> std::io::Result<()> {
        if stream.write_all(s.as_bytes()).is_err() {
            // In Rust, we don't have an equivalent to Node.js's 'drain' event.
            // We'll just flush the stream instead.
            stream.flush()?;
        }
        Ok(())
    }

    fn store_event(event: &super::Store) -> String {
        let mut js_string = String::new();
        for (j, byte) in event.data.iter().enumerate() {
            if event.import {
                js_string += &format!(
                    "new Uint8Array({}.buffer)[{}] = {}\n",
                    event.name,
                    event.addr + j as i32,
                    byte
                );
            } else {
                js_string += &format!(
                    "new Uint8Array(instance.exports.{}.buffer)[{}] = {}\n",
                    event.name,
                    event.addr + j as i32,
                    byte
                );
            }
        }
        js_string
    }

    fn call_event(event: &super::Call) -> String {
        format!(
            "instance.exports.{}({})\n",
            event.name,
            write_params_string(&event.params)
        )
    }

    fn table_call_event(event: &super::TableCall) -> String {
        format!(
            "instance.exports.{}.get({})({})\n",
            event.table_name,
            event.funcidx,
            write_params_string(&event.params)
        )
    }

    fn mem_grow_event(event: &super::MemGrow) -> String {
        if event.import {
            format!("{}.grow({})\n", event.name, event.amount)
        } else {
            format!("instance.exports.{}.grow({})\n", event.name, event.amount)
        }
    }

    fn table_set_event(event: &super::TableSet) -> String {
        let mut js_string = if event.import {
            format!("{}.set({}, ", event.name, event.idx)
        } else {
            format!("instance.exports.{}.set({}, ", event.name, event.idx)
        };
        if event.func_import {
            js_string.push_str(&event.func_name);
        } else {
            js_string.push_str(&format!("instance.exports.{}", event.func_name));
        }
        js_string.push_str(")\n");
        js_string
    }

    fn table_grow_event(event: &super::TableGrow) -> String {
        if event.import {
            format!("{}.grow({})\n", event.name, event.amount)
        } else {
            format!("instance.exports.{}.grow({})\n", event.name, event.amount)
        }
    }

    fn global_get(event: &super::GlobalGet) -> String {
        if event.import {
            format!("{}.value = {}\n", event.name, event.value)
        } else {
            format!(
                "instance.exports.{}.value = {}\n",
                event.name,
                if event.big_int {
                    format!("BigInt({})", event.value)
                } else {
                    event.value.to_string()
                }
            )
        }
    }

    fn write_func_global(funcidx: &i32) -> String {
        format!("global_{}", funcidx.to_string())
    }

    fn write_module(module: &str) -> String {
        format!("imports['{}'] = {{}}", module)
    }

    fn write_import(module: &str, name: &str) -> String {
        format!("imports['{}']['{}'] = ", module, name)
    }

    fn write_params_string(params: &[F64]) -> String {
        params
            .iter()
            .map(|p| p.to_string())
            .collect::<Vec<String>>()
            .join(",")
    }
}

// TODO: factor out with test_encode_decode
#[test]
fn test_generate_javascript() -> std::io::Result<()> {
    use super::*;
    use std::fs;
    use std::io;
    use std::io::BufRead;
    use std::io::Read;
    use std::path::Path;
    use tempfile::tempfile;

    fn visit_dirs(dir: &Path) -> io::Result<()> {
        if dir.is_dir() {
            for entry in fs::read_dir(dir)? {
                let entry = entry?;
                let path = entry.path();
                if path.is_dir() {
                    visit_dirs(&path)?;
                } else {
                    if path.file_name().and_then(|s| s.to_str()) == Some("trace.r3") // node format
                        || path.file_name().and_then(|s| s.to_str()) == Some("trace-ref.r3") // web format
                    {
                        if path.display().to_string().contains("kittygame") || // floating point precision
                            path.display().to_string().contains("pathfinding") // slow
                        {
                            println!("skipping problematic case {}", path.display());
                            continue;
                        }
                        println! ("Testing {}", path.display());
                        // Read replay.js file
                        let replay_path = path.with_file_name("replay.js");
                        let replay_file = fs::File::open(replay_path.clone())?;
                        let mut reader = io::BufReader::new(replay_file);
                        let mut old_js = String::new();
                        reader.read_to_string(&mut old_js)?;

                        let trace_file = fs::File::open(&path)?;
                        let reader = io::BufReader::new(trace_file);
                        let mut trace = trace::Trace::new();
                        for line in reader.lines() {
                            let line = line?;
                            let event = line.parse()?;
                            trace.push(event);
                        }
                        println!("trace read complete");
                        let mut generator = Generator::new();
                        generator.generate_replay(&trace);
                        println!("generate_replay complete");
                        let mut temp_file = tempfile()?;
                        generate_javascript(&mut temp_file, &generator.code)?;
                        println!("generate_javascript complete");
                        temp_file.seek(SeekFrom::Start(0))?;

                        let mut reader = io::BufReader::new(temp_file);
                        let mut new_js = String::new();
                        reader.read_to_string(&mut new_js)?;
                        assert!(
                            old_js == new_js,
                            "Generated JS does not match for {}, original js: {}",
                            path.display(),
                            replay_path.display()
                        );
                    }
                }
            }
        }
        Ok(())
    }
    visit_dirs(Path::new("../../tests"))?;
    Ok(())
}

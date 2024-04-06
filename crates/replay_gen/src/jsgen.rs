use std::io::Write;
use std::{fs::File, path::Path};

use crate::irgen::{HostEvent, Import, INIT_INDEX};
use crate::trace::ValType;
use crate::{
    irgen::{Context, Replay, WriteResult},
    trace::F64,
    write,
};

pub fn generate_replay_javascript(out_path: &Path, code: &Replay) -> std::io::Result<()> {
    let mut file = File::create(&out_path)?;
    let stream = &mut file;
    write(stream, "import fs from 'fs'\n")?;
    write(stream, "import path from 'path'\n")?;
    write(stream, "let instance\n")?;
    write(stream, "let imports = {}\n")?;

    // Init modules
    for module in &code.imported_modules() {
        write(stream, &format!("{}\n", write_module(module)))?;
    }
    // Init memories
    for (_i, mem) in &code.imported_mems() {
        let Import { module, name } = mem.import.clone().unwrap();
        write(
            stream,
            &format!(
                "const {name} = new WebAssembly.Memory({{ initial: {}, maximum: {} }})\n",
                mem.initial,
                match mem.maximum {
                    Some(max) => max.to_string(),
                    None => "undefined".to_string(),
                }
            ),
        )?;
        write(stream, &format!("{}{name}\n", write_import(&module, &name)))?;
    }
    // Init globals
    for (_i, global) in &code.imported_globals() {
        let Import { module, name } = global.import.clone().unwrap();
        if global.initial.0.is_nan() || !global.initial.0.is_finite() {
            if name.to_lowercase() == "infinity" {
                write(stream, &format!("{}Infinity\n", write_import(&module, &name)))?;
            } else if name.to_lowercase() == "nan" {
                write(stream, &format!("{}NaN\n", write_import(&module, &name)))?;
            } else {
                panic!("Could not generate javascript code for the global initialisation, the initial value is NaN. The website you where recording did some weired stuff that I was not considering during the implementation of Wasm-R3. Tried to genereate global:");
            }
        } else {
            write(
                stream,
                &format!(
                    "const {name} = new WebAssembly.Global({{ value: '{}', mutable: {}}}, {})\n",
                    global.valtype, global.mutable, global.initial
                ),
            )?;
            write(stream, &format!("{}{name}\n", write_import(&module, &name)))?;
        }
    }
    // Init tables
    for (_i, table) in &code.imported_tables() {
        let Import { module, name } = table.import.clone().unwrap();
        write(
            stream,
            &format!(
                "const {name} = new WebAssembly.Table({{ initial: {}, maximum: {}, element: '{}'}})\n",
                table.initial,
                match table.maximum {
                    Some(max) => max.to_string(),
                    None => "undefined".to_string(),
                },
                table.reftype
            ),
        )?;
        write(stream, &format!("{}{name}\n", write_import(&module, &name),))?;
    }
    // Imported functions
    for (funcidx, func) in &code.imported_funcs() {
        let Import { module, name } = func.import.clone().unwrap();
        // TODO: better handling of initialization
        if *funcidx == INIT_INDEX {
            continue;
        }
        write(stream, &format!("let {} = 0\n", write_func_global(funcidx)))?;
        write(stream, &format!("{}() => {{\n", write_import(&module, &name)))?;
        if !func.bodys.is_empty() {
            write(stream, &format!("switch ({}) {{\n", write_func_global(funcidx)))?;
            for (i, body) in func.bodys.iter().enumerate() {
                if let Some(body) = body {
                    write_body(stream, body, i)?
                }
            }
            write(stream, "}\n")?;
        }
        write(stream, &format!("{}++\n", write_func_global(funcidx)))?;
        write_results(stream, &func.results, &write_func_global(funcidx))?;
        write(stream, "}\n")?;
    }
    write(stream, "export function replay(wasm) {")?;
    write(stream, "instance = wasm.instance\n")?;
    let initialization = code.funcs.get(&INIT_INDEX).unwrap().bodys.last().unwrap();
    if let Some(initialization) = initialization {
        for event in initialization {
            let str = hostevent_to_js(&event);
            writeln!(stream, "{}", str)?;
        }
    }
    write(stream, "}\n")?;

    write(stream, "export function instantiate(wasmBinary) {\n")?;
    write(stream, "return WebAssembly.instantiate(wasmBinary, imports)\n")?;
    write(stream, "}\n")?;
    write(stream, "let firstArg\n")?;
    write(
        stream,
        "if (typeof Deno === 'undefined'){firstArg=process.argv[2]}else{firstArg=Deno.args[0]}\n",
    )?;
    write(stream, "if (firstArg === 'run') {\n")?;
    write(stream, "let nodeModules;\n")?;
    write(stream, "if (typeof Deno === 'undefined') { nodeModules = Promise.all([import('path'),import('fs')])}else{nodeModules=Promise.all([import('node:path'),import('node:fs')])}\n")?;
    write(stream, "nodeModules.then(([path,fs])=>{")?;
    write(
        stream,
        "const p = path.join(path.dirname(import.meta.url).replace(/^file:/, ''), 'index.wasm')\n",
    )?;
    write(stream, "const wasmBinary = fs.readFileSync(p)\n")?;
    write(stream, "instantiate(wasmBinary).then((wasm) => replay(wasm))\n")?;
    write(stream, "})}\n")?;
    Ok(())
}

fn write_module(module: &str) -> String {
    format!("imports['{}'] = {{}}", module)
}

fn write_func_global(funcidx: &usize) -> String {
    format!("global_{}", funcidx.to_string())
}

fn write_import(module: &str, name: &str) -> String {
    format!("imports['{}']['{}'] = ", module, name)
}

fn write_results(stream: &mut File, results: &[WriteResult], func_global: &str) -> std::io::Result<()> {
    let mut current = 0;
    for r in results {
        let new_c = current + r.reps;
        writeln!(
            stream,
            "if (({} >= {}) && {} < {}) {{",
            func_global,
            current + 1,
            func_global,
            new_c + 1
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

fn write_body(stream: &mut File, b: &Context, i: usize) -> std::io::Result<()> {
    if !b.is_empty() {
        writeln!(stream, "case {}:", i)?;
        for event in b {
            let str = hostevent_to_js(event);
            writeln!(stream, "{}", str)?;
        }
        writeln!(stream, "break")?;
    }
    Ok(())
}

fn hostevent_to_js(event: &HostEvent) -> String {
    fn write_params_string(params: &[F64]) -> String {
        params.iter().map(|p| p.to_string()).collect::<Vec<String>>().join(",")
    }
    let str = match event {
        HostEvent::ExportCall { idx: _, name, params } => {
            format!("instance.exports.{}({})\n", name, write_params_string(&params))
        }
        HostEvent::ExportCallTable { idx: _, table_name, funcidx, params } => {
            format!(
                "instance.exports.{}.get({})({})\n",
                table_name,
                funcidx,
                write_params_string(&params)
            )
        }
        HostEvent::MutateMemory { addr, data, import, name } => {
            let mut js_string = String::new();
            for (j, byte) in data.iter().enumerate() {
                if *import {
                    js_string += &format!("new Uint8Array({}.buffer)[{}] = {}\n", name, addr + j as i32, byte);
                } else {
                    js_string += &format!(
                        "new Uint8Array(instance.exports.{}.buffer)[{}] = {}\n",
                        name,
                        addr + j as i32,
                        byte
                    );
                }
            }
            js_string
        }
        HostEvent::GrowMemory { amount, import, name } => {
            if *import {
                format!("{}.grow({})\n", name, amount)
            } else {
                format!("instance.exports.{}.grow({})\n", name, amount)
            }
        }
        HostEvent::MutateTable {
            tableidx: _,
            funcidx: _,
            idx,
            func_import,
            func_name,
            import,
            name,
        } => {
            let mut js_string = if *import {
                format!("{}.set({}, ", name, idx)
            } else {
                format!("instance.exports.{}.set({}, ", name, idx)
            };
            if *func_import {
                js_string.push_str(&func_name);
            } else {
                js_string.push_str(&format!("instance.exports.{}", func_name));
            }
            js_string.push_str(")\n");
            js_string
        }
        HostEvent::GrowTable { idx: _, amount, import, name } => {
            if *import {
                format!("{}.grow({})\n", name, amount)
            } else {
                format!("instance.exports.{}.grow({})\n", name, amount)
            }
        }
        HostEvent::MutateGlobal { idx: _, value, valtype, import, name } => {
            if *import {
                format!("{}.value = {}\n", name, value)
            } else {
                format!(
                    "instance.exports.{}.value = {}\n",
                    name,
                    if *valtype == ValType::I64 {
                        format!("BigInt({})", value)
                    } else {
                        value.to_string()
                    }
                )
            }
        }
    };
    str
}

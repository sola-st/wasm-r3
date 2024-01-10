use std::io::Write;
use std::{fs::File, path::Path};

use crate::irgen::HostEvent;
use crate::trace::ValType;
use crate::{
    irgen::{Context, Replay, WriteResult},
    trace::F64,
};

pub fn generate_javascript(out_path: &Path, code: &Replay) -> std::io::Result<()> {
    let mut file = File::create(&out_path)?;
    let stream = &mut file;
    write(stream, "import fs from 'fs'\n")?;
    write(stream, "import path from 'path'\n")?;
    write(stream, "let instance\n")?;
    write(stream, "let imports = {}\n")?;

    // Init modules
    for module in &code.modules {
        write(stream, &format!("{}\n", write_module(module)))?;
    }
    // Init memories
    for (_i, mem) in &code.mem_imports {
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
    for (_i, global) in &code.global_imports {
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
    for (_i, table) in &code.table_imports {
        write(
            stream,
            &format!(
                "const {} = new WebAssembly.Table({{ initial: {}, maximum: {}, element: '{}'}})\n",
                table.name,
                table.initial,
                match table.maximum {
                    Some(max) => max.to_string(),
                    None => "undefined".to_string(),
                },
                table.element
            ),
        )?;
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
        // TODO: better handling of initialization
        if *funcidx == -1 {
            continue;
        }
        write(stream, &format!("let {} = 0\n", write_func_global(funcidx)))?;
        write(
            stream,
            &format!("{}() => {{\n", write_import(&func.module, &func.name)),
        )?;
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
        write(stream, &format!("{}++\n", write_func_global(funcidx)))?;
        write_results(stream, &func.results, &write_func_global(funcidx))?;
        write(stream, "}\n")?;
    }
    write(stream, "export function replay(wasm) {")?;
    write(stream, "instance = wasm.instance\n")?;
    let initialization = code.func_imports.get(&-1).unwrap().bodys.last().unwrap();
    for event in initialization {
        let str = hostevent_to_js(event);
        writeln!(stream, "{}", str)?;
    }
    write(stream, "}\n")?;
    write(stream, "export function instantiate(wasmBinary) {\n")?;
    write(
        stream,
        "return WebAssembly.instantiate(wasmBinary, imports)\n",
    )?;
    write(stream, "}\n")?;
    write(stream, "if (process.argv[2] === 'run') {\n")?;
    write(
        stream,
        "const p = path.join(path.dirname(import.meta.url).replace(/^file:/, ''), 'index.wasm')\n",
    )?;
    write(stream, "const wasmBinary = fs.readFileSync(p)\n")?;
    write(
        stream,
        "instantiate(wasmBinary).then((wasm) => replay(wasm))\n",
    )?;
    write(stream, "}\n")?;
    Ok(())
}

fn valty_to_const(valty: &ValType) -> String {
    match valty {
        ValType::I32 => "i32.const",
        ValType::I64 => "i64.const",
        ValType::F32 => "f32.const",
        ValType::F64 => "f64.const",
        ValType::V128 => todo!(),
        ValType::Anyref => todo!(),
        ValType::Externref => todo!(),
    }
    .to_string()
}

pub fn generate_standalone(wasm_path: &Path, code: &Replay) -> std::io::Result<()> {
    let orig_wat = wasmprinter::print_file(wasm_path).unwrap();
    let orig_wat = orig_wat.split('\n').collect::<Vec<_>>();
    let mut iter = orig_wat.iter().peekable();

    let canned = wasm_path.parent().unwrap().join("canned.wat");
    let mut file = File::create(&canned).unwrap();
    let stream = &mut file;
    while let Some(line) = iter.next() {
        if line.trim_start().starts_with("(import") {
            let import_type = if line.contains("(func") {
                "(func"
            } else if line.contains("(memory") {
                "(memory"
            } else if line.contains("(global") {
                "(global"
            } else if line.contains("(table") {
                "(table"
            } else {
                unreachable!("Unknown import: {}", line);
            };
            let start = line.find(import_type).unwrap_or(0);
            let end = line.rfind(")").unwrap_or_else(|| line.len());

            if import_type == "(func" {
                let start_idx = line.find("(;").unwrap_or(0) + 2;
                let end_idx = line.find(";)").unwrap_or_else(|| line.len());
                let funcidx: i32 = line[start_idx..end_idx].parse().unwrap();
                let global_idx = format!("$global_{}", funcidx.to_string());
                write(stream, &(line[start..=end - 2].to_string() + "\n"))?;
                let func = code.func_imports.get(&funcidx).unwrap();
                for (i, body) in func.bodys.iter().enumerate() {
                    let mut bodystr = String::new();
                    let _body = for event in body {
                        bodystr += &hostevent_to_wat(event, code)
                    };
                    write(
                        stream,
                        &format!("(i64.eq (global.get {global_idx}) (i64.const {i}))\n"),
                    )?;
                    write(stream, &format!("(if(then {bodystr}))\n"))?;
                }
                write(
                    stream,
                    &format!(
                        "(global.get {global_idx}) (i64.const 1) (i64.add) (global.set {global_idx})\n"
                    ),
                )?;
                let mut current = 0;
                for r in func.results.iter() {
                    let ty = code.func_idx_to_ty.get(&(funcidx as usize)).unwrap();
                    let _param_tys = ty.params.clone();
                    let new_c = current + r.reps;
                    let res = match r.results.get(0) {
                        Some(v) => format!(
                            "(return ({} {v}))",
                            valty_to_const(ty.results.get(0).unwrap())
                        ),
                        None => "(return)".to_owned(),
                    };
                    write(
                        stream,
                        &format!(
                            " (if
                                (i32.and
                                  (i64.ge_s (global.get {global_idx}) (i64.const {current}))
                                  (i64.lt_s (global.get {global_idx}) (i64.const {new_c}))
                                )
                                (then
                                    {res}
                                )
                              )"
                        ),
                    )?;
                    current = new_c;
                }
                let ty = code.func_idx_to_ty.get(&(funcidx as usize)).unwrap();
                let _param_tys = ty.params.clone();
                let default_return = match ty.results.get(0) {
                    Some(v) => match v {
                        ValType::I32 => "(i32.const 0)",
                        ValType::I64 => "(i64.const 0)",
                        ValType::F32 => "(f32.const 0)",
                        ValType::F64 => "(f64.const 0)",
                        ValType::V128 => todo!(),
                        ValType::Anyref => todo!(),
                        ValType::Externref => todo!(),
                    },
                    None => "",
                };
                write(stream, &format!("(return {})", default_return))?;
                write(stream, ")\n")?;
            } else if import_type == "(global" {
                let valtype = if line.contains("i32") {
                    "i32"
                } else if line.contains("i64") {
                    "i64"
                } else if line.contains("f32") {
                    "f32"
                } else if line.contains("f64") {
                    "f64"
                } else {
                    unreachable!("Unknown global type: {}", line);
                };
                let replaced = if !line.contains("mut") {
                    line.replace(
                        &format!("{valtype}"),
                        &format!("{valtype} ({valtype}.const 0)"),
                    )
                } else {
                    line.replace(
                        &format!("(mut {valtype})"),
                        &format!("(mut {valtype}) ({valtype}.const 0)"),
                    )
                };
                write(stream, &&(replaced[start..replaced.len() - 1]))?;
            } else {
                write(stream, &(line[start..=end - 1].to_string() + "\n"))?;
            }
            // handle the following
            // error: initializer expression can only reference an imported global
        } else if (line.trim_start().starts_with("(global")
            || line.trim_start().starts_with("(elem"))
            && line.contains("global.get")
        {
            let parts: Vec<&str> = line.split("global.get").collect();
            let first_part = parts[0];
            let remaining_parts: Vec<&str> = parts[1].trim().split(')').collect();
            let third_part = remaining_parts[0].trim();
            let fourth_part = remaining_parts[1].trim();

            let global = code
                .global_imports
                .get(&third_part.parse::<usize>().unwrap())
                .unwrap();

            // TODO: make this more elegant
            let hack_for_diff_format = if line.trim_start().starts_with("(elem") {
                ""
            } else {
                "("
            };

            let to_write = first_part.to_string()
                + &format!(
                    "{}{} {:?}){})",
                    hack_for_diff_format,
                    &valty_to_const(&global.value),
                    &global.initial,
                    fourth_part
                );
            write(stream, &to_write)?;
            write(stream, "\n")?;
        }
        // handle error: duplicate export "main"
        else if line.contains("export \"main\"") {
            continue;
        }
        // _start function
        else if iter.peek().is_none() {
            for (i, _f) in &code.func_imports {
                if *i == -1 {
                    continue;
                }
                let global_idx = format!("$global_{}", i.to_string());
                write(
                    stream,
                    &format!("(global {global_idx} (mut i64) (i64.const 0))\n"),
                )?;
            }
            write(stream, "(func (export \"_start\") (export \"main\")\n")?;
            let initialization = code.func_imports.get(&-1).unwrap().bodys.last().unwrap();
            for event in initialization {
                write(stream, &format!("{}", hostevent_to_wat(event, code)))?
            }
            write(stream, "(return)\n)")?;
            write(stream, line)?;
        } else {
            write(stream, line)?;
            write(stream, "\n")?;
        }
    }
    let binary = wat::parse_file(canned.clone()).unwrap();
    let canned_wasm = wasm_path.parent().unwrap().join("canned.wasm");
    let mut file = File::create(&canned_wasm).unwrap();
    file.write_all(&binary).unwrap();

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
        params
            .iter()
            .map(|p| p.to_string())
            .collect::<Vec<String>>()
            .join(",")
    }
    let str = match event {
        HostEvent::ExportCall {
            idx: _,
            name,
            params,
        } => {
            format!(
                "instance.exports.{}({})\n",
                name,
                write_params_string(&params)
            )
        }
        HostEvent::ExportCallTable {
            idx: _,
            table_name,
            funcidx,
            params,
        } => {
            format!(
                "instance.exports.{}.get({})({})\n",
                table_name,
                funcidx,
                write_params_string(&params)
            )
        }
        HostEvent::MutateMemory {
            addr,
            data,
            import,
            name,
        } => {
            let mut js_string = String::new();
            for (j, byte) in data.iter().enumerate() {
                if *import {
                    js_string += &format!(
                        "new Uint8Array({}.buffer)[{}] = {}\n",
                        name,
                        addr + j as i32,
                        byte
                    );
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
        HostEvent::GrowMemory {
            amount,
            import,
            name,
        } => {
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
        HostEvent::GrowTable {
            idx: _,
            amount,
            import,
            name,
        } => {
            if *import {
                format!("{}.grow({})\n", name, amount)
            } else {
                format!("instance.exports.{}.grow({})\n", name, amount)
            }
        }
        HostEvent::MutateGlobal {
            idx: _,
            value,
            valtype,
            import,
            name,
        } => {
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

fn hostevent_to_wat(event: &HostEvent, code: &Replay) -> String {
    let str = match event {
        HostEvent::ExportCall {
            idx,
            name: _,
            params,
        } => {
            let ty = code.func_idx_to_ty.get(&(*idx as usize)).unwrap();
            let param_tys = ty.params.clone();
            let result_count = ty.results.len();
            let idx = idx;
            let params = params
                .iter()
                .zip(param_tys.clone())
                .map(|(p, p_ty)| format!("({} {p})", valty_to_const(&p_ty)))
                .collect::<Vec<String>>()
                .join("\n");
            params + &format!("(call {idx})") + &("(drop)".repeat(result_count))
        }
        HostEvent::ExportCallTable {
            idx,
            table_name: _,
            funcidx: _,
            params,
        } => {
            let ty = code.func_idx_to_ty.get(&(*idx as usize)).unwrap();
            let param_tys = ty.params.clone();
            let result_count = ty.results.len();
            let idx = idx;
            let params = params
                .iter()
                .zip(param_tys.clone())
                .map(|(p, p_ty)| format!("({} {p})", valty_to_const(&p_ty)))
                .collect::<Vec<String>>()
                .join("\n");
            params + &format!("(call {idx})",) + &("(drop)".repeat(result_count))
        }
        HostEvent::MutateMemory {
            addr,
            data,
            import: _,
            name: _,
        } => {
            let mut js_string = String::new();
            for (j, byte) in data.iter().enumerate() {
                js_string += &format!("i32.const {}\n", addr + j as i32);
                js_string += &format!("i32.const {}\n", byte);
                js_string += &format!("i32.store\n",);
            }
            js_string
        }
        HostEvent::GrowMemory {
            amount,
            import: _,
            name: _,
        } => {
            format!("(memory.grow (i32.const {})) (drop)\n", amount)
        }
        HostEvent::MutateTable {
            tableidx,
            funcidx,
            idx,
            func_import: _,
            func_name: _,
            import: _,
            name: _,
        } => {
            format!(
                "(table.set {} (i32.const {}) (ref.func {}))",
                tableidx, idx, funcidx
            )
        }
        HostEvent::GrowTable {
            idx: _,
            amount,
            import: _,
            name: _,
        } => {
            format!("(table.grow (i32.const {})) (drop)\n", amount)
        }
        HostEvent::MutateGlobal {
            idx,
            value,
            valtype,
            import: _,
            name: _,
        } => {
            let valtype = match valtype {
                ValType::I32 => "i32.const",
                ValType::I64 => "i64.const",
                ValType::F32 => "f32.const",
                ValType::F64 => "f64.const",
                ValType::V128 => todo!(),
                ValType::Anyref => todo!(),
                ValType::Externref => todo!(),
            };
            let value = value;
            let globalidx = idx;
            format!("({valtype} {value})\n") + &format!("(global.set {globalidx})")
        }
    };
    str
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

pub fn write(stream: &mut File, s: &str) -> std::io::Result<()> {
    if stream.write_all(s.as_bytes()).is_err() {
        // In Rust, we don't have an equivalent to Node.js's 'drain' event.
        // We'll just flush the stream instead.
        stream.flush()?;
    }
    Ok(())
}

use std::collections::HashSet;
use std::io::Write;
use std::process::Command;
use std::{fs::File, path::Path};

use crate::irgen::{FunctionTy, HostEvent, INIT_INDEX};
use crate::trace::ValType;
use crate::{irgen::Replay, write};

pub fn generate_replay_wasm(replay_path: &Path, code: &Replay) -> std::io::Result<()> {
    let mut module_set: HashSet<&String> = code
        .module
        .imports
        .iter()
        .map(|import| &import.module)
        .collect();
    let binding = "main".to_string();
    module_set.insert(&binding);
    for current_module in module_set.clone() {
        let module_wat_path = replay_path
            .parent()
            .unwrap()
            .join(&format!("{current_module}.wat"));
        let mut module_wat_file = File::create(&module_wat_path)?;
        let stream = &mut module_wat_file;
        write(stream, "(module\n")?;

        // Import part
        for (_memidx, memory) in &code.exported_mems() {
            let name = memory.export.clone().unwrap().name.clone();
            let initial = memory.initial;
            let maximum = match memory.maximum {
                Some(max) => max.to_string(),
                None => "".to_string(),
            };
            write(
                stream,
                &format!("(import \"index\" \"{name}\" (memory {initial} {maximum}))\n",),
            )?;
        }

        for (_globalidx, global) in &code.exported_globals() {
            let name = global.export.clone().unwrap().name.clone();
            let valtype = global.valtype.clone();
            let typedecl = match global.mutable {
                true => format!("(mut {valtype})"),
                false => format!("{valtype}"),
            };

            write(
                stream,
                &format!("(import \"index\" \"{name}\" (global ${name} {typedecl}))\n",),
            )?;
        }

        for (_tableidx, table) in &code.exported_tables() {
            let name = table.export.clone().unwrap().name.clone();
            let initial = table.initial;
            let reftype = &table.reftype;

            write(
                stream,
                &format!("(import \"index\" \"{name}\" (table ${name} {initial} {reftype}))\n",),
            )?;
        }

        for (_funcidx, func) in &code.exported_funcs() {
            let name = func.export.clone().unwrap().name.clone();

            let paramtys: Vec<String> = func.ty.params.iter().map(|v| format!("{}", v)).collect();
            let paramtys = paramtys.join(" ");
            let resulttys: Vec<String> = func.ty.results.iter().map(|v| format!("{}", v)).collect();
            let resulttys = resulttys.join(" ");
            write(
            stream,
            &format!("(import \"index\" \"{name}\" (func ${name} (param {paramtys}) (result {resulttys})))\n",),
        )?;
        }
        let func_names = code
            .exported_funcs()
            .iter()
            .map(|(_i, f)| format!("${}", f.export.clone().unwrap().name.clone()))
            .collect::<Vec<String>>()
            .join(" ");
        write(stream, &format!("(elem declare func {func_names})\n",))?;

        // Export part
        // memories
        for (_i, memory) in &code.imported_mems() {
            let import = memory.import.clone().unwrap();
            let module = import.module.clone();
            let name = import.name.clone();
            let initial = memory.initial;
            let maximum = match memory.maximum {
                Some(max) => max.to_string(),
                None => "".to_string(),
            };
            if module == *current_module {
                write(
                    stream,
                    &format!("(memory (export \"{name}\") {initial} {maximum})\n",),
                )?;
            } else {
                write(
                    stream,
                    &format!("(import \"{module}\" \"{name}\" (memory {initial} {maximum}))\n",),
                )?;
            }
        }
        for (_i, global) in &code.imported_globals() {
            let import = global.import.clone().unwrap();
            if import.module != *current_module {
                continue;
            }
            let name = import.name.clone();
            let valtype = global.valtype.clone();
            let initial = global.initial;
            write(
                stream,
                &format!("(global (export \"{name}\") {valtype} ({valtype}.const {initial:?}))\n",),
            )?;
        }
        // tables
        for (_i, table) in &code.imported_tables() {
            let import = table.import.clone().unwrap();
            if import.module != *current_module {
                continue;
            }
            let name = import.name.clone();
            let initial = table.initial;
            let maximum = match table.maximum {
                Some(max) => max.to_string(),
                None => "".to_string(),
            };
            let reftype = table.reftype.clone();
            write(
                stream,
                &format!("(table (export \"{name}\") {initial} {maximum} {reftype})\n",),
            )?;
        }
        // functions
        if current_module == "main" {
            let initialization = code.funcs.get(&INIT_INDEX).unwrap().bodys.last().unwrap();
            write(stream, "(func (export \"_start\") (export \"main\")\n")?;
            for event in initialization {
                write(stream, &format!("{}", hostevent_to_wat(event, code)))?
            }
            write(stream, "(return)\n)")?;
        } else {
            for (funcidx, func) in &code.imported_funcs() {
                let import = func.import.clone().unwrap();
                if import.module != *current_module {
                    continue;
                }
                // TODO: better handling of initialization
                if *funcidx == INIT_INDEX {
                    continue;
                }
                let funcidx = *funcidx;
                let name = func.import.clone().unwrap().name.clone();
                let global_idx = format!("$global_{}", funcidx.to_string());
                let func = code.funcs.get(&funcidx).unwrap();
                write(
                    stream,
                    &format!("(global {global_idx} (mut i64) (i64.const 0))\n"),
                )?;
                let tystr = get_functy_strs(&func.ty);
                write(stream, &format!("(func (export \"{name}\") {tystr}\n",))?;
                for (i, body) in func.bodys.iter().enumerate() {
                    let mut bodystr = String::new();
                    let _body = for event in body {
                        bodystr += &hostevent_to_wat(event, code)
                    };
                    write(
                        stream,
                        &format!(
                            "(if
                            (i64.eq (global.get {global_idx}) (i64.const {i}))
                            (then {bodystr}))\n"
                        ),
                    )?;
                }
                write(
                    stream,
                    &format!(
                    "(global.get {global_idx}) (i64.const 1) (i64.add) (global.set {global_idx})\n"
                ),
                )?;
                let mut current = 0;
                for r in func.results.iter() {
                    let ty = &code.funcs.get(&funcidx).unwrap().ty;
                    let _param_tys = ty.params.clone();
                    let new_c = current + r.reps;
                    let c1 = current + 1;
                    let c2 = new_c + 1;
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
                              (i64.ge_s (global.get {global_idx}) (i64.const {c1}))
                              (i64.lt_s (global.get {global_idx}) (i64.const {c2}))
                            )
                            (then
                                {res}
                            )
                          )"
                        ),
                    )?;
                    current = new_c;
                }
                let ty = &code.funcs.get(&funcidx).unwrap().ty;
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
            }
        }

        write(stream, ")\n")?;

        let binary = wat::parse_file(module_wat_path.clone()).unwrap();
        let module_wasm_path = replay_path
            .parent()
            .unwrap()
            .join(&format!("{current_module}.wasm"));
        let mut modle_wasm_file = File::create(&module_wasm_path).unwrap();
        modle_wasm_file.write_all(&binary).unwrap();
    }
    let module_args = module_set
        .iter()
        .map(|module| vec![format!("{}.wasm", module), module.to_string()])
        .flatten()
        .collect::<Vec<String>>();
    let args = [
        "--rename-export-conflicts",
        "--enable-reference-types",
        "--enable-multimemory",
        "index.wasm",
        "index",
    ]
    .iter()
    .cloned()
    .chain(module_args.iter().map(|s| s.as_str()))
    .chain(["-o", "merged.wasm"]);
    let _output = Command::new("wasm-merge")
        .current_dir(replay_path.parent().unwrap())
        .args(args)
        .output()
        .expect("Failed to execute wasm-merge");
    let _output = Command::new("wasm-opt")
        .current_dir(replay_path.parent().unwrap())
        .args([
            "--enable-reference-types",
            "--enable-gc",
            // for handling inlining of imported globals. Without this glob-merge node test will fail.
            "--simplify-globals",
            "merged.wasm",
            "-o",
            replay_path.to_str().unwrap(),
        ])
        .output()
        .expect("Failed to execute wasm-opt");

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

fn hostevent_to_wat(event: &HostEvent, code: &Replay) -> String {
    let str = match event {
        HostEvent::ExportCall { idx, name, params } => {
            let func = code.funcs.get(idx).unwrap();

            let param_tys = func.ty.params.clone();
            let result_count = func.ty.results.len();
            let params = params
                .iter()
                .zip(param_tys.clone())
                .map(|(p, p_ty)| format!("({} {p})", valty_to_const(&p_ty)))
                .collect::<Vec<String>>()
                .join("\n");
            params + &format!("(call ${name})") + &("(drop)".repeat(result_count))
        }
        HostEvent::ExportCallTable {
            idx,
            table_name: _,
            funcidx,
            params,
        } => {
            let func = code.funcs.get(idx).unwrap();

            let param_tys = func.ty.params.clone();
            let result_tys = func.ty.results.clone();
            let tystr = get_functy_strs(&func.ty);
            let params = params
                .iter()
                .zip(param_tys.clone())
                .map(|(p, p_ty)| format!("({} {p})", valty_to_const(&p_ty)))
                .collect::<Vec<String>>()
                .join("\n");
            params
                + &format!("(call_indirect {tystr} (i32.const {funcidx}))",)
                + &("(drop)".repeat(result_tys.len()))
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
                js_string += &format!("i32.store8\n",);
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
            func_name,
            import: _,
            name: _,
        } => {
            format!("(table.set {tableidx} (i32.const {idx}) (ref.func ${func_name}))",)
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
            name,
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
            let _globalidx = idx;
            format!("({valtype} {value})\n") + &format!("(global.set ${name})")
        }
    };
    str
}

fn get_functy_strs(ty: &FunctionTy) -> String {
    let paramstr = ty
        .params
        .iter()
        .map(|p| format!("{}", p))
        .collect::<Vec<String>>()
        .join(" ");
    let resultstr = ty
        .results
        .iter()
        .map(|r| format!("{}", r))
        .collect::<Vec<String>>()
        .join(" ");
    format!("(param {paramstr}) (result {resultstr})")
}

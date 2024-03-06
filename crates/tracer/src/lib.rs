use std::{
    collections::HashMap,
    fmt::{format, Debug},
};

use js_sys::Uint8Array;
use serde::{Deserialize, Serialize};
use wasm_bindgen::prelude::*;
use wasmparser::WasmFeatures;

const IGNORE_TABLE: bool = true;
const IGNORE_GLOBAL: bool = true;

#[derive(Debug, Deserialize, Serialize)]
pub struct Output {
    pub instrumented: Vec<u8>,
    pub stats: Stats,
}

#[derive(Debug, Deserialize, Serialize)]
pub struct Stats {
    pub calls: usize,
    pub instrumented_calls: usize,
    pub functions: usize,
    pub local_functions: usize,
    pub public_local_functions: usize,
    pub instrumented_function_entries_based_on_my_own_count: usize,
}

#[wasm_bindgen]
pub fn instrument_wasm_js(buffer: &[u8]) -> Result<JsValue, JsValue> {
    let output = instrument_wasm(buffer).map_err(|e| JsValue::from_str(e))?;
    // let uint8_array = js_sys::Uint8Array::new_with_length(buffer.len() as u32);
    // uint8_array.copy_from(&buffer);

    // Ok(JsValue::from(uint8_array))
    let output = serde_wasm_bindgen::to_value(&output)?;
    Ok(output)
}

const TRACE_MEM: &str = "$trace_mem";
const TRACE_MEM_PAGES: u32 = 10_000;
const TRACE_MEM_MAX_FILL: u32 = 7_000;
const TRACE_MEM_EXPORT_NAME: &str = "trace";
const MEM_POINTER: &str = "$mem_pointer";
const MEM_POINTER_EXPORT_NAME: &str = "trace_byte_length";
const LOCAL_FUNCREF: &str = "$funcref";
const FUNCREF_TABLE: &str = "$table";
const FUNCREF_TABLE_SIZE: u32 = 100_000;
const FUNCREF_TABLE_MAX_FILL: u32 = 80_000;
const FUNCREF_TABLE_EXPORT_NAME: &str = "lookup";
const TABLE_POINTER: &str = "$table_pointer";
const TABLE_POINTER_EXPORT_NAME: &str = "lookup_table_pointer";
const IMPORT_MODULE: &str = "r3";
const CHECK_MEM_IMPORT_NAME: &str = "check_mem";
const CHECK_MEM: &str = "$check_mem";
const CHECK_TABLE_IMPORT_NAME: &str = "check_table";
const CHECK_TABLE: &str = "$check_table";
const LOCAL_ADDR: &str = "$addr_local";
const LOCAL_I32: &str = "$i32";
const LOCAL_I64: &str = "$i64";
const LOCAL_F32: &str = "$f32";
const LOCAL_F64: &str = "$f64";
const INTERNAL_CALL_GLOBAL: &str = "$internal_call";
const SHADOW_MEM: &str = "$shadow_mem";
const SHADOW_TABLE: &str = "$shadow_table";

pub fn instrument_wasm(buffer: &[u8]) -> Result<Output, &'static str> {
    let mut orig_wat = wasmprinter::print_bytes(buffer).unwrap();
    if orig_wat == "(module)" {
        orig_wat = "(module\n)".into();
    }
    let mut orig_wat = orig_wat.split('\n').peekable();

    // First loop: gather metadata
    let mut types = Vec::new();
    let mut types_by_functions = HashMap::new();
    let mut type_idx = 0;
    let mut functions = Vec::new();
    let mut globals = Vec::new();
    let mut memories = Vec::new();
    let mut tables = Vec::new();
    let mut func_idx = 0;
    let mut shadows = Vec::new();
    for l in orig_wat.clone() {
        let l = l.trim();
        if l.starts_with("(type") {
            types.push(FuncType::new(l, type_idx)?);
            type_idx += 1;
        } else if l.starts_with("(import") && l.contains("(func") {
            let type_idx = get_type_idx_by_func_import(l)?;
            types_by_functions.insert(func_idx, types.get(type_idx as usize).unwrap().clone());
            functions.push(Function::from_func_import(l)?);
            func_idx += 1;
        } else if l.starts_with("(import") && l.contains("(global") {
            if IGNORE_GLOBAL == false {
                globals.push(Global::from_global_import(l)?);
            }
        } else if l.starts_with("(import") && l.contains("(memory") {
            let mem = extract_definition(l.into(), "(memory")?;
            shadows.push(transform_to_shadow(mem, SHADOW_MEM)?);
            memories.push(true);
        } else if l.starts_with("(memory") {
            shadows.push(transform_to_shadow(l.into(), SHADOW_MEM)?);
            memories.push(false);
        } else if l.starts_with("(import") && l.contains("(table") {
            if IGNORE_TABLE == false {
                // FOR SHADOW TABLE, THIS CURRENTLY ONLY SUPPORTS 1 TABLE
                // let table = extract_definition(l.into(), "(table")?;
                // shadows.push(transform_to_shadow(table, SHADOW_TABLE)?);
                tables.push(Table { public: true });
                // FOR SHADOW TABLE, THIS CURRENTLY ONLY SUPPORTS 1 TABLE
            }
        } else if l.starts_with("(table") {
            if IGNORE_TABLE == false {
                // shadows.push(transform_to_shadow(l.into(), SHADOW_TABLE)?);
                tables.push(Table { public: false });
            }
        } else if l.starts_with("(func") {
            let type_idx = get_type_idx_by_func_def(l)?;
            types_by_functions.insert(func_idx, types.get(type_idx as usize).unwrap().clone());
            functions.push(Function::from_func(l)?);
            func_idx += 1;
        } else if l.starts_with("(global") {
            if IGNORE_GLOBAL == false {
                globals.push(Global::from_global(l)?);
            }
        } else if l.starts_with("(export") && l.contains("(global") {
            if IGNORE_GLOBAL == false {
                let global_idx = get_exp_index(l)?;
                globals[global_idx].public = true;
            }
        } else if l.starts_with("(export") && l.contains("(memory") {
            let memory_idx = get_exp_index(l)?;
            memories[memory_idx] = true;
        } else if l.starts_with("(export") && l.contains("(table") {
            if IGNORE_TABLE == false {
                let table_idx = get_exp_index(l)?;
                tables[table_idx].public = true;
            }
        } else if l.starts_with("(export") && l.contains("(func") {
            let func_idx = get_exp_index_func(l, &functions)?;
            functions.get_mut(func_idx).unwrap().public = true;
            functions.get_mut(func_idx).unwrap().exported = true;
        } else if l.starts_with("(elem") {
            if IGNORE_TABLE == false {
                elem_func_public(l, &mut functions, &tables)?;
            }
        }
    }

    // Second loop: generate the instrumented module
    let mut gen_wat = Vec::new();
    let mut stats = Stats {
        calls: 0,
        instrumented_calls: 0,
        functions: functions.len(),
        local_functions: functions.iter().filter(|f| !f.imported).count(),
        public_local_functions: functions
            .iter()
            .filter(|f| f.in_public_table || f.exported)
            .count(),
        instrumented_function_entries_based_on_my_own_count: 0,
    };
    func_idx = 0;
    let mut local_count = 0;
    let mut typ: FuncType = FuncType {
        idx: 0,
        params: vec![],
        results: vec![],
    };
    let mut inside_func = false;
    while let Some(l) = orig_wat.next() {
        let mut l = l.trim().to_string();
        let offset = &mut 0;
        if is_new_section(orig_wat.peek()) && (inside_func || l.starts_with("(func")) {
            l.pop();
        }
        if l.starts_with("(module") {
            gen_wat.push(l);
            gen_wat.push(format!(
                "(import \"{}\" \"{}\" (func {}))",
                IMPORT_MODULE, CHECK_MEM_IMPORT_NAME, CHECK_MEM
            ));
            if IGNORE_TABLE == false {
                gen_wat.push(format!(
                    "(import \"{}\" \"{}\" (func {}))",
                    IMPORT_MODULE, CHECK_TABLE_IMPORT_NAME, CHECK_TABLE
                ));
            }
        } else if l.starts_with("(imp") && l.contains("(func") {
            gen_wat.push(l);
            func_idx += 1;
        } else if l.starts_with("(func") {
            inside_func = true;
            local_count = 0;
            typ = types_by_functions.get(&func_idx).unwrap().clone();
            local_count += typ.params.len();
            if let Some(next) = orig_wat.peek() {
                if next.trim().starts_with("(local") {
                    gen_wat.push(l);
                    l = orig_wat.next().unwrap().trim().to_string();
                    local_count += l
                        .split_whitespace()
                        .filter(|&token| token != "local" && token != ")")
                        .count();
                }
            }
            gen_wat.push(l);
            gen_wat.push(typ.locals_wat());
            local_count += 6 + typ.results.len();
            let func = functions.get(func_idx as usize).unwrap();
            if func.exported || func.in_public_table {
                // if false {
                stats.instrumented_function_entries_based_on_my_own_count += 1;
                gen_wat.push(format!("global.get {}", INTERNAL_CALL_GLOBAL));
                gen_wat.push("i32.eqz".into());
                gen_wat.push("(if (then".into());
                gen_wat.extend(trace_u8(0x02, offset));
                gen_wat.extend(trace_u32(func_idx, offset));
                gen_wat.extend(trace_u32(typ.idx, offset));
                gen_wat.extend(typ.trace_params(offset));
                gen_wat.extend(increment_mem_pointer(offset));
                gen_wat.push(") (else))".into());
            }
            func_idx += 1;
        } else if l == "return" {
            let func = functions.get((func_idx - 1) as usize).unwrap();
            if func.exported || func.in_public_table {
                trace_return(&mut gen_wat, offset);
            }
            gen_wat.push(l);
        } else if l.starts_with("call_indirect") {
            let called_type_idx = get_type_idx_by_call_indirect(&l)?;
            let called_type = types.get(called_type_idx).unwrap();
            let table_idx = get_table_idx_by_call_indirect(&l)?;
            // SHADOW TABLE OPTIMISATION
            // gen_wat.push(format!("local.tee {}", LOCAL_ADDR));
            // gen_wat.push(format!("table.get"));
            // gen_wat.push(format!("local.tee {}", LOCAL_FUNCREF));
            // gen_wat.push(format!("local.get {}", LOCAL_ADDR));
            // gen_wat.push(format!("table.get {}", SHADOW_TABLE));
            // gen_wat.push(format!("ref.eq"));
            // gen_wat.push(format!("(if (then) (else"));
            // gen_wat.extend(trace_u8(0x11, offset));
            // gen_wat.push(format!("local.get {}", LOCAL_ADDR));
            // gen_wat.extend(trace_u32(table_idx, offset));
            // gen_wat.push(format!("local.get {}", LOCAL_FUNCREF));
            // gen_wat.extend(save_funcref(offset));
            // gen_wat.push("drop".into());
            // gen_wat.extend(increment_mem_pointer(offset));
            // gen_wat.push(l);
            // gen_wat.extend(trace_u8(0xFE, offset));
            // gen_wat.push(format!("global.get {}", MEM_POINTER));
            // gen_wat.push(format!("local.get {}", LOCAL_ADDR));
            // gen_wat.push(store_value(&ValType::I32, offset));
            // gen_wat.extend(trace_u32(called_type.idx, offset));
            // gen_wat.extend(trace_stack_value(called_type.results.get(0), offset));
            // gen_wat.extend(increment_mem_pointer(offset));
            // gen_wat.push("))".into());
            // REPLACE THE FOLLOWING WITH THE ABOVE FOR THE SHADOW TABLE OPTIMISATION
            // gen_wat.extend(trace_u8(0x11, offset));
            // gen_wat.extend(trace_u32(table_idx, offset));
            // gen_wat.extend(trace_stack_value(Some(&ValType::I32), offset));
            // gen_wat.push(format!("local.get {}", LOCAL_I32));
            // gen_wat.push(format!("table.get {}", table_idx));
            // gen_wat.push(format!("global.get {}", TABLE_POINTER));
            // gen_wat.push(format!("local.set {}", LOCAL_ADDR));
            // gen_wat.extend(save_funcref(offset));
            // gen_wat.push("drop".into());
            // gen_wat.extend(increment_mem_pointer(offset));
            // gen_wat.push(l);
            // gen_wat.extend(trace_u8(0xFE, offset));
            // gen_wat.push(format!("global.get {}", MEM_POINTER));
            // gen_wat.push(format!("local.get {}", LOCAL_ADDR));
            // gen_wat.push(store_value(&ValType::I32, offset));
            // gen_wat.extend(trace_u32(called_type.idx, offset));
            // gen_wat.extend(trace_stack_value(called_type.results.get(0), offset));
            // gen_wat.extend(increment_mem_pointer(offset));

            gen_wat.extend(trace_u8(0x10, offset));

            gen_wat.extend(trace_stack_value(Some(&ValType::I32), offset));
            gen_wat.extend(increment_mem_pointer(offset));
            gen_wat.push(l);
            gen_wat.extend(trace_u8(0xFF, offset));
            gen_wat.push(format!("global.get {}", MEM_POINTER));
            gen_wat.push(format!("local.get {}", LOCAL_I32));
            gen_wat.push(store_value(&ValType::I32, offset));
            gen_wat.extend(trace_u32(called_type.idx, offset));
            gen_wat.extend(trace_stack_value(called_type.results.get(0), offset));
            gen_wat.extend(increment_mem_pointer(offset));
        } else if l.starts_with("call") {
            stats.calls += 1;
            let called_func_idx = get_func_idx_by_call_instr(&mut l, &functions)?;
            let called_function = functions.get(called_func_idx as usize).unwrap();
            if called_function.exported {
                gen_wat.push(format!("global.get {}", INTERNAL_CALL_GLOBAL));
                gen_wat.push("i32.const 1".into());
                gen_wat.push("i32.add".into());
                gen_wat.push(format!("global.set {}", INTERNAL_CALL_GLOBAL));
            }
            if called_function.imported {
                // if false {
                gen_wat.push("i32.const 0".into());
                gen_wat.push(format!("global.set {}", INTERNAL_CALL_GLOBAL));
                stats.instrumented_calls += 1;
                let called_type = types_by_functions.get(&called_func_idx).unwrap();
                gen_wat.extend(trace_u8(0x10, offset));
                gen_wat.extend(trace_u32(called_func_idx, offset));
                gen_wat.extend(increment_mem_pointer(offset));
                gen_wat.push(l);
                gen_wat.extend(trace_u8(0xFF, offset));
                gen_wat.extend(trace_u32(called_func_idx, offset));
                gen_wat.extend(trace_u32(called_type.idx, offset));
                gen_wat.extend(trace_stack_value(called_type.results.get(0), offset));
                gen_wat.extend(increment_mem_pointer(offset));
            } else {
                gen_wat.push(l);
            }
        } else if l.starts_with("memory.grow") {
            // gen_wat.extend(trace_u8(0x40, offset));
            // gen_wat.extend(trace_stack_value(Some(&ValType::I32), offset));
            // gen_wat.extend(increment_mem_pointer(offset));
            // gen_wat.push(format!("local.get {}", LOCAL_I32));
            gen_wat.push(format!("local.tee {}", LOCAL_ADDR));
            gen_wat.push(format!("memory.grow {}", SHADOW_MEM));
            gen_wat.push(format!("drop"));
            gen_wat.push(format!("local.get {}", LOCAL_ADDR));
            gen_wat.push(l);
        } else if l.starts_with("i32.load")
            || l.starts_with("i64.load")
            || l.starts_with("f32.load")
            || l.starts_with("f64.load")
        {
            let (code, typ, offs) = get_load_info(&l)?;
            // shadow mem opt
            gen_wat.push(format!("local.tee {}", LOCAL_ADDR));
            gen_wat.push(l.clone());
            gen_wat.push(format!("local.tee {}", typ.to_local()));
            gen_wat.push(format!("local.get {}", LOCAL_ADDR));
            gen_wat.push(to_shadow_mem_instr(&l)?);
            gen_wat.push(format!("{}.ne", typ.to_string()));
            gen_wat.push(format!("(if (then"));
            // instrumentation
            gen_wat.extend(trace_u8(code, offset));
            gen_wat.push(format!("global.get {}", MEM_POINTER));
            gen_wat.push(format!("local.get {}", LOCAL_ADDR));
            if let Some(offs) = offs {
                gen_wat.push(format!("i32.const {}", offs));
                gen_wat.push("i32.add".into());
            }
            gen_wat.push(store_value(&ValType::I32, offset));
            gen_wat.push(format!("global.get {}", MEM_POINTER));
            gen_wat.push(format!("local.get {}", typ.to_local()));
            gen_wat.push(store_value(&typ, offset));
            gen_wat.extend(increment_mem_pointer(offset));
            // end
            gen_wat.push(") (else))".into());
            gen_wat.push(format!("local.get {}", typ.to_local()));
        } else if l.contains("i32.store")
            || l.contains("i64.store")
            || l.contains("f32.store")
            || l.contains("f64.store")
        {
            let (code, typ, offs) = get_store_info(&l)?;
            gen_wat.push(format!("local.set {}", typ.to_local()));
            gen_wat.push(format!("local.tee {}", LOCAL_ADDR));
            gen_wat.push(format!("local.get {}", typ.to_local()));
            gen_wat.push(to_shadow_mem_instr(&l)?);
            gen_wat.push(format!("local.get {}", LOCAL_ADDR));
            gen_wat.push(format!("local.get {}", typ.to_local()));
            gen_wat.push(l);
        } else if l.starts_with("table.get") {
            if IGNORE_TABLE == false {
                let table_idx = get_table_idx_by_table_get(&l)?;
                gen_wat.extend(trace_u8(0x25, offset));
                gen_wat.extend(trace_u32(table_idx, offset));
                gen_wat.extend(trace_stack_value(Some(&ValType::I32), offset));
                gen_wat.push(l);
                gen_wat.extend(save_funcref(offset));
                gen_wat.extend(increment_mem_pointer(offset));
            }
        } else if l.starts_with("table.set") {
            if IGNORE_TABLE == false {
                gen_wat.extend(trace_u8(0x26, offset));
                gen_wat.extend(trace_store_stack(&ValType::Funcref, None, offset));
                gen_wat.push(l);
                gen_wat.extend(increment_mem_pointer(offset));
            } else {
                gen_wat.push(l);
            }
        } else if l.starts_with("global.get") {
            if IGNORE_GLOBAL == false {
                let global_idx = get_global_idx(&l, &globals)?;
                let global = globals.get(global_idx as usize).unwrap();
                if global.should_be_traced() {
                    gen_wat.extend(trace_u8(0x23, offset));
                    gen_wat.extend(trace_u8(global.valtype.get_code(), offset));
                    gen_wat.extend(trace_u32(global_idx, offset));
                    gen_wat.push(l);
                    gen_wat.extend(trace_stack_value(Some(&global.valtype), offset));
                    gen_wat.extend(increment_mem_pointer(offset));
                } else {
                    gen_wat.push(l);
                }
            } else {
                gen_wat.push(l);
            }
        } else if l.starts_with("global.set") {
            if IGNORE_GLOBAL == false {
                let global_idx = get_global_idx(&l, &globals)?;
                let global = globals.get(global_idx as usize).unwrap();
                if global.should_be_traced() {
                    gen_wat.extend(trace_u8(0x24, offset));
                    gen_wat.extend(trace_u8(global.valtype.get_code(), offset));
                    gen_wat.extend(trace_u32(global_idx, offset));
                    gen_wat.extend(trace_stack_value(Some(&global.valtype), offset));
                    gen_wat.push(l);
                    gen_wat.extend(increment_mem_pointer(offset));
                } else {
                    gen_wat.push(l);
                }
            } else {
                gen_wat.push(l);
            }
        } else if l.starts_with("(export") {
            adapt_export_func_idx(&mut l)?;
            gen_wat.push(l);
        } else if l.starts_with("(elem") {
            // if IGNORE_TABLE == false {
            adapt_elem_func_idx(&mut l, &mut functions)?;
            // FOR SHADOW TABLE OPT. THIS SUPPORTS ONLY ONE TABLE CURRENTLY
            //     gen_wat.push(transform_to_shadow(
            //         l.clone(),
            //         &format!("(table {SHADOW_TABLE})"),
            //     )?);
            gen_wat.push(l);
            // }
        } else if l.starts_with("(data") {
            // gen_wat.push(transform_to_shadow(l.clone(), SHADOW_MEM)?);
            gen_wat.push(l);
        } else if l.starts_with("(@producers") {
            let mut closed_bracket = "";
            while closed_bracket != ")" {
                if let Some(x) = orig_wat.next() {
                    closed_bracket = x.trim();
                }
            }
        } else if let None = orig_wat.peek() {
            l.pop();
            gen_wat.push(l);
            gen_wat.push(format!(
                "(memory {} (export \"{}\") {})",
                TRACE_MEM, TRACE_MEM_EXPORT_NAME, TRACE_MEM_PAGES
            ));
            gen_wat.push(format!(
                "(global {} (export \"{}\") (mut i32) (i32.const 0))",
                MEM_POINTER, MEM_POINTER_EXPORT_NAME
            ));
            if IGNORE_TABLE == false {
                gen_wat.push(format!(
                    "(table {} (export \"{}\") {} funcref)",
                    FUNCREF_TABLE, FUNCREF_TABLE_EXPORT_NAME, FUNCREF_TABLE_SIZE
                ));
                gen_wat.push(format!(
                    "(global {} (export \"{}\") (mut i32) (i32.const 0))",
                    TABLE_POINTER, TABLE_POINTER_EXPORT_NAME
                ));
            }
            gen_wat.push(format!(
                "(global {} (mut i32) (i32.const 0))",
                INTERNAL_CALL_GLOBAL
            ));
            gen_wat.extend(shadows.clone());
            gen_wat.push(")".into())
        } else {
            gen_wat.push(l);
        }
        if is_new_section(orig_wat.peek()) && inside_func {
            let func = functions.get((func_idx - 1) as usize).unwrap();
            if func.exported || func.in_public_table {
                // if false {
                trace_return(&mut gen_wat, offset);
            }
            gen_wat.push(")".into());
            inside_func = false;
        }
    }
    let gen_wat: String = gen_wat.join("\n");
    let gen = gen_wat.clone();
    // return Err(Box::leak(gen.into_boxed_str()));
    match wat::parse_str(gen_wat) {
        Ok(buffer) => match wasmparser::Validator::new_with_features(WasmFeatures::all())
            .validate_all(&buffer)
        {
            Ok(_) => Ok(Output {
                stats,
                instrumented: buffer,
            }),
            Err(_) => {
                println!("HELLO");
                Err(Box::leak(gen.into_boxed_str()))
            }
        },
        Err(_) => {
            println!("HELLO 2");
            Err(Box::leak(gen.into_boxed_str()))
        }
    }
}

fn trace_u8(value: u8, offset: &mut u32) -> Vec<String> {
    vec![
        format!("global.get {}", MEM_POINTER),
        format!("i32.const {}", value),
        store_value(&ValType::U8, offset),
    ]
}

fn trace_u32(value: u32, offset: &mut u32) -> Vec<String> {
    vec![
        format!("global.get {}", MEM_POINTER),
        format!("i32.const {}", value),
        store_value(&ValType::I32, offset),
    ]
}

fn trace_stack_value(typ: Option<&ValType>, offset: &mut u32) -> Vec<String> {
    match typ {
        Some(typ) => {
            let local = typ.to_local();
            vec![
                format!("local.tee {}", local),
                format!("global.get {}", MEM_POINTER),
                format!("local.get {}", local),
                store_value(typ, offset),
            ]
        }
        None => vec![],
    }
}

fn trace_store_stack(typ: &ValType, addr_offset: Option<u32>, offset: &mut u32) -> Vec<String> {
    let local = typ.to_local();
    let mut instrs = vec![];
    match typ {
        ValType::Funcref => {
            instrs.extend(save_funcref(offset));
            instrs.push("drop".into());
        }
        _ => instrs.extend(vec![
            format!("local.set {}", local),
            format!("global.get {}", MEM_POINTER),
            format!("local.get {}", local),
            store_value(&typ, offset),
        ]),
    }
    instrs.push(format!("local.tee {}", LOCAL_ADDR));
    instrs.push(format!("global.get {}", MEM_POINTER));
    instrs.push(format!("local.get {}", LOCAL_ADDR));
    if let Some(offs) = addr_offset {
        instrs.push(format!("i32.const {}", offs));
        instrs.push("i32.add".into());
    }
    instrs.push(store_value(&ValType::I32, offset));
    instrs.push(format!("local.get {}", local));
    instrs
}

fn save_funcref(offset: &mut u32) -> Vec<String> {
    vec![
        format!("local.tee {}", LOCAL_FUNCREF),
        format!("global.get {}", TABLE_POINTER),
        format!("local.get {}", LOCAL_FUNCREF),
        format!("table.set {}", FUNCREF_TABLE),
        format!("global.get {}", MEM_POINTER),
        format!("global.get {}", TABLE_POINTER),
        store_value(&ValType::I32, offset),
        format!("global.get {}", TABLE_POINTER),
        format!("i32.const 1"),
        format!("i32.add"),
        format!("global.set {}", TABLE_POINTER),
    ]
}

fn increment_mem_pointer(offset: &mut u32) -> Vec<String> {
    let instrs = vec![
        format!("global.get {}", MEM_POINTER),
        format!("i32.const {}", offset),
        format!("i32.add"),
        format!("global.set {}", MEM_POINTER),
    ];
    *offset = 0;
    instrs
}

fn is_new_section(wat: Option<&&str>) -> bool {
    match wat {
        Some(l) => {
            let l = l.trim();
            if l.starts_with("(func")
                || l.starts_with("(global")
                || l.starts_with("(memory")
                || l.starts_with("(table")
                || l.starts_with("(export")
            {
                true
            } else {
                false
            }
        }
        None => false,
    }
}

fn store_value(typ: &ValType, offset: &mut u32) -> String {
    match typ {
        ValType::U8 => {
            let instr = format!("i32.store8 {} offset={}", TRACE_MEM, offset);
            *offset += 1;
            instr
        }
        ValType::I32 => {
            let instr = format!("i32.store {} offset={}", TRACE_MEM, offset);
            *offset += 4;
            instr
        }
        ValType::I64 => {
            let instr = format!("i64.store {} offset={}", TRACE_MEM, offset);
            *offset += 8;
            instr
        }
        ValType::F32 => {
            let instr = format!("f32.store {} offset={}", TRACE_MEM, offset);
            *offset += 4;
            instr
        }
        ValType::F64 => {
            let instr = format!("f64.store {} offset={}", TRACE_MEM, offset);
            *offset += 8;
            instr
        }
        ValType::Funcref => panic!("You cannot store a funcref to the memory"),
    }
}

fn check_mem() -> Vec<String> {
    vec![
        format!("i32.const {}", 64000 * TRACE_MEM_MAX_FILL),
        format!("global.get {}", MEM_POINTER),
        format!("i32.le_u"),
        format!("(if (then call {}))", CHECK_MEM),
    ]
}

fn check_table() -> Vec<String> {
    vec![
        format!("i32.const {}", FUNCREF_TABLE_MAX_FILL),
        format!("global.get {}", TABLE_POINTER),
        format!("i32.le_u"),
        format!("(if (then call {}))", CHECK_TABLE),
    ]
}

fn get_func_idx_by_call_instr(
    input: &mut String,
    functions: &Vec<Function>,
) -> Result<u32, &'static str> {
    let offset = if IGNORE_TABLE == false { 2 } else { 1 };
    let parts: Vec<&str> = input.split_whitespace().collect();

    if parts.len() < 2 {
        return Err("Couldnt extract func idx from call instr");
    }
    if parts[1].starts_with("$") {
        for (i, f) in functions.iter().enumerate() {
            if let Some(id) = &f.identifier {
                if id == parts[1] {
                    *input = format!("call {}", i + offset);
                    return Ok(i as u32);
                }
            }
        }
        return Err("Couldnt find function idx by call instr");
    }
    let idx = match parts[1].parse::<u32>() {
        Ok(number) => number,
        Err(_) => return Err("Couldnt extract func idx from call instr"),
    };
    *input = vec![parts[0], " ", &(idx + offset as u32).to_string()].concat();
    Ok(idx)
}

fn adapt_export_func_idx(input: &mut String) -> Result<(), &'static str> {
    let re = regex::Regex::new(r"(func)\s+(\d+)").map_err(|_| "Regex compilation failed")?;
    let caps = match re.captures(input) {
        Some(c) => c,
        None => return Ok(()),
    };
    let funcidx_str = caps.get(2).ok_or("No funcidx found")?.as_str();
    let mut funcidx: i32 = funcidx_str.parse().map_err(|_| "Funcidx parsing failed")?;
    if IGNORE_TABLE == false {
        funcidx += 2;
    } else {
        funcidx += 1;
    }
    *input = re.replace(input, format!("$1 {}", funcidx)).to_string();
    Ok(())
}

/// This parses element sections
/// This needs to increment all function indexes by 2 because we add two imported functions in the beginning
fn adapt_elem_func_idx(input: &mut String, functions: &Vec<Function>) -> Result<(), &'static str> {
    // (elem (;0;) (i32.const 0) func 4 5)
    // (elem (;1;) (table 1) (i32.const 0) func $func_name 7))
    let mut parts: Vec<String> = input.split_whitespace().map(|s| s.into()).collect();
    let mut start_idx = 5;
    if parts.iter().filter(|p| p.starts_with("(")).count() == 4 {
        if parts[3].trim_end_matches(')').starts_with("$") {
            return Err("Table index starts with $ in elem section not supported yet");
        }
        start_idx = 7;
    }
    let len = parts.len();
    for i in start_idx..len {
        parts[i] = parts[i].trim_end_matches(')').to_string();
        let func_idx = if parts[i].starts_with("$") {
            functions
                .iter()
                .enumerate()
                .find(|(_, f)| {
                    if let Some(n) = &f.identifier {
                        if *n == parts[i] {
                            return true;
                        }
                    }
                    return false;
                })
                .map(|(func_idx, _)| func_idx)
                .ok_or("Couldnt map func identifier to func idx in elem section")?
        } else {
            parts[i]
                .parse::<usize>()
                .map_err(|_| "Couldnt func idx in elem section")?
        };
        let offset = if IGNORE_TABLE == false { 2 } else { 1 };
        parts[i] = (func_idx + offset).to_string();
    }
    parts.push(")".into());
    *input = parts.join(" ");
    Ok(())
}

/// This parses element sections
/// If the corresponding table is public this also sets the respective functions to public
fn elem_func_public(
    input: &str,
    functions: &mut Vec<Function>,
    tables: &Vec<Table>,
) -> Result<(), &'static str> {
    // (elem (;0;) (i32.const 0) func 4 5)
    // (elem (;1;) (table 1) (i32.const 0) func $func_name 7))
    let mut parts: Vec<String> = input.split_whitespace().map(|s| s.into()).collect();
    let mut start_idx = 5;
    let mut table_idx = 0;
    if parts.iter().filter(|p| p.starts_with("(")).count() == 4 {
        if parts[3].trim_end_matches(')').starts_with("$") {
            return Err("Table index starts with $ in elem section not supported yet");
        }
        table_idx = parts[3]
            .trim_end_matches(')')
            .parse::<usize>()
            .map_err(|_| "Couldnt parse table idx in elem section")?;
        start_idx = 7;
    }
    let len = parts.len();
    for i in start_idx..len {
        parts[i] = parts[i].trim_end_matches(')').to_string();
        let func_idx = if parts[i].starts_with("$") {
            functions
                .iter()
                .enumerate()
                .find(|(_, f)| {
                    if let Some(n) = &f.identifier {
                        if *n == parts[i] {
                            return true;
                        }
                    }
                    return false;
                })
                .map(|(func_idx, _)| func_idx)
                .ok_or("Couldnt map func identifier to func idx in elem section")?
        } else {
            parts[i]
                .parse::<usize>()
                .map_err(|_| "Couldnt func idx in elem section")?
        };
        if tables.get(table_idx).unwrap().public {
            functions.get_mut(func_idx).unwrap().in_public_table = true;
        }
    }
    Ok(())
}

fn get_type_idx_by_func_def(input: &str) -> Result<u32, &'static str> {
    let start_pattern = "(type ";
    let start = input.find(start_pattern).ok_or("Type pattern not found")?;
    let number_start = start + start_pattern.len();
    let end = input[number_start..]
        .find(|c: char| c == ' ' || c == ')')
        .ok_or("Closing pattern not found")?
        + number_start;
    input[number_start..end]
        .parse::<u32>()
        .map_err(|_| "Failed to parse type index")
}

fn get_type_idx_by_func_import(input: &str) -> Result<u32, &'static str> {
    let start_pattern = "(type ";
    let start = input.find(start_pattern).ok_or("Type pattern not found")?;
    let number_start = start + start_pattern.len();
    let end = input[number_start..]
        .find(|c: char| c == ' ' || c == ')')
        .ok_or("Closing pattern not found")?
        + number_start;
    input[number_start..end]
        .parse::<u32>()
        .map_err(|_| "Failed to parse type index")
}

fn get_exp_index(input: &str) -> Result<usize, &'static str> {
    let parts: Vec<&str> = input.split_whitespace().collect();
    if parts.len() > 3 {
        let num_str = parts[3].trim_end_matches(')');
        if let Ok(num) = num_str.parse::<usize>() {
            return Ok(num);
        }
    }
    Err("No valid number found in the export expression")
}

fn get_exp_index_func(input: &str, functions: &Vec<Function>) -> Result<usize, &'static str> {
    let parts: Vec<&str> = input.split_whitespace().collect();
    if parts.len() > 3 {
        if parts[3].starts_with("$") {
            for (i, f) in functions.iter().enumerate() {
                if let Some(id) = &f.identifier {
                    if id == parts[3].trim_end_matches(')') {
                        return Ok(i);
                    }
                }
            }
            return Err("No valid function found in export expression. While trying to resolve a identifier ($lasfdkj)");
        }
        let num_str = parts[3].trim_end_matches(')');
        if let Ok(num) = num_str.parse::<usize>() {
            return Ok(num);
        }
    }
    Err("No valid number found in the export expression")
}

fn get_table_idx_by_call_indirect(input: &str) -> Result<u32, &'static str> {
    let parts: Vec<&str> = input.split_whitespace().collect();
    if parts.len() > 3 {
        let num_str = parts[1];
        if let Ok(num) = num_str.parse::<u32>() {
            Ok(num)
        } else {
            Err("Couldnt parse out tableidx from call_indirect")
        }
    } else {
        Ok(0)
    }
}

fn get_table_idx_by_table_get(input: &str) -> Result<u32, &'static str> {
    let parts: Vec<&str> = input.split_whitespace().collect();
    if parts.is_empty() {
        return Err("Empty input");
    }
    match parts[0] {
        "call_indirect" | "table.get" => {
            if parts.len() > 1 {
                if let Ok(idx) = parts[1].parse::<u32>() {
                    return Ok(idx);
                } else {
                    return Err("Failed to parse table index");
                }
            }
            Err("No table index found in the instruction")
        }
        _ => Err("Unsupported instruction type"),
    }
}

fn get_mem_offset(wasm_text: &String) -> Result<Option<u32>, &'static str> {
    // load or store can have these 4 forms
    // i32.load
    // i32.load offset=4
    // i32.load offset=4 align=4
    // i32.load align=4
    let mut parts: Vec<&str> = wasm_text.split_whitespace().collect();
    if parts.len() > 3 {
        return Err("Couldnt parse load or store instruction. To many components");
    }
    let offset = parts
        .iter()
        .find(|&part| part.starts_with("offset="))
        .and_then(|offset_part| offset_part.strip_prefix("offset="))
        .and_then(|number_str| number_str.parse::<u32>().ok());
    // if parts.len() < 3 {
    //     if let Some(_) = offset {
    //         // dbg!("CHANGE");
    //         // dbg!(&wasm_text);
    //         *wasm_text = parts[0].to_string();
    //         // dbg!(&wasm_text);
    //     }
    // } else {
    //     // dbg!("CHANGE");
    //     // dbg!(&wasm_text);
    //     *wasm_text = format!("{} {}", parts[0], parts[2]);
    //     // dbg!(&wasm_text);
    //     // dbg!(&offset);
    // }
    Ok(offset)
    // Ok(Some(0))
}

fn get_load_info(wat: &String) -> Result<(u8, ValType, Option<u32>), &'static str> {
    let offset = get_mem_offset(wat)?;
    if wat.starts_with("i32.load8") {
        Ok((0x2C, ValType::I32, offset))
    } else if wat.starts_with("i32.load16") {
        Ok((0x2E, ValType::I32, offset))
    } else if wat.starts_with("i32.load") {
        Ok((0x28, ValType::I32, offset))
    } else if wat.starts_with("i64.load8") {
        Ok((0x30, ValType::I64, offset))
    } else if wat.starts_with("i64.load16") {
        Ok((0x32, ValType::I64, offset))
    } else if wat.starts_with("i64.load32") {
        Ok((0x34, ValType::I64, offset))
    } else if wat.starts_with("i64.load") {
        Ok((0x29, ValType::I64, offset))
    } else if wat.starts_with("f32.load") {
        Ok((0x2A, ValType::F32, offset))
    } else if wat.starts_with("f64.load") {
        Ok((0x2B, ValType::F64, offset))
    } else {
        Err("Getting load info failed")
    }
}

fn get_store_info(wat: &String) -> Result<(u8, ValType, Option<u32>), &'static str> {
    let offset = get_mem_offset(wat)?;
    if wat.starts_with("i32.store8") {
        Ok((0x3A, ValType::I32, offset))
    } else if wat.starts_with("i32.store16") {
        Ok((0x3B, ValType::I32, offset))
    } else if wat.starts_with("i32.store") {
        Ok((0x36, ValType::I32, offset))
    } else if wat.starts_with("i64.store8") {
        Ok((0x3C, ValType::I64, offset))
    } else if wat.starts_with("i64.store16") {
        Ok((0x3D, ValType::I64, offset))
    } else if wat.starts_with("i64.store32") {
        Ok((0x3E, ValType::I64, offset))
    } else if wat.starts_with("i64.store") {
        Ok((0x37, ValType::I64, offset))
    } else if wat.starts_with("f32.store") {
        Ok((0x38, ValType::F32, offset))
    } else if wat.starts_with("f64.store") {
        Ok((0x39, ValType::F64, offset))
    } else {
        Err("Getting store info failed")
    }
}

fn get_global_idx(input: &str, globals: &Vec<Global>) -> Result<u32, &'static str> {
    let parts: Vec<&str> = input.split_whitespace().collect();

    // Ensure there are enough parts in the string
    if parts.len() < 2 {
        return Err("String does not contain enough parts");
    }

    let global_idx = parts.last().unwrap();

    if global_idx.starts_with("$") {
        for (i, g) in globals.iter().enumerate() {
            if let Some(id) = &g.identifier {
                if global_idx == id {
                    return Ok(i as u32);
                }
            }
        }
        return Err("Couldnt find global");
    } else {
        global_idx
            .parse::<u32>()
            .map_err(|_| "Failed to parse global idx")
    }
}

#[derive(Clone, Debug)]
struct FuncType {
    idx: u32,
    params: Vec<ValType>,
    results: Vec<ValType>,
}
impl FuncType {
    fn new(wat: &str, idx: u32) -> Result<FuncType, &'static str> {
        if !wat.starts_with("(type") {
            return Err("Cannot parse type");
        }
        let wat = wat.replace("(", "").replace(")", "");
        let mut params = Vec::new();
        let mut results = Vec::new();
        let mut current_target = &mut params;
        for token in wat.split_whitespace() {
            match token {
                "param" => current_target = &mut params,
                "result" => current_target = &mut results,
                "i32" => current_target.push(ValType::I32),
                "i64" => current_target.push(ValType::I64),
                "f32" => current_target.push(ValType::F32),
                "f64" => current_target.push(ValType::F64),
                _ => {}
            }
        }
        Ok(FuncType {
            idx,
            params,
            results,
        })
    }

    fn trace_params(&self, offset: &mut u32) -> Vec<String> {
        let mut local_id = -1;
        self.params
            .iter()
            .flat_map(|v| {
                local_id += 1;
                vec![
                    format!("global.get {}", MEM_POINTER),
                    format!("local.get {}", local_id),
                    store_value(v, offset),
                ]
            })
            .collect()
    }

    fn trace_results(&self, local_count: usize, offset: &mut u32) -> Vec<String> {
        let mut local_id = local_count - self.results.len() - 1;
        self.results
            .iter()
            .flat_map(|v| {
                local_id += 1;
                vec![
                    format!("global.get {}", MEM_POINTER),
                    format!("local.get {}", local_id),
                    store_value(v, offset),
                ]
            })
            .collect()
    }

    fn locals_wat(&self) -> String {
        let mut wat = format!(
            "(local {} i32)(local {} i32)(local {} i64)(local {} f32)(local {} f64)(local {} funcref)(local",
            LOCAL_ADDR, LOCAL_I32, LOCAL_I64, LOCAL_F32, LOCAL_F64, LOCAL_FUNCREF
        );
        for r in &self.results {
            match r {
                ValType::U8 => unreachable!("This will not be contained in the results"),
                ValType::I32 => wat.push_str(" i32"),
                ValType::I64 => wat.push_str(" i64"),
                ValType::F32 => wat.push_str(" f32"),
                ValType::F64 => wat.push_str(" f64"),
                ValType::Funcref => unreachable!("This will not be contained in the results"),
            }
        }
        wat.push(')');
        wat
    }
}

fn get_type_idx_by_call_indirect(wat: &str) -> Result<usize, &'static str> {
    let type_pattern = "(type ";
    let start = wat.find(type_pattern).ok_or("Pattern not found")?;
    let id_start = start + type_pattern.len();
    let remaining = &wat[id_start..];
    let end = remaining.find(')').ok_or("Closing parenthesis not found")?;
    remaining[..end]
        .trim()
        .parse::<usize>()
        .map_err(|_| "Failed to parse type ID")
}

fn trace_return(gen_wat: &mut Vec<String>, offset: &mut u32) {
    gen_wat.push(format!("global.get {}", INTERNAL_CALL_GLOBAL));
    gen_wat.push("i32.eqz".into());
    gen_wat.push("(if (then".into());
    gen_wat.extend(trace_u8(0x0F, offset));
    gen_wat.extend(increment_mem_pointer(offset));
    gen_wat.push(") (else".into());
    gen_wat.push(format!("global.get {}", INTERNAL_CALL_GLOBAL));
    gen_wat.push("i32.const 1".into());
    gen_wat.push("i32.sub".into());
    gen_wat.push(format!("global.set {}", INTERNAL_CALL_GLOBAL));
    gen_wat.push("))".into());
    gen_wat.extend(check_mem());
    if IGNORE_TABLE == false {
        gen_wat.extend(check_table());
    }
}

fn transform_to_shadow(wat: String, identifier: &str) -> Result<String, &'static str> {
    let mut parts: Vec<&str> = wat
        .split_ascii_whitespace()
        .filter(|part| !part.starts_with("(;") && !part.starts_with("$"))
        .collect();
    parts.insert(1, identifier);
    let shadow = parts.join(" ");
    Ok(shadow)
}

fn to_shadow_mem_instr(instr: &str) -> Result<String, &'static str> {
    let mut parts: Vec<&str> = instr.split_whitespace().collect();
    parts.insert(1, SHADOW_MEM);
    let shadow = parts.join(" ");
    Ok(shadow)
}

#[derive(Clone, Debug)]
enum ValType {
    U8,
    I32,
    I64,
    F32,
    F64,
    Funcref,
}

impl ValType {
    fn from_type_str(typ: &str) -> Result<ValType, &'static str> {
        match typ {
            "i32" => Ok(ValType::I32),
            "i64" => Ok(ValType::I64),
            "f32" => Ok(ValType::F32),
            "f64" => Ok(ValType::F64),
            "funcref" => Ok(ValType::Funcref),
            _ => Err("Could not parse valtype"),
        }
    }

    fn to_local(&self) -> &'static str {
        match self {
            ValType::U8 => panic!("There is no local for U8"),
            ValType::I32 => LOCAL_I32,
            ValType::I64 => LOCAL_I64,
            ValType::F32 => LOCAL_F32,
            ValType::F64 => LOCAL_F64,
            ValType::Funcref => LOCAL_FUNCREF,
        }
    }

    fn get_code(&self) -> u8 {
        match self {
            ValType::I32 => 0,
            ValType::I64 => 1,
            ValType::F32 => 2,
            ValType::F64 => 3,
            ValType::Funcref => 4,
            ValType::U8 => 5,
        }
    }

    fn get_byte_length(&self) -> u32 {
        match self {
            ValType::U8 => 1,
            ValType::I32 => 4,
            ValType::I64 => 8,
            ValType::F32 => 4,
            ValType::F64 => 8,
            ValType::Funcref => 4,
        }
    }

    fn to_string(&self) -> String {
        match self {
            ValType::U8 => panic!("Shouldnt transform u3 to string"),
            ValType::I32 => "i32".into(),
            ValType::I64 => "i64".into(),
            ValType::F32 => "f32".into(),
            ValType::F64 => "f64".into(),
            ValType::Funcref => panic!("Shouldnt transform funcref to string"),
        }
    }
}

struct Global {
    mutable: bool,
    public: bool,
    valtype: ValType,
    identifier: Option<String>,
}

impl Global {
    fn from_global(wat: &str) -> Result<Global, &'static str> {
        let tokens: Vec<&str> = wat.split_whitespace().collect();
        if tokens.len() < 3 {
            return Err("Global string does not contain enough parts");
        }
        let mut mutable = false;
        let mut base_idx = 2;
        let mut identifier = None;
        if tokens[1].starts_with("$") {
            base_idx = 3;
            identifier = Some(tokens[1].into())
        }
        let type_token = if tokens[base_idx].starts_with("(mut") {
            mutable = true;
            tokens.get(base_idx + 1).ok_or("Type not found")
        } else {
            tokens.get(base_idx).ok_or("Type not found")
        };
        let typ = type_token.map(|&s| s.trim_matches(|c: char| c == '(' || c == ')'))?;
        let valtype = ValType::from_type_str(typ)?;
        Ok(Global {
            mutable,
            public: false,
            valtype,
            identifier,
        })
    }

    fn from_global_import(wat: &str) -> Result<Global, &'static str> {
        let mut nesting = 0;
        let mut start_index = None;
        let mut end_index = None;

        for (i, c) in wat.char_indices() {
            match c {
                '(' => {
                    nesting += 1;
                    if wat[i..].starts_with("(global") && start_index.is_none() {
                        start_index = Some(i);
                    }
                }
                ')' => {
                    if nesting == 0 {
                        return Err("Unbalanced parentheses");
                    }
                    nesting -= 1;
                    if nesting == 0 && start_index.is_some() {
                        end_index = Some(i);
                        break;
                    }
                }
                _ => {}
            }
        }
        if let (Some(start), Some(end)) = (start_index, end_index) {
            let mut global = Global::from_global(&wat[start..end])?;
            global.public = true;
            Ok(global)
        } else {
            Err("No global declaration found")
        }
    }

    fn should_be_traced(&self) -> bool {
        self.mutable && self.public
    }
}

#[derive(Debug, Clone)]
struct Function {
    public: bool,
    identifier: Option<String>,
    imported: bool,
    exported: bool,
    in_public_table: bool,
}

impl Function {
    fn from_func(wat: &str) -> Result<Function, &'static str> {
        let tokens: Vec<&str> = wat.split_whitespace().collect();
        let mut identifier = None;
        if tokens[1].starts_with("$") {
            identifier = Some(tokens[1].into())
        }
        Ok(Function {
            public: false,
            identifier,
            imported: false,
            exported: false,
            in_public_table: false,
        })
    }

    fn from_func_import(wat: &str) -> Result<Function, &'static str> {
        let mut nesting = 0;
        let mut start_index = None;
        let mut end_index = None;

        for (i, c) in wat.char_indices() {
            match c {
                '(' => {
                    nesting += 1;
                    if wat[i..].starts_with("(func") && start_index.is_none() {
                        start_index = Some(i);
                    }
                }
                ')' => {
                    if nesting == 0 {
                        return Err("Unbalanced parentheses");
                    }
                    nesting -= 1;
                    if nesting == 0 && start_index.is_some() {
                        end_index = Some(i);
                        break;
                    }
                }
                _ => {}
            }
        }
        if let (Some(start), Some(end)) = (start_index, end_index) {
            let mut function = Function::from_func(&wat[start..end])?;
            function.public = true;
            function.imported = true;
            Ok(function)
        } else {
            Err("No function declaration found")
        }
    }
}

struct Table {
    public: bool,
}

/// please provide something like "(memory" or "(global" or "(table" as keyword
fn extract_definition(input: String, keyword: &str) -> Result<String, &'static str> {
    let start_index = input.find(keyword).ok_or("Keyword not found")?;

    // Find the closing bracket ')' after the keyword
    let mut close_bracket_index = start_index;
    let mut bracket_count = 1;
    while close_bracket_index < input.len() && bracket_count > 0 {
        close_bracket_index += 1;
        match &input[close_bracket_index..=close_bracket_index] {
            "(" => bracket_count += 1,
            ")" => bracket_count -= 1,
            _ => {}
        }
    }
    if bracket_count != 0 {
        return Err("Closing bracket not found");
    }

    // Extract and return the definition
    if start_index < close_bracket_index {
        Ok(input[start_index..=close_bracket_index].to_string())
    } else {
        Err("Invalid structure in extract definition")
    }
}

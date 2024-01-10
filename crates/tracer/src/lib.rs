use std::{collections::HashMap, fmt::Debug};

use anyhow::Result;
use walrus::{
    ir::{
        self, BinaryOp, Binop, BrIf, Call, Const, GlobalGet, GlobalSet, IfElse, Instr, LocalGet,
        LocalSet, MemArg, Store, StoreKind, Value, VisitorMut,
    },
    FunctionBuilder, FunctionId, FunctionKind, GlobalId, InstrLocId, LocalFunction, LocalId,
    MemoryId, Module, ModuleConfig, TableId, Type, TypeId, ValType,
};
use wasm_bindgen::prelude::*;

type Instruction = (Instr, InstrLocId);

#[wasm_bindgen]
pub fn instrument_wasm_js(buffer: &[u8]) -> Result<JsValue, JsValue> {
    let mut module = instrument_wasm(buffer).map_err(|e| JsValue::from_str(&e.to_string()))?;
    let value = serde_wasm_bindgen::to_value(&module.emit_wasm())?;
    Ok(value)
}

pub fn instrument_wasm(buffer: &[u8]) -> Result<Module> {
    let mut module = Module::from_buffer(buffer)?;
    let trace_mem_id = module.memories.add_local(false, 10000, None); // around 2 GB
    module.exports.add("trace", trace_mem_id);
    let mem_pointer = module.globals.add_local(
        walrus::ValType::I32,
        true,
        walrus::InitExpr::Value(walrus::ir::Value::I32(0)),
    );
    module.exports.add("trace_byte_length", mem_pointer);
    let locals = add_locals(&mut module);
    let module_types = Types::new(&module);
    let current_type = module
        .types
        .get(module.functions().find(|_| true).unwrap().ty())
        .clone();
    // Add return instruction at the end of each function (Importend for Instrumentation)
    module.funcs.iter_local_mut().for_each(|(_, f)| {
        f.builder_mut().func_body().return_();
    });
    // Mem check imported function
    let typ = module.types.find(&[], &[]);
    let typ = match typ {
        Some(t) => t,
        None => module.types.add(&[], &[]),
    };
    let (check_mem_id, _) = module.add_import_func("r3", "check_mem", typ);
    // Mem check local function
    let mut builder = FunctionBuilder::new(&mut module.types, &[], &[]);
    builder
        .func_body()
        .const_(Value::I32(1000 * 64000))
        .global_get(mem_pointer)
        .binop(BinaryOp::I32LeU)
        .if_else(
            None,
            |then| {
                then.call(check_mem_id)
                    .const_(Value::I32(0))
                    .global_set(mem_pointer);
            },
            |_| {},
        );
    let check_mem_id_local = builder.finish(vec![], &mut module.funcs);

    let mut generator = Generator::new(
        trace_mem_id,
        mem_pointer,
        locals.0,
        locals.1,
        module_types,
        current_type,
        check_mem_id,
        check_mem_id_local,
    );
    // Instrument
    module.funcs.iter_mut().for_each(|f| {
        if f.id() == check_mem_id_local {
            return;
        }
        if let FunctionKind::Local(f) = &mut f.kind {
            generator.set_current_func_type(module.types.get(f.ty()).clone());
            generator.set_func_entry(true);
            ir::dfs_pre_order_mut(&mut generator, f, f.entry_block())
        }
    });

    // dbg!(&module);
    Ok(module)
}

type Locals = HashMap<ValType, Vec<LocalId>>;
fn add_locals(module: &mut Module) -> (Locals, Locals) {
    let mut added_locals: Locals = HashMap::new();
    added_locals.insert(ValType::I32, vec![module.locals.add(ValType::I32)]);
    added_locals.insert(ValType::I64, vec![module.locals.add(ValType::I64)]);
    added_locals.insert(ValType::F32, vec![module.locals.add(ValType::F32)]);
    added_locals.insert(ValType::F64, vec![module.locals.add(ValType::F64)]);
    module.types.iter().for_each(|t| {
        let params = t.params();
        let mut amounts: HashMap<ValType, usize> = HashMap::new();
        params.iter().for_each(|t| {
            let _ = amounts.entry(*t).and_modify(|e| *e += 1).or_insert(1);
        });
        amounts.iter().for_each(|(t, a)| {
            added_locals.entry(*t).and_modify(|e| {
                if e.len() < *a {
                    let mut vec = Vec::with_capacity(*a);
                    for _ in 0..*a {
                        vec.push(module.locals.add(*t));
                    }
                    *e = vec;
                }
            });
        });
        let results = t.results();
        results.iter().for_each(|t| {
            let _ = amounts.entry(*t).and_modify(|e| *e += 1).or_insert(1);
        });
        amounts.iter().for_each(|(t, a)| {
            added_locals.entry(*t).and_modify(|e| {
                if e.len() < *a {
                    let mut vec = Vec::with_capacity(*a);
                    for _ in 0..*a {
                        vec.push(module.locals.add(*t));
                    }
                    *e = vec;
                }
            });
        });
    });
    let mut locals = HashMap::new();
    module.locals.iter().for_each(|l| {
        let _ = locals
            .entry(l.ty())
            .and_modify(|e: &mut Vec<LocalId>| {
                e.push(l.id());
            })
            .or_insert(vec![l.id()]);
    });
    (locals, added_locals)
}

#[derive(Debug)]
struct Types {
    by_func: HashMap<FunctionId, Type>,
    by_id: HashMap<TypeId, Type>,
    global_types: HashMap<GlobalId, ValType>,
    element_types: HashMap<TableId, ValType>,
}

impl Types {
    fn new(module: &Module) -> Types {
        let by_func = module
            .functions()
            .map(|f| (f.id(), module.types.get(f.ty()).clone()))
            .collect();
        let by_id = module
            .functions()
            .map(|f| (f.ty(), module.types.get(f.ty()).clone()))
            .collect();
        let global_types = module.globals.iter().map(|g| (g.id(), g.ty)).collect();
        let element_types = module
            .tables
            .iter()
            .map(|t| (t.id(), t.element_ty))
            .collect();
        Self {
            by_func,
            by_id,
            global_types,
            element_types,
        }
    }

    fn get_by_func(&self, func: &FunctionId) -> Option<&Type> {
        self.by_func.get(func)
    }

    fn get_by_id(&self, id: &TypeId) -> Option<&Type> {
        self.by_id.get(id)
    }

    fn get_global_type(&self, id: &GlobalId) -> Option<&ValType> {
        self.global_types.get(id)
    }

    fn get_element_type(&self, id: &TableId) -> Option<&ValType> {
        self.element_types.get(id)
    }
}

enum InstructionsEnum {
    Sequence(Vec<Instruction>),
    Single(Instruction),
}

impl InstructionsEnum {
    pub fn from_vec(vec: Vec<InstructionsEnum>) -> Self {
        Self::Sequence(
            vec.into_iter()
                .map(|e| match e {
                    InstructionsEnum::Sequence(s) => s,
                    InstructionsEnum::Single(s) => vec![s],
                })
                .flat_map(|s| s.into_iter())
                .collect(),
        )
    }

    pub fn flatten(&self) -> Vec<Instruction> {
        match self {
            InstructionsEnum::Sequence(s) => s.to_vec(),
            InstructionsEnum::Single(s) => vec![s.clone()],
        }
    }
}

#[derive(Debug)]
struct Generator {
    trace_mem_id: MemoryId,
    mem_pointer: GlobalId,
    locals: Locals,
    added_locals: Locals,
    module_types: Types,
    current_func_type: Type,
    func_entry: bool,
    check_mem_id: FunctionId,
    check_mem_id_local: FunctionId,
}

impl VisitorMut for Generator {
    fn start_instr_seq_mut(&mut self, seq: &mut ir::InstrSeq) {
        let mut added_instr_count = 0;
        let mut instrumentation_code = Vec::new();
        seq.clone().iter().enumerate().for_each(|(i, (instr, _))| {
            let mut gen_seq: Vec<Instruction> = vec![];
            let offset: &mut u32 = &mut 0;
            if self.func_entry == true {
                let opcode = 0x02;
                let c = self.current_func_type.clone();
                let params = c.params();
                gen_seq.append(
                    &mut InstructionsEnum::from_vec(vec![
                        self.trace_code(opcode, offset),
                        self.save_locals(params, offset),
                        self.increment_mem_pointer(*offset),
                    ])
                    .flatten(),
                );
                self.func_entry = false;
            }
            match instr {
                Instr::Load(load) => {
                    let (opcode, local_type) = match load.kind {
                        ir::LoadKind::I32 { .. } => (0x28, ValType::I32),
                        ir::LoadKind::I64 { .. } => (0x29, ValType::I64),
                        ir::LoadKind::F32 => (0x2A, ValType::F32),
                        ir::LoadKind::F64 => (0x2B, ValType::F64),
                        ir::LoadKind::V128 => todo!(),
                        ir::LoadKind::I32_8 { .. } => (0x2C, ValType::I32),
                        ir::LoadKind::I32_16 { .. } => (0x2E, ValType::I32),
                        ir::LoadKind::I64_8 { .. } => (0x30, ValType::I64),
                        ir::LoadKind::I64_16 { .. } => (0x32, ValType::I64),
                        ir::LoadKind::I64_32 { .. } => (0x34, ValType::I64),
                    };
                    gen_seq.append(
                        &mut InstructionsEnum::from_vec(vec![
                            self.trace_code(opcode, offset),
                            self.save_stack(&[ValType::I32], offset),
                            self.instr(instr.clone()),
                            self.save_stack(&[local_type], offset),
                            self.increment_mem_pointer(*offset),
                        ])
                        .flatten(),
                    );
                }
                Instr::Store(store) => {
                    let (opcode, local_type) = match store.kind {
                        ir::StoreKind::I32 { .. } => (0x36, ValType::I32),
                        ir::StoreKind::I64 { .. } => (0x37, ValType::I64),
                        ir::StoreKind::F32 => (0x38, ValType::F32),
                        ir::StoreKind::F64 => (0x39, ValType::F64),
                        ir::StoreKind::V128 => todo!(),
                        ir::StoreKind::I32_8 { .. } => (0x3A, ValType::I32),
                        ir::StoreKind::I32_16 { .. } => (0x3B, ValType::I32),
                        ir::StoreKind::I64_8 { .. } => (0x3C, ValType::I64),
                        ir::StoreKind::I64_16 { .. } => (0x3D, ValType::I64),
                        ir::StoreKind::I64_32 { .. } => (0x3E, ValType::I64),
                    };
                    gen_seq.append(
                        &mut InstructionsEnum::from_vec(vec![
                            self.trace_code(opcode, offset),
                            self.save_stack(&[ValType::I32, local_type], offset),
                            self.instr(instr.clone()),
                            self.increment_mem_pointer(*offset),
                        ])
                        .flatten(),
                    );
                }
                Instr::Call(call) => {
                    let opcode = 0x10;
                    let return_code = 0xFF;
                    let typ = self.module_types.get_by_func(&call.func).unwrap().clone();
                    gen_seq.append(
                        &mut InstructionsEnum::from_vec(vec![
                            self.trace_code(opcode, offset),
                            self.trace_type(&typ, offset),
                            self.save_stack(typ.params(), offset),
                            self.instr(instr.clone()),
                            self.trace_code(return_code, offset),
                            self.trace_type(&typ, offset),
                            self.save_stack(typ.results(), offset),
                            self.increment_mem_pointer(*offset),
                        ])
                        .flatten(),
                    );
                }
                Instr::CallIndirect(call) => {
                    let opcode = 0x11;
                    let return_code = 0xFF;
                    let typ = self.module_types.get_by_id(&call.ty).unwrap().clone();
                    gen_seq.append(
                        &mut InstructionsEnum::from_vec(vec![
                            self.trace_code(opcode, offset),
                            self.save_stack(&[typ.params(), &[ValType::I32]].concat(), offset),
                            self.instr(instr.clone()),
                            self.trace_code(return_code, offset),
                            self.trace_type(&typ, offset),
                            self.save_stack(typ.results(), offset),
                            self.increment_mem_pointer(*offset),
                        ])
                        .flatten(),
                    );
                }
                Instr::GlobalGet(g) => {
                    let opcode = 0x23;
                    let typ = self
                        .module_types
                        .get_global_type(&g.global)
                        .unwrap()
                        .clone();
                    gen_seq.append(
                        &mut InstructionsEnum::from_vec(vec![
                            self.trace_code(opcode, offset),
                            self.instr(instr.clone()),
                            self.save_stack(&[typ], offset),
                            self.increment_mem_pointer(*offset),
                        ])
                        .flatten(),
                    );
                }
                Instr::GlobalSet(get) => {
                    let opcode = 0x24;
                    let typ = self
                        .module_types
                        .get_global_type(&get.global)
                        .unwrap()
                        .clone();
                    gen_seq.append(
                        &mut InstructionsEnum::from_vec(vec![
                            self.trace_code(opcode, offset),
                            self.save_stack(&[typ], offset),
                            self.instr(instr.clone()),
                            self.increment_mem_pointer(*offset),
                        ])
                        .flatten(),
                    );
                }
                Instr::TableGet(set) => {
                    let opcode = 0x25;
                    let typ = self
                        .module_types
                        .get_element_type(&set.table)
                        .unwrap()
                        .clone();
                    gen_seq.append(
                        &mut InstructionsEnum::from_vec(vec![
                            self.trace_code(opcode, offset),
                            self.save_stack(&[ValType::I32], offset),
                            self.instr(instr.clone()),
                            self.save_stack(&[typ], offset),
                            self.increment_mem_pointer(*offset),
                        ])
                        .flatten(),
                    );
                }
                Instr::TableSet(set) => {
                    let opcode = 0x26;
                    let typ = self
                        .module_types
                        .get_element_type(&set.table)
                        .unwrap()
                        .clone();
                    gen_seq.append(
                        &mut InstructionsEnum::from_vec(vec![
                            self.trace_code(opcode, offset),
                            self.save_stack(&[ValType::I32, typ], offset),
                            self.instr(instr.clone()),
                            self.increment_mem_pointer(*offset),
                        ])
                        .flatten(),
                    );
                }
                // Instr::TableGrow(_) => todo!(),
                // Instr::TableFill(_) => todo!(),
                // Instr::LoadSimd(_) => todo!(),
                // Instr::TableInit(_) => todo!(),
                // Instr::ElemDrop(_) => todo!(),
                // Instr::TableCopy(_) => todo!(),
                Instr::Return(_) => {
                    let opcode = 0x0F;
                    let c = self.current_func_type.clone();
                    let returns = c.results();
                    gen_seq.append(
                        &mut InstructionsEnum::from_vec(vec![
                            self.trace_code(opcode, offset),
                            self.save_stack(returns, offset),
                            self.increment_mem_pointer(*offset),
                            self.call(self.check_mem_id_local),
                            self.instr(instr.clone()),
                        ])
                        .flatten(),
                    );
                }
                // Instr::MemoryGrow(_) => todo!(),
                // Instr::MemoryInit(_) => todo!(),
                // Instr::DataDrop(_) => todo!(),
                // Instr::MemoryCopy(_) => todo!(),
                // Instr::MemoryFill(_) => todo!(),
                _ => return,
            };
            let gen_length = gen_seq.len() - 1;
            instrumentation_code.push((i + added_instr_count, gen_seq));
            added_instr_count += gen_length;
        });
        instrumentation_code.iter().for_each(|(i, gen_seq)| {
            seq.splice(i.clone()..(i.clone() + 1), gen_seq.clone());
        })
    }
}

impl Generator {
    fn new(
        trace_mem_id: MemoryId,
        mem_pointer: GlobalId,
        locals: Locals,
        added_locals: Locals,
        module_types: Types,
        current_func_type: Type,
        check_mem_id: FunctionId,
        check_mem_id_local: FunctionId,
    ) -> Self {
        Self {
            trace_mem_id,
            mem_pointer,
            locals,
            added_locals,
            module_types,
            current_func_type,
            func_entry: true,
            check_mem_id,
            check_mem_id_local,
        }
    }

    fn trace_type(&mut self, typ: &Type, offset: &mut u32) -> InstructionsEnum {
        InstructionsEnum::from_vec(vec![
            self.get_const(ir::Value::I32(typ.id().index() as i32)),
            self.global_get(self.mem_pointer),
            self.save_stack(&[ValType::I32], offset),
        ])
    }

    fn check_mem(&self) -> InstructionsEnum {
        InstructionsEnum::from_vec(vec![
            self.get_const(ir::Value::I32(64000 * 20000)),
            self.global_get(self.mem_pointer),
            self.binop(BinaryOp::I32Eq),
            // self.check_mem_and_call(),
        ])
    }

    fn call(&self, func: FunctionId) -> InstructionsEnum {
        InstructionsEnum::Single((Instr::Call(Call { func }), InstrLocId::default()))
    }

    fn save_locals(&mut self, values: &[ValType], offset: &mut u32) -> InstructionsEnum {
        let mut locals = Vec::new();
        InstructionsEnum::from_vec(
            values
                .iter()
                .map(|t| {
                    let local = *self.added_locals.get(t).unwrap().get(0).unwrap();
                    locals.push(local);
                    self.locals.entry(*t).and_modify(|e| {
                        let id = e.remove(0);
                        e.push(id);
                    });
                    let instrs = InstructionsEnum::from_vec(vec![
                        self.global_get(self.mem_pointer),
                        self.local_get(local),
                        self.store_val_to_trace(*t, offset),
                    ]);
                    instrs
                })
                .collect(),
        )
    }

    fn save_stack(&mut self, values: &[ValType], offset: &mut u32) -> InstructionsEnum {
        let mut locals = Vec::new();
        InstructionsEnum::from_vec(vec![
            InstructionsEnum::from_vec(
                values
                    .iter()
                    .rev()
                    .map(|t| {
                        let local = *self.added_locals.get(t).unwrap().get(0).unwrap();
                        locals.push(local);
                        self.added_locals.entry(*t).and_modify(|e| {
                            let id = e.remove(0);
                            e.push(id);
                        });
                        let instrs = InstructionsEnum::from_vec(vec![
                            self.local_set(local),
                            self.global_get(self.mem_pointer),
                            self.local_get(local),
                            self.store_val_to_trace(*t, offset),
                        ]);
                        instrs
                    })
                    .collect(),
            ),
            InstructionsEnum::from_vec(locals.iter().rev().map(|l| self.local_get(*l)).collect()),
        ])
    }

    fn trace_code(&self, code: i32, offset: &mut u32) -> InstructionsEnum {
        InstructionsEnum::from_vec(vec![
            self.global_get(self.mem_pointer),
            self.get_const(Value::I32(code)),
            self.store_to_trace(StoreKind::I32_8 { atomic: false }, offset),
        ])
    }

    fn store_val_to_trace(&self, val_type: ValType, offset: &mut u32) -> InstructionsEnum {
        let kind = match val_type {
            ValType::I32 => StoreKind::I32 { atomic: false },
            ValType::I64 => StoreKind::I64 { atomic: false },
            ValType::F32 => StoreKind::F32,
            ValType::F64 => StoreKind::F64,
            ValType::V128 => todo!(),
            ValType::Externref => StoreKind::I32 { atomic: false },
            ValType::Funcref => StoreKind::I32 { atomic: false },
        };
        self.store_to_trace(kind, offset)
    }

    // fn double_drop(&self) -> InstructionsEnum {
    //     InstructionsEnum::from_vec(vec![self.drop(), self.drop()])
    // }

    // fn drop(&self) -> InstructionsEnum {
    //     InstructionsEnum::Single((Instr::Drop(Drop {}), InstrLocId::default()))
    // }

    fn store_to_trace(&self, kind: StoreKind, offset: &mut u32) -> InstructionsEnum {
        let align = match kind {
            StoreKind::I32 { .. } => 4,
            StoreKind::I64 { .. } => 8,
            StoreKind::F32 => 4,
            StoreKind::F64 => 8,
            StoreKind::V128 => todo!(),
            StoreKind::I32_8 { .. } => 1,
            StoreKind::I32_16 { .. } => 2,
            StoreKind::I64_8 { .. } => 1,
            StoreKind::I64_16 { .. } => 2,
            StoreKind::I64_32 { .. } => 4,
        };
        let instr = InstructionsEnum::Single((
            Instr::Store(Store {
                memory: self.trace_mem_id,
                kind,
                arg: MemArg {
                    align,
                    offset: *offset,
                },
            }),
            InstrLocId::default(),
        ));
        match kind {
            StoreKind::I32 { .. } => *offset += 4,
            StoreKind::I64 { .. } => *offset += 8,
            StoreKind::F32 => *offset += 4,
            StoreKind::F64 => *offset += 8,
            StoreKind::V128 => todo!(),
            StoreKind::I32_8 { .. } => *offset += 1,
            StoreKind::I32_16 { .. } => *offset += 2,
            StoreKind::I64_8 { .. } => *offset += 1,
            StoreKind::I64_16 { .. } => *offset += 2,
            StoreKind::I64_32 { .. } => *offset += 4,
        };
        instr
        // self.double_drop()
    }

    fn instr(&self, instr: Instr) -> InstructionsEnum {
        InstructionsEnum::Single((instr, InstrLocId::default()))
    }

    fn get_const(&self, value: Value) -> InstructionsEnum {
        InstructionsEnum::Single((Instr::Const(Const { value }), InstrLocId::default()))
    }

    fn global_get(&self, global: GlobalId) -> InstructionsEnum {
        InstructionsEnum::Single((
            Instr::GlobalGet(GlobalGet { global }),
            InstrLocId::default(),
        ))
    }

    fn global_set(&self, global: GlobalId) -> InstructionsEnum {
        InstructionsEnum::Single((
            Instr::GlobalSet(GlobalSet { global }),
            InstrLocId::default(),
        ))
    }

    fn call_check_mem(&self) -> InstructionsEnum {
        InstructionsEnum::Single((
            Instr::Call(Call {
                func: self.check_mem_id,
            }),
            InstrLocId::default(),
        ))
    }

    // fn local_tee(&self, local: LocalId) -> InstructionsEnum {
    //     InstructionsEnum::Single((Instr::LocalTee(LocalTee { local }), InstrLocId::default()))
    // }

    fn local_get(&self, local: LocalId) -> InstructionsEnum {
        InstructionsEnum::Single((Instr::LocalGet(LocalGet { local }), InstrLocId::default()))
    }

    fn local_set(&self, local: LocalId) -> InstructionsEnum {
        InstructionsEnum::Single((Instr::LocalSet(LocalSet { local }), InstrLocId::default()))
    }

    fn increment_mem_pointer(&self, amount: u32) -> InstructionsEnum {
        InstructionsEnum::from_vec(vec![
            self.global_get(self.mem_pointer),
            self.get_const(Value::I32(amount as i32)),
            self.binop(ir::BinaryOp::I32Add),
            self.global_set(self.mem_pointer),
        ])
    }

    fn binop(&self, op: BinaryOp) -> InstructionsEnum {
        InstructionsEnum::Single((Instr::Binop(Binop { op }), InstrLocId::default()))
    }

    // fn check_mem_and_call(&self) -> InstructionsEnum {
    //     // let mut module = Module::with_config(ModuleConfig::new());
    //     // let mut builder = FunctionBuilder::new(&mut module.types, &[], &[]);
    //     // let id = builder
    //     //     .dangling_instr_seq(None)
    //     //     .call(self.check_mem_id)
    //     //     .const_(Value::I32(0))
    //     //     .global_set(self.mem_pointer)
    //     //     .id();
    //     // let empty_id = builder.dangling_instr_seq(None).id();
    //     // InstructionsEnum::Single((
    //     //     Instr::IfElse(IfElse {
    //     //         consequent: id,
    //     //         alternative: empty_id,
    //     //     }),
    //     //     InstrLocId::default(),
    //     // ))
    //     InstructionsEnum::from_vec(vec![self.branch_if()])
    // }

    // fn branch_if() -> InstructionsEnum {
    //     // InstructionsEnum::Single((Instr::BrIf(BrIf { block }), InstrLocId::default()))
    //     todo!()
    // }

    fn set_current_func_type(&mut self, typ: Type) {
        self.current_func_type = typ;
    }

    fn set_func_entry(&mut self, entry: bool) {
        self.func_entry = entry;
    }
}

fn get_byte_length(valtype: &ValType) -> i32 {
    match valtype {
        ValType::I32 => 4,
        ValType::I64 => 8,
        ValType::F32 => 4,
        ValType::F64 => 8,
        ValType::V128 => todo!(),
        ValType::Externref => todo!(),
        ValType::Funcref => todo!(),
    }
}
f
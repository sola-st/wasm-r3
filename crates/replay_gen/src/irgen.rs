//! IRGenerator is a tool to generate a replay IR from a trace file. The IR has type Replay.
//! It keeps the auxiliary states needed at field state.
//! Its main job is to put the right HostEvent into a right spot.
//! HostEvent corresponds to some event in the host context, which is classified into the effect
//! it has on wasm state. They get translated into different host code depending on the backend.
use std::collections::BTreeMap;

use walrus::Module;

use crate::trace::{Trace, ValType, WasmEvent, F64};

pub struct IRGenerator {
    pub replay: Replay,
    state: State,
}

pub struct Replay {
    // original index is usize but we use i32 to handle host initialization code
    // TODO: more elegant solution
    pub func_imports: BTreeMap<i32, Function>,
    pub func_idx_to_ty: BTreeMap<usize, FunctionTy>,
    pub mem_imports: BTreeMap<usize, Memory>,
    pub table_imports: BTreeMap<usize, Table>,
    pub global_imports: BTreeMap<usize, Global>,
    pub modules: Vec<String>,
}

struct State {
    host_call_stack: Vec<i32>,
    last_func: i32,
}

#[derive(Clone, Debug)]
pub enum HostEvent {
    ExportCall {
        idx: i32,
        name: String,
        params: Vec<F64>,
    },
    ExportCallTable {
        idx: i32,
        table_name: String,
        funcidx: i32,
        params: Vec<F64>,
    },
    GrowMemory {
        amount: i32,
        import: bool,
        name: String,
    },
    GrowTable {
        idx: usize,
        amount: i32,
        import: bool,
        name: String,
    },
    MutateMemory {
        addr: i32,
        data: Vec<F64>,
        import: bool,
        name: String,
    },
    MutateGlobal {
        idx: usize,
        value: F64,
        valtype: ValType,
        import: bool,
        name: String,
    },
    MutateTable {
        tableidx: usize,
        funcidx: i32,
        idx: i32,
        func_import: bool,
        func_name: String,
        import: bool,
        name: String,
    },
}

#[derive(Clone, Debug, PartialEq)]
pub struct WriteResult {
    pub results: Vec<F64>,
    pub reps: i32,
}

pub type Context = Vec<HostEvent>;

#[derive(Clone, Debug)]
pub struct Function {
    pub module: String,
    pub name: String,
    pub bodys: Vec<Context>,
    pub results: Vec<WriteResult>,
}

#[derive(Clone, Debug)]
pub struct FunctionTy {
    pub params: Vec<ValType>,
    pub results: Vec<ValType>,
}

pub struct Memory {
    pub module: String,
    pub name: String,
    pub initial: u32,
    pub maximum: Option<u32>,
}

pub struct Table {
    pub module: String,
    pub name: String,
    // enum is better
    pub element: String,
    pub initial: u32,
    pub maximum: Option<u32>,
}

pub struct Global {
    pub module: String,
    pub name: String,
    pub mutable: bool,
    pub initial: F64,
    pub value: ValType,
}

impl IRGenerator {
    pub fn new(module: Module) -> Self {
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
        let mut mem_imports = BTreeMap::new();
        let mut table_imports = BTreeMap::new();
        let mut func_idx_to_ty = BTreeMap::new();
        for f in module.funcs.iter() {
            let ty = module.types.get(f.ty());
            func_idx_to_ty.insert(
                f.id().index(),
                FunctionTy {
                    params: ty.params().iter().map(|p| (*p).into()).collect(),
                    results: ty.results().iter().map(|p| (*p).into()).collect(),
                },
            );
        }

        for i in module.imports.iter() {
            match i.kind {
                walrus::ImportKind::Function(f) => {
                    let ty = module.types.get(module.funcs.get(f).ty());
                    func_imports.insert(
                        f.index() as i32,
                        Function {
                            module: i.module.to_string(),
                            name: i.name.to_string(),
                            bodys: vec![],
                            results: vec![],
                        },
                    );
                }
                walrus::ImportKind::Table(tid) => {
                    let table = module.tables.get(tid);
                    table_imports.insert(
                        tid.index(),
                        Table {
                            module: i.module.to_string(),
                            name: i.name.to_string(),
                            // want to replace anyfunc through t.refType but it holds the wrong string ('funcref')
                            element: "anyfunc".to_string(),
                            initial: table.initial,
                            maximum: table.maximum,
                        },
                    );
                }
                walrus::ImportKind::Memory(mid) => {
                    let m = module.memories.get(mid);
                    mem_imports.insert(
                        mid.index(),
                        Memory {
                            module: i.module.to_string(),
                            name: i.name.to_string(),
                            initial: m.initial,
                            maximum: m.maximum,
                        },
                    );
                }
                // Global is handled by the trace.
                walrus::ImportKind::Global(_) => {}
            }
        }
        Self {
            replay: Replay {
                func_imports,
                mem_imports,
                table_imports,
                func_idx_to_ty,
                global_imports: BTreeMap::new(),
                modules: Vec::new(),
            },
            // -1 is the _start function
            state: State {
                host_call_stack: vec![-1], //
                last_func: -1,
            },
        }
    }

    pub fn generate_replay(&mut self, trace: &Trace) -> &Replay {
        for event in trace.iter() {
            self.consume_event(event);
        }
        &self.replay
    }

    fn push_call(&mut self, event: HostEvent) {
        let idx = self.state.host_call_stack.last().unwrap();
        let current_context = self.idx_to_cxt(*idx);

        current_context.push(event.clone());
    }

    fn consume_event(&mut self, event: &WasmEvent) {
        match event {
            WasmEvent::FuncEntry { idx, name, params } => {
                self.push_call(HostEvent::ExportCall {
                    idx: idx.clone(),
                    name: name.clone(),
                    params: params.clone(),
                });
            }
            WasmEvent::FuncEntryTable {
                idx,
                tablename,
                tableidx: funcidx,
                params,
            } => {
                self.push_call(HostEvent::ExportCallTable {
                    idx: *idx,
                    table_name: tablename.clone(),
                    funcidx: *funcidx,
                    params: params.clone(),
                });
            }
            WasmEvent::FuncReturn => {}
            WasmEvent::Load {
                idx,
                name,
                offset,
                data,
            } => {
                self.splice_event(HostEvent::MutateMemory {
                    import: self.replay.mem_imports.contains_key(&idx),
                    name: name.clone(),
                    addr: *offset,
                    data: data.clone(),
                });
            }
            WasmEvent::MemGrow { idx, name, amount } => {
                self.splice_event(HostEvent::GrowMemory {
                    import: self.replay.mem_imports.contains_key(idx),
                    name: name.clone(),
                    amount: *amount,
                });
            }
            WasmEvent::TableGet {
                tableidx,
                name,
                idx,
                funcidx,
                funcname,
            } => {
                self.splice_event(HostEvent::MutateTable {
                    tableidx: *tableidx,
                    funcidx: *funcidx,
                    import: self.replay.table_imports.contains_key(&tableidx),
                    name: name.clone(),
                    idx: *idx,
                    func_import: self.replay.func_imports.contains_key(funcidx),
                    func_name: funcname.clone(),
                });
            }
            WasmEvent::TableGrow { idx, name, amount } => {
                self.splice_event(HostEvent::GrowTable {
                    import: self.replay.table_imports.contains_key(idx),
                    name: name.clone(),
                    idx: *idx,
                    amount: *amount,
                });
            }
            WasmEvent::GlobalGet {
                idx,
                name,
                value,
                valtype,
            } => {
                self.splice_event(HostEvent::MutateGlobal {
                    idx: *idx,
                    import: self.replay.global_imports.contains_key(&idx),
                    name: name.clone(),
                    value: *value,
                    valtype: valtype.clone(),
                });
            }

            WasmEvent::ImportCall { idx, name: _name } => {
                self.replay
                    .func_imports
                    .get_mut(idx)
                    .unwrap()
                    .bodys
                    .push(vec![]);
                self.state.host_call_stack.push(*idx);
                self.state.last_func = *idx;
            }
            WasmEvent::ImportReturn {
                idx: _idx,
                name: _name,
                results,
            } => {
                let current_fn_idx = self.state.host_call_stack.last().unwrap();
                let r = &mut self
                    .replay
                    .func_imports
                    .get_mut(&current_fn_idx)
                    .unwrap()
                    .results;
                r.push(WriteResult {
                    results: results.clone(),
                    reps: 1,
                });
                self.state.last_func = self.state.host_call_stack.pop().unwrap();
            }
            WasmEvent::ImportGlobal {
                idx,
                module,
                name,
                mutable,
                initial,
                value,
            } => {
                self.replay.global_imports.insert(
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
        }
    }
    fn splice_event(&mut self, event: HostEvent) {
        let idx = self.state.host_call_stack.last().unwrap();
        let last_idx = self.state.last_func;
        let last_import_call = *idx == last_idx;
        let current_context = self.idx_to_cxt(*idx);

        if last_import_call {
            current_context.insert(current_context.len() - 1, event);
        } else {
            let last_idx = &self.state.last_func;
            let last_context = self.idx_to_cxt(*last_idx);
            last_context.push(event.clone());
        }
    }

    fn idx_to_cxt(&mut self, idx: i32) -> &mut Vec<HostEvent> {
        let current_context = self
            .replay
            .func_imports
            .get_mut(&idx)
            .unwrap()
            .bodys
            .last_mut()
            .unwrap();
        current_context
    }

    // fn add_module(&mut self, module: &String) {
    //     if !self.replay.modules.contains(module) {
    //         self.replay.modules.push(module.clone());
    //     }
    // }
}

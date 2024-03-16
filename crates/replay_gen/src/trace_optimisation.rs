use std::collections::HashMap;

use walrus::{DataKind, ElementKind, ImportKind, Module};

use crate::trace::{LoadValue, WasmEvent};

pub trait TraceOptimiser {
    fn discard_event(&mut self, event: &WasmEvent) -> bool;
}

pub struct ShadowMemory(Vec<u8>);
impl ShadowMemory {
    const MEM_PAGE_SICE: u32 = 65536;

    fn from_module(module: &Module) -> Vec<ShadowMemory> {
        if module.memories.len() > 1 {
            todo!("Multiple memories not supported yet");
        }
        let mut memories: Vec<ShadowMemory> = module
            .memories
            .iter()
            .map(|m| ShadowMemory(vec![0; (m.initial * Self::MEM_PAGE_SICE) as usize]))
            .collect();
        module.data.iter().for_each(|d| {
            if let DataKind::Active(data) = &d.kind {
                let offset = match data.location {
                    walrus::ActiveDataLocation::Absolute(n) => n as usize,
                    walrus::ActiveDataLocation::Relative(_) => todo!("Relative data segment offset not supported yet"),
                };
                memories.get_mut(0).unwrap().store(offset, d.value.clone());
            }
        });
        memories
    }

    fn store(&mut self, offset: usize, data: impl Into<Vec<u8>>) {
        let data = data.into();
        self.0[offset..(offset + data.len())].copy_from_slice(&data);
    }

    fn grow(&mut self, amount: u32) {
        let new_portion = vec![0; (amount * Self::MEM_PAGE_SICE) as usize];
        self.0.extend(new_portion);
    }

    fn contains_already(&mut self, offset: usize, data: LoadValue) -> bool {
        let data: Vec<u8> = data.into();
        if offset + data.len() >= self.0.len() {}
        if data == self.0[offset..(offset + data.len())].to_vec() {
            true
        } else {
            false
        }
    }
}

pub struct ShadowMemoryOptimiser {
    shadow_mem: Vec<ShadowMemory>,
}

impl ShadowMemoryOptimiser {
    pub fn new(module: &Module) -> Self {
        Self { shadow_mem: ShadowMemory::from_module(module) }
    }
}

impl TraceOptimiser for ShadowMemoryOptimiser {
    fn discard_event(&mut self, event: &WasmEvent) -> bool {
        match event {
            WasmEvent::Load { offset, data, idx } => {
                if self
                    .shadow_mem
                    .get_mut(*idx)
                    .unwrap()
                    .contains_already(*offset as usize, data.clone())
                {
                    false
                } else {
                    self.shadow_mem.get_mut(*idx).unwrap().store(*offset as usize, data.clone());
                    true
                }
            }
            WasmEvent::Store { offset, data, idx } => {
                self.shadow_mem.get_mut(*idx).unwrap().store(*offset as usize, data.clone());
                false
            }
            WasmEvent::MemGrow { idx, amount } => {
                self.shadow_mem.get_mut(*idx).unwrap().grow(*amount as u32);
                false
            }
            _ => true,
        }
    }
}

fn get_init_value(exp: walrus::InitExpr, module: &Module) -> Result<usize, &'static str> {
    match exp {
        walrus::InitExpr::Value(v) => match v {
            walrus::ir::Value::I32(v) => Ok(v as usize),
            walrus::ir::Value::I64(v) => Ok(v as usize),
            walrus::ir::Value::F32(_v) => todo!(),
            walrus::ir::Value::F64(_v) => todo!(),
            walrus::ir::Value::V128(_v) => todo!(),
        },
        walrus::InitExpr::Global(id) => match module.globals.get(id).kind {
            walrus::GlobalKind::Import(_) => {
                Err("WARNING: Shadow Table optimiser: Shadow Table probably not correctly initialized")
            }
            walrus::GlobalKind::Local(exp) => get_init_value(exp, module),
        },
        walrus::InitExpr::RefNull(_) => todo!(),
        walrus::InitExpr::RefFunc(_) => todo!(),
    }
}

#[derive(Debug)]
pub struct ShadowTable {
    content: Vec<usize>,
    pub_name: Option<String>,
}

impl ShadowTable {
    fn from_module(module: &Module) -> Vec<ShadowTable> {
        let mut tables: Vec<ShadowTable> = module
            .tables
            .iter()
            .map(|t| ShadowTable { content: vec![0; t.initial as usize], pub_name: None })
            .collect();
        module.elements.iter().for_each(|e| {
            if let ElementKind::Active { table, offset } = e.kind {
                let offset = match get_init_value(offset, module) {
                    Ok(offset) => offset,
                    Err(e) => {
                        dbg!(e);
                        return;
                    }
                };
                tables
                    .get_mut(table.index())
                    .unwrap()
                    .set(offset, &e.members.iter().map(|i| i.unwrap().index()).collect());
            }
        });
        tables
    }

    fn set(&mut self, offset: usize, contents: &Vec<usize>) {
        self.content[offset..(offset + contents.len())].copy_from_slice(contents);
    }

    fn contains_already(&mut self, offset: usize, funcidx: usize) -> bool {
        self.content.get(offset).unwrap() == &funcidx
    }
}

pub struct ShadowTableOptimiser {
    shadow_tables: Vec<ShadowTable>,
}

impl ShadowTableOptimiser {
    pub fn new(module: &Module) -> Self {
        ShadowTableOptimiser { shadow_tables: ShadowTable::from_module(module) }
    }
}

impl TraceOptimiser for ShadowTableOptimiser {
    fn discard_event(&mut self, event: &WasmEvent) -> bool {
        match event {
            WasmEvent::TableGet { tableidx, idx, funcidx } => {
                if self
                    .shadow_tables
                    .get_mut(*tableidx)
                    .unwrap()
                    .contains_already(*idx, *funcidx as usize)
                {
                    false
                } else {
                    // dbg!(event);
                    // dbg!(&self.shadow_tables);
                    self.shadow_tables
                        .get_mut(*tableidx)
                        .unwrap()
                        .set(*idx, &vec![*funcidx as usize]);
                    true
                }
            }
            WasmEvent::TableSet { tableidx, idx, funcidx } => {
                self.shadow_tables
                    .get_mut(*tableidx)
                    .unwrap()
                    .set(*idx, &vec![*funcidx as usize]);
                false
            }
            _ => true,
        }
    }
}

pub struct FuncEntryTransformer {
    shadow_tables: Vec<ShadowTable>,
    pub_functions: HashMap<usize, String>,
}

impl FuncEntryTransformer {
    pub fn new(module: &Module) -> Self {
        let mut pub_functions = HashMap::new();
        for i in module.imports.iter() {
            if let walrus::ImportKind::Function(f) = i.kind {
                pub_functions.insert(f.index(), i.name.clone());
            }
        }
        module.exports.iter().for_each(|e| {
            if let walrus::ExportItem::Function(id) = e.item {
                pub_functions.insert(id.index(), e.name.clone());
            }
        });
        FuncEntryTransformer {
            shadow_tables: ShadowTable::from_module(module),
            pub_functions,
        }
    }
}

impl FuncEntryTransformer {
    pub fn transform_event(&self, event: WasmEvent) -> WasmEvent {
        match event.clone() {
            WasmEvent::FuncEntry { idx, params } => match self.pub_functions.get(&idx) {
                Some(_) => event,
                None => {
                    for (i, table) in self.shadow_tables.iter().enumerate() {
                        for (offset, c) in table.content.iter().enumerate() {
                            if c == &idx {
                                return WasmEvent::FuncEntryTable { funcidx: offset, offset: i, params };
                            }
                        }
                    }
                    panic!("The called function is neither exported nor in an public table")
                }
            },
            _ => event,
        }
    }
}

enum Scope {
    Internal,
    External,
}

pub struct CallOptimiser {
    call_stack: Vec<Scope>,
    import_functions: Vec<()>,
    event: usize,
}

impl CallOptimiser {
    pub fn new(module: &Module) -> CallOptimiser {
        let mut import_functions = Vec::new();
        module.imports.iter().for_each(|i| {
            if let ImportKind::Function(_) = i.kind {
                import_functions.push(());
            }
        });
        CallOptimiser {
            import_functions,
            call_stack: vec![Scope::External],
            event: 0,
        }
    }
}

impl TraceOptimiser for CallOptimiser {
    fn discard_event(&mut self, event: &WasmEvent) -> bool {
        self.event += 1;
        match event {
            WasmEvent::FuncEntry { .. } | WasmEvent::FuncEntryTable { .. } => {
                let mut keep = true;
                match self.call_stack.last() {
                    Some(_) => {},
                    None => {
                        let x = format!("Call stack length {}, event {}", self.call_stack.len(), self.event);
                        let y: Result<String, String> = Err(x);
                        y.unwrap();
                    }
                }
                if let Scope::Internal = self.call_stack.last().unwrap() {
                    keep = false
                }
                self.call_stack.push(Scope::Internal);
                keep
            }
            WasmEvent::FuncReturn => {
                self.call_stack.pop();
                if self.call_stack.len() == 1 {
                    true
                } else {
                    false
                }
            }
            WasmEvent::Call { idx } => {
                if let None = self.import_functions.get(*idx) {
                    false
                } else {
                    self.call_stack.push(Scope::External);
                    true
                }
            }
            WasmEvent::CallIndirect { funcidx, .. } => {
                if let None = self.import_functions.get(*funcidx as usize) {
                    false
                } else {
                    self.call_stack.push(Scope::External);
                    true
                }
            }
            WasmEvent::CallReturn { .. } => {
                if let Scope::External = self.call_stack.last().unwrap() {
                    self.call_stack.pop();
                    true
                } else {
                    false
                }
            }
            _ => true,
        }
    }
}

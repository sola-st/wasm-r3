use crate::{irgen::{Replay, WriteResult}, trace::Trace};

use walrus::{Module, DataKind};

pub struct ShadowMemory(Vec<u8>);
impl ShadowMemory {
    fn new(module: &Module) -> Self {
        if module.memories.len() > 1 {
            todo!("Multiple memories not supported yet");
        }
        let mut memory = ShadowMemory(vec![
            0u8;
            module.memories.iter().find(|_| true).map(|m| m.initial).unwrap() as usize
        ]);
        module.data.iter().for_each(|d| {
            if let DataKind::Active(data) = &d.kind {
                let offset = match data.location {
                    walrus::ActiveDataLocation::Absolute(n) => n as usize,
                    walrus::ActiveDataLocation::Relative(_) => todo!("Relative data segment offset not supported yet"),
                };
                memory.store(offset, d.value.clone());
            }
        });
        memory
    }

    fn store(&mut self, offset: usize, data: impl Into<Vec<u8>>) {
        let data = data.into();
        self.0[offset..data.len()].copy_from_slice(&data);
    }
}

pub struct Optimiser;
impl Optimiser {
    pub fn shadow_mem(_trace: &mut Trace, module: &Module) {
        let mut _shadow_mem: ShadowMemory = ShadowMemory::new(module);
        //         let mut filter = false;
        //         while let Some(e) = trace.next().await {
        //             match e.clone() {
        //                 WasmEvent::Load { idx, offset, data } => filter = true,
        //                 WasmEvent::Store { offset, data } => shadow_mem.store(offset as usize, data.clone()),
        //                 _ => {}
        //             }
        //         }
        //         let _ = trace.filter_map(|e| {
        //             match e {
        //                 WasmEvent::Load { idx, offset, data } => {
        //                     if filter == true {
        //                         None
        //                     } else {
        //                         Some(e)
        //                     }
        //                 }
        //                 WasmEvent::Store { offset, data } => None,
        //                 _ => Some(e),
        //             }
        //         });
        //         // let _ = trace.filter_map(|e| {
        //         //     match e {
        //         //         WasmEvent::Load { idx, offset, data } => todo!(),
        //         //         WasmEvent::Store { offset, data } => {
        //         //             shadow_mem.store(offset as usize, data);
        //         //             None
        //         //         }
        //         //         _ => Some(e),
        //         //     }
        //         // });
        //     }
    }

    pub fn opt_shadow_table(&mut self, _module: &Module) {}

    pub fn opt_shadow_global(&mut self, _module: &Module) {}

    pub fn opt_function_entry(&mut self) {}

    pub fn merge_fn_results(replay: &mut Replay) {
        for (_i, f) in &mut replay.func_imports {
            let mut new_results: Vec<WriteResult> = vec![];
            for v in &f.results {
                match new_results.last() {
                    Some(v2) if v2.results == v.results => new_results.last_mut().unwrap().reps += 1,
                    _ => new_results.push(v.clone()),
                }
            }
            f.results = new_results;
        }
    }
}

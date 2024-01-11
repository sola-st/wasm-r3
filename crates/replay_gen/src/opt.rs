use crate::{irgen::{Replay, WriteResult}};


pub struct Optimiser;
impl Optimiser {
    // pub fn shadow_mem(_trace: &mut Trace, module: &Module) {
    //     let mut _shadow_mem: ShadowMemory = ShadowMemory::new(module);
    //     //         let mut filter = false;
    //     //         while let Some(e) = trace.next().await {
    //     //             match e.clone() {
    //     //                 WasmEvent::Load { idx, offset, data } => filter = true,
    //     //                 WasmEvent::Store { offset, data } => shadow_mem.store(offset as usize, data.clone()),
    //     //                 _ => {}
    //     //             }
    //     //         }
    //     //         let _ = trace.filter_map(|e| {
    //     //             match e {
    //     //                 WasmEvent::Load { idx, offset, data } => {
    //     //                     if filter == true {
    //     //                         None
    //     //                     } else {
    //     //                         Some(e)
    //     //                     }
    //     //                 }
    //     //                 WasmEvent::Store { offset, data } => None,
    //     //                 _ => Some(e),
    //     //             }
    //     //         });
    //     //         // let _ = trace.filter_map(|e| {
    //     //         //     match e {
    //     //         //         WasmEvent::Load { idx, offset, data } => todo!(),
    //     //         //         WasmEvent::Store { offset, data } => {
    //     //         //             shadow_mem.store(offset as usize, data);
    //     //         //             None
    //     //         //         }
    //     //         //         _ => Some(e),
    //     //         //     }
    //     //         // });
    //     //     }
    // }

    // pub fn opt_shadow_table(&mut self, _module: &Module) {}

    // pub fn opt_shadow_global(&mut self, _module: &Module) {}

    // pub fn opt_function_entry(&mut self) {}

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

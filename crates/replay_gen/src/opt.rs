use crate::irgen::{Import, Replay, WriteResult};
use std::collections::BTreeMap;

use crate::irgen::{Context, Function, FunctionTy, HostEvent};

pub struct Optimiser;
impl Optimiser {
    pub fn merge_fn_results(replay: &mut Replay) {
        for (_i, f) in &mut replay.funcs {
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

    pub fn discard_empty_body(replay: &mut Replay) {
        for (_i, f) in &mut replay.funcs {
            let mut new_bodys = vec![];
            for context in &f.bodys {
                match context {
                    Some(context) if context.len() == 0 => new_bodys.push(None),
                    Some(context) => new_bodys.push(Some(context.clone())),
                    None => new_bodys.push(None),
                };
            }
            f.bodys = new_bodys;
        }
    }

    pub fn split_big_body(replay: &mut Replay) {
        let mut new_funcs: BTreeMap<usize, Function> = BTreeMap::new();

        let last_key_value = replay.funcs.last_key_value().unwrap().0;
        let mut idx = 1;
        for (i, f) in &replay.funcs {
            let mut new_bodys: Vec<Option<Context>> = vec![];
            for context in &f.bodys {
                match context {
                    Some(context) if context.len() > 100000 => {
                        let mut sliced_context = vec![];
                        context.chunks(100000).for_each(|chunk| {
                            let unused_key = last_key_value + idx;
                            idx += 1;

                            sliced_context.push(HostEvent::ExportCall {
                                idx: unused_key,
                                name: unused_key.to_string(),
                                params: vec![],
                            });
                            new_funcs.insert(
                                unused_key,
                                Function {
                                    import: Some(Import {
                                        module: f.import.clone().unwrap().module,
                                        name: unused_key.to_string(),
                                    }),
                                    export: None,
                                    ty: FunctionTy { params: vec![], results: vec![] },
                                    results: vec![],
                                    bodys: vec![Some(chunk.to_vec())],
                                },
                            );
                        });

                        new_bodys.push(Some(sliced_context))
                    }
                    _ => new_bodys.push(context.clone()),
                };
            }
            new_funcs.insert(
                *i,
                Function {
                    import: f.import.clone(),
                    export: f.export.clone(),
                    ty: f.ty.clone(),
                    results: f.results.clone(),
                    bodys: new_bodys,
                },
            );
        }

        replay.funcs = new_funcs;
    }
}

use crate::irgen::{Replay, WriteResult};

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

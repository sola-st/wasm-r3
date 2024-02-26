#[no_mangle]
pub extern "C" fn new() -> Vec<i32> {
    vec![].into_iter().collect()
    // (0..1).collect()
}

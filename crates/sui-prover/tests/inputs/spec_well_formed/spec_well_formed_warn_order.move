module 0x42::foo;

#[ext(spec_only)]
use prover::prover::asserts;

fun add(x: u64, _y: u64): u64 {
    x
}

#[ext(spec(prove))] #[allow(unused_function)]
fun add_spec(x: u64, _y: u64): u64 {
    let res = add(x, _y);
    asserts(true);
    res
}

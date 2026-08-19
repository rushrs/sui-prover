#[allow(unused)]
module 0x42::extra_bpl_test;

#[ext(spec_only)]
use prover::prover::ensures;

// Native function that will be defined in the extra BPL file
#[ext(spec_only)] #[allow(unused_function)]
native fun custom_add(x: u64, y: u64): u64;

#[ext(spec(prove, extra_bpl = b"simple.ok.bpl"))] #[allow(unused_function)]
fun test_custom_add_spec() {
    ensures(custom_add(2, 3) == 5);
    ensures(custom_add(10, 20) == 30);
}

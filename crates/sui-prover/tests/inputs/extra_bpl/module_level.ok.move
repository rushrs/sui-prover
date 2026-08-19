#[allow(unused)]
#[ext(spec_only(extra_bpl = b"module_level.ok.bpl"))]
module 0x42::extra_bpl_module_test;

#[ext(spec_only)]
use prover::prover::ensures;

// Native function defined in the module-level extra BPL file
#[ext(spec_only)] #[allow(unused_function)]
native fun custom_multiply(x: u64, y: u64): u64;

#[ext(spec(prove))] #[allow(unused_function)]
fun test_custom_multiply_spec() {
    ensures(custom_multiply(2, 3) == 6);
    ensures(custom_multiply(5, 4) == 20);
}

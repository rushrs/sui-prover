#[allow(unused)]
module 0x42::quantifiers_partial_pattern_exists_fail;

#[ext(spec_only)]
use prover::prover::{end_exists_lambda, ensures};

#[ext(spec(prove))] #[allow(unused_function)]
fun test_3_spec() {
    let b = end_exists_lambda();
    ensures(b);
}

// Should fail

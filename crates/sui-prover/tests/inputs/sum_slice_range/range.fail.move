#[allow(unused)]
module 0x42::range_ok;

#[ext(spec_only)]
use prover::prover::ensures;

#[ext(spec_only)]
use prover::vector_iter::range;

#[ext(spec(prove))] #[allow(unused_function)]
fun test_0_spec() {
    ensures(range(0, 1) == vector[0, 1]); // should 1 element
}

#[ext(spec(prove))] #[allow(unused_function)]
fun test_1_spec() {
    ensures(range(709, 713) == vector[705, 710, 721, 712]); // wrong elements
}


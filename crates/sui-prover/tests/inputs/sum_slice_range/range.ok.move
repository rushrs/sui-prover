#[allow(unused)]
module 0x42::range_ok;

#[ext(spec_only)]
use prover::prover::ensures;

#[ext(spec_only)]
use prover::vector_iter::range;

#[ext(spec(prove))] #[allow(unused_function)]
fun test_spec() {
    ensures(range(1, 0) == vector[]);
    ensures(range(0, 1) == vector[0]);
    ensures(range(709, 713) == vector[709, 710, 711, 712]);
}

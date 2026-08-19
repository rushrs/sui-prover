#[allow(unused)]
module 0x42::vector_ext_push_front_pure_ok;

#[ext(spec_only)]
use prover::prover::{ensures, clone};

#[ext(spec_only)]
use prover::vector_ext::push_front_pure;

// New first element equals the pushed element.
#[ext(spec(prove))] #[allow(unused_function)]
fun test_push_front_head(v: &vector<u64>, e: u64) {
    let r = push_front_pure(v, &e);
    ensures(*vector::borrow(r, 0) == e);
}

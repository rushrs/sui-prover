#[allow(unused)]
module 0x42::vector_ext_remove_pure_ok;

#[ext(spec_only)]
use prover::prover::{ensures, requires, clone};

#[ext(spec_only)]
use prover::vector_ext::remove_pure;

#[ext(spec(prove))] #[allow(unused_function)]
fun test_remove_matches(v: &mut vector<u64>, i: u64) {
    requires(i < vector::length(v));
    let old_v = clone!(v);
    let _ = v.remove(i);
    ensures(*v == *remove_pure(old_v, i));
}

#[allow(unused)]
module 0x42::vector_ext_pop_back_pure_ok;

#[ext(spec_only)]
use prover::prover::{ensures, requires, clone};

#[ext(spec_only)]
use prover::vector_ext::pop_back_pure;

#[ext(spec(prove))] #[allow(unused_function)]
fun test_pop_back_matches(v: &mut vector<u64>) {
    requires(!v.is_empty());
    let old_v = clone!(v);
    let _ = v.pop_back();
    ensures(*v == *pop_back_pure(old_v));
}

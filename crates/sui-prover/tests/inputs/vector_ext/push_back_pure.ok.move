#[allow(unused)]
module 0x42::vector_ext_push_back_pure_ok;

#[ext(spec_only)]
use prover::prover::{ensures, requires, clone};

#[ext(spec_only)]
use prover::vector_ext::push_back_pure;

#[ext(spec(prove))] #[allow(unused_function)]
fun test_push_back_matches(v: &mut vector<u64>, e: u64) {
    let old_v = clone!(v);
    v.push_back(e);
    ensures(*v == *push_back_pure(old_v, &e));
}

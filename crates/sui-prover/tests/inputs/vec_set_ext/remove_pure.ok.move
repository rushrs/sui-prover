#[allow(unused)]
module 0x42::vec_set_ext_remove_pure_ok;

use sui::vec_set;

#[ext(spec_only)]
use prover::prover::{ensures, requires, clone};

#[ext(spec_only)]
use prover::vec_set_ext::remove_pure;

#[ext(spec(prove))] #[allow(unused_function)]
fun test_remove_matches(s: &mut vec_set::VecSet<u64>, k: u64) {
    requires(s.contains(&k));
    let old_s = clone!(s);
    s.remove(&k);
    ensures(*s == *remove_pure(old_s, &k));
}

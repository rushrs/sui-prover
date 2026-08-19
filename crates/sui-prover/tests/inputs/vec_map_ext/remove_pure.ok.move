#[allow(unused)]
module 0x42::vec_map_ext_remove_pure_ok;

use sui::vec_map;

#[ext(spec_only)]
use prover::prover::{ensures, requires, clone};

#[ext(spec_only)]
use prover::vec_map_ext::remove_pure;

// After remove of a contained key, the functional model equals the result.
#[ext(spec(prove))] #[allow(unused_function)]
fun test_remove_matches(m: &mut vec_map::VecMap<u64, u8>, k: u64) {
    requires(m.contains(&k));
    let old_m = clone!(m);
    let (_rk, _rv) = m.remove(&k);
    ensures(*m == *remove_pure(old_m, &k));
}

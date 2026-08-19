#[allow(unused)]
module 0x42::vec_map_ext_get_or_unknown_fail;

use sui::vec_map;

#[ext(spec_only)]
use prover::prover::{ensures, requires};

#[ext(spec_only)]
use prover::vec_map_ext::get_or_unknown;

// For an absent key, get_or_unknown returns an uninterpreted value —
// claiming a specific value must fail to verify.
#[ext(spec(prove))] #[allow(unused_function)]
fun test_absent_not_specific(m: &vec_map::VecMap<u64, u8>, k: u64) {
    requires(!m.contains(&k));
    ensures(*get_or_unknown(m, &k) == 0);
}

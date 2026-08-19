#[allow(unused)]
module 0x42::vec_map_ext_get_or_unknown_ok;

use sui::vec_map;

#[ext(spec_only)]
use prover::prover::{ensures, requires};

#[ext(spec_only)]
use prover::vec_map_ext::get_or_unknown;
#[ext(spec_only)]
use fun prover::vec_map_ext::get_or_unknown as vec_map::VecMap.get_or_unknown;

// Contained key: get_or_unknown agrees with vec_map::get.
#[ext(spec(prove))] #[allow(unused_function)]
fun test_contained_matches_get(m: &vec_map::VecMap<u64, u8>, k: u64) {
    requires(m.contains(&k));
    ensures(get_or_unknown(m, &k) == m.get(&k));
}

#[ext(spec(prove))] #[allow(unused_function)]
fun test_method_syntax(m: &vec_map::VecMap<u64, u8>, k: u64) {
    requires(m.contains(&k));
    ensures(m.get_or_unknown(&k) == m.get(&k));
}

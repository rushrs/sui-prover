#[allow(unused)]
module 0x42::table_ext_add_pure_ok;

use sui::table::Table;

#[ext(spec_only)]
use prover::prover::{ensures, requires, clone};

#[ext(spec_only)]
use prover::table_ext::add_pure;

#[ext(spec(prove))] #[allow(unused_function)]
fun test_add_matches(t: &mut Table<u64, u8>, k: u64, v: u8) {
    requires(!t.contains(k));
    let old_t = clone!(t);
    t.add(k, v);
    ensures(t == add_pure(old_t, k, &v));
}

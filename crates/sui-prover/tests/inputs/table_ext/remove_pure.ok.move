#[allow(unused)]
module 0x42::table_ext_remove_pure_ok;

use sui::table::Table;

#[ext(spec_only)]
use prover::prover::{ensures, requires, clone};

#[ext(spec_only)]
use prover::table_ext::remove_pure;

#[ext(spec(prove))] #[allow(unused_function)]
fun test_remove_matches(t: &mut Table<u64, u8>, k: u64) {
    requires(t.contains(k));
    let old_t = clone!(t);
    let _ = t.remove(k);
    ensures(t == remove_pure(old_t, k));
}

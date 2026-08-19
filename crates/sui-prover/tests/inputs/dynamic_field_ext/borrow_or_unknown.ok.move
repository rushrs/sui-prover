#[allow(unused)]
module 0x42::dynamic_field_ext_borrow_or_unknown_ok;

use sui::dynamic_field;

#[ext(spec_only)]
use prover::prover::{ensures, requires};

#[ext(spec_only)]
use prover::dynamic_field_ext::borrow_or_unknown;

public struct Foo has key {
    id: UID,
}

// Present field: borrow_or_unknown agrees with dynamic_field::borrow.
#[ext(spec(prove))] #[allow(unused_function)]
fun test_present_matches_borrow(x: &Foo, k: u64) {
    requires(dynamic_field::exists_with_type<u64, u8>(&x.id, k));
    ensures(borrow_or_unknown<u64, u8>(&x.id, k) == dynamic_field::borrow<u64, u8>(&x.id, k));
}

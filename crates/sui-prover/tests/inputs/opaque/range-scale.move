#[allow(unused_use)]
module 0x42::opaque_tests;

#[ext(spec_only)] use fun prover::integer::from_u8 as u8.to_int;
#[ext(spec_only)] use fun prover::integer::from_u16 as u16.to_int;
#[ext(spec_only)] use fun prover::integer::from_u32 as u32.to_int;
#[ext(spec_only)] use fun prover::integer::from_u64 as u64.to_int;
#[ext(spec_only)] use fun prover::integer::from_u128 as u128.to_int;
#[ext(spec_only)] use fun prover::integer::from_u256 as u256.to_int;

use prover::prover::{requires, ensures, asserts, clone};
use std::u64;

public struct Range<phantom T> {
    x: u64,
    y: u64,
}

fun scale<T>(r: &mut Range<T>, k: u64) {
    r.x = r.x * k;
    r.y = r.y * k;
}

#[ext(spec(prove))] #[allow(unused_function)]
fun scale_spec<T>(r: &mut Range<T>, k: u64) {
    let old_r = clone!(r);

    requires(r.x <= r.y);

    asserts(r.y.to_int().mul(k.to_int()).lte(u64::max_value!().to_int()));

    scale(r, k);

    ensures(r.x == old_r.x * k);
    ensures(r.y == old_r.y * k);
}

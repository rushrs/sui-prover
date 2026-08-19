#[allow(unused_use)]
module 0x42::opaque_tests;

#[ext(spec_only)] use fun prover::integer::from_u8 as u8.to_int;
#[ext(spec_only)] use fun prover::integer::from_u16 as u16.to_int;
#[ext(spec_only)] use fun prover::integer::from_u32 as u32.to_int;
#[ext(spec_only)] use fun prover::integer::from_u64 as u64.to_int;
#[ext(spec_only)] use fun prover::integer::from_u128 as u128.to_int;
#[ext(spec_only)] use fun prover::integer::from_u256 as u256.to_int;

use prover::prover::ensures;

fun add_no_asserts(x: u64, y: u64): u64 {
    x + y
}

#[ext(spec(prove, ignore_abort))] #[allow(unused_function)]
fun add_no_asserts_spec(x: u64, y: u64): u64 {
    let result = add_no_asserts(x, y);

    ensures(result.to_int() == x.to_int().add(y.to_int()));

    result
}

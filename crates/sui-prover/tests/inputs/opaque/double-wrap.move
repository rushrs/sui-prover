#[allow(unused_use)]
module 0x42::opaque_tests;

#[ext(spec_only)] use fun prover::integer::from_u8 as u8.to_int;
#[ext(spec_only)] use fun prover::integer::from_u16 as u16.to_int;
#[ext(spec_only)] use fun prover::integer::from_u32 as u32.to_int;
#[ext(spec_only)] use fun prover::integer::from_u64 as u64.to_int;
#[ext(spec_only)] use fun prover::integer::from_u128 as u128.to_int;
#[ext(spec_only)] use fun prover::integer::from_u256 as u256.to_int;

use prover::prover::{ensures};

fun add_wrap(x: u64, y: u64): u64 {
    (((x as u128) + (y as u128)) % 18446744073709551616) as u64
}

fun double_wrap(x: u64): u64 {
    add_wrap(x, x)
}

#[ext(spec(prove))] #[allow(unused_function)]
fun double_wrap_spec(x: u64): u64 {
    let result = double_wrap(x);
    ensures(result == x.to_int().mul((2u8).to_int()).to_u64());
    result
}

#[allow(unused_use)]
module 0x42::opaque_tests;

#[ext(spec_only)] use fun prover::integer::from_u8 as u8.to_int;
#[ext(spec_only)] use fun prover::integer::from_u16 as u16.to_int;
#[ext(spec_only)] use fun prover::integer::from_u32 as u32.to_int;
#[ext(spec_only)] use fun prover::integer::from_u64 as u64.to_int;
#[ext(spec_only)] use fun prover::integer::from_u128 as u128.to_int;
#[ext(spec_only)] use fun prover::integer::from_u256 as u256.to_int;

use prover::prover::{ensures};

fun add_wrap_buggy(x: u64, y: u64): u64 {
    x + y
}

fun double_wrap_buggy(x: u64): u64 {
    add_wrap_buggy(x, x)
}

#[ext(spec(prove))] #[allow(unused_function)]
fun double_wrap_buggy_spec(x: u64): u64 {
    let result = double_wrap_buggy(x);
    ensures(result == x.to_int().mul((2u8).to_int()).to_u64());
    result
}

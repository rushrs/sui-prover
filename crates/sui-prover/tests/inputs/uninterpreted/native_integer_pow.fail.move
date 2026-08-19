#[allow(unused_use)]
module 0x42::foo;

#[ext(spec_only)] use fun prover::integer::from_u8 as u8.to_int;
#[ext(spec_only)] use fun prover::integer::from_u16 as u16.to_int;
#[ext(spec_only)] use fun prover::integer::from_u32 as u32.to_int;
#[ext(spec_only)] use fun prover::integer::from_u64 as u64.to_int;
#[ext(spec_only)] use fun prover::integer::from_u128 as u128.to_int;
#[ext(spec_only)] use fun prover::integer::from_u256 as u256.to_int;

use prover::integer::Integer;
use prover::prover::ensures;

fun foo(a: Integer, b: Integer): Integer {
    a.pow(b)
}

#[ext(spec(prove, uninterpreted = prover::integer::pow))] #[allow(unused_function)]
fun foo_spec(a: Integer, b: Integer): Integer {
    let result = foo(a, b);
    ensures(result == 8u8.to_int()); // fails: pow is uninterpreted, can't deduce pow(2,3)==8
    result
}

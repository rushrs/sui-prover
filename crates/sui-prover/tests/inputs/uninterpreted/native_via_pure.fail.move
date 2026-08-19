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

// Pure function that calls pow — its $pure body must use pow$pure
#[ext(pure)]
fun square(x: Integer): Integer {
    x.pow(2u8.to_int())
}

fun foo(x: Integer): Integer {
    square(x)
}

#[ext(spec(prove, uninterpreted = prover::integer::pow))] #[allow(unused_function)]
fun foo_spec(x: Integer): Integer {
    let result = foo(x);
    ensures(result == x.mul(x)); // fails: pow is uninterpreted inside square$pure
    result
}

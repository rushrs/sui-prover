#[allow(unused_use)]
module 0x42::foo;

#[ext(spec_only)] use fun prover::real::from_u8 as u8.to_real;
#[ext(spec_only)] use fun prover::real::from_u16 as u16.to_real;
#[ext(spec_only)] use fun prover::real::from_u32 as u32.to_real;
#[ext(spec_only)] use fun prover::real::from_u64 as u64.to_real;
#[ext(spec_only)] use fun prover::real::from_u128 as u128.to_real;
#[ext(spec_only)] use fun prover::real::from_u256 as u256.to_real;

#[ext(spec_only)] use fun prover::integer::from_u8 as u8.to_int;
#[ext(spec_only)] use fun prover::integer::from_u16 as u16.to_int;
#[ext(spec_only)] use fun prover::integer::from_u32 as u32.to_int;
#[ext(spec_only)] use fun prover::integer::from_u64 as u64.to_int;
#[ext(spec_only)] use fun prover::integer::from_u128 as u128.to_int;
#[ext(spec_only)] use fun prover::integer::from_u256 as u256.to_int;

use prover::integer::Integer;
use prover::real::Real;
use prover::prover::ensures;

public fun foo(a: Integer, p: u8): Integer {
  a.pow(p.to_int())
}


public fun bar(a: Real, p: u8): Real {
  a.exp(p.to_int())
}

#[ext(spec(prove))] #[allow(unused_function)]
public fun spec_i_d() {
  ensures(foo(5u8.to_int(), 2) == 25u8.to_int());
  ensures(foo(2u8.to_int(), 4) == 16u8.to_int());
  ensures(foo(1u8.to_int(), 2) == 1u8.to_int());
  ensures(foo(1u8.to_int(), 0) == 1u8.to_int());
}

#[ext(spec(prove))] #[allow(unused_function)]
public fun spec_r_d() {
  ensures(bar(6u8.to_real(), 2) == 36u8.to_real());
  ensures(bar(2u8.to_real(), 3) == 8u8.to_real());
  ensures(bar(1u8.to_real(), 2) == 1u8.to_real());
  ensures(bar(1u8.to_real(), 0) == 1u8.to_real());
}

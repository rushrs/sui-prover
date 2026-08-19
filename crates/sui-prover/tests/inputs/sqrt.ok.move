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

public fun foo(a: Integer): Integer {
  a.sqrt()
}


public fun bar(a: Real): Real {
  a.sqrt()
}

#[ext(spec(prove))] #[allow(unused_function)]
public fun spec_i_d() {
  ensures(foo(16u8.to_int()) == 4u8.to_int());
}

#[ext(spec(prove))] #[allow(unused_function)]
public fun spec_i_b() {
  ensures(foo(17u8.to_int()).gte(4u8.to_int()));
  ensures(foo(17u8.to_int()).lt(5u8.to_int()));
}

#[ext(spec(prove))] #[allow(unused_function)]
public fun spec_r_d() {
  ensures(bar(16u8.to_real()) == 4u8.to_real());
}

#[ext(spec(prove))] #[allow(unused_function)]
public fun spec_r_b() {
  ensures(bar(17u8.to_real()).gt(4u8.to_real()));
  ensures(bar(17u8.to_real()).lt(5u8.to_real()));
}

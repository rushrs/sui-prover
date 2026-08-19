#[allow(unused_use)]
module 0x42::foo;

#[ext(spec_only)] use fun prover::integer::from_u8 as u8.to_int;
#[ext(spec_only)] use fun prover::integer::from_u16 as u16.to_int;
#[ext(spec_only)] use fun prover::integer::from_u32 as u32.to_int;
#[ext(spec_only)] use fun prover::integer::from_u64 as u64.to_int;
#[ext(spec_only)] use fun prover::integer::from_u128 as u128.to_int;
#[ext(spec_only)] use fun prover::integer::from_u256 as u256.to_int;

#[ext(spec_only)]
use prover::prover::{ensures, requires};

public fun foo(x: u64): u64 {
  x + 1
}

#[ext(spec(prove))] #[allow(unused_function)]
public fun foo_spec(x: u64): u64 {
  requires(x < std::u64::max_value!());
  let res = foo(x);
  let x_int = x.to_int();
  let res_int = res.to_int();
  ensures(res_int != x_int.add(1u64.to_int()));
  res
}

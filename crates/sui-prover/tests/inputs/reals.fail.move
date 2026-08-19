module 0x42::foo;

#[ext(spec_only)] use fun prover::real::from_u8 as u8.to_real;
#[ext(spec_only)] use fun prover::real::from_u16 as u16.to_real;
#[ext(spec_only)] use fun prover::real::from_u32 as u32.to_real;
#[ext(spec_only)] use fun prover::real::from_u64 as u64.to_real;
#[ext(spec_only)] use fun prover::real::from_u128 as u128.to_real;
#[ext(spec_only)] use fun prover::real::from_u256 as u256.to_real;

use prover::prover::{ensures, requires};
use prover::log;

public fun foo(x: u64): u64 {
  x + 1
}

#[ext(spec_only)] #[allow(unused_function)]
fun show_real(the_real: prover::real::Real): prover::real::Real {
  the_real
}

#[ext(spec(prove))] #[allow(unused_function)]
public fun foo_spec(x: u64): u64 {
  requires(x < std::u64::max_value!());
  let res = foo(x);
  let y_real = show_real(1u64.to_real().div(7u64.to_real()));
  log::var<prover::real::Real>(&y_real);
  ensures(y_real  != y_real);
  res
}

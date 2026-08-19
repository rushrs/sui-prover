#[allow(unused_use)]
module 0x42::simple_axiom;

#[ext(spec_only)] use fun prover::integer::from_u8 as u8.to_int;
#[ext(spec_only)] use fun prover::integer::from_u16 as u16.to_int;
#[ext(spec_only)] use fun prover::integer::from_u32 as u32.to_int;
#[ext(spec_only)] use fun prover::integer::from_u64 as u64.to_int;
#[ext(spec_only)] use fun prover::integer::from_u128 as u128.to_int;
#[ext(spec_only)] use fun prover::integer::from_u256 as u256.to_int;

use prover::prover::ensures;
use prover::vector_iter::{sum_range, filter_range};

#[ext(pure)]
fun is_qualified(x: &u8): bool {
    *x > 1 && *x < 20 && *x % 2 == 0
}

#[ext(spec_only(axiom))] #[allow(unused_function)]
fun f_axiom(v: &vector<u8>): bool {
    let y = filter_range!<u8>(v, 0, 3, |x| is_qualified(x));
    sum_range(y, 0, 3).gt(5u8.to_int()) && sum_range(y, 0, 3).lt(25u8.to_int())
}

public fun foo(_v: &vector<u8>) {
  assert!(true);
}

#[ext(spec(prove))] #[allow(unused_function)]
public fun foo_spec(_v: &vector<u8>) {
    foo(_v);
    ensures(true);
}

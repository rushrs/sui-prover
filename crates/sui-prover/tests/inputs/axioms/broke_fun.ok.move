#[allow(unused_use)]
module 0x42::simple_axiom;

#[ext(spec_only)] use fun prover::integer::from_u8 as u8.to_int;
#[ext(spec_only)] use fun prover::integer::from_u16 as u16.to_int;
#[ext(spec_only)] use fun prover::integer::from_u32 as u32.to_int;
#[ext(spec_only)] use fun prover::integer::from_u64 as u64.to_int;
#[ext(spec_only)] use fun prover::integer::from_u128 as u128.to_int;
#[ext(spec_only)] use fun prover::integer::from_u256 as u256.to_int;

use prover::prover::ensures;

#[ext(spec_only(axiom))] #[allow(unused_function)]
fun f_axiom(x: &u64): bool {
    (*x).to_int().sqrt() == 3u8.to_int()
}

public fun foo() {
  assert!(true);
}

#[ext(spec(prove))] #[allow(unused_function)]
public fun foo_spec() {
  foo();
  ensures(16u8.to_int().sqrt() == 3u8.to_int());
}

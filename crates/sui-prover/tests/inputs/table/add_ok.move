#[allow(unused_use)]
module 0x42::foo;

#[ext(spec_only)] use fun prover::integer::from_u8 as u8.to_int;
#[ext(spec_only)] use fun prover::integer::from_u16 as u16.to_int;
#[ext(spec_only)] use fun prover::integer::from_u32 as u32.to_int;
#[ext(spec_only)] use fun prover::integer::from_u64 as u64.to_int;
#[ext(spec_only)] use fun prover::integer::from_u128 as u128.to_int;
#[ext(spec_only)] use fun prover::integer::from_u256 as u256.to_int;

use prover::prover::{requires, ensures, clone};

use sui::table::Table;

fun foo(t: &mut Table<u64, u8>) {
  t.add(10, 0);
}

#[ext(spec(prove))] #[allow(unused_function)]
fun bar_spec(t: &mut Table<u64, u8>) {
  requires(!t.contains(10));
  let old_t = clone!(t);
  foo(t);
  requires(t.contains(10));
  ensures(t[10] == 0);
  ensures(!t.is_empty());
  ensures(t.length().to_int() == old_t.length().to_int().add(1u64.to_int()));
}

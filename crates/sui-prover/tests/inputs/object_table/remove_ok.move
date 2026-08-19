#[allow(unused_use)]
module 0x42::foo;

#[ext(spec_only)] use fun prover::integer::from_u8 as u8.to_int;
#[ext(spec_only)] use fun prover::integer::from_u16 as u16.to_int;
#[ext(spec_only)] use fun prover::integer::from_u32 as u32.to_int;
#[ext(spec_only)] use fun prover::integer::from_u64 as u64.to_int;
#[ext(spec_only)] use fun prover::integer::from_u128 as u128.to_int;
#[ext(spec_only)] use fun prover::integer::from_u256 as u256.to_int;

use prover::prover::{requires, ensures, clone};

use sui::object_table::ObjectTable;

public struct Foo has key, store {
  id: UID,
}

fun foo(t: &mut ObjectTable<u64, Foo>): Foo {
  t.remove(10)
}

#[ext(spec(prove))] #[allow(unused_function)]
fun bar_spec(t: &mut ObjectTable<u64, Foo>): Foo {
  requires(t.contains(10));
  let old_t = clone!(t);
  let result = foo(t);
  ensures(!t.contains(10));
  ensures(result == &old_t[10]);
  ensures(t.length().to_int() == old_t.length().to_int().sub(1u64.to_int()));
  result
}

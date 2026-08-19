module 0x42::foo;

use prover::prover::requires;

use sui::table::Table;

fun foo(t: Table<u64, u8>) {
  t.destroy_empty()
}

#[ext(spec(prove))] #[allow(unused_function)]
fun foo_spec(t: Table<u64, u8>) {
  requires(t.is_empty());
  foo(t);
}

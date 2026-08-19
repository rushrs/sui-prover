module 0x42::foo;

#[ext(spec_only)]
use prover::prover::ensures;

public fun foo(x: u128): u128 {
  assert!(true);
  0u128
}

#[ext(spec(prove))] #[allow(unused_function)]
public fun foo_spec(x: u128): u64 {
  foo(x);
  ensures(true);

  5u64
}

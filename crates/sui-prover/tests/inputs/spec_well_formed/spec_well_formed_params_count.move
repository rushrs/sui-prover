module 0x42::foo;

#[ext(spec_only)]
use prover::prover::ensures;

public fun foo() {
  assert!(true);
}

#[ext(spec(prove))] #[allow(unused_function)]
public fun foo_spec(x: u128) {
  foo();
  ensures(true);
}

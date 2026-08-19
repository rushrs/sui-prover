module 0x42::foo;

use prover::prover::ensures;

public fun foo() {
  assert!(true);
}

#[ext(spec(prove, skip))] #[allow(unused_function)]
public fun foo_spec() {
  foo();
  ensures(false);
}

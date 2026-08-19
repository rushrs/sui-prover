module 0x42::foo;

#[ext(spec_only)]
use prover::prover::ensures;

public fun foo(a: u8) {
  assert!(true);
}

#[ext(spec(prove))] #[allow(unused_function)]
public fun foo_spec(a: u8) {
  if (a > 3) {
    return;
  };

  foo(a);

  ensures(true);
}

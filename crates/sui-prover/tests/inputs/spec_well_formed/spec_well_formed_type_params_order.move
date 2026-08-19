module 0x42::foo;

#[ext(spec_only)]
use prover::prover::ensures;

public fun foo<T, K>() {
  assert!(true);
}

#[ext(spec(prove))] #[allow(unused_function)]
public fun foo_spec<T, K>() {
  foo<K, T>();
  ensures(true);
}

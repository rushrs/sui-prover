module 0x42::foo;

#[ext(spec_only)]
use prover::prover::ensures;

public fun foo(x: u64): u64 {
  if (x == 0) {
    x
  } else {
    x - 1
  }
}

#[ext(spec(prove))] #[allow(unused_function)]
public fun foo_spec(a: u64): u64 {
  let result = foo(a);

  ensures(true);

  result
}

module 0x42::foo;

#[ext(spec_only)]
use prover::prover::ensures;

// not inlined
public fun factorial(x: u64): u64 {
  if (x == 0) {
    1
  } else {
    x * factorial(x - 1)
  }
}

#[ext(spec(prove))] #[allow(unused_function)]
public fun my_spec() {
  ensures(5u64 * 5u64 == 25u64);
}

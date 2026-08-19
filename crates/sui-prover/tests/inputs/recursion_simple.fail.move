module 0x42::recursion_simple_fail;

#[ext(spec_only)]
use prover::prover::ensures;

public fun factorial(x: u64): u64 {
  if (x == 0) {
    1
  } else {
    x * factorial(x - 1)
  }
}

#[ext(spec(prove))] #[allow(unused_function)]
public fun my_spec_simple() {
  ensures(factorial(5) == 120);
}

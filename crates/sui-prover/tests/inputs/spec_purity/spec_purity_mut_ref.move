module 0x42::foo;

#[ext(spec_only)]
use prover::prover::ensures;

public fun foo() {
  assert!(true);
}

public fun sub_foo(a: &mut u64) {
  assert!(true);
}


#[ext(spec(prove))] #[allow(unused_function)]
public fun foo_spec() {
  foo();

  let mut a = 5u64;

  sub_foo(&mut a);
  ensures(true);
}

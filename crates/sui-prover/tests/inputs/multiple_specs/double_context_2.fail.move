module 0x42::fb {
  public fun foo() {
    assert!(true);
  }

  public fun bar() {
    foo();
    assert!(true);
  }
}

module 0x42::foo_specs {
  use prover::prover::ensures;
  use 0x42::fb::foo;

  #[ext(spec(prove, target = 0x42::fb::foo))] #[allow(unused_function)]
  public fun foo_spec() {
    foo();
    ensures(true);
  }
}

#[ext(spec_only(include = 0x42::foo_specs::foo_spec))]
module 0x42::bar_specs_double_foo_imported_module {
  use prover::prover::ensures;
  use 0x42::fb::{foo, bar};

  #[ext(spec(prove, target = 0x42::fb::foo))] #[allow(unused_function)]
  public fun foo_spec() {
    foo();
    ensures(true);
  }

  #[ext(spec(prove, target = 0x42::fb::bar))] #[allow(unused_function)]
  public fun bar_spec() {
    bar();
    ensures(true);
  }
}

// Should FAIL because of duplicate spec for foo in same context

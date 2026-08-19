module 0x42::fb {
  public native fun foo();

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
  use 0x42::fb::bar;

  #[ext(spec(prove, target = 0x42::fb::bar))] #[allow(unused_function)]
  public fun bar_spec() {
    bar();
    ensures(true);
  }
}

// Should not fail because we include foo_spec which saves us from using unimplemented native foo

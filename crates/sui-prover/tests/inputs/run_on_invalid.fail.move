module 0x42::run_on_invalid_test;

public fun foo() {
    assert!(true);
}

// This spec has an invalid run_on value and should produce an error
#[ext(spec(prove, run_on=b"somewhere"))] #[allow(unused_function)]
public fun foo_spec_invalid() {
    foo();
}

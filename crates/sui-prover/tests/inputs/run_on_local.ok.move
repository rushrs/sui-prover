module 0x42::run_on_test;

public fun foo() {
    assert!(true);
}

// This spec should be able to run locally even when --cloud is configured
#[ext(spec(prove, run_on=b"local"))] #[allow(unused_function)]
public fun foo_spec_local() {
    foo();
}

// This spec should run according to the global setting
#[ext(spec(prove))] #[allow(unused_function)]
public fun foo_spec_default() {
    foo();
}

module 0x42::run_on_invalid_test;

public fun foo() {
    assert!(true);
}

// This spec should fail, --cloud is not configured
#[ext(spec(prove, run_on=b"cloud"))] #[allow(unused_function)]
public fun foo_spec_cloud() {
    foo();
}

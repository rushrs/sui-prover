module 0x42::foo {
    public fun foo(input: u64): u64 {
        assert!(input != 10);

        input
    }
}

module 0x43::bar {
    use prover::prover::asserts;
    use 0x42::foo::foo;

    #[ext(spec(prove, target = 0x42::foo::foo))] #[allow(unused_function)]
    fun foo_spec(input: u64): u64 {
        asserts(input != 10);

        let result = foo(input);
        result
    }
}
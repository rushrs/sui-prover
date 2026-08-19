module 0x42::foo;

#[ext(spec_only)]
use prover::prover::requires;
#[ext(spec_only)]
use prover::vector_iter::filter;

public struct Foo {
    x: u64,
}

#[ext(spec_only, pure)] #[allow(unused_function)]
fun foo_property(
    v1: &vector<Foo>,
    v2: &vector<Foo>,
    x: u64,
): bool {
    v1 == filter!(v2, |foo| is_x(foo, x))
}

#[ext(spec_only, pure)] #[allow(unused_function)]
fun is_x(foo: &Foo, x: u64): bool {
    foo.x == x
}

#[ext(spec(prove))] #[allow(unused_function)]
fun foo_spec(v1: &vector<Foo>, v2: &vector<Foo>, x: u64) {
    requires(foo_property(v1, v2, x));
}

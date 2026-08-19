module 0x42::foo;

#[ext(spec_only)]
use prover::prover::{ensures};

fun foo(x: &mut u8) {
    *x = 70;
}

fun bar(x: &mut u8) {
    foo(x);
}

#[ext(spec(prove, no_opaque))] #[allow(unused_function)]
fun foo_spec(x: &mut u8) {
    foo(x);
}

#[ext(spec(prove))] #[allow(unused_function)]
fun bar_spec(x: &mut u8) {
    bar(x);

    ensures(x == 70); // ok
}
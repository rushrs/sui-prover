module 0x42::opaque_tests;

use prover::prover::{fresh};

#[ext(spec_only)] #[allow(unused_function)]
fun fresh_with_type_withness<T, U>(_: &T): U {
    fresh()
}

#[ext(spec(prove))] #[allow(unused_function)]
fun fresh_with_type_withness_spec<T, U>(x: &T): U {
    fresh_with_type_withness(x)
}

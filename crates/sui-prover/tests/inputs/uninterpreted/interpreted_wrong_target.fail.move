module 0x42::foo;

use prover::prover::ensures;

#[ext(pure)] // pure but NOT globally uninterpreted
fun bar(): u64 {
    42
}

fun foo(): u64 {
    bar()
}

#[ext(spec(prove, interpreted = bar))] #[allow(unused_function)] // should error: bar is not #[ext(uninterpreted)]
fun foo_spec(): u64 {
    let result = foo();
    ensures(result == 42);
    result
}

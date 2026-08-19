module 0x42::foo;

use prover::prover::ensures;

fun bar(): u64 {
    42
}

fun foo(): u64 {
    bar()
}

#[ext(spec(prove, uninterpreted = bar))] #[allow(unused_function)] // should panic because bar is not pure
fun foo_spec(): u64 {
    let result = foo();
    ensures(result == 42);
    result
}

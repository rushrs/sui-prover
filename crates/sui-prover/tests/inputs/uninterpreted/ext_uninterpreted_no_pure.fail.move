module 0x42::foo;

use prover::prover::ensures;

#[ext(uninterpreted)] // should error: missing #[ext(pure)]
fun bar(): u64 {
    42
}

fun foo(): u64 {
    bar()
}

#[ext(spec(prove))] #[allow(unused_function)]
fun foo_spec(): u64 {
    let result = foo();
    ensures(result == bar());
    result
}

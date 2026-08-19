module 0x42::foo;

use prover::prover;

fun foo(x: u64): u64 {
    x
}

fun bar(x: u64): u64 {
    x
}

#[ext(spec(prove))] #[allow(unused_function)]
fun foo_spec(x: u64): u64 {
    let result = foo(x);
    prover::ensures(result < bar(x));
    result
}

#[ext(spec(prove))] #[allow(unused_function)]
fun bar_spec(x: u64): u64 {
    let result = bar(x);
    prover::ensures(result < foo(x));
    result
}

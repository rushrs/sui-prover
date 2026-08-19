module 0x42::foo;

use prover::integer::Integer;
use prover::prover::ensures;

fun foo(a: Integer, b: Integer): Integer {
    a.pow(b)
}

#[ext(spec(prove, uninterpreted = prover::integer::pow))] #[allow(unused_function)]
fun foo_spec(a: Integer, b: Integer): Integer {
    let result = foo(a, b);
    ensures(result == result);
    result
}
